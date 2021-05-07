//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 7/05/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    
    var movie: MovieData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "detail".localized
        if let data = movie {
            movieImage.imageFromServerURL(urlString: Config.imageUrl + data.posterPath)
            movieTitle.text = data.title
            movieOverview.text = data.overview
            ratingLabel.text = "rating".localized + String(data.voteAverage)
            votesLabel.text = "votes".localized + String(data.voteCount)
        }
    }
}
