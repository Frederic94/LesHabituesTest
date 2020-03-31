//
//  Database.swift
//  LesHabituesTest
//
//  Created by Frédéric Mallet on 30/03/2020.
//  Copyright © 2020 Frederic Mallet. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

public protocol WriteableDatabase {
    func save<T: Storable>(object: T) throws
    func save<T: Storable>(objects: [T]) throws
    func remove<T: Storable>(object: T) throws
    func removeAll<T: Storable>(object: T.Type) throws
    func removeAll() throws
    func changeSet<T: Storable>(_ model: T.Type) -> Observable<(AnyRealmCollection<Object>, RealmChangeset?)>
}

public protocol ReadableDatabase {
    func fetchObservable<T: Storable>(_ model: T.Type, predicate: NSPredicate?) -> Observable<[T]>
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?) -> [T]
}

public typealias Database = WriteableDatabase & ReadableDatabase
