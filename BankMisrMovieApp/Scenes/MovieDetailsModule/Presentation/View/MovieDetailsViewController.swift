//
//  MovieDetailsViewController.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    let viewModel = MovieDetailsViewModel()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieInfo: UITextView!
    @IBOutlet weak var movieGenresCollectionView: UICollectionView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var moviePageUrl: UILabel!
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getDetails()
    }
    
    func getDetails() {
        viewModel.getMovieDetails {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.movieInfo.text = viewModel.detailsArray.first?.overview
                self.movieRating.text = String(format: "%.1f", viewModel.detailsArray.first?.voteAverage ?? 0)
                self.movieTitle.text = viewModel.detailsArray.first?.title
                self.moviePageUrl.text = viewModel.detailsArray.first?.homepage
                self.runTimeLabel.text = "\(viewModel.detailsArray.first?.runtime ?? 0)"
                self.releaseDateLabel.text = viewModel.detailsArray.first?.releaseDate
                
                let backgroundImageUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.detailsArray.first?.backdropPath ?? "")")
                loadImage(from: backgroundImageUrl!) { image in
                    DispatchQueue.main.async {
                        self.backgroundImage.image = image
                    }
                }
                let posterImageUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.detailsArray.first?.posterPath ?? "")")
                loadImage(from: posterImageUrl!) { image in
                    DispatchQueue.main.async {
                        self.posterImage.image = image
                        self.posterImage.layer.cornerRadius = 20.0
                    }
                }
                myView.layer.cornerRadius = 20.0
                movieGenresCollectionView.reloadData()
            }
        }
    }
    
    func loadImage(from urlString: URL, completion: @escaping (UIImage?) -> Void) {
 
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            // Check for errors and if data is available
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Could not decode image data.")
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    func setupCollectionView() {
        movieGenresCollectionView.dataSource = self
        movieGenresCollectionView.delegate = self
        
        let nib = UINib(nibName: "MovieDetailsCollectionViewCell", bundle: nil)
        movieGenresCollectionView.register(nib, forCellWithReuseIdentifier: "MovieDetailsCollectionViewCell")
    }
}

extension MovieDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.detailsArray.first?.genres?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailsCollectionViewCell", for: indexPath) as! MovieDetailsCollectionViewCell
        cell.genreLabel.text = viewModel.detailsArray.first?.genres?[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    
}
