//
//  ProjectViewController.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import UIKit

open class ProjectViewController: UIViewController {

    public static var defaultBarStyle: UIStatusBarStyle = .lightContent

    // MARK: - Init
    public init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
    }

    public init(withNib: Bool) {
        let nibName: String? = withNib ? String(describing: type(of: self)) : nil
        let bundle: Bundle? = withNib ? Bundle(for: type(of: self)) : nil
        super.init(nibName: nibName, bundle: bundle)
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var barStyle: UIStatusBarStyle = ProjectViewController.defaultBarStyle

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return barStyle
    }

    public func setStatusBarStyle(_ preferredStatusBarStyle: UIStatusBarStyle) {
        barStyle = preferredStatusBarStyle
        setNeedsStatusBarAppearanceUpdate()
    }
}
