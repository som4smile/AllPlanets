//
//  APIManager.swift
//  Planets
//
//  Created by SOM on 04/05/21.
//

import Foundation

///Class responsible for API call and fetch response.
class APIManager :  NSObject {
    
    /// Shared instance to used as Singleton
    static let shared = APIManager()
    
    /// String of URLto connect with server
    private let urlString = "https://swapi.dev/api/planets/"
    
    /**
     Functions connects with server and fetch JSON response
     
     - Parameter completion: Block which notify the caller that data has been fetched or error occured.
    */
    func fetchData(completion: @escaping (Data?, Error?) -> ()) {
        guard let sourceURL = URL(string: urlString) else { return }
        
        var request = URLRequest(url: sourceURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: sourceURL) { (data, urlResponse, error) in
            
            if let data = data {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        }.resume()
    }


}
