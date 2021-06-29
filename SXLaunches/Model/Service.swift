//
//  Service.swift
//  SXLaunches
//
//  Created by fârûqî on 26.06.2021.
//

import Alamofire
import SwiftyJSON

class APIService {
    
    static let instance = APIService()
    
    func fetchData<T: Codable> ( model: T.Type, completion: @escaping (AFResult<Codable>) ->Void ) {
        let url = "https://api.spacexdata.com/v2/launches"
        AF.request(url)
            .validate()
            .responseJSON { response in
                //print(response)
                switch response.result {
                case .success(let value ):
                    do{
                        let responseJsonData = JSON(value)
                        let responseModel = try JSONDecoder().decode(model.self, from: responseJsonData.rawData())
                        //print(responseJsonData)
                        completion(.success(responseModel))
                    }
                    catch let parsingError{
                        print("fetch success but: \(parsingError)")
                    }
                    break;
                case .failure(let error):
                    print("failure: \(error)")
                    completion(.failure(error))
                
                }
            }
        }
    }
    

