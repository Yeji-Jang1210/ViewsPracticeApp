//
//  TravelTalkVC.swift
//  ViewsPracticeApp
//
//  Created by 장예지 on 7/20/24.
//

import UIKit
import SnapKit

final class TravelTalkVC: UIViewController {
    
    enum Section: CaseIterable {
        case all
    }
    
    private lazy var collectionView: UICollectionView = {
        let object = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        object.register(TravelTalkCollectionViewCell.self, forCellWithReuseIdentifier: TravelTalkCollectionViewCell.identifier)
        return object
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, ChatRoom>!
    private var viewModel: TravelTalkVM!
    
    init(){
        super.init(nibName: nil, bundle: nil)
        viewModel = TravelTalkVM()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    private func configureHierarchy(){
        view.addSubview(collectionView)
    }
    
    private func configureLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI(){
        configureNavigationBar()
        configureDataSource()
        configureSnapshot()
    }
    
    private func configureNavigationBar(){
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        navigationItem.title = "TRAVEL TALK"
    }
    
    private func createLayout() -> UICollectionViewLayout {
           let itemSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .absolute(66)
           )
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
           let groupSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .absolute(74)
           )
        
           let group = NSCollectionLayoutGroup.vertical(
               layoutSize: groupSize,
               subitems: [item]
           )
           
           let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
           
           let layout = UICollectionViewCompositionalLayout(section: section)
           return layout
   }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelTalkCollectionViewCell.identifier, for: indexPath) as! TravelTalkCollectionViewCell
            cell.setData(itemIdentifier)
            return cell
        }
    }
    
    private func configureSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatRoom>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(mockChatList, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

