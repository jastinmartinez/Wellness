import Foundation

enum ModelState<T: Equatable>: Equatable {
    case loading
    case success(T)
    case failure
}
