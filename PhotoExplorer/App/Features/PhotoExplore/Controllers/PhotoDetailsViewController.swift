//
//  PhotoDetailsViewController.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/10/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!

    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        guard
            let photo = photo,
            let url = URL(string: photo.pictureURL)
            else { return}

        photoImageView.kf.setImage(with: url)
        detailsLabel.text = photo.description + "\nSource: \(photo.source)"
    }

}
