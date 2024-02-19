//
//  RealmModel.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/16/24.
//

import UIKit
import Foundation
import RealmSwift

class Reminder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var date: Date?
    @Persisted var time: String?
    @Persisted var priority: String?
    @Persisted var isDone: Bool = false
    
    convenience init(title: String, memo: String? = nil, date: Date? = nil, time: String? = nil, priority: String? = nil, isDone: Bool = false) {
        self.init()
        self.title = title
        self.memo = memo
        self.date = date
        self.time = time
        self.priority = priority
        self.isDone = isDone
    }
}
