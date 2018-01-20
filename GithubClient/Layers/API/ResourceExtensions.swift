//
//  ResourceExtensions.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Siesta
import SwiftyJSON


typealias APIError = GCError

extension Resource {
    // MARK: - GET
    func GET(withParams params:[String:String]? = nil,
             onSuccess:@escaping (Any)->(),
             onFailure:@escaping (APIError)->())  {
        var request = self.request(.get)
        if let parameters = params {
            request = self.request(.get, json: parameters)
        }
        self.load(using: request).onSuccess { (data) in onSuccess(data.content)}.onFailure { (error) in onFailure(APIError(error: error))}
    }
    
    // MARK: - POST
    func POST(withParams params:[String:String],
              onSuccess:@escaping (Any)->(),
              onFailure:@escaping (APIError)->())  {
        let request = self.request(.post, json: params)
        self.load(using: request).onSuccess { (data) in
            onSuccess(data.content)
            }.onFailure { (error) in onFailure(APIError(error: error))}
    }
    
    func POST(withJson json:String?,
              onSuccess:@escaping (Any)->(),
              onFailure:@escaping (APIError)->())  {
        var request = self.request(.post)
        if let jsonString = json {
            request = self.request(.post, text: jsonString)
        }
        self.service.invalidateConfiguration()
        self.load(using: request)
            .onSuccess { (data) in
                onSuccess(data.content)
            }.onFailure { (error) in onFailure(APIError(error: error))}
    }
    
    func POST(withJson json:Dictionary<String, Any>?,
              onSuccess:@escaping (Any)->(),
              onFailure:@escaping (APIError)->())  {
        var request = self.request(.post)
        if let params = json {
            request = self.request(.post, json: params)
        }
        self.load(using: request).onSuccess { (data) in
            onSuccess(data.content)
            }.onFailure { (error) in onFailure(APIError(error: error))}
    }
    
    // MARK: - PUT
    func PUT(withParams params:[String:String],
             onSuccess:@escaping (Any)->(),
             onFailure:@escaping (APIError)->())  {
        let request = self.request(.put, json: params)
        self.load(using: request).onSuccess { (data) in
            onSuccess(data.content)
            }.onFailure { (error) in onFailure(APIError(error: error))}
    }
    
    // MARK: - PATCH
    func PATCH(withParams params:[String:String],
               onSuccess:@escaping (Any)->(),
               onFailure:@escaping (APIError)->())  {
        let request = self.request(.patch, json: params)
        self.load(using: request).onSuccess { (data) in
            onSuccess(data.content)
            }.onFailure { (error) in onFailure(APIError(error: error))}
    }
    
    // MARK: - DELETE
    func DELETE(withParams params:[String:String],
                onSuccess:@escaping (Any)->(),
                onFailure:@escaping (APIError)->())  {
        let request = self.request(.delete, json: params)
        self.load(using: request).onSuccess { (data) in
            onSuccess(data.content)
            }.onFailure { (error) in onFailure(APIError(error: error))}
    }
}
