
//  MoviesView.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.


import SwiftUI

typealias ActionHandler = () -> Void

struct MoviesView: View {

    @State var showMoviesTypeView: Bool = false
    @StateObject private var viewModel = MovieCollectionViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors:[
                    Color(uiColor: UIColor(hex: "#90cea1")),
                    Color(uiColor: UIColor(hex: "#01b4e4")),
                ]),
                startPoint: .leading,
                endPoint: .trailing)
            .ignoresSafeArea(edges: .all)
            
            TabView {
                VStack(spacing: 20) {
                    
                    MovieTypeCardView(type: .popular(tapAction: {
                        viewModel.onChangePickerView(type: .popular)
                        showMoviesTypeView.toggle()
                    }))
                    
                    MovieTypeCardView(type: .topRated(tapAction: {
                        viewModel.onChangePickerView(type: .topRated)
                        showMoviesTypeView.toggle()
                    }))
                    
                    MovieTypeCardView(type: .upcoming(tapAction: {
                        viewModel.onChangePickerView(type: .upcoming)
                        showMoviesTypeView.toggle()
                    }))
                    
                    MovieTypeCardView(type: .nowPlaying(tapAction: {
                        viewModel.onChangePickerView(type: .nowPlaying)
                        showMoviesTypeView.toggle()
                    }))
                    
                }
                .tabItem {
                    VStack {
                        Image(systemName: "play.square.stack")
                        Text("Movies")
                    }
                }
                
                VStack {
                    FavoriteMovieListView(viewModel: viewModel)
                }
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                        Text("Favorites")
                    }
                }
            }
        }
        
        NavigationLink(
            destination: MovieCollectionView(viewModel: viewModel),
            isActive: $showMoviesTypeView,
            label: {})
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}


