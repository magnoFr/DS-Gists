//
//  FavoriteButton.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 24/12/20.
//

import UIKit

class FavoriteButton: UIButton {
    // Images
    let checkedImage = UIImage(named: "heart-filled")
    let uncheckedImage = UIImage(named: "heart")
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
