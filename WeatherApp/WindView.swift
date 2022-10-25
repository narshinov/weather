//
//  WindView.swift
//  WeatherApp
//
//  Created by nikita on 25.10.22.
//

import Foundation
import UIKit

struct WindViewModel {
    let windSpeed: Int
}

final class WindView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wind"
        label.textColor = Constants.textColor
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "wind")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = Constants.textColor
        return image
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.textColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [titleLabel, iconView, valueLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setup(with model: WindViewModel) {
        valueLabel.text = "\(model.windSpeed) м/с"
    }
}
