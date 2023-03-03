//
//  ViewCodeConfiguration.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation

public protocol ViewCodeConfiguration: AnyObject {
    func setupViewCode()
    func setupViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeConfiguration {
    public func setupViewCode() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
    public func setupViewHierarchy() {}
    public func setupConstraints() {}
    public func configureViews() {}
}
