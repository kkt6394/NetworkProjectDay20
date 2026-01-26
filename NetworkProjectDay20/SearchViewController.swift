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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            pageTitle, searchBar
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
    }
    override func configureView() {
        super.configureView()
        pageTitle.text = "SEARCH PHOTO"
        pageTitle.font = .boldSystemFont(ofSize: 18)
        pageTitle.textAlignment = .center
        
        searchBar.placeholder = "키워드 검색"
        searchBar.searchTextField.backgroundColor = .systemGray5
    }

}

