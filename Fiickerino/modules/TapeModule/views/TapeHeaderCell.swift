//
//  TapeHeaderCell.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit
import RxSwift
import IVCollectionKit

class TapeHeaderCell:UICollectionViewCell{
    var action: (() -> ())?
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = Font.sf(font: .SFUIText, weight: .semibold, size: 14)
        label.textColor = Color.lightGrayText()
        label.textAlignment = .left
        return label
    }()
    
    let actionButton:UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Font.sf(font: .SFUIDisplay, weight: .regular, size: 13)
        button.setTitleColor(Color.blueColor(), for: .normal)
        //button.setImage(Asset.Buttons.Catalog.icSort, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()
    
    private func common_init(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(8)
        }
        
        actionButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        common_init()
    }
    
    @objc
    private func didTap(){
        action?()
    }
}
extension TapeHeaderCell:ConfigurableCollectionItem {
    static func estimatedSize(item: TapeHeaderCellModel?, boundingSize: CGSize) -> CGSize {
        let height:CGFloat = 40
        return CGSize(width: boundingSize.width, height: height)
    }
    
    func configure(item: TapeHeaderCellModel) {
        actionButton.setTitle(item.buttonLabel, for: .normal)
        titleLabel.text = item.titleLabel
        action = item.filterAction
    }
}

struct TapeHeaderCellModel:Hashable{
    static func == (lhs: TapeHeaderCellModel, rhs: TapeHeaderCellModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    
    private let uuid = UUID()
    let titleLabel: String
    let count: Int
    let buttonLabel: String
    var isEmpty: Bool {
        return count == 0
    }
    
    let filterAction: (() -> ())
    
    init(title: String, buttonTitle: String, count: Int,
         filterAction: @escaping (() -> ())) {
        self.count = count
        self.titleLabel = title 
        self.buttonLabel = buttonTitle
        self.filterAction = filterAction
    }
}
