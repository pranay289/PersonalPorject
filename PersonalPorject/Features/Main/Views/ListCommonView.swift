//
//  ListCommonView.swift
//  PersonalPorject
//
//  Created by Pranay2 on 18/02/25.
//

import SwiftUI

struct ListCommonView: View {
    let menuItem: MenuItem
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: menuItem.url)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                default:
                    Image(systemName: "photo")

                }
            }.frame(height: 250).padding(.bottom,10)
            Text(menuItem.title).frame(maxWidth: .infinity, alignment: .leading)
                .fontDesign(.serif).font(.system(size: 18).bold()).padding(.leading,5).lineLimit(4)
            
            Text(menuItem.description).frame(maxWidth: .infinity, alignment: .leading)
                .fontDesign(.serif).font(.system(size: 14)).padding(.leading,5).padding(.top,0.5).lineLimit(4)
        }
    }
}

#Preview {
    ListCommonView(
        menuItem: MenuItem(
            url: "https://picsum.photos/200",
            title: "The standard Lorem Ipsum passage",
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            id: 0))
}
