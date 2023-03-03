//
//  UIBarButtonItem+Extension.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import UIKit

class CustomBarButtomItem: UIBarButtonItem {
    public typealias UIButtomTargetClosure = (UIBarButtonItem) -> Void

    private var targetClosure: UIButtomTargetClosure?

    public convenience init(title: String?, style: UIBarButtonItem.Style = .plain, closure: UIButtomTargetClosure?) {
        self.init(title: title, style: style, target: nil, action: #selector(CustomBarButtomItem.closureAction(sender:)))
        target = self
        self.targetClosure = closure
    }

    public convenience init(image: UIImage?, style: UIBarButtonItem.Style = .plain, closure: UIButtomTargetClosure?) {
        self.init(image: image, style: style, target: nil, action: #selector(CustomBarButtomItem.closureAction(sender:)))
        target = self
        self.targetClosure = closure
    }

    @objc func closureAction(sender: UIBarButtonItem) {
        targetClosure?(sender)
    }
}
