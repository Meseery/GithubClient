//
//  GCPersistantStore.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/20/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Foundation

enum StorageType {
    case cache
    case permanent
    
    var searchPathDirectory: FileManager.SearchPathDirectory {
        switch self {
        case .cache: return .cachesDirectory
        case .permanent: return .documentDirectory
        }
    }
    
    var folder: URL {
        let path = NSSearchPathForDirectoriesInDomains(searchPathDirectory, .userDomainMask, true).first!
        let subfolder = "com.githubclient.UserRepos.json_storage"
        return URL(fileURLWithPath: path).appendingPathComponent(subfolder)
    }
    
    func clearStorage() {
        try? FileManager.default.removeItem(at: folder)
    }
}


class GCPersistantStore<T> where T : Codable {
    let storageType: StorageType
    var filename: String?
    
    init(storageType: StorageType) {
        self.storageType = storageType
        ensureFolderExists()
    }
    
    func save(_ object: T,
              toFile name:String) {
        self.filename = "\(name).json"
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: fileURL)
        } catch let e {
            print("ERROR: \(e)")
        }
    }
    
    func restoreValue(fromFile name: String) -> T? {
        self.filename = "\(name).json"
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(T.self, from: data)
        } catch let e {
            print("ERROR: \(e)")
            return nil
        }
    }
    
    
    private var folder: URL {
        return storageType.folder
    }
    
    private var fileURL: URL {
        guard let file = filename else {
            fatalError("You Must Provide Filename in order to save data")
        }
        return folder.appendingPathComponent(file)
    }
    
    private func ensureFolderExists() {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: folder.path, isDirectory: &isDir) {
            if isDir.boolValue {
                return
            }
            
            try? FileManager.default.removeItem(at: folder)
        }
        try? fileManager.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)
    }
}
