//
//  PhotoCollectionViewCell.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/10/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    var photo: Photo? {
        didSet {
            //load photo from url
            guard
                let photo = photo,
                let url = URL(string: photo.pictureURL)
                else { return}

            photoImageView.kf.setImage(with: url)
            photoImageView.contentMode = .scaleToFill
        }
    }

    @IBOutlet weak var photoImageView: UIImageView!
}
