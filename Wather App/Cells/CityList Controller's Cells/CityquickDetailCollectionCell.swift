import Foundation
import UIKit

class CityquickDetailCollectionCell: UICollectionViewCell {
    //MARK: - Properties
    
    
    var isEditModeOn = true
    
    var isCurrentIndex: Bool = false
    
    
    var defaultMainViewLeftAnchor : NSLayoutConstraint?
    var animatedMainViewLeftAnchor: NSLayoutConstraint?
    
    
    let baseView: UIView = {
        let bv = UIView()
        bv.layer.cornerRadius = 12
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    
    var weatherIconImage: UIImageView = {
        let w = UIImageView()
        w.backgroundColor = .clear
        w.image = UIImage(named: "sun")
        w.contentMode = .scaleAspectFit
        w.clipsToBounds = true
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    
    var dateLbl: UILabel = {
        let w = UILabel()
        w.textColor = .customPurple
        w.text = "7/27/2020"
        w.font = UIFont(name: "Roboto-Medium", size: 12)
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var weatherDegreeLbl: UILabel = {
        let w = UILabel()
        w.textColor = .customPurple
        w.font = UIFont(name: "Roboto-Medium", size: 28)
        w.text = "35 C"
        w.backgroundColor = .clear
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    
    lazy var deleteIcon: UIImageView = {
        let d = UIImageView()
        d.image = UIImage(named: "delete")
        d.contentMode = .scaleAspectFit
        d.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSwipes)))
        d.alpha = 0
        d.translatesAutoresizingMaskIntoConstraints = false
        return d
    }()
    
     lazy var reorderBtn: UIButton = {
        let d = UIButton()
        d.setImage(UIImage(named: "reorder"), for: .normal)
        d.addTarget(self, action: #selector(handleSwipes), for: .touchUpInside)
        d.alpha = 0
        d.translatesAutoresizingMaskIntoConstraints = false
//        d.isUserInteractionEnabled = true
        return d
    }()
    
    lazy var deleteView: UIView = {
        let dv = UIView()
        dv.backgroundColor = .red
        dv.layer.cornerRadius = 12
        dv.clipsToBounds = true
        dv.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        dv.translatesAutoresizingMaskIntoConstraints = false
        return dv
    }()
    
    lazy var deleteLbl: UILabel = {
        let dl = UILabel()
        dl.text = "Sil"
        dl.backgroundColor = .clear
        dl.textColor = .white
        dl.font = UIFont.boldSystemFont(ofSize: 10)
        //UIFont(name: "IRANSansMobile(FaNum)_Light", size: 1)
        dl.adjustsFontSizeToFitWidth = true
        dl.textAlignment = .center
        dl.translatesAutoresizingMaskIntoConstraints = false
        return dl
    }()
    
    
    
    
    lazy var mainView: UIView = {
        let mv = UIView()
        mv.backgroundColor = .white
        mv.layer.masksToBounds = false
        mv.clipsToBounds = false
        mv.layer.shadowColor   = UIColor.gray.cgColor
        mv.layer.shadowOffset  = CGSize(width: 1, height: 2)
        mv.layer.shadowRadius  = 2
        mv.layer.shadowOpacity = 0.2
        mv.layer.cornerRadius  = 12
        mv.isUserInteractionEnabled = true
        mv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSwipes)))
//        mv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(indexDidSelect)))
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
        lbl.text = "Istanbul"
        lbl.font = UIFont(name: "Roboto-Medium", size: 17)
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(indexDidSelect)))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        if isEditModeOn == false {
            reorderBtn.alpha = 0
            deleteIcon.alpha = 0
        } else {
            reorderBtn.alpha = 1
            deleteIcon.alpha = 1

        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    @objc func handleSwipes() {
        
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
//            self.defaultMainViewLeftAnchor?.isActive = false
//            self.animatedMainViewLeftAnchor?.isActive = true
//            self.layoutIfNeeded()
//        } completion: { (_) in
//
//        }
    }
    
    
    //MARK: - Handling actions when this index selected
    @objc func indexDidSelect() {
        
    }
    
    //MARK: - seting up constrain for city label
    func setupConstraint() {
        addSubview(baseView)
        addSubview(mainView)
        
        baseView.addSubview(deleteView)
        baseView.addSubview(deleteLbl)
        mainView.addSubview(cityNameLbl)
        
        mainView.addSubview(deleteIcon)
        mainView.addSubview(reorderBtn)
        mainView.addSubview(weatherIconImage)
        mainView.addSubview(cityNameLbl)

        mainView.addSubview(dateLbl)

        mainView.addSubview(weatherDegreeLbl)

        
        defaultMainViewLeftAnchor = mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: edgeSpacing)
        animatedMainViewLeftAnchor = mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: (edgeSpacing - 30))
        guard let leftConstraint = defaultMainViewLeftAnchor else {return}
        
        NSLayoutConstraint.activate([
            baseView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: edgeSpacing),
            baseView.widthAnchor.constraint(equalToConstant: (frame.size.width - (edgeSpacing * 2))),
            baseView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            baseView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            deleteView.rightAnchor.constraint(equalTo: baseView.rightAnchor),
            deleteView.topAnchor.constraint(equalTo: baseView.topAnchor),
            deleteView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            deleteView.widthAnchor.constraint(equalToConstant: 60),
            
            
            deleteLbl.centerYAnchor.constraint(equalTo: deleteView.centerYAnchor, constant: 10),
            deleteLbl.centerXAnchor.constraint(equalTo: deleteView.centerXAnchor),
            deleteLbl.widthAnchor.constraint(equalTo: deleteView.widthAnchor, multiplier: 0.5),
            deleteLbl.heightAnchor.constraint(equalTo: deleteView.heightAnchor, multiplier: 0.15),
            
            mainView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftConstraint,
            mainView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            mainView.widthAnchor.constraint(equalToConstant: (frame.size.width - (edgeSpacing * 2))),
            
            
            deleteIcon.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 8),
            deleteIcon.widthAnchor.constraint(equalToConstant: 20),
            deleteIcon.heightAnchor.constraint(equalToConstant: 20),
            deleteIcon.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            
            reorderBtn.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -8),
            reorderBtn.widthAnchor.constraint(equalToConstant: 20),
            reorderBtn.heightAnchor.constraint(equalToConstant: 20),
            reorderBtn.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            
            //            cityNameLbl.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 22),
            //            cityNameLbl.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -22),
            //            cityNameLbl.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            //            cityNameLbl.heightAnchor.constraint(equalTo: mainView.heightAnchor, constant: 0.1),
            
            
            weatherIconImage.leftAnchor.constraint(equalTo: deleteIcon.leftAnchor, constant: edgeSpacing * 1.5),
            weatherIconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIconImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            weatherIconImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            cityNameLbl.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityNameLbl.topAnchor.constraint(equalTo: weatherIconImage.topAnchor),
            cityNameLbl.leftAnchor.constraint(equalTo: weatherIconImage.rightAnchor, constant: edgeSpacing * 2),
            cityNameLbl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.36),
            
            dateLbl.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLbl.bottomAnchor.constraint(equalTo: weatherIconImage.bottomAnchor),
            dateLbl.leftAnchor.constraint(equalTo: weatherIconImage.rightAnchor, constant: edgeSpacing * 2),
            dateLbl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.24),
            
            weatherDegreeLbl.rightAnchor.constraint(equalTo: reorderBtn.rightAnchor, constant: -(edgeSpacing * 0.7)),
            weatherDegreeLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherDegreeLbl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.19),
            weatherDegreeLbl.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.72)
            
            
        ])
    }
}
