//
//  APIResources.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Siesta
import SwiftyJSON

extension _APIService {
    var userRepos : Resource {
        return resource(APIEndpoint.userRepos.rawValue)
    }
}
