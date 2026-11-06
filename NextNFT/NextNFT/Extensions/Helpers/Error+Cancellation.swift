//
//  Error+Cancellation.swift
//  NextNFT
//

import Foundation

extension Error {
    /// True when the work was cancelled, e.g. a view's `.task` ended because
    /// the user switched tabs. Not a failure worth showing.
    var isCancellation: Bool {
        self is CancellationError || (self as? URLError)?.code == .cancelled
    }
}
