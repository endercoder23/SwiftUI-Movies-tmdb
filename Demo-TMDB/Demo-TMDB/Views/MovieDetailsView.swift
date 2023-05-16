//
//  MovieDetailsView.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import SwiftUI


struct MovieDetailListView: View {
    
    // Declared variables
    let movie: Movies
    let isFromFavorite: Bool
    @ObservedObject var viewModel: MovieCollectionViewModel
    
    var body: some View {
        
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                MovieBackdropImage(imageURL: movie.backdropURL)
                
                GeometryReader { moviePoster in
                    MovieCardView(movie: movie)
                        .position(x: moviePoster.size.width / 5, y: moviePoster.size.height / 4)
                }
                .padding(.bottom)
                
                GeometryReader { text in
                    VStack(alignment: .trailing, spacing: 8) {
                        
                        Text(movie.release_date ?? "-")
                            .font(.footnote)
                            .foregroundColor(Color.gray.opacity(0.8))
                    }
                    .position(x: text.size.width - 90, y: 0)
                }
                .padding(.bottom, 50)
                
                HStack {
                    if !movie.ratingText.isEmpty {
                        Text(movie.ratingText).foregroundColor(Color.yellow)
                    }
                    Text(movie.scoreText)
                }
                .padding([.top, .leading, .trailing])
                
                VStack(alignment: .leading) {
                    Text("Overview")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(movie.overview ?? "")
                }
                .padding([.top, .leading, .trailing])
                
                getStartedButton
            }
        }
        .cornerRadius(25)
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
                if viewModel.favoriteMovies.map({$0.id}).contains(movie.id) {
                    viewModel.favoriteMovies.removeAll(where: {$0.id == movie.id})
                } else {
                    viewModel.favoriteMovies.append(movie)
                }
            }, label: {
                Text(viewModel.favoriteMovies.map {$0.id}.contains(movie.id) ? "Remove from favorites" : "Add to favorites")
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
        .frame(height: 50)
    }
}

struct MovieCardView: View {
    
    let movie: Movies
    
    var body: some View {
        ZStack {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.8))
                    .cornerRadius(8)
            }
        }
        .frame(width: 100, height: 170)
        .aspectRatio(1, contentMode: .fit)
        .shadow(radius: 8)
    }
}

struct MovieBackdropImage: View {
    
    let imageURL: URL
    
    var body: some View {
        ZStack {
            AsyncImage(url: imageURL) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
    }
}

