//
//  NowPlayingViewController.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import UIKit

enum TabBarSreen: String {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case upcoming = "upcoming"
}

class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    private var type: TabBarSreen
    private lazy var viewModel: MovieViewModelProtocol = MovieViewModel(type: type)
    let indicator = UIActivityIndicatorView(style: .medium)
    var isFetchingMovies = false
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNetworkCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        
        switch type {
        case .nowPlaying:
            self.title = "Now Playing"
        case .popular:
            self.title = "popular"
        case .upcoming:
            self.title = "upcoming"
        }
        
    }
    
    init(type: TabBarSreen) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
        let nib = UINib(nibName: "NowPlayingCollectionViewCell", bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: "NowPlayingCollectionViewCell")
        
        setupIndicator()
    }
    func setupIndicator() {
        indicator.center = view.center
        indicator.startAnimating()
        view.addSubview(indicator)
    }
    func setupNetworkCall(){
        if InternetConnectivity.hasInternetConnect() {
            getData()
        }else{
            let alert = UIAlertController(title: "Poor internet connection", message: "Please make sure that you are connected to internet", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive) { _ in
                self.getData()
            }
            alert.addAction(dismissAction)
            self.present(alert, animated: true)
        }
    }
    
    func getData() {
        viewModel.getData(page: currentPage) { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
                self.indicator.stopAnimating()
            }
        }
    }
}

extension NowPlayingViewController : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCollectionViewCell", for: indexPath) as! NowPlayingCollectionViewCell
        cell.movieTitle.text = viewModel.movieArray[indexPath.row].title
        cell.movieDate.text = viewModel.movieArray[indexPath.row].releaseDate
        cell.movieImage.loadImage(from: viewModel.movieArray[indexPath.row].posterPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailsViewController(movieId: viewModel.movieArray[indexPath.row].id ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 250)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight + 200 {
            if !isFetchingMovies && currentPage < viewModel.pagesCount ?? 0 {
                currentPage += 1
                viewModel.getData(page: currentPage) { [weak self] in
                    guard let self else { return }
                    DispatchQueue.main.async {
                        self.indicator.startAnimating()
                        self.moviesCollectionView.reloadData()
                        self.indicator.stopAnimating()
                    }
                }
            }else{
                return
            }
        }
    }
}

