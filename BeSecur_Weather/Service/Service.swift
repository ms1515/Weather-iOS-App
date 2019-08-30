//
//  Service.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    let basePath = "https://www.metaweather.com/api/location/"
    
    func searchLocationWOID(location: String, completion: @escaping ([Location]?, Error?)->()) {
        let urlString = basePath + "search/?query=\(location)"
        genericGetAPICall(urlString: urlString, completion: completion)
    }
    
    func fetchLocationWeather(woid: String, completion: @escaping (Weather?, Error?)->()) {
        let urlString = basePath + "\(woid)"
        genericGetAPICall(urlString: urlString, completion: completion)
    }
    
    func fetchLocationDayWeather(woid: String, date: String, completion: @escaping ([ConsolidatedWeather]?, Error?) -> ()) {
        let urlString = basePath + "\(woid)/" + "\(date)"
        genericGetAPICall(urlString: urlString, completion: completion)
    }
    
     func genericGetAPICall<T: Codable> (urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        print("T is type: ", T.self)
        
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request) { (data, resp, err) in
            
            if err != nil || data == nil {
                print("Error: url not found")
                completion( nil, err)
                return
            }
            
            if let resp = resp as? HTTPURLResponse {
                guard (200 ... 299) ~= resp.statusCode else {
                    completion(nil, err)
                    return
                }
                
                guard let data = data else {return}
    
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(object, nil)
                } catch let jsonErr {
                    print("failed to decode json data",jsonErr)
                    completion(nil, jsonErr)
                }
            }
            }.resume()
    }
}
