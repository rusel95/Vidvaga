//
//  VidvagaApi.swift
//  Vidvaga
//
//  Created by Admin on 13.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VidvagaApi {
    
    static let shared = VidvagaApi()
    private init () { }
    
    //          All api request examples
    //    lastIdURL         http://dev.inkubator-up.co.ua/api/v1/news/last_id
    //    newLoadURL        http://dev.inkubator-up.co.ua/api/v1/news/
    //    searcByTagsURL    http://dev.inkubator-up.co.ua/api/v1/news/search_id_tags
    //    loginURL          http://dev.inkubator-up.co.ua/api/v1/users/login
    //    registrationURL   http://dev.inkubator-up.co.ua/api/v1/users
    //    questions         /api/v1/questions
    

    private let apiUrl = "http://dev.inkubator-up.co.ua/api/v1/"
    
    func getAllNews(givePosts: @escaping ([Post]?) -> Void) -> Void {
        
        let newsURL = "news/"
        
        let urlForRequest = apiUrl + newsURL
        
        Alamofire.request(urlForRequest).responseJSON { (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
//                let url = json["hits"][0]["webformatURL"].string
//                givePosts(url)
                
            case .failure(let error):
                print(error.localizedDescription, urlForRequest)
                givePosts(nil)
            }
        }
    }
    
    func getAllQuestions(giveData: @escaping (JSON?) -> Void) -> Void {
        
        let questionsURL = "questions/"
        
        let urlForRequest = apiUrl + questionsURL
        
        Alamofire.request(urlForRequest).response { (response) in
            print(response)
//            switch response.result {
//            case .success:
//                let json = JSON(response.result.value!)
//                print(json)
////                giveData(json)
//                
//            case .failure(let error):
//                print(error.localizedDescription, urlForRequest)
//                giveData(nil)
//            }
        }
    }
    
    func loginUserWith(giveData: @escaping (JSON?) -> Void) -> Void {
        
        let loginURL = "/login"
        let phoneNumberURL = "?phone_number=+38097577071"
        let passwordURL = "&password=$2y$13$Dv7mbfC0pxO787w349GKFudZ8TIsH.4bByJr0BUk8O307/QZmAqQm"
        
        let urlForRequest = apiUrl + loginURL + phoneNumberURL + passwordURL
        
        Alamofire.request(urlForRequest).response { (response) in
            print(response)
            //            switch response.result {
            //            case .success:
            //                let json = JSON(response.result.value!)
            //                print(json)
            ////                giveData(json)
            //
            //            case .failure(let error):
            //                print(error.localizedDescription, urlForRequest)
            //                giveData(nil)
            //            }
        }
    }
    
}
