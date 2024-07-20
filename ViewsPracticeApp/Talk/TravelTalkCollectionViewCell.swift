//
//  TravelTalkCollectionViewCell.swift
//  ViewsPracticeApp
//
//  Created by 장예지 on 7/20/24.
//

import UIKit
import SnapKit

final class TravelTalkCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: TravelTalkCollectionViewCell.self)
    
    let imageView: UIImageView = {
        let object = UIImageView()
        object.contentMode = .scaleAspectFill
        object.clipsToBounds = true
        return object
    }()
    
    let userLabel: UILabel = {
        let object = UILabel()
        object.font = .boldSystemFont(ofSize: 14)
        return object
    }()
    
    let chatLabel: UILabel = {
        let object = UILabel()
        object.textColor = .darkGray
        object.font = .systemFont(ofSize: 12)
        return object
    }()
    
    let dateLabel: UILabel = {
        let object = UILabel()
        object.textColor = .darkGray
        object.font = .systemFont(ofSize: 12)
        return object
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy(){
        contentView.addSubview(imageView)
        contentView.addSubview(userLabel)
        contentView.addSubview(chatLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func configureLayout(){
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.verticalEdges.equalTo(contentView).inset(8)
            make.width.equalTo(imageView.snp.height)
        }
        
        userLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.centerY).offset(-4)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.centerY).offset(4)
            make.leading.equalTo(userLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-20)
            make.top.equalTo(userLabel)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
    
    public func setData(_ item: ChatRoom){
        if let imageStr = item.chatroomImage.first, let image = UIImage(named: imageStr) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "emptyProfile")
        }
        
        userLabel.text = item.chatroomName
        chatLabel.text = item.chatList.last?.message
        dateLabel.text = item.chatRoomDate
    }
}
