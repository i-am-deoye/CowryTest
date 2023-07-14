//
//  RealmUtility.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation
import RealmSwift


class RealmUtility {
    static let schemaVersion : UInt64 = 1
    
    class func migrate() {
        print(Realm.Configuration.defaultConfiguration.fileURL!.absoluteString)
        
        let migrationBlock : MigrationBlock = { migration, oldSchemaVersion in
            version1(old: oldSchemaVersion, migration: migration)
        }
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion:RealmUtility.schemaVersion, migrationBlock: migrationBlock)
    }
}


extension RealmUtility {
    
    fileprivate class func version1(old version: UInt64, migration: Migration) {
    
    }
}
