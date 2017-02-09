//: Playground - noun: a place where people can play

import UIKit

/// 24. 타입중첩

/*
    열거형은 특정 클래스나 구조체의 기능을 명확히 사용하도록 하기에 용이합니다. 그러나 굳이 클래스나 구조체 외부에서는 열거형을
    사용할 필요가 없을 때도 있습니다. 즉, 클래스나 구조체 내부에서 자신의 역할을 충실히 수행할 수 있도록 역할을 구분짓는 
    열거형을 선언해주고 자신의 내부에서만 사용할 수 있기를 원할 수 있습니다. 또는 특정 데이터 타입들을 하나의 클래스나 구조체
    에 구현하여 외부와의 혼선을 피하고 싶을 수도 있습니다. 어떤 이유가 되었근, 스위프트에는 타입 내부에 타입을 정의하고 구현
    할 수 있습니다. 이처럼 타입 내부에 새로운 타입을 선언해준 것을 중첩타입이라고 부릅니다.
    타입의 내부에 새로운 타입을 정의하고 싶다면, 자신의 정의 내부에 새로운 타입을 정의하고 구현해주기만 하면 됩니다.
 */



/// 24-1 중첩 데이터 타입 구현

class Person {
    enum Job {
        case jobless, programmer, student
    }
    
    var job: Job = .jobless
}

class Student: Person {
    
    enum School {
        case elementary, middle, high
    }
    
    var school: School
    
    init(school: School) {
        self.school = school
        super.init()
        self.job = .student
    }
}

let personJob: Person.Job = .jobless
let studentJob: Student.Job = .student

let student: Student = Student(school: .middle)
print(student.job)  // studnet
print(student.school)   // middle



/// 24-2 같은 이름의 중첩 데이터 타입 구현

struct Sports {
    
    enum GameType {
        case football, basketball
    }
    
    var gameType: GameType
    
    struct GameInfo {
        var time: Int
        var player: Int
    }
    
    var gameInfo: GameInfo {
        switch self.gameType {
        case .basketball:
            return GameInfo(time: 40, player: 5)
        case .football:
            return GameInfo(time: 90, player: 11)
        }
    }
}

struct Esport {
    
    enum GameType {
        case online, offline
    }
    
    var gameType: GameType
    
    struct GameInfo {
        var location: String
        var package: String
    }
    
    var gameInfo: GameInfo {
        switch self.gameType {
        case .online:
            return GameInfo(location: "www.liveonline.co.kr", package: "LoL")
        case .offline:
            return GameInfo(location: "제주", package: "SA")
        }
    }
}

var basketball: Sports = Sports(gameType: .basketball)
print(basketball.gameInfo)

var sudden: Esport = Esport(gameType: .offline)
print(sudden)

let someGameType: Sports.GameType = .football
let anotherGameType: Esport.GameType = .online

// let errorIfYouWantIt: Sports.GameType = .online // 오류 발생


