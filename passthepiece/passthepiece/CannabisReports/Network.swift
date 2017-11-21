//
//  Network.swift
//  passthepiece
//
//  Created by brianna on 11/20/17.
//  Copyright © 2017 brianna. All rights reserved.
//

import Foundation
import Alamofire

struct Strain {
    
}

enum Router: URLRequestConvertible {
    case getStrains
    
    static let baseURLString = "https://www.cannabisreports.com"
    static let versionString = "/api/v1.0"
    static let strainsString = "/strains"
    
    var method: HTTPMethod {
        switch self {
        case .getStrains:
            return HTTPMethod.get
        }
    }
    
    var path: String {
        switch self {
        case .getStrains:
            return Router.baseURLString + Router.versionString + Router.strainsString
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
//        switch self {
//        case .createUser(let parameters):
//            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//        case .updateUser(_, let parameters):
//            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//        default:
//            break
//        }
        
        return urlRequest
    }
}


class Network {
    
    enum Key: String {
        case data = "data"
    }
    
    enum NetworkError: Error {
        case jsonIsNotDictionary
        case returnedJSONHasNoData
    }
    
    func getStrains(results: (_ strains: [Strain], _ error: NetworkError)->()) throws {
        
        Alamofire.request(Router.getStrains)
            .validate()
            .responseJSON { response in
                
                guard let json = response.result.value as! [String:Any] else {
                    throw error(NetworkError.jsonIsNotDictionary)
                }
                
                guard let data = json[Key.data.rawValue] as! [[String:Any]] else {
                    throw error(NetworkError.returnedJSONHasNoData)
                }
                
                
        }
    }
}
