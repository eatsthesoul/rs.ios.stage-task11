//
//  RocketsListViewTests.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 28/09/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import XCTest
@testable import RSSchool_T11

final class RocketsListViewTests: XCTestCase {

    // MARK: - Properties

    private var view: RocketListViewController?
    private var output: RocketsListViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = RocketListViewController()
        output = RocketsListViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class RocketsListViewOutputMock: RocketListViewOutput {
    }

}
