//
//  TeamCollectionViewCell.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Kingfisher
import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    func loadImage(with url: String) {
        image.kf.setImage(with: URL(string: url))
        
    }
}
