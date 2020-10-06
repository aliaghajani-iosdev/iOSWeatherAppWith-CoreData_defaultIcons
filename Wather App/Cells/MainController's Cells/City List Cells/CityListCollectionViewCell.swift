//
//  CityListCollectionViewCell.swift
//  weather
//
//  Created by Ali Aghajani on 10/1/20.
//

import Foundation
import UIKit

class CityListCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    
    var Data: CityID? {
        didSet {
            if let existedData = Data {
                cityNameLbl.text = existedData.name
                cityId = Int(existedData.id)
                
            }
        }
    }
    
    var isCurrentIndex: Bool = false
    var cellIndex: Int?
    var cityId: Int?
    var delegate: SendingBackIndexAndIDDelegate?
    
    lazy var mainView: UIView = {
        let mv = UIView()
        mv.clipsToBounds = true
        mv.layer.cornerRadius = 12
        mv.isUserInteractionEnabled = true
        mv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellDidSelect)))
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    lazy var cityNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        if isCurrentIndex == true {
            lbl.textColor = .white
        } else {
            lbl.textColor = .slate
            
        }
        
        lbl.font = UIFont(name: "Roboto-Regular", size: 18)
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellDidSelect)))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        backgroundColor = .tableViewBackgroundColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Handling actions when this index selected
    
    
    
    
    
    @objc func cellDidSelect() {
        
        guard let index = cellIndex else {return}
        guard let id = cityId else {return}
        if let delegate = delegate {
            delegate.makeNiewRequest(index, id)
        }
        
    }
    
    //MARK: - seting up constrain for city label
    func setupConstraint() {
        contentView.addSubview(mainView)
        mainView.addSubview(cityNameLbl)
        
        
        NSLayoutConstraint.activate([
            mainView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            cityNameLbl.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 22),
            cityNameLbl.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -22),
            cityNameLbl.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            cityNameLbl.heightAnchor.constraint(equalTo: mainView.heightAnchor, constant: 0.1),
            
        ])
    }
}
