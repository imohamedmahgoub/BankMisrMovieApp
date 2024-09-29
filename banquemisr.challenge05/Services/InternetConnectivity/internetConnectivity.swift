//
//  internetConnectivity.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Network
import Foundation

class InternetConnectivity{
   static func hasInternetConnect() -> Bool {
       guard let url = URL(string: "https://www.google.com") else { return false }
       let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 3)
       let semaphore = DispatchSemaphore(value: 0)
       var success = false
       
       URLSession(configuration: .default).dataTask(with: request) { _, response, error in
           if let httpsResponse = response as? HTTPURLResponse,
              httpsResponse.statusCode == 200,
              error == nil {
               success = true
           }
           semaphore.signal()
       }.resume()
       
       semaphore.wait()
       return success
    }
}

