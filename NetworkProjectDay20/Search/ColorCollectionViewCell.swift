//
//  ColorCollectionViewCell.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit
import SnapKit

class ColorCollectionViewCell: UICollectionViewCell {
    let button = {
        let button = UIButton()
        return button
    }()
        
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
            button
        ].forEach { contentView.addSubview($0) }

    }
    
    func configureLayout() {
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }
    func configureView() {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold)
        let image = UIImage(systemName: "circle.fill", withConfiguration: symbolConfig)
        var config = UIButton.Configuration.plain()
        config.image = image
        config.title = "색깔"
        config.imagePadding = 4
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .black
        config.imageColorTransformer = .init { _ in .systemYellow}
        button.configuration = config
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

    }
    
    func configureCell(text: String) {
        button.setTitle(text, for: .normal)

    }
}
