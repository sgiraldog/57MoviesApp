//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 6/05/21.
//

import Foundation
import CoreData
class MovieViewModel: NSObject {
    
    private var filter = ""
    var _moviesData: [MovieData]?
    var moviesData: [MovieData]? {
        set {
            self.bindMoviesToController()
            _moviesData = newValue
        }
        get {
            return filter.isEmpty ? _moviesData : self._moviesData?.filter({ $0.title.contains(filter) })
        }
    }
    
    var bindMoviesToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.fetchMovies(page: 1)
    }
    
    func fetchMovies(page: Int) {
        APIService.shared.getMoviesList(page: String(page)) { (movies, error) in
            if let movies = movies {
                if self.moviesData != nil {
                    self.moviesData!.append(contentsOf: movies.results)
                } else {
                    self.moviesData = movies.results
                }
            }else {
                print("errorFetchingMovies".localized)
            }
        }
    }
    
    func clearMoviesList() {
        moviesData = []
    }
    
    func filterMovies(searchText: String) {
        filter = searchText
    }
}
