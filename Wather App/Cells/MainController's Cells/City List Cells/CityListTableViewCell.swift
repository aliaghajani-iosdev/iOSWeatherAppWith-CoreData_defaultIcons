//
//  CityListTableViewCell.swift
//  weather
//
//  Created by Ali Aghajani on 10/1/20.
//

import Foundation
import UIKit

class CityListTableViewCell: UITableViewCell {
    //MARK: - Properties
    let cityListCollctionCellIdentifier = "jblkblblblb"
    var list: [CityID] = []
    var cities: [CityID]?  {
        
        didSet {
            if let existedData = cities {
                list = existedData
                collectionView.reloadData()
            }
          
        }
    }
    
    var delegate: sendBackCityIdDelegate?
    lazy var currentIndex = 0
    
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 5
        layout.estimatedItemSize = CGSize(width: 100 , height: frame.size.height * 0.1)
        
        layout.scrollDirection = .horizontal
        let cl = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cl.backgroundColor = .clear
        cl.clipsToBounds = true
        cl.delegate = self
        cl.dataSource = self
        cl.register(CityListCollectionViewCell.self, forCellWithReuseIdentifier: cityListCollctionCellIdentifier)
        cl.isPagingEnabled = true
        cl.showsHorizontalScrollIndicator = false
        cl.translatesAutoresizingMaskIntoConstraints = false
        return cl
    }()
    
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraint()
        setupUI()
        backgroundColor = .tableViewBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let currentIndexPath = IndexPath(row: self.currentIndex, section: 0)
        self.collectionView.scrollToItem(at: currentIndexPath, at: .left, animated: false)
    }
    
    
    //MARK: - Seting Up constraint for CollectionView
    private func setupConstraint() {
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            collectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

extension CityListTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cityListCollctionCellIdentifier, for: indexPath) as! CityListCollectionViewCell
        if indexPath.item == currentIndex {
            cell.mainView.backgroundColor = .customPurple
            cell.cityNameLbl.textColor = .white
        } else {
            cell.mainView.backgroundColor = .clear
            cell.cityNameLbl.textColor = .slate
        }
        cell.Data = list[indexPath.row]
        cell.cellIndex = indexPath.row
        cell.delegate = self
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: edgeSpacing, bottom: 0, right: edgeSpacing * 2)
    }
}

extension CityListTableViewCell: SendingBackIndexAndIDDelegate {

    
    func makeNiewRequest(_ index: Int, _ id: Int) {
        let lastCell = self.collectionView.cellForItem(at: NSIndexPath(row: currentIndex, section: 0) as IndexPath) as? CityListCollectionViewCell
        lastCell?.mainView.backgroundColor = .clear
        lastCell?.cityNameLbl.textColor = .slate
        let currentCell = self.collectionView.cellForItem(at: NSIndexPath(row: currentIndex, section: 0) as IndexPath) as? CityListCollectionViewCell
        currentCell?.mainView.backgroundColor = .customPurple
        currentCell?.cityNameLbl.textColor = .white
        currentCell?.cellIndex = index
        
        currentIndex = index
        
        
        delegate?.makeRequestWithID(id)
    }
    
    
}
