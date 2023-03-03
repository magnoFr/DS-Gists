//
//  ProjectNavigationController.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 24/12/20.
//

import UIKit

public class ProjectNavigationController: UINavigationController {
    public override var childForStatusBarStyle: UIViewController? {
        return viewControllers.last
    }
}
