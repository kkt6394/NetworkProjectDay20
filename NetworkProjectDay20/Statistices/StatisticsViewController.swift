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
    
    var closureData: ((Bool) -> Void)?

    lazy var key = searchData?.id
    lazy var buttonTag = UserDefaults.standard.bool(forKey: key ?? "")
    
    var statData: StatisticsData?
    var searchData: SearchData.Result?
    var topicData: TopicData?
    
    var profileImageUrl: String?
    var mainImageUrl: String?
    var name: String?
    var date: String?
    
    let scrollView = UIScrollView()
    let contentsView = UIView()
    
    let profileImage = UIImageView()
    
    let profileStackView = UIStackView()
    let nameLabel = UILabel()
    let createdDay = UILabel()
    
    let heartImageBtn = UIButton()
    
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
        setBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        let imageName = buttonTag ? "heart.fill" : "heart"
        heartImageBtn.setImage(UIImage(systemName: imageName), for: .normal)
    }
    override func configureHierarchy() {
        [
            profileImage, profileStackView, heartImageBtn, scrollView
        ].forEach { view.addSubview($0) }
        
        [
            contentsView
        ].forEach { scrollView.addSubview($0) }
        
        [
            mainImageView, infoLabel, sizeLabel, resolutionLabel, viewLabel, viewCountLabel, downloadLabel, downloadCountLabel, chartLabel, segCtr
        ].forEach { contentsView.addSubview($0) }
        
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
        heartImageBtn.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(30)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(14)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        contentsView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.verticalEdges.equalTo(scrollView.contentLayoutGuide)

        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
            make.bottom.equalToSuperview().inset(30)
        }
    }
    override func configureView() {
        
    }
    
    func setBtn() {
        heartImageBtn.addTarget(self, action: #selector(heartImageBtnTapped), for: .touchUpInside)
    }
    
    @objc
    func heartImageBtnTapped() {
        if buttonTag {
            // 좋아요 상태
            UserDefaults.standard.set(false, forKey: key ?? "")
            heartImageBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            closureData?(false)
        } else {
            UserDefaults.standard.set(true, forKey: key ?? "")

            heartImageBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            closureData?(true)
        }
        
    }
    
    func configureSearch() {
        let url = searchData?.user.profile_image.medium
        profileImage.kf.setImage(with: URL(string: url!))
        profileImage.layer.cornerRadius = 24
        profileImage.clipsToBounds = true
        profileStackView.axis = .vertical
        profileStackView.spacing = 0
        profileStackView.alignment = .leading
        profileStackView.distribution = .equalSpacing
        nameLabel.text = searchData?.user.name
        createdDay.text = searchData?.created_at
        heartImageBtn.setImage(UIImage(systemName: "heart"), for: .normal)
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
    
    func configureTopic() {
        let url = topicData?.user.profile_image.medium
        profileImage.kf.setImage(with: URL(string: url!))
        profileImage.layer.cornerRadius = 24
        profileImage.clipsToBounds = true
        profileStackView.axis = .vertical
        profileStackView.spacing = 0
        profileStackView.alignment = .leading
        profileStackView.distribution = .equalSpacing
        nameLabel.text = topicData?.user.name
        createdDay.text = topicData?.created_at
        heartImageBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        let mainUrl = topicData?.urls.small
        mainImageView.kf.setImage(with: URL(string: mainUrl!))
        infoLabel.text = "정보"
        sizeLabel.text = "크기"
        resolutionLabel.text = "\(topicData?.width ?? 0) x \(topicData?.height ?? 0)"
        viewLabel.text = "조회수"
        viewCountLabel.text = statData?.views.total.formatted()
        print("&&&&&&&&&&&&&&", statData)
        downloadLabel.text = "다운로드"
        downloadCountLabel.text = statData?.downloads.total.formatted()
        chartLabel.text = "차트"
        

    }
    
}
