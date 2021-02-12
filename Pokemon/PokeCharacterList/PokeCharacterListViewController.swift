//
//  PokeCharacterListViewController.swift
//  Pokemon
//
//  Created by Jalal Najafi on 10/02/2021.
//

import Foundation
import UIKit


protocol PokeCharacterListDisplayLogic: AnyObject {
    func displayPokeCharatersList(result: FetchPokeCharacterList.PresentResponse)
}


class PokeCharacterListViewController: UIViewController {
    
    //MARK: Properties
    private var presenter: PokeCharacterListViewToPresenterProtocol? = nil
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 3
    private var contentView = PokeCharacterListView(frame: UIScreen.main.bounds)
    private let searchbarView = UISearchBar()
    private var isLoading: Bool = false
    private let distanceUntileEndForLoadingMore: CGFloat = 200
    private let pokeCharactersDataSource: PokeCharactersDataSource = PokeCharactersDataSource()
    
    
    //MARK: LifeCycle
    init(presenter: PokeCharacterListViewToPresenterProtocol?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        presenter?.fetchPokeCharacters(isNext: false)
    }
    
    
    //MARK: - Private Func
    private func setupCollectionView() {
        contentView.collectionView.dataSource = pokeCharactersDataSource
        contentView.collectionView.delegate = self
        contentView.collectionView.register(PokeCharacterListCell.self, forCellWithReuseIdentifier: PokeCharacterListCell.identifier)
    }
    
    private func setupNavigationBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        searchbarView.delegate = self
        searchbarView.placeholder = "Search"
        navigationItem.titleView = searchbarView
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func configureView(hasData: Bool){
        self.contentView.imageView.isHidden = hasData
        self.contentView.collectionView.isHidden = !hasData
    }
    
    private func handleViewWithData(_ characters: ([PokemonViewModel])) {
        pokeCharactersDataSource.configure(characters: characters)
        DispatchQueue.main.async {
            self.contentView.collectionView.reloadData()
            self.configureView(hasData: true)
            
        }
    }
    
    private func handleViewWithOutData() {
        DispatchQueue.main.async {
            self.configureView(hasData: false)
        }
    }
    
    
    private func showAlert() {
        let alert = UIAlertController(title: "OPS", message: "Some thing is Wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}


// MARK: - Collection View Flow Layout Delegate
extension PokeCharacterListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let character = pokeCharactersDataSource.getCharacter(for: indexPath.row) else{
            showAlert()
            return
        }
        presenter?.navigateToDetail(charcter: character)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}


extension PokeCharacterListViewController: UIScrollViewDelegate {
    public func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity _: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !isLoading, presenter?.canLoadMore() ?? false, distance < distanceUntileEndForLoadingMore {
            presenter?.fetchPokeCharacters(isNext: true)
            isLoading = true
        }
    }
}


//MARK: - Display Logic
extension PokeCharacterListViewController: PokeCharacterListDisplayLogic{
    
    func displayPokeCharatersList(result: FetchPokeCharacterList.PresentResponse) {
        switch result {
        case .content(let characters):
            handleViewWithData(characters)
        case .empty:
            handleViewWithOutData()
        case .error(_):
            showAlert()
        }
        isLoading = false
    }
}

// MARK: - Searchbar Delegation
extension PokeCharacterListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let result = pokeCharactersDataSource.searchBy(name: searchText)
        pokeCharactersDataSource.configureSearch(characters: result)
        contentView.collectionView.reloadData()
    }
    
}
