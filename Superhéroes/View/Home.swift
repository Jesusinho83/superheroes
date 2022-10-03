//
//  Home.swift
//  Superhéroes
//
//  Created by Jesus Grimaldo on 28/09/22.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit


struct Home: View {
    @StateObject var json  = ModelViewModel()
    @State var boton = false
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false, content: {
            if json.datosModelo.isEmpty {
                ProgressView()
                    .padding(.vertical)
                    .onAppear {
                    print("recargando personajes")
                  
                    }

            }else{
                
                VStack(spacing: 15){
                    
                    ForEach(json.datosModelo, id: \.id){ item in
                        
                        // AsyncImage(url: URL(string: "\(item.thumbnail.path).\(item.thumbnail.thumbnailExtension)"))
                        HStack{
                            WebImage(url: extractImage(data: item.thumbnail))
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading,spacing: 9,content:  {
                                Text(item.name)
                                    .font(.title)
                                    .foregroundColor(.blue)
                                    .bold()
                              

                                Button{
                                    boton.toggle()
                                    
                                    print("Favoritos")
                                }label: {
                                    NavigationLink(destination: PersonajeView(name:item.name, thumbnail: item.thumbnail,description: item.description ?? " ", urls: item.urls)){
                                    Label("info", systemImage: "arrowshape.turn.up.right.fill")
                                }
                                }.padding(.horizontal)
                                HStack(spacing: 10){
                                    ForEach(item.urls, id: \.self){data in
                                        NavigationLink(destination: WebView(url: extracURL(data: data))
                                            .navigationBarTitle(extractURLType(data: data))
                                        , label: {
                                            Text(extractURLType(data: data))
                                        })
                                        
                                    }
                                }
                                
                            })
                        }
                        
                    }.navigationTitle("Superheroes")
                    if json.offset1 == json.datosModelo.count{
                        ProgressView()
                            .padding(.vertical)
                            .onAppear {
                                print("recargando personajes")
                                json.fetch()
                            }
                    }else{
                        GeometryReader{ reader -> Color in
                            
                            let minY = reader.frame(in: .global).maxY
                            let height  = UIScreen.main.bounds.height / 1.3
                            
                            if !json.datosModelo.isEmpty && minY < height {
                                
                                DispatchQueue.main.async {
                                    json.offset1 = json.datosModelo.count
                                }
                                
                            }
                            
                            return Color.clear
                        }
                        .frame(width: 20,height: 20)
                    }
                
            }
         }
            
      })
    }
        
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
