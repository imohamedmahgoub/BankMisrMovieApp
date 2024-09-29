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
    
    private var movieId : Int
    lazy var viewModel : MovieDetailsViewModelProtocol = MovieDetailsViewModel(id: movieId)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    init(movieId : Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func didSelectUrl(_ sender: Any) {
        guard let url = URL(string: viewModel.movieUrl ?? "") else { return }
        UIApplication.shared.open(url)
    }
    func getDetails() {
        viewModel.getMovieDetails { [weak self] data in
            guard let self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.title = data.title
                self.movieInfo.text = data.overview
                self.movieRating.text = String(format: "%.1f", data.voteAverage ?? 0)
                self.movieTitle.text = data.title
                self.moviePageUrl.text = data.homepage
                self.runTimeLabel.text = "\(data.runtime ?? 0)"
                self.releaseDateLabel.text = data.releaseDate
                self.backgroundImage.loadImage(from: data.backdropPath)
                self.posterImage.loadImage(from: data.posterPath )
                
                self.posterImage.layer.cornerRadius = 20.0
                self.posterImage.layer.borderWidth = 1.0
                self.posterImage.layer.borderColor = UIColor.gray.cgColor
                
                myView.layer.cornerRadius = 20.0
                movieGenresCollectionView.reloadData()
            }
        }
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
        return viewModel.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailsCollectionViewCell", for: indexPath) as! MovieDetailsCollectionViewCell
        cell.genreLabel.text = viewModel.genres[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: collectionView.frame.height - 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 25)
    }
}
