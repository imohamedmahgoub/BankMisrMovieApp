//
//  NowPlayingCollectionViewCell.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var labelsView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        
        movieImage.layer.cornerRadius = 20.0
        labelsView.layer.cornerRadius = 10.0
        labelsView.layer.borderWidth = 0.3
        labelsView.layer.borderColor = UIColor.gray.cgColor
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 10.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
    }
}
