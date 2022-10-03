//
//  ModelViewModel.swift
//  Superhéroes
//
//  Created by Jesus Grimaldo on 28/09/22.
//

import Foundation
import SwiftUI
import Alamofire
import CryptoKit

class ModelViewModel: ObservableObject{
    
    @Published var datosModelo: [Result] = []
    let publickey = "0e6ae805d345df00d77c5950d72ec5e4"
    let privatekey = "8b6c46299fe5144ae46961d045ca7c2db3f8a603"
    @Published var offset1: Int = 0

    init(){
        fetch()
       
        
    }
    
    func fetch(){
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privatekey)\(publickey)")
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters?limit=20&offset=\(offset1)&ts=\(ts)&apikey=\(publickey)&hash=\(hash)") else { return }
        URLSession.shared.dataTask(with: url) {data,_,_ in
            
            guard let data = data else { return }
            do{
                let json = try JSONDecoder().decode(Modelo.self, from: data)
                DispatchQueue.main.async {
                    self.datosModelo.append(contentsOf: json.data.results)
                }
            }catch let error as NSError {
                print(String(describing: error))
            }
            
        }.resume()
        
    }
    
    func MD5(data: String) -> String{
        
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
}
