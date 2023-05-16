//
//  MovieCellView.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import SwiftUI

struct MovieCellView: View {
    
    // Declared variables
    var movie: Movies
    
    var body: some View {
        HStack {
            AsyncImage(url: APIEndpoint.image(movie.poster_path ?? "").components.url) { image in
                image
                    .resizable()
                    .aspectRatio(0.7 ,contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(movie.original_title ?? "")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.red)
                Text(movie.overview ?? "")
                    .lineLimit(5)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}


