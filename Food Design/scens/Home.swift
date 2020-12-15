//
//  Home.swift
//  Food Design
//
//  Created by hosam on 12/15/20.
//

import SwiftUI

// tabs...

var tabs = ["Shakes","Coffee","Drinks","Cocktail"]

struct Home : View {
    
    @State var midY : CGFloat = 0
    @State var selected = "Shakes"
    @State var search = ""
    
    var body: some View{
        
        HStack(spacing: 0){
            
            VStack{
                
                Button(action: {}, label: {
                    
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                })
                
                Spacer(minLength: 0)
                
                ForEach(tabs,id: \.self){name in
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 13, height: 13)
                            .offset(x: selected == name ? 28 : -80)
                        
                        Color("tab")
                            .frame(width: 150, height: 110)
                            .rotationEffect(.init(degrees: -90))
                            .offset(x: -50)
                        
                        GeometryReader {reader in
                            
                            Button(action: {
                                
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.65, blendDuration: 0.65)){
                                    
                                    self.midY = reader.frame(in: .global).midY
                                    self.selected = name
                                }
                                
                            }, label: {
                                
                                Text(name)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            })
                            .frame(width: 150, height: 110)
                            // default frame...
                            .rotationEffect(.init(degrees: -90))
                            
                            // getting Inital First Curve Position....
                            .onAppear(perform: {
                                
                                if name == tabs.first{
                                    self.midY = reader.frame(in: .global).midY
                                }
                            })
                            .offset(x: -8)
                        }
                        .frame(width: 150, height: 110)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .frame(width: 70)
            .background(
                Color("tab")
                    .clipShape(Curve(midY: midY))
                    .ignoresSafeArea()
                
            )
            
            VStack{
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundColor(.black)
                    })
                }
                .padding()
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 4, content: {
                        
                        Text("Smoothie King")
                            .font(.title)
                            .fontWeight(.heavy)
                        
                        Text("Shakes")
                            .font(.title)
                    })
                    .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(spacing: 15){
                    
                    TextField("Search", text: $search)
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                .background(Color.black.opacity(0.06))
                .clipShape(Capsule())
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    LazyVStack(spacing: 25){
                        
                        // Items....
                        ForEach(items){item in
                            
                            ItemView(item: item)
                        }
                    }
                    .padding()
                    .padding(.top)
                })
            }
            .padding(.leading)
            
            Spacer()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
