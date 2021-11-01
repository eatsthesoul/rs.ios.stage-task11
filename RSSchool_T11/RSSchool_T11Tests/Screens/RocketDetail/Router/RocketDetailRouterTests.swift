//
//  RocketDetailRouterTests.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import XCTest
@testable import RSSchool_T11

final class RocketDetailRouterTests: XCTestCase {

	// MARK: - Properties

    private var view: MockModuleTransitionable?
    private var router: RocketDetailRouter?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        router = RocketDetailRouter()
        view = MockModuleTransitionable()
        router?.view = view
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        router = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class MockModuleTransitionable: ModuleTransitionable {

        func showModule(_ module: UIViewController) {
        }

        func dismissView(animated: Bool, completion: (() -> Void)?) {
        }

        func presentModule(_ module: UIViewController, animated: Bool, completion: (() -> Void)?) {
        }

        func pop(animated: Bool) {
        }

        func push(module: UIViewController, animated: Bool) {
        }

        func push(module: UIViewController, animated: Bool, hideTabBar: Bool) {
        }

    }

}
