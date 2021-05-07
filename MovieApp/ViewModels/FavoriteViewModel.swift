//
//  FavoriteViewModel.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 7/05/21.
//

import Foundation
import CoreData
class FavoriteViewModel: NSObject {
    
    private (set) var favoriteMovies: [NSManagedObject]! {
        didSet {
            self.bindFavoriteMoviesToController()
        }
    }
    
    var bindFavoriteMoviesToController: (() -> ()) = {}
        
    func addMovieAsFavorite(movie: MovieData) {
        CoreDataManager.shared.createData(movie: movie)
    }
    
    func fetchFavoriteMovies() {
        self.favoriteMovies = CoreDataManager.shared.fetchData()
    }
    
    func isMovieSelectedAsFavorite(title: String) -> Bool {
        return CoreDataManager.shared.isMovieInEntity(title: title)
    }
    
    func deleteMovieFromFavorites(title: String) {
        CoreDataManager.shared.deleteData(title: title)
        fetchFavoriteMovies()
    }
}
