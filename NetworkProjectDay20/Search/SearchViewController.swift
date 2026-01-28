//
//  SearchViewController.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit
import SnapKit

class SearchViewController: BaseViewController {
    
    var data: [SearchData.Result] = []
    
    let pageTitle = UILabel()
    let searchBar = UISearchBar()
    lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setColorCVLayout())
    lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setPhotoCVLayout())
    var defaultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        searchBar.delegate = self
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            pageTitle, searchBar, colorCollectionView, photoCollectionView, defaultLabel
        ].forEach { view.addSubview($0) }
        
    }
    override func configureLayout() {
        super.configureLayout()
        pageTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(44)
        }
        colorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(colorCollectionView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        defaultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    override func configureView() {
        super.configureView()
        pageTitle.text = "SEARCH PHOTO"
        pageTitle.font = .boldSystemFont(ofSize: 18)
        pageTitle.textAlignment = .center
        
        searchBar.placeholder = "키워드 검색"
        searchBar.searchTextField.backgroundColor = .systemGray5
        
        defaultLabel.text = "사진을 검색해보세요"
    }
    
    func configureCollectionView() {
        colorCollectionView.register(
            ColorCollectionViewCell.self,
            forCellWithReuseIdentifier: String(
                describing: ColorCollectionViewCell.self
            )
        )
        photoCollectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: String(
                describing: PhotoCollectionViewCell.self
            )
        )
        
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    func setColorCVLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width / 5
        layout.itemSize = CGSize(width: width, height: 44)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        layout.minimumInteritemSpacing = 10
        
        return layout
    }
    
    func setPhotoCVLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = (UIScreen.main.bounds.width - 22) / 2
        let height = width * 1.3
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        return layout
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorCollectionView {
            return Color.allCases.count
        } else {
            print(data)
            return data.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colorCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ColorCollectionViewCell.self),
                for: indexPath
            ) as? ColorCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(text: Color.allCases[indexPath.item].colorName)
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: PhotoCollectionViewCell.self),
                for: indexPath
            ) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            cell.configureImageCell(text: data[indexPath.item].urls.small)
            cell.configureCountCell(int: data[indexPath.item].likes)
            return cell
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(StatisticsViewController(), animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        NetworkManager.shared.callSearchRequest(query: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
//                self.data.append(contentsOf: success.results)
                self.data = success.results
                print("성공", success.results)
                if !self.data.isEmpty {
                    self.photoCollectionView.reloadData()
                    self.defaultLabel.isHidden = true
                    self.photoCollectionView.isHidden = false

                    
                } else {
                    self.defaultLabel.text = "검색 결과가 없어요"
                    self.defaultLabel.isHidden = false
                    self.photoCollectionView.isHidden = true
                    self.photoCollectionView.reloadData()

                }

            case .failure(let failure):
                
                print("실패", failure)
            }
        }
        searchBar.endEditing(true)
    }
}
