//
//  ContentView.swift
//  Weather
//
//  Created by Alexander Heck on 4/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                LocationView()
            }.tabItem {
                Image(systemName: "location.fill")
                Text("My Location")
            }
            NavigationView {
                FavoritesView()
            }
                .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }


            NavigationView {
                SearchView()
            }.tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
