//
//  FeatureWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by nikita on 26.10.22.
//

import Foundation
import UIKit
import SnapKit

struct FeatureWeatherTableViewCellModel {
    let date: String
    let weatherIcon: UIImage
    let degrees: String
}

final class FeatureWeatherTableViewCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Tuesday, 14"
        label.textColor = Constants.textColor
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cloud.drizzle")?.withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.tintColor = Constants.textColor
        return image
    }()
    
    private lazy var degreesLabel: UILabel = {
        let label = UILabel()
        label.text = "18º4º"
        label.textColor = Constants.textColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(stackView)
        [dateLabel, weatherIcon, degreesLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraint() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setup(with model: FeatureWeatherTableViewCellModel) {
        dateLabel.text = model.date
        weatherIcon.image = model.weatherIcon
        degreesLabel.text = model.degrees
    }
}
