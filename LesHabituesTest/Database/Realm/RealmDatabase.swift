//
//  RealmDatabase.swift
//  LesHabituesTest
//
//  Created by Frédéric Mallet on 30/03/2020.
//  Copyright © 2020 Frederic Mallet. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxRealm
import RxSwift

public protocol Storable {}

extension Object: Storable {}

public enum DatabaseError: Error {
    case noDatabase
    case objectNotSaved
}
public enum ConfigurationType {
    case basic(url: String?)
    case inMemory(identifier: String?)
    var associated: String? {
        switch self {
        case .basic(let url): return url
        case .inMemory(let identifier): return identifier
        }
    }
}
public final class RealmDatabase: Database {
    private let configuration: ConfigurationType
    public init(configuration: ConfigurationType = .basic(url: nil)) throws {
        self.configuration = configuration
    }

    private func instantiateRealm() -> Realm? {
        var rmConfig = Realm.Configuration()
        switch configuration {
        case .basic:
            rmConfig = Realm.Configuration.defaultConfiguration
            if let url = configuration.associated {
                rmConfig.fileURL = NSURL(string: url) as URL?
            }
        case .inMemory:
            rmConfig = Realm.Configuration()
            if let identifier = configuration.associated {
                rmConfig.inMemoryIdentifier = identifier
            }
        }
        return try? Realm(configuration: rmConfig)
    }
    public func fetchObservable<T: Storable>(_ model: T.Type, predicate: NSPredicate?) -> Observable<[T]> {
        guard let realm = instantiateRealm(),
        let objectType = model as? Object.Type else {
            return Observable.empty()
        }
        var objects = realm.objects(objectType)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        return Observable.collection(from: objects).map {result in
            result.compactMap { $0 as? T }
        }
    }

    public func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?) -> [T] {
        guard let realm = instantiateRealm(),
            let objectType = model as? Object.Type else {
                return []
        }
        var objects = realm.objects(objectType)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }

        return objects.compactMap { $0 as? T }
    }

    public func remove<T: Storable>(object: T) throws {
        guard let realm = instantiateRealm() else {
            throw DatabaseError.objectNotSaved
        }
        do {
            try realm.write {
                // swiftlint:disable force_cast
                realm.delete(object as! Object)
                // swiftlint:enable force_cast
            }
        } catch {
            throw DatabaseError.objectNotSaved
        }
    }

    public func removeAll<T: Storable>(object: T.Type) throws {
        guard let realm = instantiateRealm() else {
            throw DatabaseError.objectNotSaved
        }
        do {
            // swiftlint:disable force_cast
            let allObjects = realm.objects(object.self as! Object.Type)
            // swiftlint:enable force_cast
            try realm.write {
                realm.delete(allObjects)
            }
        } catch {
            throw DatabaseError.objectNotSaved
        }
    }

    public func removeAll() throws {
        guard let realm = instantiateRealm() else {
            throw DatabaseError.noDatabase
        }
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            throw DatabaseError.objectNotSaved
        }
    }

    public func save<T: Storable>(object: T) throws {
        guard let realm = instantiateRealm() else {
            throw DatabaseError.objectNotSaved
        }
        do {
            try realm.write {
                // swiftlint:disable force_cast
                realm.add(object as! Object, update: .all)
                // swiftlint:enable force_cast
            }
        } catch {
            throw DatabaseError.objectNotSaved
        }
    }

    public func save<T: Storable>(objects: [T]) throws {
        guard let realm = instantiateRealm() else {
            throw DatabaseError.objectNotSaved
        }
        do {
            try realm.write {
                // swiftlint:disable force_cast
                realm.add(objects as! [Object], update: .all)
                // swiftlint:enable force_cast
            }
        } catch {
            throw DatabaseError.objectNotSaved
        }
    }

    public func changeSet<T: Storable>(_ model: T.Type) -> Observable<(AnyRealmCollection<Object>, RealmChangeset?)> {
        guard let realm = instantiateRealm(),
            let objectType = model as? Object.Type else {
                return .never()
        }
        let objects = realm.objects(objectType)
        return Observable.changeset(from: objects)
            .filter { $1 != nil }
    }
}

