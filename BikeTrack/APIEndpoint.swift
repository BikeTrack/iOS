//
//  APIEndpoint.swift
//  BikeTrack
//
//  Created by Gil Felot on 18/05/16.
//  Copyright © 2016 Gil Felot. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

enum API {
    case Login()
    case CreateUser()
    case GetBikes()
    case CreateBike()
}

extension API: TargetType {
    var baseURL: NSURL { return NSURL(string: "biketrack-api.herokuapp.com/api")! }
    
    var path: String {
        switch self {
        case .Login():
            return "/users/login"
        case .CreateUser():
            return "/users"
        case .GetBikes():
            return "/bikes"
        case .CreateBike():
            return "/bikes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Login():
            return .POST
        case .CreateUser():
            return .POST
        case .GetBikes():
            return .GET
        case .CreateBike():
            return .POST
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .Login():
            return .None
        case .CreateUser():
            return .None
        case .GetBikes():
            return .None
        case .CreateBike():
            return .None
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return .JSON
    }
    
    var sampleData: NSData {
        switch self {
        case .Login():
            return "{\"success\": true, \"token\": \"JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI1NzI2NjhmMjVkMzZiNTExMDBjODE1OTUiLCJ1c2VybmFtZSI6ImdpbCIsInBhc3N3b3JkIjoiJDJhJDEwJHhjUEdHdk5TYmRTNTFCSGJZRU9MeS4zYVJ2cjZlb3FYTktnekV4VG9VbkhBaHlDWEpSaEVXIiwiX192IjowLCJiaWtlIjpbeyJuYW1lIjoiXCJzcGVjaWFsaXplZFwiIiwibG9uZyI6NDIsImxhdCI6MjQsIl9pZCI6IjU3MjY2YzMzNWQzNmI1MTEwMGM4MTU5NiJ9LHsibmFtZSI6InNwZWNpYWxpemVkIiwibG9uZyI6NDIsImxhdCI6MjQsIl9pZCI6IjU3MjY2YzU0NWQzNmI1MTEwMGM4MTU5NyJ9XX0.j81Q-S4GdP3zy2NEfJwsLcdqoI1wMX496szEM2lmcb8\"}".dataUsingEncoding(NSUTF8StringEncoding)!
        case .CreateUser():
            return "{\"code\": 200, \"message\": \"Successful created new user\"}".dataUsingEncoding(NSUTF8StringEncoding)!
        case .GetBikes():
            return "[{\"name\": \"specialized\",\"long\": 42,\"lat\": 24,\"_id\": \"57266c335d36b51100c81596\"},{\"name\": \"specialized\",\"long\": 42,\"lat\": 24,\"_id\": \"57266c545d36b51100c81597\"},{\"name\": \"specialized\",\"long\": 42,\"lat\": 24,\"_id\": \"573c7a90efdc361100c4c7d7\"},{\"name\": \"specialized\",\"long\": 42,\"lat\": 24,\"_id\": \"573c7ad0efdc361100c4c7d8\"}]".dataUsingEncoding(NSUTF8StringEncoding)!
        case .CreateBike():
            return "{\"name\": \"specialized\",\"long\": \"42\",\"lat\": \"24\"}".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    
}