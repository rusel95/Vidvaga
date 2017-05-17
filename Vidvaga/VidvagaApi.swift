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
    
    func getAllNews(with name: String, giveURL: @escaping (String?) -> Void) -> Void {
        
        let newsURL = "news/"
        
        let urlForRequest = apiUrl + newsURL
        
        Alamofire.request(urlForRequest).responseJSON { (response) in
            switch response.result {
                
            case .success:
                let json = JSON(response.result.value!)
                let url = json["hits"][0]["webformatURL"].string
                giveURL(url)
                
            case .failure(let error):
                print(error.localizedDescription, urlForRequest)
                giveURL(nil)
            }
        }
    }
    
}
