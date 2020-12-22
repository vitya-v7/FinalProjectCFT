//
//  VDDataManager.swift
//  
//
//  Created by Viktor Deryabin on 28.11.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit
import CoreData
class VDDataManager: NSObject {
    static let sharedManager = VDDataManager()
    let firstNames = [
        "Tran", "Lenore", "Bud", "Fredda", "Katrice",
        "Clyde", "Hildegard", "Vernell", "Nellie", "Rupert",
        "Billie", "Tamica", "Crystle", "Kandi", "Caridad",
        "Vanetta", "Taylor", "Pinkie", "Ben", "Rosanna",
        "Eufemia", "Britteny", "Ramon", "Jacque", "Telma",
        "Colton", "Monte", "Pam", "Tracy", "Tresa",
        "Willard", "Mireille", "Roma", "Elise", "Trang",
        "Ty", "Pierre", "Floyd", "Savanna", "Arvilla",
        "Whitney", "Denver", "Norbert", "Meghan", "Tandra",
        "Jenise", "Brent", "Elenor", "Sha", "Jessie"
    ]
    let lastNames = [
        
        "Farrah", "Laviolette", "Heal", "Sechrest", "Roots",
        "Homan", "Starns", "Oldham", "Yocum", "Mancia",
        "Prill", "Lush", "Piedra", "Castenada", "Warnock",
        "Vanderlinden", "Simms", "Gilroy", "Brann", "Bodden",
        "Lenz", "Gildersleeve", "Wimbish", "Bello", "Beachy",
        "Jurado", "William", "Beaupre", "Dyal", "Doiron",
        "Plourde", "Bator", "Krause", "Odriscoll", "Corby",
        "Waltman", "Michaud", "Kobayashi", "Sherrick", "Woolfolk",
        "Holladay", "Hornback", "Moler", "Bowles", "Libbey",
        "Spano", "Folson", "Arguelles", "Burke", "Rook"]
   
    let adresses = ["Zorge", "Petuhova", "Vatutina", "Zatulinka", "Moskva"]

    let namesCount = 50
    let adressesCount = 5
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ViperCoreDataDZ")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static let coursePredmet = ["IOS","JAVASCRIPT","PYTHON","C++","FORTRAN"]
    static let courseCount = 5
    
    //////////////// MARK: COURSES
    func addCourse() {
        
        let course: VDCourse = NSEntityDescription.insertNewObject(forEntityName: "VDCourse", into: persistentContainer.viewContext) as! VDCourse
        course.name = String("Course" + String(Int(arc4random())%10000))
        course.predmet = VDDataManager.coursePredmet[Int(arc4random())%5]
        try? persistentContainer.viewContext.save()
        
        VDCourseSpecial.addNewObjectFromEntity(entity: course)
        VDCourseSpecial.courses.sortingBy(parameters: ["name"])
        
        let users = getAllObjectsByEntity(name: "VDUser")
        let prepod = users[Int(arc4random())%users.count] as? VDUser
        //course.prepod = prepod
        
        assignUserAsTeacher(with: (prepod?.objectID)!, onCourseWith: course.objectID)
        while ((course.students?.count)! < 3) {
            
            let stud = users[Int(arc4random())%users.count] as! VDUser
            if (course.prepod != stud && !(course.students?.contains(stud))!) {
                course.addToStudents(stud)
                assignUserAsStudent(with: stud.objectID, onCourseWith: course.objectID)
            }
            
        }
        try? persistentContainer.viewContext.save()
        
    }
    
    func addEmptyCourse() -> VDCourseSpecial
    {
        let course:VDCourse = insertObject(name:"VDCourse")
        let courseModel = VDCourseSpecial.addNewObjectFromEntity(entity: course)
        
        return courseModel
    }
    

    func addTenCourses() {
        for _ in 1...10 {
            addCourse()
        }
    }

