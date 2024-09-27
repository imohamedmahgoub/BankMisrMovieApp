//
//  MovieDetailsCollectionViewCell.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 15.0
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderColor = UIColor.white.cgColor
    }

}
