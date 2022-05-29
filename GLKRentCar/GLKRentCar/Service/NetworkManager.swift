//
//  WebService.swift
//  GLKRentCar
//
//  Created by engin gülek on 24.05.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    public func fetch<T:Codable>(url:String,method:HTTPMethod,requestModel: T?, model: T.Type,completion: @escaping (AFResult<Codable>) -> Void) {
    
        let param = NetworkManager.toParameters(model: requestModel)
        
        
        AF.request(url,method:method,
                   parameters: param,encoding: JSONEncoding.init() ).response { response in
            
           
            
            if method == .get {
                
                    switch response.result {
                    case .success(let value):
                        do{
                            
                            let responseJsonData = JSON(value!)
                            
                            let responseModel = try JSONDecoder().decode(model.self, from: responseJsonData.rawData())
                            completion(.success(responseModel))
                        }
                        catch let parsingError{
                                                print("Success (error): \(parsingError)")
                                            }
                    case .failure(let error):
                        print("Failure: \(error)")
                                                completion(.failure(error))
                        
                    }
            }
            
            
        }
        
    }
    
    
    static func toParameters<T:Encodable>(model: T?) -> [String:AnyObject]?
        {
            if(model == nil)
            {
                return nil
            }
            
            let jsonData = modelToJson(model:model)
            let parameters = jsonToParameters(from: jsonData!)
            return parameters! as [String: AnyObject]
        }
    
    static func modelToJson<T:Encodable>(model:T)  -> Data?
        {
            return try! JSONEncoder().encode(model.self)
        }

        static func jsonToParameters(from data: Data) -> [String: Any]?
        {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }




}
