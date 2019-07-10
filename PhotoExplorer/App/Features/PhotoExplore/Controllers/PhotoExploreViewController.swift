//
//  PicturesListViewController.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/5/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import UIKit

class PhotoExploreViewController: UIViewController {

    let viewModel = PhotoExploreViewModel()
    var selectedPhoto: Photo?

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPhotos()
        viewModel.delegate = self
    }
}

extension PhotoExploreViewController: PhotoExploreViewModelDelegate {
    func didFinishFetchingPhotos() {
        collectionView.reloadData()
    }
}

extension PhotoExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.photosByService.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photosByService[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell

        cell.backgroundColor = UIColor.darkGray
        cell.photo = viewModel.photosByService[indexPath.section][indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(PhotoHeaderView.self)",
                    for: indexPath) as? PhotoHeaderView
                else {
                    fatalError("Invalid view type")
            }

            let searchTerm = viewModel.photosByService[indexPath.section].first?.source
            headerView.label.text = searchTerm
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhoto = viewModel.photosByService[indexPath.section][indexPath.row]
        performSegue(withIdentifier: "PhotoDetailsSegue", sender: self)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PhotoDetailsViewController {
            vc.photo = selectedPhoto
        }
    }
}

class PhotoHeaderView: UICollectionReusableView {
    @IBOutlet weak var label: UILabel!
}
