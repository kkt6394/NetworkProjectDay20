//
//  StatisticsViewController.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/28/26.
//

import UIKit
import SnapKit
import Kingfisher

class StatisticsViewController: BaseViewController {
    
    var statData: StatisticsData?
    var searchData: SearchData.Result?
    
    
    var profileImageUrl: String?
    var mainImageUrl: String?
    var name: String?
    var date: String?
    
    let profileImage = UIImageView()

    let profileStackView = UIStackView()
    let nameLabel = UILabel()
    let createdDay = UILabel()
    
    let heartImage = UIImageView()
    
    let mainImageView = UIImageView()
    
    let infoLabel = UILabel()

    let sizeLabel = UILabel()
    let resolutionLabel = UILabel()
    let viewLabel = UILabel()
    let viewCountLabel = UILabel()
    let downloadLabel = UILabel()
    let downloadCountLabel = UILabel()
    
    let chartLabel = UILabel()
    
    let segCtr = UISegmentedControl()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func configureHierarchy() {
        [
            profileImage, profileStackView, heartImage, mainImageView, infoLabel, sizeLabel, resolutionLabel, viewLabel, viewCountLabel, downloadLabel, downloadCountLabel, chartLabel, segCtr
        ].forEach { view.addSubview($0) }
        
        [
            nameLabel, createdDay
        ].forEach { profileStackView.addArrangedSubview($0) }
        
    }
    override func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(48)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
            make.height.equalTo(48)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(24)
        }
        createdDay.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(24)
        }
        heartImage.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(48)
        }
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview()
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
        }
        sizeLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(14)
            make.leading.equalTo(infoLabel.snp.trailing).offset(40)
        }
        resolutionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sizeLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        viewLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeLabel.snp.bottom).offset(10)
            make.leading.equalTo(sizeLabel)
        }
        viewCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(viewLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        downloadLabel.snp.makeConstraints { make in
            make.top.equalTo(viewLabel.snp.bottom).offset(10)
            make.leading.equalTo(sizeLabel)
        }
        downloadCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(downloadLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        chartLabel.snp.makeConstraints { make in
            make.top.equalTo(downloadLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        segCtr.snp.makeConstraints { make in
            make.top.equalTo(chartLabel)
            make.leading.equalTo(sizeLabel)
        }
    }
    override func configureView() {
        
    }
    
    func configureSearch() {
        let url = searchData?.user.profile_image.medium
        profileImage.kf.setImage(with: URL(string: url!))
        profileStackView.axis = .vertical
        profileStackView.spacing = 0
        profileStackView.alignment = .leading
        profileStackView.distribution = .equalSpacing
        nameLabel.text = searchData?.user.name
//        nameLabel.text = "이름입니다."
        createdDay.text = searchData?.created_at
//        createdDay.text = "yyyy년 mm월 dd일 게시됨"
        heartImage.image = UIImage(systemName: "heart")
        let mainUrl = searchData?.urls.small
        mainImageView.kf.setImage(with: URL(string: mainUrl!))
        infoLabel.text = "정보"
        sizeLabel.text = "크기"
        resolutionLabel.text = "\(searchData?.width ?? 0) x \(searchData?.height ?? 0)"
        viewLabel.text = "조회수"
        viewCountLabel.text = statData?.views.total.formatted()
        print("&&&&&&&&&&&&&&", statData)
        downloadLabel.text = "다운로드"
        downloadCountLabel.text = statData?.downloads.total.formatted()
        chartLabel.text = "차트"
    }

}
