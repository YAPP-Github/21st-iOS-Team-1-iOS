//
//  File.swift
//  
//
//  Created by 김성훈 on 2022/12/15.
//

import UIKit

public struct FTButtonStyle {
    let isSelectedButton: Bool
    let configuration: UIButton.Configuration
    let titleFont: UIFont
    var selectedColorSet: [UIColor] = []
    let nonSelectedColorSet: [UIColor]
    var strokeColor: UIColor = .clear
    let topBottomInset: CGFloat
    let leftRightInset: CGFloat
    let cornerRadius: CGFloat
    var imagePlacement: NSDirectionalRectEdge = .all
    var imagePadding: CGFloat = 0.0
    var isShadow: Bool = false
    var strokeWidth: Double = 1
}

extension FTButtonStyle {
    
    public static let large = FTButtonStyle (
        isSelectedButton: true,
        configuration: .tinted(),
        titleFont: FindTownFont.body3.font,
        selectedColorSet: [FindTownColor.white.color, FindTownColor.primary.color],
        nonSelectedColorSet: [FindTownColor.white.color, FindTownColor.grey5.color],
        topBottomInset: 14,
        leftRightInset: 0,
        cornerRadius: 10
    )
    
    public static let mediumFilled = FTButtonStyle (
        isSelectedButton: false,
        configuration: .filled(),
        titleFont: FindTownFont.body3.font,
        nonSelectedColorSet: [FindTownColor.primary.color, FindTownColor.white.color],
        topBottomInset: 12,
        leftRightInset: 50,
        cornerRadius: 10
    )
    
    public static let mediumTintedWithOpacity = FTButtonStyle (
        isSelectedButton: false,
        configuration: .tinted(),
        titleFont: FindTownFont.body3.font,
        nonSelectedColorSet: [FindTownColor.primary10.color, FindTownColor.primary.color],
        topBottomInset: 12,
        leftRightInset: 50,
        cornerRadius: 10,
        strokeWidth: 0.0
    )
    
    public static let mediumTintedWithRadius = FTButtonStyle (
        isSelectedButton: false,
        configuration: .tinted(),
        titleFont: FindTownFont.body3.font,
        nonSelectedColorSet: [FindTownColor.white.color, FindTownColor.primary.color],
        topBottomInset: 12,
        leftRightInset: 50,
        cornerRadius: 10
    )
    
    public static let small = FTButtonStyle (
        isSelectedButton: true,
        configuration: .tinted(),
        titleFont: FindTownFont.body3.font,
        selectedColorSet: [FindTownColor.white.color, FindTownColor.primary.color],
        nonSelectedColorSet: [FindTownColor.white.color, FindTownColor.grey4.color],
        topBottomInset: 11,
        leftRightInset: 40,
        cornerRadius: 10
    )
    
    public static let xSmall = FTButtonStyle (
        isSelectedButton: true,
        configuration: .tinted(),
        titleFont: FindTownFont.body3.font,
        selectedColorSet: [FindTownColor.white.color, FindTownColor.primary.color],
        nonSelectedColorSet: [FindTownColor.white.color, FindTownColor.grey4.color],
        topBottomInset: 8,
        leftRightInset: 25,
        cornerRadius: 10
    )
    
    public static let xxSmall = FTButtonStyle (
        isSelectedButton: true,
        configuration: .tinted(),
        titleFont: FindTownFont.label2.font,
        selectedColorSet: [FindTownColor.white.color, FindTownColor.primary.color],
        nonSelectedColorSet: [FindTownColor.white.color, FindTownColor.grey4.color],
        topBottomInset: 8,
        leftRightInset: 8,
        cornerRadius: 10
    )
    
    public static let buttonFilter = FTButtonStyle (
        isSelectedButton: true,
        configuration: .tinted(),
        titleFont: FindTownFont.label1.font,
        selectedColorSet: [FindTownColor.white.color, FindTownColor.primary.color],
        nonSelectedColorSet: [FindTownColor.white.color, FindTownColor.grey4.color],
        topBottomInset: 12,
        leftRightInset: 20,
        cornerRadius: 30,
        imagePlacement: .trailing,
        imagePadding: 5
    )
    
    public static let buttonFilterNormal = FTButtonStyle (
        isSelectedButton: false,
        configuration: .tinted(),
        titleFont: FindTownFont.label1.font,
        nonSelectedColorSet: [FindTownColor.white.color, FindTownColor.grey5.color],
        topBottomInset: 12,
        leftRightInset: 20,
        cornerRadius: 30,
        imagePlacement: .leading,
        imagePadding: 5
    )
    
    public static let iconFilter = FTButtonStyle (
        isSelectedButton: true,
        configuration: .filled(),
        titleFont: FindTownFont.body4.font,
        selectedColorSet: [FindTownColor.primary.color, FindTownColor.white.color],
        nonSelectedColorSet: [FindTownColor.white.color, FindTownColor.grey6.color],
        strokeColor: FindTownColor.grey2.color,
        topBottomInset: 8,
        leftRightInset: 20,
        cornerRadius: 30,
        imagePlacement: .leading,
        imagePadding: 5,
        isShadow: true
    )
    
    public static let round = FTButtonStyle (
        isSelectedButton: true,
        configuration: .filled(),
        titleFont: FindTownFont.body4.font,
        selectedColorSet: [FindTownColor.white.color, FindTownColor.grey7.color],
        nonSelectedColorSet: [FindTownColor.black.color, FindTownColor.white.color],
        strokeColor: FindTownColor.grey3.color,
        topBottomInset: 12,
        leftRightInset: 20,
        cornerRadius: 30,
        imagePlacement: .leading,
        imagePadding: 5,
        isShadow: true
    )
    
    public static let icon = FTButtonStyle (
        isSelectedButton: true,
        configuration: .tinted(),
        titleFont: FindTownFont.label1.font,
        selectedColorSet: [FindTownColor.white.color, FindTownColor.primary.color],
        nonSelectedColorSet: [FindTownColor.white.color, FindTownColor.grey4.color],
        topBottomInset: 8,
        leftRightInset: 20,
        cornerRadius: 0,
        imagePlacement: .top,
        imagePadding: 10,
        strokeWidth: 0.0
    )
}
