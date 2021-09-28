//
//  RocketsListModuleConfiguratorTests.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 28/09/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import XCTest
@testable import RSSchool_T11

final class RocketsListModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: RocketsListViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load RocketsListViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = RocketsListModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "RocketsListViewController is nil after configuration")
        XCTAssertTrue(viewController.output is RocketsListPresenter, "output is not RocketsListPresenter")

        guard let presenter: RocketsListPresenter = viewController.output as? RocketsListPresenter else {
            XCTFail("Cannot assign viewController.output as RocketsListPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in RocketsListPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in RocketsListPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is RocketsListRouter, "router is not RocketsListRouter")

        guard let router: RocketsListRouter = presenter.router as? RocketsListRouter else {
            XCTFail("Cannot assign presenter.router as RocketsListRouter")
            return
        }

        XCTAssertTrue(router.view is RocketsListViewController, "view in router is not RocketsListViewController")
    }

}
