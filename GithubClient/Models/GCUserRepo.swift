//
//  GCUserRepo.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import SwiftyJSON

class GCUserRepo{
    
    var name: String?
    var fullName: String?
    var privateRepo: Bool?
    var createdAt: String?
    var forksCount: Int?
    var openIssuesCount: Int?
    var message : String?
    var fork: Bool?

    init(json: JSON) throws {
        name = json["name"].string
        fullName = json["full_name"].string
        privateRepo = json["private"].bool
        createdAt = json["created_at"].string
        forksCount = json["forks_count"].int
        openIssuesCount = json["open_issues_count"].int
        message = json["message"].string
        fork = json["fork"].bool
    }
}
