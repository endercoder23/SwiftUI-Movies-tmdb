//
//  MovieCardView.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import SwiftUI


enum MovieCardType {
    case popular(tapAction: ActionHandler)
    case topRated(tapAction: ActionHandler)
    case upcoming(tapAction: ActionHandler)
    case nowPlaying(tapAction: ActionHandler)

    var image: Image {
        switch self {
        case .popular:
            return Image("icon_popular")
        case .topRated:
            return Image("icon_toprated")
        case .upcoming:
            return Image("icon_upcoming")
        case .nowPlaying:
            return Image("icon_play")
        }
    }

    var title: Text {
        switch self {
        case .popular:
            // L10n.Menu.lidarTitle
            return Text("Popular")
        case .topRated:
            // L10n.Menu.swatchTitle
            return Text("Top Rated")
        case .upcoming:
            // L10n.Menu.floorplanTitle
            return Text("Upcoming")
            
        case .nowPlaying:
            return Text("Now Playing")
        }
    }

}

struct MovieTypeCardView: View {

    let type: MovieCardType

    var body: some View {
        HStack(alignment: .center) {

            type.image
                .padding([.trailing], 8)

            VStack(alignment: .leading) {
                Spacer()
                
                type.title
                    .padding(.bottom, 4)
                    .font(.custom("Avenir-Heavy", size: 20))
                    .foregroundColor(Color(.white))

                Spacer()
            }

            Spacer()
        }
        .padding()
        .frame(width: 374, height: 122)
        .background(Color.black.opacity(0.6))
        .cornerRadius(12)
        .onTapGesture {
            switch type {
            case .topRated(let tapAction):
                tapAction()
            case .popular(let tapAction):
                tapAction()
            case .upcoming(let tapAction):
                tapAction()
            case .nowPlaying(let tapAction):
                tapAction()
            }
        }
    }
}

struct MovieTypeCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTypeCardView(type: .topRated(tapAction: {}))
    }
}

