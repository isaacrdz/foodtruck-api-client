//
//  DataService.swift
//  foodtruck-api.client
//
//  Created by Isaac Rodriguez on 11/13/17.
//  Copyright © 2017 Isaac Rodriguez. All rights reserved.
//

import Foundation



protocol DataServiceDelegate: class {
    func trucksLoaded()
    func reviewsLoaded()
}

class DataService {
    static let instance = DataService()
    weak var delegate: DataServiceDelegate?
    var foodTrucks = [FoodTruck]()
    var reviews = [FoodTruckReview]()
    
    //GET all foodtrucks//
    
    func getAllFoodTrucks(){
        let sessionConfig = URLSessionConfiguration.default
        
        //Create a session, optionally set a URLSessionDelegate
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        //Create Request
        //Get all foodtrucks request (GET /api/v1/foodtrucks)
        
        guard let URL = URL(string: GET_ALL_FT_URL) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
            if (error == nil){
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task succeded: HTTP \(statusCode)")
                if let data = data {
                    self.foodTrucks = FoodTruck.parseFoodTruckJSONData(data: data)
                    self.delegate?.trucksLoaded()
                    
                }
            }
            else {
                print("URL Session Task Failed: \(error!.localizedDescription)")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    // Get all reviews for specific Food Trucks
    func getAllReviews(for truck: FoodTruck){
        
        let sessionConfig = URLSessionConfiguration.default
        
        //Create a session, optionally set a URLSessionDelegate
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string:"\(GET_ALL_FT_Reviews)/\(truck.id)") else { return }
        
        var request = URLRequest(url: URL)
        
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: {(data:Data?,response: URLResponse?, error:Error?) -> Void in
            if ((error) != nil){
                //Success
                let statusCode = ( response as! HTTPURLResponse).statusCode
                print("URL Session task succeded:HTTP \(statusCode)")
                //Parse JSON Data
                if let data = data {
                    self.reviews = FoodTruckReview.parseReviewJSONData(data: data)
                    self.delegate?.reviewsLoaded()
                }
            } else {
                //Failure
                print("URL Session task failed: HTTP \(error!.localizedDescription)")
            }
            
        })
        task.resume()
        session.finishTasksAndInvalidate()
        
    }
    
    func addNewFoodTruck(_ name: String, country:String, foodtype:String, avgcost:Double, latitude: Double, longitude: Double,completion: @escaping callback ){
        //Construct our JSON
        
        let json:[String: Any] = [
            "name":name,
            "country":country,
            "foodtype":foodtype,
            "avgcost":avgcost,
            "geometry": [
                "coordinates":[
                    "lat":latitude,
                    "long":longitude
                ]
            ]
        ]
        do {
            //Serialize JSON
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: POST_ADD_NEW_FOODTRUCK) else { return }
            
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            guard let token = Authservice.instance.authToken else {
                completion(false)
                return
            }
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) -> Void in
                if (error == nil){
                    //Success
                    let statusCode = ( response as! HTTPURLResponse).statusCode
                    print("URL Session task succeded:HTTP \(statusCode)")
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        self.getAllFoodTrucks()
                        completion(true)
                    }
                } else {
                    //Failure
                    print("URL Session task failed:  \(error!.localizedDescription)")
                    completion(false)

                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            
            
        } catch let err{
            completion(false)
            print(err)
        }
    }
    
    //POST add a new foodtruck review
    
    func addNewReview(_ foodtruckId:String, title:String, text:String,completion:@escaping callback){
        let json: [String: Any] = [
            "title": title,
            "text": text,
            "foodtruck": foodtruckId
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string:"\(POST_ADD_NEW_REVIEW)/\(foodtruckId)") else { return }
            
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            guard let token = Authservice.instance.authToken else {
                completion(false)
                return
            }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) -> Void in
                
                
                if(error == nil){
                    //Success
                    let statusCode = ( response as! HTTPURLResponse).statusCode
                    print("URL Session task succeded:HTTP \(statusCode)")
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        
                        completion(true)
                    }
                    
                } else {
                    //Failure
                    print("URL Session task Failed: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            
        } catch let err {
            print(err)
            completion(false)
        }
    }
}
























