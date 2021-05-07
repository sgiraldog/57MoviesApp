//
//  MoviesTableViewDelegate.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 7/05/21.
//

import Foundation
import UIKit

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = indexPath.row
        self.performSegue(withIdentifier: "movieDetailSegue", sender: self)
    }
}
