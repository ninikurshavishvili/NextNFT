//
//  ViewState.swift
//  NextNFT
//

/// What a screen or section is showing. One value instead of separate
/// `isLoading` / `errorMessage` / data properties, so a view can't be
/// loading and failed at the same time.
enum ViewState<Value> {
    case idle
    case loading
    case loaded(Value)
    case empty
    case failed(message: String)

    var value: Value? {
        if case .loaded(let value) = self { return value }
        return nil
    }

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    /// Idle or failed: worth (re)loading when the view appears.
    var needsLoad: Bool {
        switch self {
        case .idle, .failed: return true
        case .loading, .loaded, .empty: return false
        }
    }
}

extension ViewState: Equatable where Value: Equatable {}
extension ViewState: Sendable where Value: Sendable {}
