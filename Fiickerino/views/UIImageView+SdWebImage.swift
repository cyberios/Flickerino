//
//  UIImageView+SdWebImage.swift
//  Flickerino
//
//  Created by Alexraag on 18.08.2020.
//  Copyright © 2020 Alexraag. All rights reserved.
//

import UIKit.UIImageView
import SDWebImage

extension UIImageView {
    func downloadImage(with urlString: String?, defaultImage: UIImage? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.image = defaultImage
            }
            return
        }
        sd_setImage(with: url, placeholderImage: defaultImage)
    }
    
    func cancelDownload() {
        sd_cancelCurrentImageLoad()
    }
}
