//
//  PokeCharacterDetailView.swift
//  Pokemon
//
//  Created by Jalal Najafi on 11/02/2021.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class PokeCharacterDetailView: UIView {

    public lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()
    
    
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        tableView.allowsSelection = false
        tableView.separatorInsetReference = .fromCellEdges
        return tableView
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        backgroundColor = .white
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        addSubview(imageView)
        addSubview(tableView)

    }
    
    func makeConstraints() {
        

        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(91)
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
        }
        
        
    }
    
    func configureImage(with url: URL?) {
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
