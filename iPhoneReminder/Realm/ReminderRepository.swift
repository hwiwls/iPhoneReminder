//
//  ReminderRepository.swift
//  iPhoneReminder
//
//  Created by hwijinjeong on 2/18/24.
//

import Foundation
import RealmSwift

final class ReminderRepository {
    let realm = try! Realm()
    
    func createItem(_ item: Reminder) {
        do {
            try realm.write {
                realm.add(item)
                print("Realm Crate")
            }
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<Reminder> {
        return realm.objects(Reminder.self)
    }
    
    func fetchSortedByDate() -> Results<Reminder> {
        return realm.objects(Reminder.self).sorted(byKeyPath: "date", ascending: true)
    }

    func fetchSortedByTitle() -> Results<Reminder> {
        return realm.objects(Reminder.self).sorted(byKeyPath: "title", ascending: true)
    }

    func fetchWithLowPriority() -> Results<Reminder> {
        return realm.objects(Reminder.self).filter("priority == '낮음'")
    }

}
