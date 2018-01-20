//
//  APIService.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Siesta
import SwiftyJSON

open class _APIService : Service {
    
    /// Add to a reponse pipeline to wrap JSON responses with SwiftyJSON
    private let SwiftyJSONTransformer =
        ResponseContentTransformer
            { JSON($0.content as AnyObject) }
    
    // MARK: - Initalization
    init(baseURL url:String) {
        super.init(baseURL: url)
        setuoConfigurations()
    }
    
    // MARK: - Configurations
    func setuoConfigurations()  {
        // Global configuration
        #if DEBUG
            LogCategory.enabled = [.network]
            LogCategory.enabled = LogCategory.common
            LogCategory.enabled = LogCategory.detailed
        #endif
        
        configure{
            $0.expirationTime = 60*60
            $0.pipeline[.parsing].add(self.SwiftyJSONTransformer, contentTypes: ["*/json"])
            $0.pipeline[.cleanup].add(GCErrorMessageExtractor())
            $0.headers["Accept"] = "application/json"
        }
    }
    
    /// If the response is JSON and has a "message" value, use it as the user-visible error message.
    private struct GCErrorMessageExtractor: ResponseTransformer {
        func process(_ response: Response) -> Response {
            switch response {
            case .success:
                return response
                
            case .failure(var error):
                error.userMessage = error.json["message"].string ?? error.userMessage
                return .failure(error)
            }
        }
    }
}


/// Provides a .json convenience accessor to get raw JSON from resources
extension TypedContentAccessors {
    var json: JSON {
        return typedContent(ifNone: JSON.null)
    }
}
