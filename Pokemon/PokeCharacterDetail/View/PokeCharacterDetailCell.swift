//
//  PokeCharacterDetailCell.swift
//  Pokemon
//
//  Created by Jalal Najafi on 11/02/2021.
//

import Foundation
import UIKit
import Kingfisher

class PokeCharacterDetailCell: UITableViewCell {
    static let identifier = "PokemonFeatureCellIdentifier"
    
    
    
    private(set) lazy var label: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        return label
    }()
    
  

   
    
    private override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
    }
    


    private func addSubviews() {
        contentView.addSubview(label)

    }

    private func makeConstraints() {
        
        label.snp.makeConstraints { make in
            make.bottom.leading.trailing.top.equalToSuperview()
        }
    }
    
    
    func configureCell(with title: String) {
        label.text = title
    }
}
