//
//  TopicViewController.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/27/26.
//

import UIKit
import SnapKit

class TopicViewController: BaseViewController {
    
    var firstData: [TopicData] = []
    var secondData: [TopicData] = []
    var thirdData: [TopicData] = []
    
    let userBtn = UIButton()
    let titleLabel = UILabel()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let goldenLabel = UILabel()
    lazy var firstCV = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    let businessLabel = UILabel()
    lazy var secondCV = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    let architectureLabel = UILabel()
    lazy var thirdCV = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setCV()
        callRequest(TopicID.golden.rawValue)
        callRequest(TopicID.business.rawValue)
        callRequest(TopicID.architect.rawValue)
    }
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            userBtn, titleLabel, scrollView
        ].forEach { view.addSubview($0) }
        
        scrollView.addSubview(contentView)
        [
            goldenLabel, firstCV, businessLabel, secondCV, architectureLabel, thirdCV
        ].forEach { contentView.addSubview($0)}
    }
    
    override func configureLayout() {
        super.configureLayout()
        userBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview()
            make.size.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(userBtn.snp.bottom).offset(10)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.verticalEdges.equalTo(scrollView.contentLayoutGuide)
        }
        
        goldenLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        firstCV.snp.makeConstraints { make in
            make.top.equalTo(goldenLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(247)
            
        }
        businessLabel.snp.makeConstraints { make in
            make.top.equalTo(firstCV.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        secondCV.snp.makeConstraints { make in
            make.top.equalTo(businessLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(247)
            
        }
        architectureLabel.snp.makeConstraints { make in
            make.top.equalTo(secondCV.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        thirdCV.snp.makeConstraints { make in
            make.top.equalTo(architectureLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(247)
            make.bottom.equalToSuperview().offset(-20)
            
        }
    }
    override func configureView() {
        super.configureView()
        userBtn.setImage(UIImage(systemName: "person.fill"), for: .normal)
        
        titleLabel.text = "OUR TOPIC"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        goldenLabel.text = "골든 아워"
        goldenLabel.font = .boldSystemFont(ofSize: 16)
        
        businessLabel.text = "비즈니스 및 업무"
        businessLabel.font = .boldSystemFont(ofSize: 16)
        
        architectureLabel.text = "건축 및 인테리어"
        architectureLabel.font = .boldSystemFont(ofSize: 16)
        
    }
    
    func callRequest(_ topicID: String) {
        NetworkManager.shared.callTopicRequest(topicID: topicID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                switch topicID {
                case TopicID.golden.rawValue:
                    self.firstData = success
                    self.firstCV.reloadData()
                    print("first", success)
                    
                case TopicID.business.rawValue:
                    self.secondData = success
                    self.secondCV.reloadData()
                    print("second", success)
                    
                case TopicID.architect.rawValue:
                    self.thirdData = success
                    self.thirdCV.reloadData()
                    print("third", success)
                    
                default:
                    print(success)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCV {
            return firstData.count
        } else if collectionView == secondCV {
            return secondData.count
        } else {
            return thirdData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            cell.configureImageCell(text: firstData[indexPath.item].urls.small)
            cell.configureCountCell(int: firstData[indexPath.item].likes)
            return cell
            
        } else if collectionView == secondCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            cell.configureImageCell(text: secondData[indexPath.item].urls.small)
            cell.configureCountCell(int: secondData[indexPath.item].likes)
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            cell.configureImageCell(text: thirdData[indexPath.item].urls.small)
            cell.configureCountCell(int: thirdData[indexPath.item].likes)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let statVC = StatisticsViewController()
        
        if collectionView == firstCV {
            NetworkManager.shared.callStatisticsRequest(id: firstData[indexPath.item].id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    statVC.topicData = self.firstData[indexPath.item]
                    statVC.statData = success
                    statVC.configureTopic()
                    self.navigationController?.pushViewController(statVC, animated: true)
                case .failure(let failure):
                    print("실패", failure)
                }
            }
        } else if collectionView == secondCV {
            NetworkManager.shared.callStatisticsRequest(id: secondData[indexPath.item].id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    statVC.topicData = self.secondData[indexPath.item]
                    statVC.statData = success
                    statVC.configureTopic()
                    self.navigationController?.pushViewController(statVC, animated: true)
                case .failure(let failure):
                    print("실패", failure)
                }
            }
        } else {
            NetworkManager.shared.callStatisticsRequest(id: thirdData[indexPath.item].id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    statVC.topicData = self.thirdData[indexPath.item]
                    statVC.statData = success
                    statVC.configureTopic()
                    self.navigationController?.pushViewController(statVC, animated: true)
                case .failure(let failure):
                    print("실패", failure)
                }
            }
        }
    }
    func setCV() {
        firstCV.delegate = self
        firstCV.dataSource = self
        firstCV.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self)
        )
        
        secondCV.delegate = self
        secondCV.dataSource = self
        secondCV.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self)
        )
        
        thirdCV.delegate = self
        thirdCV.dataSource = self
        thirdCV.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self)
        )
    }
    
    func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = (UIScreen.main.bounds.width - 22) / 2
        let height = width * 1.3
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        return layout
    }
    
    
}
