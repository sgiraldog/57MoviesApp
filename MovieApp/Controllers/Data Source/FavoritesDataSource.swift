//
//  FavoritesDataSource.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 7/05/21.
//

import Foundation
import UIKit

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteViewModel.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteTableViewCell.identifier,
            for: indexPath
        ) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        let movie = favoriteViewModel.favoriteMovies[indexPath.row]
        cell.favoriteNameLabel.text = movie.value(forKey: "title") as? String
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return cell
    }
    
    
}
