//
//  CachedCarbObjectTests.swift
//  LoopKitTests
//
//  Copyright © 2018 LoopKit Authors. All rights reserved.
//

import XCTest
@testable import LoopKit

class CachedCarbObjectTests: PersistenceControllerTestCase {

    func testUUIDUniqueConstraint() {
        cacheStore.managedObjectContext.performAndWait {
            let uuid = UUID()

            let object1 = CachedCarbObject(context: cacheStore.managedObjectContext)
            object1.setDefaultValues()
            object1.uuid = uuid

            try! cacheStore.managedObjectContext.save()

            let object2 = CachedCarbObject(context: cacheStore.managedObjectContext)
            object2.setDefaultValues()
            object2.uuid = uuid

            try! cacheStore.managedObjectContext.save()

            let objects: [CachedCarbObject] = cacheStore.managedObjectContext.all()
            XCTAssertEqual(1, objects.count)
        }
    }

    func testSyncIdentifierUniqueConstraint() {
        cacheStore.managedObjectContext.performAndWait {
            let uuid = UUID()

            let object1 = CachedCarbObject(context: cacheStore.managedObjectContext)
            object1.setDefaultValues()
            object1.syncIdentifier = uuid.uuidString

            try! cacheStore.managedObjectContext.save()

            let object2 = CachedCarbObject(context: cacheStore.managedObjectContext)
            object2.setDefaultValues()
            object2.syncIdentifier = uuid.uuidString

            try! cacheStore.managedObjectContext.save()

            let objects: [CachedCarbObject] = cacheStore.managedObjectContext.all()
            XCTAssertEqual(1, objects.count)
        }
    }

    func testAllUniqueConstraints() {
        cacheStore.managedObjectContext.performAndWait {
            let uuid = UUID()

            let object1 = CachedCarbObject(context: cacheStore.managedObjectContext)
            object1.setDefaultValues()
            object1.uuid = uuid
            object1.syncIdentifier = uuid.uuidString

            try! cacheStore.managedObjectContext.save()

            let object2 = CachedCarbObject(context: cacheStore.managedObjectContext)
            object2.setDefaultValues()
            object2.uuid = uuid
            object2.syncIdentifier = uuid.uuidString

            try! cacheStore.managedObjectContext.save()

            let objects: [CachedCarbObject] = cacheStore.managedObjectContext.all()
            XCTAssertEqual(1, objects.count)
        }
    }

    func testSaveWithDefaultValues() {
        cacheStore.managedObjectContext.performAndWait {
            let object1 = CachedCarbObject(context: cacheStore.managedObjectContext)
            object1.setDefaultValues()

            try! cacheStore.managedObjectContext.save()

            let object2 = CachedCarbObject(context: cacheStore.managedObjectContext)
            object2.setDefaultValues()

            try! cacheStore.managedObjectContext.save()

            let objects: [CachedCarbObject] = cacheStore.managedObjectContext.all()
            XCTAssertEqual(2, objects.count)
        }
    }
}


extension CachedCarbObject {
    fileprivate func setDefaultValues() {
        createdByCurrentApp = true
        startDate = Date()
    }
}
