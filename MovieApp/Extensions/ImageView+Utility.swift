//
//  ImageView+Utility.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 6/05/21.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        var urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        urlStringNew = urlStringNew.replacingOccurrences(of: "\\", with: "")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
