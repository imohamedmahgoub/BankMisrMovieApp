//
//  UiImageExtension.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 28/09/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString,
              let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(urlString)") else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }
            
            guard let data, let image = UIImage(data: data) else {
                print("Could not decode image data.")
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

