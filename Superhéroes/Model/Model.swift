//
//  Model.swift
//  Superhéroes
//
//  Created by Jesus Grimaldo on 28/09/22.
//

import Foundation
import Alamofire

struct Modelo: Codable {
       let data: DataClass
    
}

// MARK: - DataClass
struct DataClass: Codable {
 
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let thumbnail: [String:String]
    let description: String?
    let comics, series: Comics
    let urls: [[String:String]]
    
}
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}



