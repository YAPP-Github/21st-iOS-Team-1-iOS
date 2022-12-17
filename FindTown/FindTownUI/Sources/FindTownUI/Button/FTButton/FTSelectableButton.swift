//
//  File.swift
//  
//
//  Created by 김성훈 on 2022/12/17.
//

import UIKit

public final class FTSelectableButton: UIButton {
    
    private let selectedButtonStyle: FTButtonStyle
    private let nonSelectedButtonStyle: FTButtonStyle
    
    public init(selectedStyle: FTButtonStyle, nonSelectedStyle: FTButtonStyle) {
        self.selectedButtonStyle = selectedStyle
        self.nonSelectedButtonStyle = nonSelectedStyle
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        isSelected = false
        
        configuration = configureUI(style: nonSelectedButtonStyle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                configuration = configureUI(style: selectedButtonStyle)
            case false:
                configuration = configureUI(style: nonSelectedButtonStyle)
            }
        }
    }
    
    public func setSelectedTitle(normalTitle: String, selectedTitle: String) {
        setTitle(normalTitle, for: .normal)
        setTitle(selectedTitle, for: .selected)
    }
    
    public func setSelectedImage(normalImage: UIImage, selectedImage: UIImage) {
        setImage(normalImage, for: .normal)
        setImage(selectedImage, for: .selected)
    }
    
    private func configureUI(style: FTButtonStyle) -> Configuration {
        if style.isShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = .init(width: 4, height: 4)
            layer.shadowOpacity = 0.2
            layer.shadowRadius = 5
        }
        
        var config = style.configuration
        config.baseBackgroundColor = style.backgroundColor
        config.baseForegroundColor = style.foregroundColor
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer (
            { incoming in
                var outgoing = incoming
                outgoing.font = style.titleFont
                return outgoing
            }
        )
        config.background.cornerRadius = style.cornerRadius
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 12, leading: style.inset, bottom: 12, trailing: style.inset
        )
        config.background.strokeColor = style.foregroundColor
        config.background.strokeWidth = style.strokeWidth
        config.imagePlacement = style.imagePlacement
        config.imagePadding = style.imagePadding
        
        return config
    }
}
