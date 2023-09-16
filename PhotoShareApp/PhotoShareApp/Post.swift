//
//  Post.swift
//  PhotoShareApp
//
//  Created by Mehmet Özkan on 16.09.2023.
//

import Foundation


class Post {
    var email: String
    var comment: String
    var imageUrl: String
    
    
    init(email: String, comment: String, imageUrl: String) {
        self.email = email
        self.comment = comment
        self.imageUrl = imageUrl
    }
    
    
}
