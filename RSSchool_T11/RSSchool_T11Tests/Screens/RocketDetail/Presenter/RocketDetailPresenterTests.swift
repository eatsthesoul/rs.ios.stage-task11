//
//  RocketDetailPresenterTests.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import XCTest
@testable import RSSchool_T11

final class RocketDetailPresenterTest: XCTestCase {

    // MARK: - Properties

    private var presenter: RocketDetailPresenter?
    private var view: MockViewController?
    private var output: MockModuleOutput?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        presenter = RocketDetailPresenter()
        presenter?.router = MockRouter()
        view = MockViewController()
        presenter?.view = view
        output = MockModuleOutput()
        presenter?.output = output
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        view = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class MockRouter: RocketDetailRouterInput {
    }

    private final class MockViewController: RocketDetailViewInput {
    }

    private final class MockModuleOutput: RocketDetailModuleOutput {
    }

}
