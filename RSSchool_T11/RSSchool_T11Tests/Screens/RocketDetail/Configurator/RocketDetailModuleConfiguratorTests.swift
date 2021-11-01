//
//  RocketDetailModuleConfiguratorTests.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import XCTest
@testable import RSSchool_T11

final class RocketDetailModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: RocketDetailViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load RocketDetailViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = RocketDetailModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "RocketDetailViewController is nil after configuration")
        XCTAssertTrue(viewController.output is RocketDetailPresenter, "output is not RocketDetailPresenter")

        guard let presenter: RocketDetailPresenter = viewController.output as? RocketDetailPresenter else {
            XCTFail("Cannot assign viewController.output as RocketDetailPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in RocketDetailPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in RocketDetailPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is RocketDetailRouter, "router is not RocketDetailRouter")

        guard let router: RocketDetailRouter = presenter.router as? RocketDetailRouter else {
            XCTFail("Cannot assign presenter.router as RocketDetailRouter")
            return
        }

        XCTAssertTrue(router.view is RocketDetailViewController, "view in router is not RocketDetailViewController")
    }

}
