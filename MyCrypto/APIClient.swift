//
//  APIClient.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/09.
//

import Foundation
import TDOAuth

struct APIClient {
    private static let server = "https://min-api.cryptocompare.com/data"
    
    static func getCoinList(completion: @escaping ([String:Any]?) -> Void) {
        
        let urlStr = server + "/all/coinlist"
        
        if let url = URL(string: urlStr) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard error == nil else {
                    print("Error: \(String(describing: error))")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode ==  200 else {
                    print("Response: Request failed")
                    return
                }
                
                guard let data = data else {
                    print("Data: No data")
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                        completion(json)
                    }
                } catch {
                    print("JSON conversion error")
                    return
                }
            }.resume()
        }
    }
    
    static func getCoinPrice(name: String, currencies: [String], completion: @escaping ([String:Any]?) -> Void) {
        
        let urlStr = server + "/price"
        
        if let url = URL(string: urlStr) {
            var request = URLRequest(url: url)
            
            let param = NSMutableDictionary()
            param.setValue(name, forKey: "fsym")
            param.setValue(currencies.joined(separator: ","), forKey: "tsyms")
            
            request.httpMethod = "POST"
            let body = try? JSONSerialization.data(withJSONObject: param)
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: \(String(describing: error))")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode ==  200 else {
                    print("Response: Request failed")
                    return
                }
                
                guard let data = data else {
                    print("Data: No data")
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                        completion(json)
                    }
                } catch {
                    print("JSON conversion error")
                    return
                }
            }.resume()
        }
    }
    
    // Twitter API keys and tokens for authentication
    private static let consumerSecret = "VnTQjpCOQxq8OB4ojRB9J0Ljpt9TaBGAtfNjJSV1ElWCOSwI8G"
    private static let consumerKey = "akGGH6PxX2cEPgWUWH6mA3Sr9"
    private static let accessToken = "340931524-Gsi5nBOBZw7zdF7jSDvg2cdEBTvsxlHFMU3iUmVe"
    private static let accessTokenSecret = "IrBsA8Gd7yv1OLXyAlRoIwVlA1gyvyYhKAKZpYYGOB5Pu"
    
    static func searchTweet(hashtag: String, completion: @escaping ([String:Any]?) -> Void) {
        let urlStr = "https://api.twitter.com/1.1/search/tweets.json?q=%23" + hashtag + "&result_type=recent"
        
        if let signedRequest = makeSignedRequest(urlStr) {
            URLSession.shared.dataTask(with: signedRequest) { data, response, error in
                
                guard error == nil else {
                    print("Error: \(String(describing: error))")
                    return
                }
                
                guard let data = data else {
                    print("Data: No data")
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                        completion(json)
                    }
                } catch {
                    print("JSON conversion error")
                    return
                }
            }.resume()
        }
    }
    
    /// Generate our OAuth1 signer
    private static var oauth1: OAuth1<HMACSigner> = {
        let secrets = SharedSecrets(consumerSecret: consumerSecret, accessTokenSecret: accessTokenSecret)
        let sha1Signer = HMACSigner(algorithm: .sha1, material: secrets)
        return OAuth1(withConsumerKey: consumerKey, accessToken: accessToken, signer: sha1Signer)
    }()

    /// Feed requests into our OAuth1 signer to produce signed versions of those requests.
    /// The only modificataion to the provided request is setting the Authorization HTTP header value.
    private static func makeSignedRequest(_ urlStr : String) -> URLRequest? {
        guard let url = URL(string: urlStr) else { return nil }
        let request = URLRequest(url: url)

        let signedRequest = oauth1.sign(request: request)
        return signedRequest
    }
}
