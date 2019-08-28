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
    
    func searchLocationWOID(location: String, completion: @escaping ([Location]?, URLResponse?, Error?)->()) {
        
        let urlString = basePath + "search/?query=\(location)"
        
        genericGetAPICall(urlString: urlString, completion: completion)
        
    }
    
    func fetchLocationWeather(locationWoid: String, completion: @escaping (Weather?, URLResponse?, Error?)->()) {
        
        let urlString = basePath + "\(locationWoid)"
        genericGetAPICall(urlString: urlString, completion: completion)
    }
    
     func genericGetAPICall<T: Codable> (urlString: String, completion: @escaping (T?, URLResponse?, Error?) -> ()) {
        
        print("T is type: ", T.self)
        
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request) { (data, resp, err) in
            
            if let err = err {
                completion(nil, nil, err)
            }
            
            if let resp = resp as? HTTPURLResponse {
                
                guard (200 ... 299) ~= resp.statusCode else {
                    completion(nil,resp,nil)
                    return
                }
                
                guard let data = data else {return}
                print(String(data: data, encoding: .utf8) ?? "")
                
                do {
                    
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(object, resp, nil)
                    
                } catch let jsonErr {
                    print("failed to decode json data",jsonErr)
                    completion(nil, resp, jsonErr)
                }
            }
            
            }.resume()

    }
}
