//
//  TopicViewController.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/27/26.
//

import UIKit
import SnapKit

class TopicViewController: BaseViewController {

    let userBtn = UIButton()
    let titleLabel = UILabel()
    
    let goldenLabel = UILabel()
    lazy var firstCV = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    let businessLabel = UILabel()
    lazy var secondCV = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    let architectureLabel = UILabel()
    lazy var thirdCV = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCV()
    }
    override func configureHierarchy() {
        super.configureHierarchy()
        [
            userBtn, titleLabel, goldenLabel, firstCV, businessLabel, secondCV, architectureLabel, thirdCV
        ].forEach { view.addSubview($0) }
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
        
        goldenLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(10)
        }
        firstCV.snp.makeConstraints { make in
            make.top.equalTo(goldenLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
        }
        businessLabel.snp.makeConstraints { make in
            make.top.equalTo(firstCV.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        secondCV.snp.makeConstraints { make in
            make.top.equalTo(businessLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
        }
        architectureLabel.snp.makeConstraints { make in
            make.top.equalTo(secondCV.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        thirdCV.snp.makeConstraints { make in
            make.top.equalTo(architectureLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
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
}

extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCV {
            return 2
        } else if collectionView == secondCV {
            return 2
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GoldenCollectionViewCell.self), for: indexPath) as? GoldenCollectionViewCell else { return UICollectionViewCell() }
                    return cell
        } else if collectionView == secondCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BusinessCollectionViewCell.self), for: indexPath) as? BusinessCollectionViewCell else { return UICollectionViewCell() }
                    return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ArchitectureCollectionViewCell.self), for: indexPath) as? ArchitectureCollectionViewCell else { return UICollectionViewCell() }
                    return cell
        }
    }
    
    func setCV() {
        firstCV.delegate = self
        firstCV.dataSource = self
        firstCV.register(
            GoldenCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: GoldenCollectionViewCell.self)
        )
        
        secondCV.delegate = self
        secondCV.dataSource = self
        secondCV.register(
            BusinessCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: BusinessCollectionViewCell.self)
        )
        
        thirdCV.delegate = self
        thirdCV.dataSource = self
        thirdCV.register(
            ArchitectureCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: ArchitectureCollectionViewCell.self)
        )
    }
    
    func configureLayout() -> UICollectionViewLayout {
        var layout = UICollectionViewFlowLayout()
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
