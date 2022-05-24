//
//  Carrentadvert.swift
//  GLKRentCar
//
//  Created by engin gülek on 24.05.2022.
//

import Foundation


struct Carrentadvert : Codable {
    var _id:String
    var advertUserId:String
    var carModel : Carinfo
    var carRentMinuteCost :Int
    var carGasolineState : Int
    var carAdvertDescription : String
    var carLocaitonMinute : Int
    var carLocationLongtude : String
    var carLocationLatitude : String
}
