//
//  Font.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit.UIFont

final class Font {
    static func sf(font: Font, weight: UIFont.Weight, size: CGFloat) -> UIFont {
        if #available(iOS 13, *) {
            let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).addingAttributes([UIFontDescriptor.AttributeName.traits:[UIFontDescriptor.TraitKey.weight: weight]])
            return UIFont(descriptor: fontDescriptor, size: size)
        } else {
            var fontName = ".\(font.rawValue)"
            if let weightName = name(of: weight) { fontName += "-\(weightName)" }
            return UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
        }
    }
    
    enum Font: String {
        case SFUIText = "SFUIText"
        case SFUIDisplay = "SFUIDisplay"
        
        var value: String {
            switch self {
            case .SFUIDisplay:
                return "monospaced"
            case .SFUIText:
                return "default"
            }
        }
        
            
    }

    private static func name(of weight: UIFont.Weight) -> String? {
        switch weight {
            case .ultraLight: return "UltraLight"
            case .thin: return "Thin"
            case .light: return "Light"
            case .regular: return nil
            case .medium: return "Medium"
            case .semibold: return "Semibold"
            case .bold: return "Bold"
            case .heavy: return "Heavy"
            case .black: return "Black"
            default: return nil
        }
    }
    
    /// Код для авторзации
    static let code: UIFont = {
        let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        let bodyMonospacedNumbersFontDescriptor = bodyFontDescriptor.addingAttributes([
          UIFontDescriptor.AttributeName.featureSettings: [
            [UIFontDescriptor.FeatureKey.featureIdentifier:
             kNumberSpacingType,
             UIFontDescriptor.FeatureKey.typeIdentifier:
             kMonospacedNumbersSelector]
          ]
        ])
        
        return UIFont(descriptor: bodyMonospacedNumbersFontDescriptor, size: 30)
    }()
}