    func updateCourse( course: VDCourseSpecial) {
        let courseMO = persistentContainer.viewContext.object(with: course.ID!) as! VDCourse
        courseMO.name = course.name
        courseMO.predmet = course.predmet
        
        try? persistentContainer.viewContext.save()
        VDDataManager.sharedManager.updateUserBD()
        let ind = VDCourseSpecial.getCourseIndexByID(id: course.ID!)
        VDCourseSpecial.courses[ind!] = course
        VDCourseSpecial.courses.sortingBy(parameters: ["name"])
    }

    
    func updateCourseBD() {
        VDCourseSpecial.courses.removeAll()
        let arr = getAllObjectsByEntity(name: "VDCourse")
        
        for case let obj as VDCourse in arr {
            VDCourseSpecial.addNewObjectFromEntity(entity: obj)
        }
    }
    
    
    /////////////USERS//////////////
    //////////////// MARK: USERS
    func addEmptyUser() -> VDUserSpecial {
        let user:VDUser = insertObject(name:"VDUser")
        let userModel = VDUserSpecial.addNewObjectFromEntity(entity: user)
        return userModel
    }
    
    func addUser()
    {
        let user: VDUser = NSEntityDescription.insertNewObject(forEntityName: "VDUser", into: persistentContainer.viewContext) as! VDUser
        user.firstName = firstNames[Int(arc4random())%namesCount] as String
        user.lastName = lastNames[Int(arc4random())%namesCount] as String
        user.adress = adresses[Int(arc4random())%adressesCount] as String
        try? persistentContainer.viewContext.save()
        
        VDUserSpecial.addNewObjectFromEntity(entity: user)
        
    }
    
    func addTenUsers() {
        for _ in 1...10 {
            addUser()
        }
    }
   func updateUser( user: VDUserSpecial) {
        let userMO = persistentContainer.viewContext.object(with: user.ID!) as! VDUser
        userMO.firstName = user.firstName
        userMO.lastName = user.lastName
        userMO.adress = user.adress
        try? persistentContainer.viewContext.save()
        let ind = VDUserSpecial.getUserIndexByID(id: user.ID!)
        VDUserSpecial.users[ind!] = user
        VDUserSpecial.users.sortingBy(parameters: ["firstName","lastName"])
        VDDataManager.sharedManager.updateCourseBD()
        //userMO = persistentContainer.viewContext.object(with: user.ID!) as! VDUser
        //VDDataManager.sharedManager.updateUserBD()
    }
    
    func updateUserBD() {
        VDUserSpecial.users.removeAll()
        let arr = getAllObjectsByEntity(name: "VDUser")
        for case let obj as VDUser in arr {
            VDUserSpecial.addNewObjectFromEntity(entity: obj)
        }
    }
    
    
    //////////////// MARK: SHOW
    func showAllObjects() {
        let users = VDUserSpecial.users
        let courses = VDCourseSpecial.courses
        
        NSLog("USERS:\n")
        
        for i in 0 ..< users.count {
            let user = users[i]
            NSLog("USER #\(i):\n")
            NSLog("\(user.firstName!) \(user.lastName!) \(user.adress!)\n")
            NSLog("\tUSER'S COURSES FOR LEARNING:\n")
            for course in user.courses {
                NSLog("\t\(course.name!)\n")
            }
            NSLog("\n\tUSER'S COURSES FOR TEACHING:\n")
            for course in user.coursesForTeaching {
                NSLog("\t\(course.name!)\n")
            }
        }
        
        NSLog("\n\n\nCOURSES:\n")
        for i in 0 ..< courses.count {
            let course = courses[i]
            NSLog("COURSE #\(i):\n")
            NSLog("\(course.name!) \(course.predmet!)\nPREPOD ETOTO KURSA: \(course.prepod?.firstName! ?? "Netu") \(course.prepod?.lastName! ?? "Prepoda")\n")
            NSLog("\tSTUDENT'S COURSES:\n")
            for user in course.students {
                NSLog("\t\(user.firstName!) \(user.lastName!)\n")
            }
            
        }
        
    
    }
    
    
    /////////////MARK: RELATIONSHIPS
    func assignUserAsStudent(with studentID: NSManagedObjectID, onCourseWith courseID: NSManagedObjectID) {
        let student = persistentContainer.viewContext.object(with: studentID) as! VDUser
        let course = persistentContainer.viewContext.object(with: courseID) as! VDCourse
        if (course.students?.contains(student))! {
           return
        }
        let tmp: NSMutableSet = course.students!.mutableCopy() as! NSMutableSet
        tmp.add(student)
        course.students! = tmp.copy() as! NSSet
        
        try? persistentContainer.viewContext.save()
        
    }
    
