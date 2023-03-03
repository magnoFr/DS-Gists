//
//  LoadableViewController.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import UIKit

open class LoadableViewController<ContentView: UIView>: ProjectViewController {
    public var contentView = ContentView()

    open override func loadView() { view = contentView }
}
