//
//  CarRentAdvertListVM.swift
//  GLKRentCar
//
//  Created by engin gülek on 24.05.2022.
//

import Foundation


class CarRentAdvertListViewModel {
    var carRentAdvertList : [CartRentAdvertViewModel]
    
    init(){
        self.carRentAdvertList = [CartRentAdvertViewModel]()
    }
    
    func cellForItemAt(_ index:Int) -> CartRentAdvertViewModel {
        let carRentAdvert = self.carRentAdvertList[index]
        return carRentAdvert
    }
    
    func numberOfItemsInSection() -> Int {
        return self.carRentAdvertList.count
    }
}




struct CartRentAdvertViewModel {
    var carRentAdvert : Carrentadvert
    
    var advertId : String {
        return carRentAdvert._id
    }
    
    var carInfo : Carinfo{
        return carRentAdvert.carModel
    }
    var carRentMinuteCost :Int {
        return carRentAdvert.carRentMinuteCost
    }
    var carGasolineState : Int{
        return carRentAdvert.carRentMinuteCost
    }
    var carAdvertDescription : String{
        return carRentAdvert.carAdvertDescription
    }
   
    var carLocationLongtude : String{
        return carRentAdvert.carLocationLongtude
    }
    var carLocationLatitude : String{
        return carRentAdvert.carLocationLatitude
    }
    
}
