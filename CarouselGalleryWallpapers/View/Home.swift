//
//  Home.swift
//  CarouselGalleryWallpapers
//
//  Created by Магомед Ахильгов on 17.06.2022.
//

import SwiftUI

struct Home: View {
    
    @State var posts: [Post] = []
    @State var currentPost: String = ""
    
    var body: some View {
        TabView(selection: $currentPost) {
            ForEach(posts) { post in
                GeometryReader { proxy in
                    let size = proxy.size
                    Image(post.posImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width)
                        .frame(width: size.width, height: size.height)
                }
                .tag(post.id)
                .ignoresSafeArea()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .overlay(
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(posts) { post in
                            Image(post.posImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 70, alignment: .center)
                                .cornerRadius(12)
                                .padding(2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(Color.white, lineWidth: 2)
                                        .opacity(currentPost == post.id ? 1 : 0)
                                )
                                .id(post.id)
                                .onTapGesture {
                                    withAnimation {
                                        currentPost = post.id
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .frame(height: 95)
                .background(Color.black.opacity(0.55).ignoresSafeArea())
                .onChange(of: currentPost) { _ in
                    withAnimation {
                        proxy.scrollTo(currentPost, anchor: .bottom)
                    }
                }
            }, alignment: .bottom
        )
        .onAppear {
            for index in 1...7 {
                posts.append(Post(posImage: "post\(index)"))
            }
            currentPost = posts.first?.id ?? ""
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
