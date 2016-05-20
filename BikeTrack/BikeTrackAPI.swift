//
//  BikeTrackAPI.swift
//  BikeTrack
//
//  Created by Gil Felot on 18/05/16.
//  Copyright © 2016 Gil Felot. All rights reserved.
//

import Foundation
import Moya


let BikeTrackProvider = RxMoyaProvider(endpointClosure: endpointClosure)

enum BikeTrack {
    case Login(username:String, password:String)
    case SignUp(username:String, password:String)
    case GetBikes()
    case CreateBike(name:String, longitude:Double, latitide:Double)
}

extension BikeTrack: TargetType {
    var baseURL: NSURL { return NSURL(string: "https://biketrack-api.herokuapp.com/api")! }
    
    var path: String {
        switch self {
        case .Login(_):
            return "/users/login"
        case .SignUp(_):
            return "/users"
        case .GetBikes(_):
            return "/bikes"
        case .CreateBike(_):
            return "/bikes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Login(_), .SignUp(_), .CreateBike(_):
            return .POST
        case .GetBikes(_):
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .Login(let username, let password):
            return ["username": username, "password": password]
        case .SignUp(let username, let password):
            return ["username": username, "password": password]
        case .CreateBike(let name, let longitude, let latitide):
            return ["name": name, "longitude": longitude, "latitide": latitide]
        default:
            return .None
        }
    }
    
    
    var sampleData: NSData {
        switch self {
        case .Login(_):
            return "{\"success\": true, \"token\": \"JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI1NzI2NjhmMjVkMzZiNTExMDBjODE1OTUiLCJ1c2VybmFtZSI6ImdpbCIsInBhc3N3b3JkIjoiJDJhJDEwJHhjUEdHdk5TYmRTNTFCSGJZRU9MeS4zYVJ2cjZlb3FYTktnekV4VG9VbkhBaHlDWEpSaEVXIiwiX192IjowLCJiaWtlIjpbeyJuYW1lIjoiXCJzcGVjaWFsaXplZFwiIiwibG9uZyI6NDIsImxhdCI6MjQsIl9pZCI6IjU3MjY2YzMzNWQzNmI1MTEwMGM4MTU5NiJ9LHsibmFtZSI6InNwZWNpYWxpemVkIiwibG9uZyI6NDIsImxhdCI6MjQsIl9pZCI6IjU3MjY2YzU0NWQzNmI1MTEwMGM4MTU5NyJ9XX0.j81Q-S4GdP3zy2NEfJwsLcdqoI1wMX496szEM2lmcb8\"}".UTF8EncodedData
        case .SignUp(_):
            return "{\"code\": 200, \"message\": \"Successful created new user\"}".UTF8EncodedData
        case .GetBikes(_):
            return "[{\"name\": \"specialized\",\"long\": 42,\"lat\": 24,\"_id\": \"57266c335d36b51100c81596\"},{\"name\": \"specialized\",\"long\": 42,\"lat\": 24,\"_id\": \"57266c545d36b51100c81597\"},{\"name\": \"specialized\",\"long\": 42,\"lat\": 24,\"_id\": \"573c7a90efdc361100c4c7d7\"},{\"name\": \"specialized\",\"long\": 42,\"lat\": 24,\"_id\": \"573c7ad0efdc361100c4c7d8\"}]".UTF8EncodedData
        case .CreateBike(_):
            return "{\"name\": \"specialized\",\"long\": \"42\",\"lat\": \"24\"}".UTF8EncodedData
        }
    }
    
}

var endpointClosure = { (target: BikeTrack) -> Endpoint<BikeTrack> in
    let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
    var endpoint = Endpoint<BikeTrack>(URL: url, sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    return endpoint
}

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
    
    var UTF8EncodedData: NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
}
