//
//  Observable.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation

public class Observable<T> {

    public typealias ObservableType = ((T) -> Void)

    // MARK: - Properties

    private var observables: [ObservableType] = []

    /// Observable raw value
    private var value: T {
        didSet {
            executeBinds()
        }
    }

    // MARK: - Initialize

    /// Initializer
    ///
    /// - Parameter value: initial observable value
    public init(_ value: T) {
        self.value = value
    }

    // MARK: - Public Methods

    /// Bind value for changes
    ///
    /// - Parameters:
    ///   - value: accept new value in observable value
    public func notify(_ value: T) {
        self.value = value
    }

    /// - Parameters:
    ///   - skip: Should skip initial closure cell
    ///   - bind: closure to execute every time value changed
    public func observe(skip: Bool = false, _ bind: @escaping ObservableType) {
        self.observables.append(bind)
        if skip { return }
        bind(value)
    }

    // MARK: - Private Methods

    private func executeBinds() {
        self.observables.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
}
