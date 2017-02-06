//: Playground - noun: a place where people can play

import UIKit

/// Chapter17. 서브스크립트

/*
    클래스, 구조체 열거형에는 컬렉션, 리스트, 시퀀스 등의 타입의 요소에 접근하는 단축 문법인 서브스크립트를 정의할 수 있습니다.
    서브스크립트는 별도의 설정자 또는 접근자등의 메서드를 구현하지 않아도 인덱스를 통해 값을 설정하거나 가져오는 기능을 할수 
    있습니다. 예를 들어 someArray라는 Array 인스턴스의 index를 통해 해당 인덱스의 값에 접근하고 싶다면 
    someArray[index]라고 표현하며, someDictionay라는 Dictionay의 key를 통해 해당 키에 해당하는 값을 가져오고
    싶다면 someDictionary[key]라고 표현하는 것이 서브스크립트 입니다.
 
    한 타입에 여러 개의 서브스크립트를 정의할 수 있으며 다른 타입을 인덱스로 갖는 여러 개의 서브스크립트를 중복정의 할 수도
    있습니다. 앞서 예를 들었던 Array와 Dictionary처럼 하나의 매개변수를 가질 수도 있으며, 필요에 따라 여러 개의 매개변수를
    인덱스로 사용 할 수도 있습니다.
 
    서브스크립트 문법
    서브스크립트는 인스턴스의 이름 뒤에 대괄호를 감싼 값을 써줌으로써 인스턴스 내부의 특정값에 접급할 수 있습니다.
    서브스크립트 문법은 연산 프로퍼티나 인스턴스 메서드 문법과 유사한 형태로 볼 수 있습니다. 서브스크립트는 subscript 키워드를
    사용하여 정의합니다. 인스턴스 메서드와 비슷하게 매개변수의 개수, 타입, 반화 타입 등을 지정합니다. 서브스크립트는
    읽고 쓰기가 가능하도록 구현하거나 읽기 전용으로만 구현할 수 있습니다. 이는 접근자와 설정자를 사용할 수 있는 연사 프로퍼티의
    형태와 유사합니다. 서브스크립트를 정의하는 코드는 각 타입의 구현부 또는 타입의 익스텐션 구현부에 위치해야 합니다.
 */



///  17-1 서브스크립트 정의 문법

/*
subscript(indx: Int) -> Int {
    get {
        // 적절한 서브스크립트 결괏값 반환
    }
    set(newValue) {
        // 적절한 설정자 역활 수행
    }
}
 */

/*
    구현된 서브스크립트 설정자의 newValue의 타입은 서브스크립트의 반환 타입과 동일합니다. 연산 프로퍼티와 마찬가지로 매개변수
    를 따로 명시해주지 않으면 설정자의 암시적 전달인자 newValue를 사용할 수 있습니다. 또 연산 프로퍼티와 마찬가지로 읽기 전용
    프로퍼티를 구현할 때는 get set 키워드를 사용하지 않고 적절한 값만 반화해주는 형태로 구현해도 됩니다.
 */



/// 17-2 읽기 전용 서브스크립트 정의 문법

/*
subscript(index: Int) -> Int {
    get{
        // 적절한 서브스크립트 값 반환
    }
}

subscript(index: Int) -> Int {
    //   적절한 서브스크립트 값 반환
}
*/



/// 17-3 School 클래스 서브스크립트 구현

/*
struct Student {
    var name: String
    var number : Int
}

class School {
    var number: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String) {
        let student: Student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    
    func addStudents(names: String...) {
        for name in names {
            self.addStudent(name: name)
        }
    }
    
    subscript(index: Int) -> Student? {
        if index < self.number {
            return self.students[index]
        }
        return nil
    }
}

let highSchool = School()
highSchool.addStudents(names: "MiJeong","JuHyun","JiYoung","SeongUk","MoonDuk")

let aStudent: Student? = highSchool[1]
print("\(aStudent?.number) \(aStudent?.name)")  // Optional(1) , Optional("JuHyun")
*/
 
/*
    School 클래스는 읽기 전용 서브스크립트를 하나 가지고 있습니다. 학생의 번호를 전달인자로 전달받아 자신의 students
    프로퍼티의 인덱스에 맞는 Student 인스턴스를 반환합니다. 서브스크립트는 이렇게 자신이 가지는 시퀀스나 컬렉션, 리스트 등의
    요소를 반환 하고 설정할 때 주로 사용됩니다.
 */



/*
    하나의 타입이 여러 개의 서브스크립트를 가질 수도 있습니다. 다양한 매개변수 타입을 사용하여 서브스크립트를 사용할 수 있다는
    뜻입니다.
 */

/// 17-4 복수의 서브스크립트 구현

struct Student {
    var name: String
    var number : Int
}

class School {
    var number : Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String) {
        let student: Student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    
    func addStudents(names: String...) {
        for name in names {
            self.addStudent(name: name)
        }
    }
    
    subscript(index: Int) -> Student? { // 첫 번째 서브스크립트
        get {
            if index < self.number {
                return self.students[index]
            }
            return nil
        }
        set {
            guard var newStudent : Student = newValue else {
                return
            }
            
            var number: Int = index
            
            if index > self.number {
                number = self.number
                self.number += 1
            }
            
            newStudent.number = number
            self.students[index] = newStudent
        }
    }
    
    subscript(name: String) -> Int? {   // 두 번째 서브스크립트
        get {
            return self.students.filter{ $0.name == name }.first?.number
        }
        
        set {
            guard var number : Int = newValue else {
                return
            }
            
            if number > self.number {
                number = self.number
                self.number += 1
            }
            
            let newStudent: Student = Student(name: name, number: number)
            self.students[number] = newStudent
        }
        
    }
    
    subscript(name: String, number: Int) -> Student? {  // 세번째 서브스크립트
        return self.students.filter{ $0.name == name && $0.number == number }.first
    }
}

let highSchool: School = School()
highSchool.addStudents(names: "MiJeong","JuHyun", "JiYoung", "SeongUk", "MoonDuk")

let aStudent: Student? = highSchool[1]
print("\(aStudent?.number) \(aStudent?.name)")  // Optional(1) Optional("JuHyun")

print(highSchool["MiJeong"])
print(highSchool["DoungJin"])

highSchool[0] = Student(name: "HongEui", number: 0)
highSchool["MangGu"] = 1

print(highSchool["JunHyun"])    // nil
print(highSchool["MangGu"]) // Optional(1)
print(highSchool["SeongUk",3])  // Optional(Student(name: "SeongUk", number: 3))
print(highSchool["HeeJin", 3])  // nil

/*
    서브스크립트는 메서드인듯 아닌듯, 연산 프로퍼티인듯 아닌듯 중간 형태를 띠고 있지만 인스턴스 이름 뒤에 대괄호만으로
    편리하게 내부 값에 접급하고 설정해줄 수 있ㅅ브니다. 또 다양한 목적으로 구현해줄 수 있어 용이합니다. 
 */
