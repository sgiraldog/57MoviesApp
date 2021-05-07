//
//  MoviesDataSource.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 6/05/21.
//

import Foundation
import UIKit

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.moviesData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.identifier,
            for: indexPath
        ) as? MovieTableViewCell else { return UITableViewCell() }
  
        if let movie = movieViewModel.moviesData?[indexPath.row] {
            cell.movieNameLabel.text = movie.title
            cell.movieImage.imageFromServerURL(urlString: Config.imageUrl + movie.posterPath)
            cell.favoriteButton.tag = indexPath.row
            cell.favoriteButton.tintColor = self.favoriteViewModel.isMovieSelectedAsFavorite(title: movie.title) ? .systemPink : .lightGray
            cell.favoriteButton.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
}
