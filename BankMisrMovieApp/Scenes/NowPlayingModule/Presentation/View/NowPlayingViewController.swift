//
//  NowPlayingViewController.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import UIKit

class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    var currentPage = 1
    var isFetchingMovies = false
    private let viewModel = NowPlayingViewModel()
    let indicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNetworkCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        self.title = "Now Playing"
    }
    
    func setupCollectionView() {
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self
        
        let nib = UINib(nibName: "NowPlayingCollectionViewCell", bundle: nil)
        nowPlayingCollectionView.register(nib, forCellWithReuseIdentifier: "NowPlayingCollectionViewCell")
        
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
                self.nowPlayingCollectionView.reloadData()
                self.indicator.stopAnimating()
            }
        }
    }
}

extension NowPlayingViewController : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCollectionViewCell", for: indexPath) as! NowPlayingCollectionViewCell
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.arr[indexPath.row].posterPath ?? "")")
        cell.movieTitle.text = viewModel.arr[indexPath.row].title
        cell.movieDate.text = viewModel.arr[indexPath.row].releaseDate
        loadImage(from: imageUrl!) { image in
            DispatchQueue.main.async {
                cell.movieImage.image = image
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailsViewController()
        vc.viewModel.id = viewModel.arr[indexPath.row].id ?? 0
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
//    func setupCell(cell: UICollectionViewCell){
//        cell.layer.shadowColor = UIColor.gray.cgColor
//        cell.layer.shadowOffset = .zero
//        cell.layer.shadowOpacity = 0.6
//        cell.layer.shadowRadius = 10.0
//        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
//        cell.layer.shouldRasterize = true
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight + 100 {
            if !isFetchingMovies && currentPage < viewModel.pagesCount ?? 0 {
                currentPage += 1
                viewModel.getData(page: currentPage) { [weak self] in
                    guard let self else { return }
                    DispatchQueue.main.async {
                        self.indicator.startAnimating()
                        self.nowPlayingCollectionView.reloadData()
                        self.indicator.stopAnimating()
                    }
                }
            }else{
                return
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

}

