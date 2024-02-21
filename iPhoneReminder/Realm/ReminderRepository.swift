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
    
    func createMyList(_ item: MyList) {
        do {
            try realm.write {
                realm.add(item)
                print("Realm Crate")
            }
        } catch {
            print(error)
        }
    }
    
    func fetchReminder() -> Results<Reminder> {
        return realm.objects(Reminder.self)
    }
    
    func fetchMyList() -> Results<MyList> {
        return realm.objects(MyList.self)
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
    
    func fetchIsDoneItems() -> Results<Reminder> {
        return realm.objects(Reminder.self).filter("isDone == true")
    }
    
    func fetchTodayItems() -> Results<Reminder> {
        let start = Calendar.current.startOfDay(for: Date())
        
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "date >= %@ && date < %@", start as NSDate, end as NSDate)
        return realm.objects(Reminder.self).filter(predicate)
    }
    
    func updateItemIsDone(id: ObjectId, isDone: Bool) {
        do {
            try realm.write {
                realm.create(Reminder.self, value: [
                    "id": id,
                    "isDone": isDone
                ], update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteItem(_ item: Reminder) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    func getTodayReminder() -> Results<Reminder> {
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "date >= %@ && date < %@", start as NSDate, end as NSDate)
        return realm.objects(Reminder.self).filter(predicate)
    }
    
    func getNotTodayReminder() -> Results<Reminder> {
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "date < %@ || date > %@", start as NSDate, end as NSDate)
        return realm.objects(Reminder.self).filter(predicate)
    }
    
    func addReminder(to list: MyList, data: Reminder) {
        do {
            try realm.write {
                list.detail.append(data)
                NotificationCenter.default.post(name: NSNotification.Name("MyListDetailCountUpdated"), object: nil)
            }
        } catch {
            print(error)
        }
    }
}
