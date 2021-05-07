//
//  MovieSearchBarDelegate.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 7/05/21.
//


import UIKit

extension MoviesViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.movieViewModel.filterMovies(searchText: "")
        self.updateDataSource()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.movieViewModel.filterMovies(searchText: searchText)
        self.updateDataSource()
        
    }
}
