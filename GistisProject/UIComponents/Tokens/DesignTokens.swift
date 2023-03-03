//
//  DesignTokens.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 27/02/23.
//

import Foundation

struct DesignSystemTokens {
    let space: Space
    let radii: Radii
    let color: Colors
    let fontSize: FontSize
    let font: Font
}

struct Space {
    let one: Int
    let two: Int
    let three: Int
    let four: Int
    let five: Int
    let six: Int
    let seven: Int
    let eigth: Int
    let nine: Int
    let ten: Int
}

struct Radii {
    let sharp: Int
    let small: Int
    let medium: Int
    let large: Int
    let pill: Int
}

struct Colors {
    let core: Core
    let action: Action
    let neutral: Neutral
}

struct Core {
    let brand_1: String
    let brand_2: String
    let brand_3: String
}

struct Action {
    let defualt: String
    let highlight: String
}

struct Neutral {
    let dark: String
    let dark_light: String
    let medium: String
    let medium_light: String
    let light: String
    let light_dark: String
}

struct FontSize {
    let xxs: Int
    let xs: Int
    let sm: Int
    let md: Int
    let lg: Int
    let xl: Int
    let xxl: Int
    let x2l: Int
    let x3l: Int
}

struct Font {
    let thin: String
    let regular: String
    let medium: String
    let semibold: String
    let Bold: String
}
