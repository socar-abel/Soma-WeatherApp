//
//  WeatherDetailView.swift
//  CommonUI
//
//  Created by 김상우 on 2023/04/02.
//  Copyright © 2023 soma. All rights reserved.
//

import Domain
import UIKit
import SnapKit
import Kingfisher

open class WeatherDetailView: UIView {
    var superView = UIView()
    var dateLabel = UILabel()
    var weatherImageView = UIImageView()
    var descriptionLabel = UILabel()
    var tempLabel = UILabel()
    var tempMaxLabel = UILabel()
    var tempMinLabel = UILabel()
    var humidityLabel = UILabel()
    let viewHeight: CGFloat = 360
    let viewWidth: CGFloat = 300
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initAttribute()
        initUI()
    }
    
    public func bind(weather: WeatherVO) {
        if let url = URL(string: weather.weatherIcon) {
            weatherImageView.kf.setImage(with: url)
        }
        descriptionLabel.text = weather.weatherDescription
        tempLabel.text = "Current  \(Int(weather.temp))°C"
        tempMaxLabel.text = "Highest  \(Int(weather.tempMax))°C"
        tempMinLabel.text = "Lowest  \(Int(weather.tempMin))°C"
        humidityLabel.text = "Humidity  \(weather.humidity)%"
    }

    func initAttribute() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 28
        superView.backgroundColor = .white
        superView.layer.cornerRadius = 28
        superView.layer.masksToBounds = false
        superView.layer.applyShadow(color: .black, alpha: 0.16, x: 0, y: 0, blur: 30)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMMM d (EEE) HH"
        let now = Date()
        let formattedDate = dateFormatter.string(from: now)
        
        dateLabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = formattedDate
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        
        weatherImageView = {
            let imageview = UIImageView()
            imageview.backgroundColor = .white
            imageview.contentMode = .scaleAspectFit
            imageview.layer.masksToBounds = false
            return imageview
        }()
        
        descriptionLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 22)
            return label
        }()
        
        tempLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
        
        tempMaxLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
        
        tempMinLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
        
        humidityLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
    }
    
    
    func initUI() {
        self.addSubview(superView)
        
        self.snp.makeConstraints {
            $0.height.equalTo(viewHeight)
            $0.width.equalTo(viewWidth)
        }
        
        superView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [dateLabel, weatherImageView, descriptionLabel, tempLabel, tempMaxLabel, tempMinLabel, humidityLabel]
            .forEach { superView.addSubview($0) }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(12)
            $0.width.equalTo(140)
            $0.height.equalTo(140)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        tempMaxLabel.snp.makeConstraints {
            $0.top.equalTo(tempLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        tempMinLabel.snp.makeConstraints {
            $0.top.equalTo(tempMaxLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        humidityLabel.snp.makeConstraints {
            $0.top.equalTo(tempMinLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
