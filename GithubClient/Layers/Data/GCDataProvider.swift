//
//  GCDataProvider.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Siesta
import SwiftyJSON

class _GCDataProvider : NSObject {
    
    // MARK: - Initial Setup
    private var apiService : _APIService
    
    override init() {
        apiService = _APIService(baseURL: APIEndpoint.baseUrl.rawValue)
        super.init()
        configService()
    }
    
    func configService()  {
        /// JSON Transformation
        apiService.configureTransformer("\(APIEndpoint.userRepos.rawValue)*/repos") {
            try? ($0.content as JSON)
                .arrayValue
                .map(GCUserRepo.init)
        }
    }
    
    func fetchUserRepos(withUsername
                        username:String,
                        page:Int,
                        count:Int,
                        onSuccess:@escaping ([GCUserRepo])->Void) -> Resource {
        let resource = apiService.userRepos
            .child(username)
            .child("/repos")
            .withParam("page", String(page))
            .withParam("per_page", String(count))
        resource.GET(onSuccess: { (results) in
            onSuccess(results as! [GCUserRepo])
        }) { (error) in
            error.show()
        }
        return resource
    }
    
    
}
