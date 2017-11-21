//
//  Post.swift
//  passthepiece
//
//  Created by brianna on 11/19/17.
//  Copyright © 2017 brianna. All rights reserved.
//

import Foundation

struct Post {
    var caption: String?
    var strain: String! = ""
    var comments: [Comment] = []
    var image: URL!
    var ownerImage: URL?
    var ownerHandle: String!
}
