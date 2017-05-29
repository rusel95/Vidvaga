//
//  VidvagaApi.swift
//  Vidvaga
//
//  Created by Admin on 13.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class VidvagaApi {
    static let shared = VidvagaApi()
    private init () { }
    
    private let newsURL = "http://dev.inkubator-up.co.ua/api/v1/news"
    private let topNewsIdUrl = "http://dev.inkubator-up.co.ua/api/v1/news/top_id"
    
    private var imageUrls = [String]()
    
    func downloadNews(completion: @escaping ([[String:Any]]?) -> Void) {
        var newsFeed: [[String:Any]] = []

        Alamofire.request(newsURL).responseJSON { response in
            if response.result.value != nil {
                let json = response.result.value as! [[String:Any]]
                for post in json {
                   newsFeed.append(post)
                }
            }
            completion(newsFeed)
        }
    }
    
    func downloadTopNewsId(completion: @escaping (Int?) -> Void){
        var topId: Int!
        Alamofire.request(topNewsIdUrl).responseJSON { response in
            if response.result.value != nil {
                topId = response.result.value as! Int
            }
            completion(topId)
        }
    }
    
    func downloadNewsById(newsId: Int, completion: @escaping ([String:Any]?) -> Void){
        var news: [String:Any] = [:]
        let newsByIdUrl = newsURL + "/" + "\(newsId)"
        Alamofire.request(newsByIdUrl).responseJSON { (response) in
            if response.result.value != nil {
                news = response.result.value as! [String : Any]
            }
            completion(news)
        }
    }
    
    func downloadImage(stringUrl: String, completion: @escaping (Data?) -> Void){
        var data: Data = Data()
        Alamofire.request(stringUrl).responseData { (response) in
            if response.result.value != nil {
                data = response.result.value!
            }
            completion(data)
        }
    }
    
    func getImageUrls() -> [String] {
        return imageUrls
    }
    
//    func getAllQuestions(giveData: @escaping (JSON?) -> Void) -> Void {
//        
//        let questionsURL = "questions/"
//        
//        let urlForRequest = apiUrl + questionsURL
//        
//        Alamofire.request(urlForRequest).response { (response) in
//            print(response)
////            switch response.result {
////            case .success:
////                let json = JSON(response.result.value!)
////                print(json)
//////                giveData(json)
////                
////            case .failure(let error):
////                print(error.localizedDescription, urlForRequest)
////                giveData(nil)
////            }
//        }
//    }
//    
//    func loginUserWith(giveData: @escaping (JSON?) -> Void) -> Void {
//        
//        let loginURL = "/login"
//        let phoneNumberURL = "?phone_number=+38097577071"
//        let passwordURL = "&password=$2y$13$Dv7mbfC0pxO787w349GKFudZ8TIsH.4bByJr0BUk8O307/QZmAqQm"
//        
//        let urlForRequest = apiUrl + loginURL + phoneNumberURL + passwordURL
//        
//        Alamofire.request(urlForRequest).response { (response) in
//            print(response)
//            //            switch response.result {
//            //            case .success:
//            //                let json = JSON(response.result.value!)
//            //                print(json)
//            ////                giveData(json)
//            //
//            //            case .failure(let error):
//            //                print(error.localizedDescription, urlForRequest)
//            //                giveData(nil)
//            //            }
//        }
//    }
    
}
