//
//  UiImageExtension.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 28/09/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: URL? ) {
 
        guard let urlString else { return }
        
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            // Check for errors and if data is available
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                //self.image = UIImage()
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Could not decode image data.")
//                self.image = UIImage()
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

