//
//  DateExtensions.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Foundation

extension Date {
    func displayTime(date:String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let givenDate = formatter.date(from: date)
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: givenDate!)
    }
}
