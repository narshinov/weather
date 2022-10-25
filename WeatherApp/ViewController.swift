//
//  ViewController.swift
//  WeatherApp
//
//  Created by nikita on 25.10.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Brest, Belarus"
        label.textColor = Constants.textColor
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var weatherStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 32
        return stack
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud.drizzle")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = Constants.mainTextColor
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var degreesLabel: UILabel = {
        let label = UILabel()
        label.text = "14º"
        label.textColor = Constants.mainTextColor
        label.font = .systemFont(ofSize: 56, weight: .bold)
        return label
    }()
    
    private lazy var weatherDescripton: UILabel = {
        let label = UILabel()
        label.text = "Showers"
        label.textColor = Constants.textColor
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var windView: WindView = WindView()
    
    private lazy var featureWeatherTableView: UITableView = {
        let table = UITableView()
        table.register(FeatureWeatherTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.dataSource = self
        table.separatorStyle = .none
        table.isScrollEnabled = false
        table.rowHeight = 32
        table.backgroundColor = .clear
        table.allowsSelection = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstaraints()
    }

    private func setupConstaraints() {
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        weatherStack.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(featureWeatherTableView.snp.top).offset(-16)
//            make.bottom.lessThanOrEqualToSuperview()
        }

        weatherIcon.snp.makeConstraints { make in
            make.height.width.equalTo(86)
        }
        
        featureWeatherTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
    private func setupUI() {
        [locationLabel, weatherStack, featureWeatherTableView].forEach {
            view.addSubview($0)
        }
        
        [weatherIcon, degreesLabel, weatherDescripton, windView].forEach {
            weatherStack.addArrangedSubview($0)
        }
        
        windView.setup(with: WindViewModel(windSpeed: 7))
        view.backgroundColor = Constants.backgroundColor
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "Cell",
                for: indexPath
            ) as? FeatureWeatherTableViewCell
        else { return UITableViewCell() }
        cell.setup(with: FeatureWeatherTableViewCellModel(
            date: "Tuesday, 13",
            weatherIcon: UIImage(systemName: "cloud.drizzle")?.withRenderingMode(.alwaysTemplate) ?? UIImage(),
            degrees: "14º4º")
        )
        return cell
    }
    
    
}

// https://api.openweathermap.org/data/2.5/forecast?q=München,DE&appid=548d7324e744cfdca4c35544ce82391c
