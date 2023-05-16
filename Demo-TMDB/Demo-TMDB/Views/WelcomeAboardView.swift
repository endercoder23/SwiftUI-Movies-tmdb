//
//  WelcomeAboardView.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import SwiftUI

struct WelcomeAboardView: View {
    
    // Declared Properties
    @State var showMoviesView: Bool = false
    
    
    var body: some View {
        VStack {
            Image("icon_logo")
            Text("Millions of movies, TV shows and people to discover. Explore now.")
                .font(.custom("Avenir-Heavy", size: 20))
                .foregroundColor(Color(uiColor: UIColor(hex: "#90cea1")))
                .padding()
            getStartedButton
        }
        
        NavigationLink(
            destination: MoviesView(),
            isActive: $showMoviesView,
            label: {})
    }
    
    var getStartedButton: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors:[
                    Color(uiColor: UIColor(hex: "#90cea1")),
                    Color(uiColor: UIColor(hex: "#01b4e4"))
                ]),
                startPoint: .leading,
                endPoint: .trailing)
            .mask(
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 120, height: 45, alignment: .center)
                    .blur(radius: 10)
            )
            .padding(.top, 20)
            Button(action: {
                showMoviesView.toggle()
            }, label: {
                Text("Get Started")
                    .font(.custom("Avenir-Heavy", size: 20))
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
            })
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    gradient: Gradient(colors:[
                        Color(uiColor: UIColor(hex: "#90cea1")),
                        Color(uiColor: UIColor(hex: "#01b4e4")),
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .buttonStyle(PlainButtonStyle())
        }
        .frame(height: 100)
    }
}

struct WelcomeAboardView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeAboardView()
    }
}
