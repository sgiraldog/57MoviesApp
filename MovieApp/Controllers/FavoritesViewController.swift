//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 7/05/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var favoritesTableView: UITableView!
    var favoriteViewModel: FavoriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.delegate = self
        self.title = "favorites".localized
        favoritesTableView.register(FavoriteTableViewCell.nib, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        callViewModelForUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.favoriteViewModel.fetchFavoriteMovies()
    }
    
    func callViewModelForUpdate() {
        self.favoriteViewModel = FavoriteViewModel()
        self.favoriteViewModel.bindFavoriteMoviesToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        DispatchQueue.main.async {
            self.favoritesTableView.dataSource = self
            self.favoritesTableView.reloadData()
        }
    }
    
    @objc func handleFavorite(sender: UIButton) {
        let movieTitle = self.favoriteViewModel.favoriteMovies[sender.tag].value(forKey: "title") as? String
        if let title = movieTitle {
            self.favoriteViewModel.deleteMovieFromFavorites(title: title)
            NotificationCenter.default.post(name: Notification.Name("FavoriteRemovedFromFavoritesVC"), object: nil)
        }
    }
}
