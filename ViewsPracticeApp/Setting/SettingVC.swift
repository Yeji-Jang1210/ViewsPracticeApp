//
//  SettingVC.swift
//  ViewsPracticeApp
//
//  Created by 장예지 on 7/19/24.
//

import UIKit
import SnapKit



final class SettingVC: UIViewController {
    enum Section: String, CaseIterable {
        case all = "전체 설정"
        case personal = "개인 설정"
        case etc = "기타"
    }
    
    private lazy var collectionView = {
        let object = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        object.register(SettingHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingHeaderView.identifier)
        
        return object
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    private let list: [Section: [String]] = [.all: ["공지사항", "실험실", "버전 정보"],
                                             .personal: ["개인/보안", "채팅", "멀티프로필"],
                                             .etc: ["고객센터/도움말"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        navigationItem.titleView?.tintColor = .white
        navigationController?.title = "설정"
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        configureSnapshot()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .clear
        
        var separator = UIListSeparatorConfiguration(listAppearance: .plain)
        separator.color = .white
        configuration.separatorConfiguration = separator
        
        configuration.headerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func configureDataSource(){
        let registration: UICollectionView.CellRegistration<UICollectionViewCell, String?> = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            guard let item = itemIdentifier else { return }
            
            var content = UIListContentConfiguration.valueCell()
            content.text = item
            content.textProperties.font = .systemFont(ofSize: 14, weight: .bold)
            content.textProperties.color = .white
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView){ collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SettingHeaderView.identifier, for: indexPath) as? SettingHeaderView
            
            header?.titleLabel.text = Section.allCases[indexPath.section].rawValue
            return header
        }
    }
    
    private func configureSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections(Section.allCases)
        
        for section in Section.allCases {
            snapshot.appendItems(list[section] ?? [], toSection: section)
        }
        
        dataSource.apply(snapshot)
        
    }
}
