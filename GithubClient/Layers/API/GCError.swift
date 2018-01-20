//
//  APIError.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Siesta

struct GCError {
    var errorCode : Int?
    var errorMessage : String?
    var errorFriendlyMessage : String?
    
    init(code:Int?, message:String?, friendlyMessage:String?) {
        self.errorMessage = message
        self.errorCode = code
        self.errorFriendlyMessage = friendlyMessage
    }
    
    init(error:RequestError) {
        self.errorCode = error.httpStatusCode
        self.errorMessage = error.userMessage
        if let errors = error.entity?.jsonDict["errors"] as? [String:Array<String>] {
            let messages = errors.values.joined().joined(separator: "\n")
            self.errorFriendlyMessage = messages
        }
    }
    
    func show(){
        var message = "Something Went wrong!"
        if let friendlyMsg = self.errorFriendlyMessage {
            message = friendlyMsg
        }
        AlertView.showAlert(WithMessage: message)
    }
    
}
