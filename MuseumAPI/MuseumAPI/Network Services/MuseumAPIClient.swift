//
//  MuseumAPIClient.swift
//  MuseumAPI
//
//  Created by Stephanie Ramirez on 12/28/18.
//  Copyright © 2018 Stephanie Ramirez. All rights reserved.
//

import Foundation

final class MuseumAPIClient {
    
    static func searchEvents(keyword: Int, completionHandler: @escaping (AppError?, ObjectData?) -> Void) {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(keyword)"
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let objectData = try JSONDecoder().decode(ObjectData.self, from: data)
                    // closure captures value from network response
                    completionHandler(nil, objectData)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
    static func getObjectIds(completionHandler: @escaping(AppError?, [Int]?) -> Void) {
        let myUrl = "https://collectionapi.metmuseum.org/public/collection/v1/objects"
        NetworkHelper.performDataTask(urlString: myUrl, httpMethod: "GET") { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let objectData = try JSONDecoder().decode(ObjectIDs.self, from: data)
                    // closure captures value from network response
                    completionHandler(nil, objectData.objectIDs)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
    
}
