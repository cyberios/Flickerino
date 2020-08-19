//
//  TapeCell.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit
import IVCollectionKit
import SDWebImage

class TapeCell:UICollectionViewCell{
    let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = Font.sf(font: .SFUIDisplay, weight: .semibold, size: 14)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.font = Font.sf(font: .SFUIDisplay, weight: .regular, size: 11)
        label.textColor = Color.lightGrayText()
        label.textAlignment = .left
        return label
    }()
    
    let viewsLabel:UILabel = {
        let label = UILabel()
        label.font = Font.sf(font: .SFUIDisplay, weight: .regular, size: 11)
        label.textColor = Color.lightGrayText()
        label.textAlignment = .right
        return label
    }()
    
    let authorLabel:UILabel = {
        let label = UILabel()
        label.font = Font.sf(font: .SFUIDisplay, weight: .regular, size: 12)
        label.textColor = Color.lightGrayText()
        label.textAlignment = .left
        return label
    }()
    
    let tagsLabel:UILabel = {
        let label = UILabel()
        label.font = Font.sf(font: .SFUIDisplay, weight: .regular, size: 11)
        label.textColor = Color.lightGrayText()
        label.textAlignment = .right
        return label
    }()
    
    private var mediaText:String = ""
    
    private let primeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8.5
        view.backgroundColor = Color.blueColor()
        view.snp.makeConstraints{
            $0.width.equalTo(53)
            $0.height.equalTo(17)
        }
        
        view.isHidden = true
        return view
    }()
    
    private let primeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.background()
        label.textAlignment = .center
        label.font = Font.sf(font: .SFUIDisplay, weight: .regular, size: 11)
        return label
    }()
    

    
    private func commonInit(){
        primeView.addSubview(primeLabel)
        
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        titleStackView.alignment = .center
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(primeView)
        addSubview(titleStackView)
        
        primeLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(20)
        })
        
        addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.top.equalTo(titleStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(180)
        }
        
        let authorStackView = UIStackView()
        authorStackView.axis = .horizontal
        authorStackView.alignment = .center
        authorStackView.distribution = .equalSpacing
        
        authorStackView.addArrangedSubview(authorLabel)
        authorStackView.addArrangedSubview(tagsLabel)
        addSubview(authorStackView)

        authorStackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }

        let infoStackView = UIStackView()
        infoStackView.axis = .horizontal
        infoStackView.alignment = .fill
        infoStackView.spacing = 8

        infoStackView.addArrangedSubview(dateLabel)
        infoStackView.addArrangedSubview(viewsLabel)
        addSubview(infoStackView)
        
        infoStackView.snp.makeConstraints{
            $0.top.equalTo(authorStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            //$0.bottom.lessThanOrEqualToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        imageView.cancelDownload()
        imageView.image = nil
        titleLabel.text = nil
        authorLabel.text = nil
        dateLabel.text = nil
        viewsLabel.text = nil
    }
}
extension TapeCell:ConfigurableCollectionItem{
    static func estimatedSize(item: SearchListCellModel?, boundingSize: CGSize) -> CGSize {
        let height:CGFloat = 286
        return CGSize(width: boundingSize.width, height: height)
    }
    
    func configure(item: SearchListCellModel) {
        backgroundColor = Color.background()
        titleLabel.text = item.title.maxLength(length: 30)
        authorLabel.text = "Автор: " + item.author.maxLength(length: 15)
        dateLabel.text = item.date
        viewsLabel.text = "Просмотры: " + item.views
        tagsLabel.text = "Тэги: " +
            item.tags.joined(separator: " ")
                .maxLength(length: 10)
        primeLabel.text = item.media
        if (!item.media.isEmpty){
            primeView.isHidden = false
        }
        imageView.downloadImage(with: item.image_url)
    }
}

extension TapeCell{
    enum ActionFlow{
        case didTapSelect(id:String)
    }
}
