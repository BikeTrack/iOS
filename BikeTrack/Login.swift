//
//  Login.swift
//  BikeTrack
//
//  Created by Gil Felot on 19/05/16.
//  Copyright © 2016 Gil Felot. All rights reserved.
//

import Mapper

struct Login: Mappable {
    let code: Int
    let message: String
    
    init(map: Mapper) throws {
        try code = map.from("code")
        try message = map.from("message")
    }
    
}