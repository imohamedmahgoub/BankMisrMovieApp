//
//  MovieDetailsViewController.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
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
    
    var viewModel : MovieDetailsViewModelProtocol = MovieDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    

    @IBAction func didSelectUrl(_ sender: Any) {
        let url = URL(string: viewModel.detailsArray.first?.homepage ?? "")
        guard let url = url else { return }
        UIApplication.shared.open(url)
    }
    func getDetails() {
        viewModel.getMovieDetails {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.title = viewModel.detailsArray.first?.title
                self.movieInfo.text = viewModel.detailsArray.first?.overview
                self.movieRating.text = String(format: "%.1f", viewModel.detailsArray.first?.voteAverage ?? 0)
                self.movieTitle.text = viewModel.detailsArray.first?.title
                self.moviePageUrl.text = viewModel.detailsArray.first?.homepage
                self.runTimeLabel.text = "\(viewModel.detailsArray.first?.runtime ?? 0)"
                self.releaseDateLabel.text = viewModel.detailsArray.first?.releaseDate
                
                let backgroundImageUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.detailsArray.first?.backdropPath ?? "")")
                self.backgroundImage.loadImage(from: backgroundImageUrl)
                
                let posterImageUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.detailsArray.first?.posterPath ?? "")")
                
                self.posterImage.loadImage(from: posterImageUrl)
                self.posterImage.layer.cornerRadius = 20.0
                self.posterImage.layer.borderWidth = 1.0
                self.posterImage.layer.borderColor = UIColor.gray.cgColor
                
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
        return CGSize(width: 70, height: collectionView.frame.height - 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 25)
    }
}
