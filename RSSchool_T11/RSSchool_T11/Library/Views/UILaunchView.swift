//
//  UIMainInfoView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 6.12.21.
//

import UIKit

class UILaunchView: UIView, ModelDataDisplayable {

    private lazy var launchTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.roboto(24, .bold)
        label.textColor = .black
        label.text = "ASD"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.roboto(17, .medium)
        label.textColor = .black
        label.text = "ASD"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var indicatorView: UIIndicatorView = {
        let view = UIIndicatorView()
        //need to change
        view.setupStyle(.complited)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var launchNumberLabel: UIShadowLabelView = {
        let view = UIShadowLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageView: UIShadowImageView = {
        let view = UIShadowImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .smokyWhite
    }
    
    private func setupSubviews() {
        addSubview(launchTitleLabel)
        addSubview(dateLabel)
        addSubview(stackView)
        addSubview(imageView)
        
        stackView.addArrangedSubview(indicatorView)
        stackView.addArrangedSubview(launchNumberLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 145),
            
            launchTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            launchTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: launchTitleLabel.bottomAnchor, constant: 5),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
            
//            indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
//
//            launchNumberLabel.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 10),
//            launchNumberLabel.bottomAnchor.constraint(equalTo: indicatorView.bottomAnchor),
            
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

//MARK: - API
extension UILaunchView {
    
    func setData(for launch: Launch) {
        
        setupLabelStackData([launchTitleLabel], with: launch.name)
        
        let launchDateString = buildDateString(for: launch.launchDate)
        setupLabelStackData([dateLabel], with: launchDateString)
        
        if let upcoming = launch.upcoming {
            indicatorView.setupStyle(upcoming ? .complited : .expected)
            indicatorView.isHidden = false
        } else {
            indicatorView.isHidden = true
        }
        
        if let flightNumberString = buildFlightNumber(for: launch.flightNumber) {
        launchNumberLabel.setText(flightNumberString)
            launchNumberLabel.isHidden = false
        } else {
            launchNumberLabel.isHidden = true
        }
    }
    
    func setImage(_ image: UIImage) {
        imageView.setImage(image)
    }
}
