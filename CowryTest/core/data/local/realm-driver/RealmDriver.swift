//
//  RealmDriver.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//


import Foundation
import RealmSwift

extension List {
    
    var array : [Element] {
        return Array(self)
    }
}

public final class RealmDriver : IDataBaseDriver {
    static let instance = RealmDriver()
    
    private var realm : Realm!
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func save<T>(_ entity: T) {
        do {

            try realm.write {
                realm.add(entity as! Object, update: .modified)
                //NotificationHelper.post(.RealmDidSavedData, object: self, userInfo: nil)
            }
        } catch { print(error.localizedDescription) }
    }
    
    public func fetch<T>(_ type: T.Type) -> [T] {
        let result = realm.objects(type as! Object.Type)
        return computeToList(result: result) as! [T]
    }

    
    fileprivate func computeToList<T>(result: Results<T>) -> [T] {
        var list: [T] = []
        
        for item in result {
            list.append(item)
        }
        
        return list
    }
}


