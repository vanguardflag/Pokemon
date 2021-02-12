//
//  PokeCharacterListCell.swift
//  Pokemon
//
//  Created by Jalal Najafi on 10/02/2021.
//

import Foundation
import UIKit
import Kingfisher

class PokeCharacterListCell: UICollectionViewCell {
    static let identifier = "PokemonCellIdentifier"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private(set) lazy var label: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        return label
    }()

    override func prepareForReuse() {
        imageView.image = nil
    }
    private override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addShadow()
        addSubviews()
        makeConstraints()
    }
    
    func addShadow(){
        // corner radius
        self.contentView.layer.cornerRadius = 10

        // border
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.black.cgColor

        // shadow
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.contentView.layer.shadowOpacity = 0.7
        self.contentView.layer.shadowRadius = 4.0
    }

    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }

    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(label.snp.top)
        }
        label.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    
    func configureCell(with url: URL?,name: String) {
        label.text = name
        let placeholderImage = UIImage(named: "placeHolder")
        guard let url = url else {
            imageView.image = placeholderImage
            return
        }
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result{
            case .success(let image):
                self.imageView.image = image.image
            case .failure(_):
                self.imageView.image = placeholderImage
            }
        }
    }
}
