import Foundation
import XCTest
@testable import WellNess

@MainActor
final class RemoteWellnessServiceTests: XCTestCase {
    
    override func tearDown() {
        super.tearDown()
        // Reset the environment URL after each test
        WellnessEnvironment.sessionURL = nil
    }

    func testFetchSessionsSuccessReturnsDecodedSessions() async throws {
        // Arrange: write valid JSON array to a temp file and point the environment URL to it
        let sessions: [WellnessSession] = []
        let data = try JSONEncoder().encode(sessions)
        let url = try writeTempFile(named: "sessions.json", contents: data)
        WellnessEnvironment.sessionURL = url

        let sut = RemoteWellnessService()

        // Act
        let result = try await sut.fetchSessions()

        // Assert
        XCTAssertEqual(result, [])
    }

    func testFetchSessionsWhenURLIsNilThrowsFileNotFound() async throws {
        // Arrange: ensure URL is nil
        WellnessEnvironment.sessionURL = nil
        let sut = RemoteWellnessService()

        // Act & Assert
        do {
            _ = try await sut.fetchSessions()
            XCTFail("Expected to throw but did not")
        } catch let error as RemoteWellnessService.Error {
            XCTAssertEqual(error, .fileNotFound)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    func testFetchSessionsInvalidJSONThrowsDecoding() async throws {
        // Arrange: write invalid JSON to a temp file
        let invalid = Data("not json".utf8)
        let url = try writeTempFile(named: "sessions_invalid.json", contents: invalid)
        WellnessEnvironment.sessionURL = url
        let sut = RemoteWellnessService()

        // Act & Assert
        do {
            _ = try await sut.fetchSessions()
            XCTFail("Expected to throw but did not")
        } catch let error as RemoteWellnessService.Error {
            XCTAssertEqual(error, .decoding)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    // MARK: - Helpers

    private func writeTempFile(named: String, contents: Data) throws -> URL {
        let dir = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let fileURL = dir.appendingPathComponent(UUID().uuidString).appendingPathComponent(named)
        if !FileManager.default.fileExists(atPath: fileURL.deletingLastPathComponent().path) {
            try FileManager.default.createDirectory(at: fileURL.deletingLastPathComponent(), withIntermediateDirectories: true)
            try contents.write(to: fileURL, options: .atomic)
        }
        return fileURL
    }
}
