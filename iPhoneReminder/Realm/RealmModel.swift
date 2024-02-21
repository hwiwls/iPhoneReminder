//
//  RealmModel.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/16/24.
//

import UIKit
import Foundation
import RealmSwift

class MyList: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var regDate: Date
    @Persisted var color: String
    @Persisted var detail: List<Reminder>
    @Persisted var memo: Memo?
    
    convenience init(name: String, regDate: Date, color: String) {
        self.init()
        self.name = name
        self.regDate = regDate
        self.color = color
    }
}

class Memo: EmbeddedObject {
    @Persisted var contents: String
    @Persisted var regDate: Date
    @Persisted var editDate: Date
}


class Reminder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var date: Date?
    @Persisted var time: String?
    @Persisted var priority: String?
    @Persisted var isDone: Bool = false
    @Persisted var regDate: Date
    // Inverse Relationship
    @Persisted(originProperty: "detail") var main: LinkingObjects<MyList>
    
    convenience init(title: String, memo: String? = nil, date: Date? = nil, time: String? = nil, priority: String? = nil, isDone: Bool = false, regDate: Date) {
        self.init()
        self.title = title
        self.memo = memo
        self.date = date
        self.time = time
        self.priority = priority
        self.isDone = isDone
        self.regDate = regDate
    }
}
