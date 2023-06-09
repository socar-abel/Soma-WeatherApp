//
//  HomeViewController.swift
//  Home
//
//  Created by 김상우 on 2023/04/01.
//  Copyright © 2023 soma. All rights reserved.
//

import CommonUI
import UIKit
import SnapKit
import RxSwift

public class HomeViewController: BaseViewController {
    let viewModel: HomeViewModel
    let detailView = WeatherDetailView()
    let collectionView = WeatherCollectionView(frame: CGRect.zero, collectionViewLayout: WeatherCollectionViewFlowLayout())
    
    public init(homeViewModel: HomeViewModel) {
        self.viewModel = homeViewModel
        super.init()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func setupViewProperty() {
        view.layer.insertSublayer(CommonUIAssets.homeViewGradientLayer(view), at: 0)
    }
    
    public override func setupHierarchy() {
        [detailView, collectionView].forEach{ view.addSubview($0) }
    }
    
    public override func setupDelegate() {
        collectionView.delegate = self
    }
    
    public override func setupLayout() {
        let guide = view.safeAreaLayoutGuide
        detailView.snp.makeConstraints {
            $0.top.equalTo(guide.snp.top).offset(50)
            $0.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(detailView.snp.bottom).offset(60)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-32)
            $0.height.equalTo(100)
        }
    }
    
    public override func setupBind() {
        // 현재 날씨 데이터
        viewModel.weatherRelay
            .subscribe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { (owner, response) in
                owner.detailView.bind(weather: response)
            }.disposed(by: disposeBag)
        
        // 시간별 오늘 날씨 데이터
        viewModel.todayForecastRelay
            .subscribe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: TodayWeatherCollectionCell.cellID, cellType: TodayWeatherCollectionCell.self)) { index, data, cell in
                cell.bind(weather: data)
            }.disposed(by: disposeBag)
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
}
