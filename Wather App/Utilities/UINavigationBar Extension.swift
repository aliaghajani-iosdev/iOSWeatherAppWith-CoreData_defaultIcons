//
//  UINavigationBar Extension.swift
//  weather
//
//  Created by Ali Aghajani on 10/4/20.
//

import Foundation
import UIKit

extension UINavigationBar {

    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
