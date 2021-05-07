//
//  APIService.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 6/05/21.
//

import Foundation

struct AuthResponse {
    let successfull: Bool
    let message: String?
}

enum CustomError: Error{
    case runtimeError(String)
}

class APIService: NSObject {
    static let shared = APIService()
    func getMoviesList(page:String, completion: @escaping (Movies?, Error?) -> ()) {
        guard let url = URL(string: "\(Config.apiUrl)/3/movie/popular?api_key=\(Config.apiKey)&language=en-US&page=\(page)") else {
            return completion(nil, CustomError.runtimeError("unableToProccess".localized))
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                let decoder = JSONDecoder() //do catch  Custom error
                do {
                    let moviesData = try decoder.decode(Movies.self, from: data)
                    completion(moviesData, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func mockAuthAPI(username: String, password: String, completion: @escaping (AuthResponse) -> Void) {
        if username != "user" {
            completion(AuthResponse(successfull: false, message: "userNotFound".localized))
        } else if password != "password" {
            completion(AuthResponse(successfull: false, message: "wrongPassword".localized))
        }
        completion(AuthResponse(successfull: true, message: nil))
    }
}
