//
//  Bike.swift
//  BikeTrack
//
//  Created by Gil Felot on 19/05/16.
//  Copyright © 2016 Gil Felot. All rights reserved.
//
import  Foundation
import Mapper

struct Bike: Mappable {
    let _id: String
    let name: String
    let long: Double
    let lat: Double
    
    init(map: Mapper) throws {
        try _id = map.from("_id")
        try name = map.from("name")
        try long = map.from("long")
        try lat = map.from("lat")

    }
    
}