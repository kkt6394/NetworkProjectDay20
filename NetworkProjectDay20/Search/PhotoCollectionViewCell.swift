//
//  PhotoCollectionViewCell.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
        
    let imageView = UIImageView()
    let stackView = UIStackView()
    let starImage = UIImageView()
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        [
            imageView, stackView
        ].forEach { contentView.addSubview($0) }
        
        [
            starImage, countLabel
        ].forEach { stackView.addArrangedSubview($0) }

    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        starImage.snp.makeConstraints { make in
            make.size.equalTo(15)
        }
        countLabel.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(15)
        }
    }
    
    func configureView() {
        
        imageView.image = UIImage(systemName: "circle")
        
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        
        starImage.image = UIImage(systemName: "star")
        countLabel.text = "1000"
    }
    
    func configureCell(text: String) {

    }
}
