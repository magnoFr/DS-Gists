//
//  UIApplecation+Extensions.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import UIKit

public extension UIApplication {
    static func topViewController(controller: UIViewController? = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.rootViewController) -> UIViewController? {
        var targetController = controller
        if targetController == nil {
            for window in self.shared.windows {
                guard let rootVC = window.rootViewController else { continue }
                targetController = rootVC
                window.makeKey()
                break
            }
        }

        if let navigationController = targetController as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = targetController as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = targetController?.presentedViewController {
            return topViewController(controller: presented)
        }
        return targetController
    }
}
