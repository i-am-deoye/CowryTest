//
//  Local.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation

typealias ILocal = ILocalCRUD

open class Local <E> : ILocal where E : Persistable {
    
    public typealias T = E
    private var entityClass: E.Type!
    private var db : IDataBaseDriver!
    
    private init() {}
    
    public init(entityClass: E.Type, db: IDataBaseDriver?) {
        
        guard let db = db else { Logger.log(.s, messages: "Local cant be nil"); return }
        
        self.entityClass = entityClass
        self.db = db
    }
    
    private func isPersistable(_ entity: Any) -> Bool {
        guard entity is Persistable else { return false }
        return true
    }
    
    private func throwIfPersistableError(_ entity: T) {
        assert(isPersistable(entity), "Persistable must be implemented to your Entity Class")
    }
    
    public func save(_ entity: E)  {
        throwIfPersistableError(entity)
        db.save(entity)
    }
    
    
    public func fetch() -> [E] {
        let result = db.fetch(entityClass)
        return result
    }
}
