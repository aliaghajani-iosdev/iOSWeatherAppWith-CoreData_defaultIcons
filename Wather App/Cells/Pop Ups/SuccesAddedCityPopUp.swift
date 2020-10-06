//
//  SuccesAddedCityPopUp.swift
//  weather
//
//  Created by Ali Aghajani on 10/3/20.
//

import UIKit

class SuccesAddedCityPopUp: UIView {
    
    let identifier = "identifier"
    var imageArray = [String]()
    
    fileprivate let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .customWhite
        cv.layer.cornerRadius = 18
        cv.layer.borderWidth = 0.2
        cv.layer.borderColor = UIColor.gray.cgColor
        cv.clipsToBounds = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    
    var headerLabel: UILabel = {
        let tl = UILabel()
        tl.adjustsFontSizeToFitWidth = true
        tl.textAlignment = .center
        tl.text = "City successfully Added"
        tl.numberOfLines = 2
        tl.textColor = .customPurple
        tl.font = UIFont(name: "Roboto-Medium", size: 14)
        tl.backgroundColor = .clear
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    var BackgroundImage: UIImageView = {
        let hi = UIImageView()
//        hi.image = UIImage(named: "success")
        hi.contentMode = .scaleAspectFill
        hi.clipsToBounds = true
        hi.translatesAutoresizingMaskIntoConstraints = false
        return hi
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animateOut()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc fileprivate func animateOut() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height )
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc fileprivate func animateIn() {
        self.containerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height )
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.transform = .identity
            self.alpha = 1
        })
    }
    
    
    fileprivate func setConstraint() {
        
        //        self.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        self.frame = UIScreen.main.bounds
        
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 130),
            containerView.widthAnchor.constraint(equalToConstant: 250)])
        
        
        
        containerView.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0 ),
            headerLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 50),
            headerLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8)])
        //adding collection view and seting constraint up!
        containerView.addSubview(BackgroundImage)
        NSLayoutConstraint.activate([
            BackgroundImage.heightAnchor.constraint(equalToConstant: 60),
            BackgroundImage.widthAnchor.constraint(equalToConstant: 60),
            BackgroundImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            BackgroundImage.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 2)])
                                                
        animateIn()
        }
    }
