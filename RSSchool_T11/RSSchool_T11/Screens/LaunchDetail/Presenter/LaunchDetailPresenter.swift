//
//  LaunchDetailPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 08/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

final class LaunchDetailPresenter: LaunchDetailViewOutput, LaunchDetailModuleInput {

    // MARK: - Properties

    weak var view: LaunchDetailViewInput?
    var router: LaunchDetailRouterInput?
    var output: LaunchDetailModuleOutput?
    
    var launch: Launch?

    // MARK: - LaunchDetailViewOutput

    // MARK: - LaunchDetailModuleInput

}
