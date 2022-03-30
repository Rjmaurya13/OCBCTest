//
//  NetworkClient.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation
import Foundation
let BaseUrl = "https://green-thumb-64168.uc.r.appspot.com/"

public struct NetworkClient {
    public static var shared = NetworkClient()
    func requestObject<C: Decodable>(service : TargetType, httpMethod: String = "", C classType: C.Type,completion: @escaping (C?, Error?) -> ()) {
        
        var request = URLRequest(url: service.path)
        request.httpMethod = service.method
        if (!JSONSerialization.isValidJSONObject(service.parameters)) {
            debugPrint("is not a valid json object")
            return
        }
              
        if service.parameters.count > 0 {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: service.parameters, options: .prettyPrinted)
            } catch {
                print(error)
            }
        }
        
        if let header = service.headers {
            for key in header.keys {
                print(key, header[key] ?? "")
                request.addValue(header[key] ?? "", forHTTPHeaderField: key )
            }
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response
                                                       , error) in
            guard let data = data else { return }
            do {                
                let decoder = JSONDecoder()
                let publicData = try decoder.decode(C.self, from: data)
                completion(publicData,nil)
            } catch let err {
                completion(nil,err)
            }
        }.resume()
    }
}
