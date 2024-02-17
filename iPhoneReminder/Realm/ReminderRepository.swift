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
    
    func fetchSortedByDate(_ date: Date) -> Results<Reminder> {
        return realm.objects(Reminder.self).where {
            $0.date == date
        }.sorted(byKeyPath: "date", ascending: true)
    }
    
    func fetchSortedByTitle(_ title: String) -> Results<Reminder> {
        return realm.objects(Reminder.self).where {
            $0.title == title
        }.sorted(byKeyPath: "title", ascending: true)
    }
    
    func fetchWithLowPriority(_ priority: String) -> Results<Reminder> {
        return realm.objects(Reminder.self).where {
            $0.priority == priority
        }.filter("priority == '낮음'")
    }

}
