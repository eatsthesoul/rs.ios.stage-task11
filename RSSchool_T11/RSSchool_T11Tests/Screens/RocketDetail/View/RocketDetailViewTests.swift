//
//  RocketDetailViewTests.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import XCTest
@testable import RSSchool_T11

final class RocketDetailViewTests: XCTestCase {

    // MARK: - Properties

    private var view: RocketDetailViewController?
    private var output: RocketDetailViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = RocketDetailViewController()
        output = RocketDetailViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class RocketDetailViewOutputMock: RocketDetailViewOutput {
    }

}
