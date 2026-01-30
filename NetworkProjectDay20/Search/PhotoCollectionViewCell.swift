//
//  PhotoCollectionViewCell.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
        
    let imageView = UIImageView()
    let stackView = UIStackView()
    let starImage = UIImageView()
    let countLabel = UILabel()
    
    let heartImage = UIImageView()
    
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
            imageView, stackView, heartImage
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
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        starImage.snp.makeConstraints { make in
            make.size.equalTo(15)
        }
        countLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        heartImage.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(imageView).inset(10)
            make.size.equalTo(30)
            
        }
    }
    
    func configureView() {
        
        imageView.image = UIImage(systemName: "circle")
        
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray2
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = UIColor.yellow
        countLabel.text = "1000"
        countLabel.textColor = .white
        
        heartImage.image = UIImage(systemName: "heart")
        heartImage.backgroundColor = .white
        heartImage.clipsToBounds = true
        heartImage.layer.cornerRadius = 15
        heartImage.contentMode = .center
    }
    
    func configureImageCell(text: String) {
        let url = URL(string: text)
        imageView.kf.setImage(with: url)

    }
    
    func configureCountCell(int: Int) {
        countLabel.text = int.formatted()

    }
}
