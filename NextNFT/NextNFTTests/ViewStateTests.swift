//
//  ViewStateTests.swift
//  NextNFTTests
//

import Foundation
import Testing
@testable import NextNFT

struct ViewStateTests {

    @Test func onlyIdleAndFailedNeedALoad() {
        #expect(ViewState<Int>.idle.needsLoad)
        #expect(ViewState<Int>.failed(message: "x").needsLoad)
        #expect(!ViewState<Int>.loading.needsLoad)
        #expect(!ViewState<Int>.loaded(1).needsLoad)
        #expect(!ViewState<Int>.empty.needsLoad)
    }

    @Test func valueIsOnlyAvailableWhenLoaded() {
        #expect(ViewState.loaded(42).value == 42)
        #expect(ViewState<Int>.loading.value == nil)
    }
}

struct CancellationErrorTests {

    @Test func recognisesTaskAndURLSessionCancellation() {
        #expect(CancellationError().isCancellation)
        #expect(URLError(.cancelled).isCancellation)
        #expect(!URLError(.timedOut).isCancellation)
        #expect(!TestError().isCancellation)
    }
}
