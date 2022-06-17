//
//  File.swift
//  CarouselGalleryWallpapers
//
//  Created by Магомед Ахильгов on 17.06.2022.
//

import Foundation

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var posImage: String
}
