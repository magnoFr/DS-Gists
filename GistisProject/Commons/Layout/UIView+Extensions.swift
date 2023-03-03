//
//  UIView+Extensions.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 20/12/20.
//

import Foundation
import UIKit

public extension UIView {

    /// Default corner radius to apply at top
    static var defaultCorderRadiusToTop: CGFloat { return 30 }

    /// Property to verify if corner radius already are applyed
    private static var _cornerAlreadyApplyed = [String: Bool]()
    private var cornerAlreadyApplyed: Bool {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIView._cornerAlreadyApplyed[tmpAddress] ?? false
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIView._cornerAlreadyApplyed[tmpAddress] = newValue
        }
    }

    /// Added corner radius on view
    /// - Parameter radius: radius size to aply on corner radius, default corder radius is 30.
    func round(withRadius radius: CGFloat = UIView.defaultCorderRadiusToTop) {
        if !self.cornerAlreadyApplyed {
            layer.cornerRadius = radius
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
    }

    // MARK: - Anchors and programmatically constraints

    func constraintToSuperview(constant: CGFloat = 0) {
        if let view = self.superview {
            self
                .topAnchor(equalTo: view.topAnchor, constant: constant)
                .leadingAnchor(equalTo: view.leadingAnchor, constant: constant)
                .trailingAnchor(equalTo: view.trailingAnchor, constant: -constant)
                .bottomAnchor(equalTo: view.bottomAnchor, constant: -constant)
        }
    }

    /// Function to add more than one view to view's hierarchy
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    @discardableResult func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func topAnchor(greaterThan anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func topAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func topAnchor(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func topAnchorToSuperview(constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        guard let superview = superview else { fatalError("View doesn't have a superview") }
        let constraint = topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func bottomAnchor(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func bottomAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func bottomAnchorToSuperview(constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        guard let superview = superview else { fatalError("View doesn't have a superview") }
        let constraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func leadingAnchorToSuperview(constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        guard let superview = superview else { fatalError("View doesn't have a superview") }
        let constraint = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func trailingAnchor(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func trailingAnchor(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func trailingAnchorToSuperview(constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        guard let superview = superview else { fatalError("View doesn't have a superview") }
        let constraint = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func heightAnchor(equalTo height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = heightAnchor.constraint(equalToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func heightAnchor(equalTo nsLayoutDimension: NSLayoutDimension, multiplier: CGFloat = 1.0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let heightConstraint = heightAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier)
        heightConstraint.priority = priority
        heightConstraint.isActive = true
        return self
    }

    @discardableResult func heightAnchor(greaterThanOrEqualToConstant height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func heightAnchor(lessThanOrEqualToConstant height: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = heightAnchor.constraint(lessThanOrEqualToConstant: height)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func widthAnchor(equalTo width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = widthAnchor.constraint(equalToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func widthAnchor(equalTo nsLayoutDimension: NSLayoutDimension, multiplier: CGFloat = 1.0) -> Self {
        widthAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier).isActive = true
        return self
    }

    @discardableResult func widthAnchor(greaterThanOrEqualToConstant width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func widthAnchor(lessThanOrEqualToConstant width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = widthAnchor.constraint(lessThanOrEqualToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func centerXAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
        }
        return nil
    }

    func findConstraint(identifier: String) -> NSLayoutConstraint? {
        return superview?.constraints.first { $0.identifier == identifier }
    }

    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
            let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
            let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
            return firstItemMatch || secondItemMatch
        }
        return false
    }

    /// Move up the frame
    func moveUp(points: CGFloat) {
        self.center = CGPoint(x: self.center.x, y: self.center.y - points)
    }

    var height: CGFloat {
        frame.height
    }

    var width: CGFloat {
        frame.width
    }

    var top: CGFloat {
        frame.origin.y
    }

    var bottom: CGFloat {
        frame.maxY
    }

    var left: CGFloat {
        frame.origin.x
    }

    var right: CGFloat {
        frame.maxX
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}

extension UIFont {
  /// Returns a new font with the weight specified
  /// - Parameter weight: The new font weight
  func withWeight(_ weight: UIFont.Weight) -> UIFont {
    let newDescriptor = fontDescriptor.addingAttributes([.traits: [
      UIFontDescriptor.TraitKey.weight: weight]
    ])
    return UIFont(descriptor: newDescriptor, size: pointSize)
  }
}
