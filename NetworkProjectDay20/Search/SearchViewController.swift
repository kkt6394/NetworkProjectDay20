//
//  SearchViewController.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit
import SnapKit

class SearchViewController: BaseViewController {

    let pageTitle = UILabel()
    let searchBar = UISearchBar()
    lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            pageTitle, searchBar, colorCollectionView
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
    }
    override func configureView() {
        super.configureView()
        pageTitle.text = "SEARCH PHOTO"
        pageTitle.font = .boldSystemFont(ofSize: 18)
        pageTitle.textAlignment = .center
        
        searchBar.placeholder = "키워드 검색"
        searchBar.searchTextField.backgroundColor = .systemGray5
    }
    
    func configureCollectionView() {
        colorCollectionView.register(
            ColorCollectionViewCell.self,
            forCellWithReuseIdentifier: String(
                describing: ColorCollectionViewCell.self
            )
        )
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
    }
    
    func setCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width / 5
        layout.itemSize = CGSize(width: width, height: 44)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        layout.minimumInteritemSpacing = 10
        
        return layout
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Color.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCollectionViewCell.self), for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(text: Color.allCases[indexPath.row].colorName)
        return cell
    }
    
    
    
    
}
