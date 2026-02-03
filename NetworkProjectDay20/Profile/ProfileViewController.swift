//
//  ProfileViewController.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 2/3/26.
//

import UIKit
import SnapKit

final class ProfileViewController: BaseViewController {
    
    private let firstTF = UITextField()
    private let secondTF = UITextField()
    private let thirdTF = UITextField()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func configureHierarchy() {
        [
            firstTF, secondTF, thirdTF, button
        ].forEach { view.addSubview($0) }
    }
    override func configureLayout() {
        firstTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(60)
        }
        secondTF.snp.makeConstraints { make in
            make.top.equalTo(firstTF.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(60)
            
        }
        thirdTF.snp.makeConstraints { make in
            make.top.equalTo(secondTF.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(60)
            
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(thirdTF.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(50)
        }
    }
    override func configureView() {
        firstTF.placeholder = "YEAR"
        firstTF.backgroundColor = .systemGray6
        firstTF.layer.cornerRadius = 20
        firstTF.clipsToBounds = true
        
        secondTF.placeholder = "MONTH"
        secondTF.backgroundColor = .systemGray6
        secondTF.layer.cornerRadius = 20
        secondTF.clipsToBounds = true
        
        thirdTF.placeholder = "DAY"
        thirdTF.backgroundColor = .systemGray6
        thirdTF.layer.cornerRadius = 20
        thirdTF.clipsToBounds = true
        
        button.setTitle("BUTTON", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    @objc
    private func buttonTapped() {
        // 버튼 눌렀을 때, 3개의 텍스트필드 다 검증해야함.
        // 성공 시 텍스트필드 값이 버튼으로
        // 실패 시 실패 사유를 버튼으로
        guard let first = firstTF.text else { return }
        guard let second = secondTF.text else { return }
        guard let third = thirdTF.text else { return }

        do {
            let result = try validate(year: first, month: second, day: third)
            button.setTitle("생년월일 기입이 성공했습니다.", for: .normal)
        } catch {
            button.setTitle(error.errorDescription, for: .normal)
        }
    }
    
    private func validate(year: String, month: String, day: String) throws(ProfileError) -> Bool {
        guard !year.isEmpty && !month.isEmpty && !day.isEmpty else {
            print("빈 값")
            throw .empty
        }
        guard Int(year) != nil && (Int(month) != nil) && (Int(day) != nil) else {
            print("숫자 아님")
            throw .isNotNumber
        }
        let yearRange = Range(1900...2026)
        let monthRange = Range(1...12)
        let dayRange = Range(1...31)
        guard yearRange.contains(Int(year)!) && monthRange.contains(Int(month)!) && dayRange.contains(Int(day)!) else {
            print("범위 벗어남")
            throw .outOfRange
            
        }
        return true

    }
}
