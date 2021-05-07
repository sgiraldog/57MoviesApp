//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 6/05/21.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesTableView: UITableView!
    var page = 1
    var isLoading = true
    var selectedMovie: Int?
    var movieViewModel: MovieViewModel!
    var favoriteViewModel: FavoriteViewModel!
    var authViewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: Notification.Name("FavoriteRemovedFromFavoritesVC"), object: nil)
        self.moviesTableView.delegate = self
        self.searchBar.delegate = self
        self.title = "movies".localized
        moviesTableView.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
        callViewModelForUpdate()
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        if self.authViewModel.clearSession() {
            let initialViewController = UIStoryboard.initialViewController(for: .login)
            self.navigationController?.present(initialViewController, animated: true, completion: nil)
        }
    }
    
    func callViewModelForUpdate() {
        self.authViewModel = AuthViewModel()
        self.movieViewModel = MovieViewModel()
        self.favoriteViewModel = FavoriteViewModel()
        self.movieViewModel.bindMoviesToController = {
            self.isLoading = false
            self.updateDataSource()
        }
    }
    
    @objc
    func handleNotification() {
        self.movieViewModel.clearMoviesList()
        self.page = 1
        self.movieViewModel.fetchMovies(page: page)
    }
    
    func updateDataSource() {
        DispatchQueue.main.async {
            self.moviesTableView.dataSource = self
            self.moviesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = selectedMovie, segue.identifier == "movieDetailSegue" {
            let vc = segue.destination as! MovieDetailViewController
            vc.movie = self.movieViewModel.moviesData?[index]
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((moviesTableView.contentOffset.y + moviesTableView.frame.size.height) >= moviesTableView.contentSize.height) {
            if !isLoading {
                self.isLoading = true
                self.page += 1
                self.movieViewModel.fetchMovies(page: page)
            }
        }
    }
    
    @objc func handleFavorite(sender: UIButton) {
        if let movie = self.movieViewModel.moviesData?[sender.tag] {
            if sender.tintColor == .systemPink {
                self.favoriteViewModel.deleteMovieFromFavorites(title: movie.title)
            } else {
                self.favoriteViewModel.addMovieAsFavorite(movie: movie)
                sender.tintColor = .lightGray
            }
            moviesTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        }
    }
}
