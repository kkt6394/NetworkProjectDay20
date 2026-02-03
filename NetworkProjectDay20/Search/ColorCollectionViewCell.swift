//
//  ColorCollectionViewCell.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit
import SnapKit

final class ColorCollectionViewCell: UICollectionViewCell {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let label = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        [
            stackView
        ].forEach { contentView.addSubview($0) }
        
        [
            imageView, label
        ].forEach { stackView.addArrangedSubview($0) }

    }
    
    private func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(36)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
    }
    private func configureView() {
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
//        stackView.distribution = .fill
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = .brown
        imageView.contentMode = .scaleAspectFit
        
        label.textAlignment = .center
    }
    
    func configureCell(text: String) {
        label.text = text

    }
    func configureColor(color: UIColor) {
        imageView.tintColor = color
    }
}
