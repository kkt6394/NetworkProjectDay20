//
//  TopicViewController.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/27/26.
//

import UIKit
import SnapKit

final class TopicViewController: BaseViewController {
    
    var likedID: Set<String> = []
    
    var selectedTopics: [TopicID] = []
    var topicDataDict: [TopicID: [TopicData]] = [:]
    
    var firstData: [TopicData] = []
    var secondData: [TopicData] = []
    var thirdData: [TopicData] = []
    
    private let userBtn = UIButton()
    private let titleLabel = UILabel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let goldenLabel = UILabel()
    private lazy var firstCV = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    private let businessLabel = UILabel()
    private lazy var secondCV = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    private  let architectureLabel = UILabel()
    private lazy var thirdCV = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setCV()
        fetchAllTopic()
        userBtn.addTarget(self, action: #selector(userBtnTapped), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isTranslucent = true
        if let savedData = UserDefaults.standard.array(forKey: "likedID") as? Array<String> {
            self.likedID = Set(savedData)
        }
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
    
    private func configureTopicLabel() {
        goldenLabel.text = selectedTopics[0].topicLabel
        businessLabel.text = selectedTopics[1].topicLabel
        architectureLabel.text = selectedTopics[2].topicLabel
    }
    
    private func pickRandomTopics() {
        selectedTopics = Array(TopicID.allCases.shuffled().prefix(3))
    }
    @objc
    private func userBtnTapped() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    private func callRequest(_ topicID: String, completion: @escaping () -> Void ) {
        NetworkManager.shared.callRequest(
            api: .topic(
                topicID: topicID
            ),
            type: [TopicData].self,
            completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    switch topicID {
                    case selectedTopics[0].rawValue:
                        self.firstData = success
                        
                    case selectedTopics[1].rawValue:
                        self.secondData = success
                        
                    case selectedTopics[2].rawValue:
                        self.thirdData = success
                        
                    default:
                        print(success)
                    }
                case .failure(let failure):
                    print(failure)
                }
                completion()
            }
        )
    }
    
    private func fetchAllTopic() {
        
        pickRandomTopics()
        configureTopicLabel()
        
        let group = DispatchGroup()
        
        group.enter()
        callRequest(selectedTopics[0].rawValue) {
            group.leave()
        }
        group.enter()
        callRequest(selectedTopics[1].rawValue) {
            group.leave()
        }
        group.enter()
        callRequest(selectedTopics[2].rawValue) {
            group.leave()
        }
        group.notify(queue: .main) {
            self.firstCV.reloadData()
            self.secondCV.reloadData()
            self.thirdCV.reloadData()
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
            
            if likedID.contains(firstData[indexPath.item].id) {
                cell.heartImage.image = UIImage(systemName: "heart.fill")
            } else {
                cell.heartImage.image = UIImage(systemName: "heart")
            }
            return cell
            
        } else if collectionView == secondCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            cell.configureImageCell(text: secondData[indexPath.item].urls.small)
            cell.configureCountCell(int: secondData[indexPath.item].likes)
            
            if likedID.contains(secondData[indexPath.item].id) {
                cell.heartImage.image = UIImage(systemName: "heart.fill")
            } else {
                cell.heartImage.image = UIImage(systemName: "heart")
            }
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            cell.configureImageCell(text: thirdData[indexPath.item].urls.small)
            cell.configureCountCell(int: thirdData[indexPath.item].likes)
            
            if likedID.contains(thirdData[indexPath.item].id) {
                cell.heartImage.image = UIImage(systemName: "heart.fill")
            } else {
                cell.heartImage.image = UIImage(systemName: "heart")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let statVC = StatisticsViewController()
        
        if collectionView == firstCV {
            let photoID = firstData[indexPath.item].id
            statVC.buttonTag = likedID.contains(photoID)
            statVC.closureData = { isliked in
                if isliked {
                    self.likedID.insert(photoID)
                } else {
                    self.likedID.remove(photoID)
                }
                UserDefaults.standard.set(Array(self.likedID), forKey: "likedID")
                self.firstCV.reloadItems(at: [indexPath])
            }
            
            NetworkManager.shared.callRequest(
                api: .stat(
                    id: firstData[indexPath.item].id
                ),
                type: StatisticsData.self,
                completion: { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let success):
                        statVC.topicData = self.firstData[indexPath.item]
                        statVC.statData = success
                        statVC.configureTopic()
                        self.navigationController?.pushViewController(statVC, animated: true)
                    case .failure(let failure):
                        print("실패", failure)
                        ToastManager.showToast(in: self, message: failure.errorDescription)
                    }
                }
            )
            
        } else if collectionView == secondCV {
            let photoID = secondData[indexPath.item].id
            statVC.buttonTag = likedID.contains(photoID)
            statVC.closureData = { isliked in
                if isliked {
                    self.likedID.insert(photoID)
                } else {
                    self.likedID.remove(photoID)
                }
                UserDefaults.standard.set(Array(self.likedID), forKey: "likedID")
                self.secondCV.reloadItems(at: [indexPath])
            }
            
            NetworkManager.shared.callRequest(
                api: .stat(
                    id: secondData[indexPath.item].id
                ),
                type: StatisticsData.self,
                completion: { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let success):
                        statVC.topicData = self.secondData[indexPath.item]
                        statVC.statData = success
                        statVC.configureTopic()
                        self.navigationController?.pushViewController(statVC, animated: true)
                    case .failure(let failure):
                        print("실패", failure)
                        ToastManager.showToast(in: self, message: failure.errorDescription)
                    }
                }
            )
        } else {
            let photoID = thirdData[indexPath.item].id
            statVC.buttonTag = likedID.contains(photoID)
            statVC.closureData = { isliked in
                if isliked {
                    self.likedID.insert(photoID)
                } else {
                    self.likedID.remove(photoID)
                }
                UserDefaults.standard.set(Array(self.likedID), forKey: "likedID")
                self.thirdCV.reloadItems(at: [indexPath])
            }
            NetworkManager.shared.callRequest(
                api: .stat(
                    id: thirdData[indexPath.item].id
                ),
                type: StatisticsData.self,
                completion: { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let success):
                        statVC.topicData = self.thirdData[indexPath.item]
                        statVC.statData = success
                        statVC.configureTopic()
                        self.navigationController?.pushViewController(statVC, animated: true)
                    case .failure(let failure):
                        print("실패", failure)
                        ToastManager.showToast(in: self, message: failure.errorDescription)
                    }
                }
            )            
        }
    }
    private func setCV() {
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
    
    private func configureLayout() -> UICollectionViewLayout {
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
