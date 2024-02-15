//
//  RealmModel.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/16/24.
//

import Foundation
import RealmSwift

class AccountBookTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var date: Date?
    @Persisted var time: String?
    @Persisted var priority: String?
    
    convenience init(title: String, memo: String? = nil, date: Date? = nil, time: String? = nil, priority: String? = nil) {
        self.init()
        self.title = title
        self.memo = memo
        self.date = date
        self.time = time
        self.priority = priority
    }
}
