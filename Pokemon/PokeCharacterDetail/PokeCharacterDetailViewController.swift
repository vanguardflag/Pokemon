//
//  PokeCharacterDetailViewController.swift
//  Pokemon
//
//  Created by Jalal Najafi on 11/02/2021.
//

import Foundation
import UIKit

protocol PokeCharacterDetailDisplayLogic {
    func displayPokemonDetail(pokemon: FetchPokeCharacterDetail.PresentResponse)
}


class PokeCharacterDetailViewController: UIViewController {
    
    //MARK: - Properties
    private let contentView = PokeCharacterDetailView(frame: UIScreen.main.bounds)
    private var presenter: PokeCharacterDetailViewToPresenterProtocol? = nil
    private var pokemon: [FeatureSection] = []
    
 
    //MARK: LifeCycle
    init(presenter: PokeCharacterDetailViewToPresenterProtocol?) {
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
        let character = presenter?.fetchPokeCharacter()
        pokemon = character?.features ?? []
        contentView.configureImage(with: character?.image)
        setupCollectionView()
        setupNavigationBar(title: character?.name ?? "")
    }

    //MARK: - Private Func
    private func setupCollectionView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(PokeCharacterDetailCell.self, forCellReuseIdentifier: PokeCharacterDetailCell.identifier)
    }
    
    private func setupNavigationBar(title: String){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = title
    }
}

extension PokeCharacterDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon[section].features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeCharacterDetailCell.identifier) as? PokeCharacterDetailCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: pokemon[indexPath.section].features[indexPath.row].value ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


extension PokeCharacterDetailViewController:UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
            switch section {
                case 0:
                    sectionName = TitleFeature.characteristic.rawValue
                case 1:
                    sectionName = TitleFeature.abilities.rawValue
                case 2:
                    sectionName = TitleFeature.gameIndices.rawValue
                case 3:
                    sectionName = TitleFeature.heldItems.rawValue
                case 4:
                    sectionName = TitleFeature.moves.rawValue
                case 5:
                    sectionName = TitleFeature.stats.rawValue
                case 6:
                    sectionName = TitleFeature.types.rawValue
                default:
                    sectionName = ""
            }
            return sectionName
    }
}
