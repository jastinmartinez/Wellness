import Foundation

extension JSONDecoder {
    static let wellness: JSONDecoder = {
        let dec = JSONDecoder()
        dec.dateDecodingStrategy = .iso8601
        return dec
    }()
}
