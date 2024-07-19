//
//  SettingHeaderView.swift
//  ViewsPracticeApp
//
//  Created by 장예지 on 7/19/24.
//

import UIKit
import SnapKit

class SettingHeaderView: UICollectionReusableView {
    static let identifier = String(describing: SettingHeaderView.self)
    
    let titleLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 16, weight: .bold)
        object.textColor = .white
        return object
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
}