    func assignUserAsTeacher(with teacherID: NSManagedObjectID, onCourseWith courseID: NSManagedObjectID) {
        let teacher = persistentContainer.viewContext.object(with: teacherID) as! VDUser
        let course = persistentContainer.viewContext.object(with: courseID) as! VDCourse
        course.prepod = teacher
               
        try? persistentContainer.viewContext.save()
    }
    
    func resignUserAsStudent(with studentID: NSManagedObjectID, fromCourseWith courseID: NSManagedObjectID) {
        let course = persistentContainer.viewContext.object(with: courseID) as! VDCourse
        for case let stud as VDUser in course.students! {
            if stud.objectID == studentID {
                let tmp: NSMutableSet = course.students!.mutableCopy() as! NSMutableSet
                tmp.remove(stud)
                course.students! = tmp.copy() as! NSSet
            }
        }
        try? persistentContainer.viewContext.save()
    }
    
    func resignUserAsTeacher(with teacherID: NSManagedObjectID, fromCourseWith courseID: NSManagedObjectID) {
        let course = persistentContainer.viewContext.object(with: courseID) as! VDCourse
        if course.prepod?.objectID == teacherID {
        course.prepod = nil
        }
        try? persistentContainer.viewContext.save()
    }

    ////////// MARK: GENERAL
    func insertObject<T>(name:String) -> T
    {
        let createdObject: T = NSEntityDescription.insertNewObject(forEntityName: name,
                                                                   into: persistentContainer.viewContext) as! T
        try? persistentContainer.viewContext.save()
        
        return createdObject
    }
    func deleteAllObjects(WithEntityName name: String)
    {
        let arr = getAllObjectsByEntity(name: name)
        for course in arr
        {
            persistentContainer.viewContext.delete(course)
        }
        
        try? persistentContainer.viewContext.save()
        VDDataManager.sharedManager.updateUserBD()
        VDDataManager.sharedManager.updateCourseBD()
    }
    func deleteByID(id:NSManagedObjectID) {
        persistentContainer.viewContext.delete(persistentContainer.viewContext.object(with: id))
        try? persistentContainer.viewContext.save()
        VDDataManager.sharedManager.updateUserBD()
        VDDataManager.sharedManager.updateCourseBD()
    }
    
    func getAllObjectsByEntity(name:String) -> [NSManagedObject] {
        let entity = NSEntityDescription.entity(forEntityName: name, in: persistentContainer.viewContext)
        let request = NSFetchRequest<NSFetchRequestResult>.init()
        request.entity = entity
        
        switch name {
        case "VDUser":
            let nss1 = NSSortDescriptor.init(key: "firstName", ascending: true)
            let nss2 = NSSortDescriptor.init(key: "lastName", ascending: true)
            request.sortDescriptors = [nss1,nss2]
            break
        case "VDCourse":
            let nss1 = NSSortDescriptor.init(key: "name", ascending: true)
            request.sortDescriptors = [nss1]
            break
        default:break
        }
        
        var arr =  [NSManagedObject]()
        do {
            arr = try persistentContainer.viewContext.fetch(request) as! [NSManagedObject]
        }
        catch {
            NSLog("error in EXECUTE REQUEST!!!\n")
        }
        return arr
        
    }
    
    

    
    // MARK: - Core Data Saving support
    
    

}
