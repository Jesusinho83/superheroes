//
//  PersonajeView.swift
//  Superhéroes
//
//  Created by Jesus Grimaldo on 02/10/22.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit
struct PersonajeView: View {
    
    @State var name : String
    @State var thumbnail :[String:String]
    @State var description: String
    @State var urls: [[String:String]]
    var body: some View {
        
        
        VStack{
            ScrollView(.vertical,showsIndicators: false){
            
                    
                    VStack{
                        VStack{
                        WebImage(url: extractImage(data: thumbnail))
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(width: 200, height:400)
                        
                        
                            HStack(spacing: 10){
                                ForEach(urls, id: \.self){data in
                                    NavigationLink(destination: WebView(url: extracURL(data: data))
                                        .navigationBarTitle(extractURLType(data: data))
                                    , label: {
                                        Text(extractURLType(data: data))
                                    })
                                    
                                }
                            }

                        
                        Spacer()
                      }
                        Text(description).font(.subheadline).foregroundColor(.black)

                    }
                                        
                
            }
        
        }.navigationTitle(name)
    
     }
    
    func extracURL(data: [String:String])->URL{
        
        let url = data ["url"] ?? ""
        
        return URL(string: url)!
        
    }
    func extractURLType(data: [String:String])->String{
        let type = data["type"] ?? ""
        
        return type.capitalized
    }

    
    func extractImage(data: [String: String])->URL{
        
        // unir los datos del url para mandar llamar la imagen
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
}


