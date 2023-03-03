//
//  UIViewController+Extension.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import UIKit

extension UIViewController {
    func setupBarBackButton(completion: (() -> Void)?) {
        guard let vcsCount = navigationController?.viewControllers.count, vcsCount > 1 else { return }
        let image = UIImage(named: "back-24") ?? UIImage()
        addLeftBarButton(buttomImage: image, completion: completion != nil ? completion : {
            self.navigationController?.popViewController(animated: true)
        })
    }

    func addLeftBarButton(buttomImage: UIImage, completion: (() -> Void)? = nil) {
        let backButton = CustomBarButtomItem(image: buttomImage, style: .plain) { _ in
            if let completion = completion {
                completion()
                return
            }
        }

        backButton.imageInsets = UIEdgeInsets(
            top: 0,
            left: 9,
            bottom: 0,
            right: 0)

        self.navigationItem.leftBarButtonItem = backButton
    }
}
