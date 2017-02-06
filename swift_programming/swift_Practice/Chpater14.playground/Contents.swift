//: Playground - noun: a place where people can play

import UIKit

/// Chapter 14. 옵셔널 체이닝과 빠른 종료 

/*
    옵셔널 체이닝
    옵셔널 체이닝은 nil일지도 모르는 옵셔널에 속해 있는 프로퍼티, 메서드, 서브스크립션등을 가져오거나 호출할 수 있고,
    옵셔널이 nil이라면 프로퍼티, 메서드, 서브스크립트 등은 nil을 반환합니다. 옵셔널을 반복 사용하여 옵셔널이 자전거
    체인처럼 서로 꼬리를 물고있는 모양이기 때문에 옵셔널 체이닝이라고 부릅니다. 자전거 체인에서 한 칸이라도 없거나 
    고장나면 체인 전체가 동작하지 않듯이 중첩된 옵셔널 중 하나라도 값이 존재하지 않는다면 결과적으로 nil을 반환합니다.
 
    옵셔널 체이닝은 프로퍼티나 메서드 또는 서브스크리브를 호출하고 싶은 옵셔널 변수나 상수 뒤에 물음표(?)를 붙여 표현합니다.
    옵셔널이 nil이 아니라면 정상적으로 호출될 것이고, nil이라면 결괏값을 반환할 것입니다. 결과적으로 nil이 반환될 가능성이
    있으므로 옵셔널 체이닝의 반환된 값은 항상 옵셔널입니다.
 */

/// 14-1 사람의 주소 정보 표현 설계 

class Room {    // 호실
    var number: Int // 호실 번호

    init(number: Int) {
        self.number = number
    }
}

class Building {    // 건물
    var name: String    // 건물 이름
    var room: Room?     // 건물 정보

    init(name: String) {
        self.name = name
    }
}

struct Address { // 주소
    var province: String    // 광역시/도
    var city: String    // 시/군/도
    var street: String  // 도로명
    var building: Building? // 건물
    var detailAddress: String?  // 건물 외 주소
    
    init(province: String, city: String, street: String) {
        self.province = province
        self.city = city
        self.street = street
    }
    
    /*
    func fullAddress() -> String? {
        var restAddress: String? = nil
        
        if let buildingInfo: Building = self.building {
            
            restAddress = buildingInfo.name
            
        } else if let detail = self.detailAddress {
            
            restAddress = detail
            
        }
        
        if let rest: String = restAddress {
            var fullAddress: String = self.province
            
            fullAddress += " " + self.city
            fullAddress += " " + self.street
            fullAddress += " " + rest
            
            return fullAddress
            
            
        } else {
            return nil
        }
    }
 */
    
    func fullAddress() -> String? {
        var restAddress: String? = nil
        
        if let buildingInfo : Building = self.building {
            restAddress = buildingInfo.name
        } else if let detail = self.detailAddress {
            restAddress = detail
        }
        
        guard let rest: String = restAddress else {
            return nil
        }
        
        var fullAddress: String = self.province
        fullAddress += self.city
        fullAddress += self.street
        fullAddress += rest
        
        return fullAddress
    }

 
    func printAddress() {
        if let address: String = self.fullAddress() {
            print(address)
        }
    }
    
    
}

class Person { // 사람
    var name: String    // 이름
    var address: Address?   // 주소
    
    init(name: String) {
        self.name = name
    }
}



/// 14-2 yagom 인스턴스 생성

let yagom: Person = Person(name: "yagom")



/// 14-3 옵셔널 체이닝 문법

let yagomRoomViaOptionalChaining: Int? = yagom.address?.building?.room?.number  // nil
// let ygaomRoomViaOptionalUnWaraping: Int = yagom.address!.building!.room!.number // 오류 발생



/// 14-4 옵셔널 바인딩의 사용

let yagom1: Person = Person(name: "yagom")

var roomNumber: Int? = nil

if let yagaomAddress: Address = yagom.address {
    if let yagomBuilding: Building = yagaomAddress.building {
        if let yagomRoom: Room = yagomBuilding.room {
            roomNumber = yagomRoom.number
        }
    }
}

if let number: Int = roomNumber {
    print(number)
} else {
    print("Can not find room number")
}



/// 14-5 옵셔널 체이닝의 사용

let yagom2: Person = Person(name: "yagom")

if let roomNumber: Int = yagom.address?.building?.room?.number {
    print(roomNumber)
} else {
    print("Can not find room number!")
}



/// 14-6 옵셔널 체이닝을 통한 값 할당 시도

yagom.address?.building?.room?.number = 505
print(yagom.address?.building?.room?.number)    // nil

/*
    옵셔널 체이닝을 하는 중에 nil 값이 나오기 때문에 중간에 멈추고 결국 505는 할당되지 않는다.
 */



/// 14-7 옵셔널 체이닝을 통한 값 할당

yagom.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로")
yagom.address?.building = Building(name:"곰굴")
yagom.address?.building?.room = Room(number: 0)
yagom.address?.building?.room?.number = 505

print(yagom.address?.building?.room?.number)    // Optional(505)



/*
    옵셔널 체이닝을 통해서 메서드와 서브스크립트 호출도 가능합니다.
    서브스크리브는 인덱스를 통해 값을 넣고 빼올수 있는 기능입니다.
 */

/// 14-8 옵셔널 체이닝을 통한 메서드 호출

/*
struct Address { // 주소
    var province: String // 광역시/도
    var city: String    // 시/군/구
    var street: String  // 도로명
    var building: Building? // 건물
    var detailAddress: String? // 건물 외 상세주소
    
    init(province: String, city: String, street: String) {
        self.province = province
        self.city = city
        self.street = street
    }
    
    func fullAddress() -> String? {
        var restAddress: String? = nil
        
        if let buildingInfo: Building = self.building {
            
            restAddress = buildingInfo.name
            
        } else if let detail = self.detailAddress {
            
            restAddress = detail
            
        }
        
        if let rest: String = restAddress {
            var fullAddress: String = self.province
            
            fullAddress += " " + self.city
            fullAddress += " " + self.street
            fullAddress += " " + rest
            
            return fullAddress
            
            
        } else {
            return nil
        }
    }
    
    func printAddress() {
        if let address: String = self.fullAddress() {
            print(address)
        }
    }
}

*/


yagom.address?.fullAddress()?.isEmpty   // false
yagom.address?.printAddress()   // 충청북도 청주시 청원구 충청대로 곰굴



/*
    우리가 서브스크립트를 가장 많이 사용하고 있는 곳은 Array와 Dictionary 입니다. 옵셔널의 서브스크립트를 사용하고자
    할 때는 대괄호([])보다 앞에 물음표(?)를 표시해주어야 합니다. 이는 서브스크립트 외에도 언제나 옵셔널 체이닝을 
    사용할 때의 규칙입니다.
 */

/// 14-9 옵셔널 체이닝을 통한 서브스크립트 호출

let optionalArray: [Int]? = [1,2,3,]
optionalArray?[1]   // 2

var optionalDitionary: [String: [Int]]? = [String: [Int]]() // String에 Int배열 타입인 Dictionary생성
optionalDitionary?["numberArray"] = optionalArray
optionalDitionary?["numberArray"]?[2]   // 3



/*
    빠른종료
    빠른종료의 핵심 키워드는 guard 입니다. guard 구문은 if 구문과 유사하게 Bool 카입의 값으로 동작하는 기능입니다.
    guard 뒤에 따라붙는 코드의 실행 결과가 true일 때 코드가 계속 실행됩니다. if 구문과는 다르게 guard 구문은 항상
    else 구문이 뒤에 따라와야 합니다. 만약 guard 뒤에 따라오는 값이 fasle라면 else의 블록 내부 코드를 실행하게 되는데
    이때 else 구문의 블록 내부에는 꼭 자신보다 상위 코드 블록을 종료하는 코드가 들어가게 됩니다. 그래서 특정 조건에 부합하지
    않는다는 판단이 되면 재빠르게 코드 블록의 실행을 종료할 수 있습니다. 이렇게 현재의 코드 블록을 종료할 시에는 return,
    break, continue, throw 등의 제어문 전환 명령을 사용합니다. 또는 fatalError() 와 같은 비반환 함수나 
    메서드를 호출할 수도 있습니다.
 
    guard Bool 타입 값 else {
        예외사항 실행문
        제어문 전환 명령어
    }
 
    guard 구문을 사용하면 if 코드를 훨씬 간결하고 읽기 좋게 구성할 수 있습니다. if 구문을 쓰면 예외사항을 else 블록으로
    처리해야 하지만 예외사항만을 처리하고 싶다면 guard 구문을 쓰는 것이 훨씬 간편합니다.
 */



/// 14-10

// if 구문을 사용한 코드
for i in 0...3 {
    if i == 2 {
        print(i)
    } else {
        continue
    }
}

// guard 구문을 사용한 코드

for i in 0...3 {
    guard i == 2 else {
        continue
    }
    print(i)
}

/*
    Bool 타입의 값으로 guard 구문을 동작시킬 수 있지만 옵셔널 바인딩의 역할도 수행할 수 있습니다. guard 뒤에 따라오는
    옵셔널 바인딩 표현에서 옵셔널의 값이 있는 상태라면 guard 구문에서 옵셔널 바인딩된 상수를 guard 구문이 실행된 아래 
    코드부터 함수 내부의 지역상수 처럼 사용할수 있습니다.
 */



/// 14-11 guard 구문의 옵셔널 바인딩 활용

func greet( _ person: [String: String]) {
    guard let name: String = person["name"] else {
        return
    }
    
    print("Hello \(name)")
    
    guard let location: String = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weather is nice on \(location)")
}

var personInfo: [String: String] = [String: String]()
personInfo["name"] = "Jenny"

greet(personInfo)
// Hello Jenny!
// I hope the weather is nice near you

personInfo["location"] = "Korea"

greet(personInfo)
// Hello Jenny!
// I hope the weather nice on Korea

/*
    guard를 통해 옵셔널 바인딩 된 상수는 great( _ :) 함수 내에서 지역상수 처럼 사용된 것을 볼수 있습니다.
    그러면 우리가 옵셔널 체이닝에서 작성했던 코드를 조금 더 발전시켜 보겠습니다.
 */



/// 14-12 메서드 내부에서 guard 구문의 옵셔널 바인딩 활용

/*
func fullAddress1() -> String? {
    var restAddress: String? = nil
    
    if let buildingInfo : Building = self.building {
        restAddress = buildingInfo.name
    } else if let detail = self.detatilAddress {
        restAddress = detail
    }
    
    guard let rest: String = restAddress else {
        return nil
    }
    
    var fullAddress: String = self.province
    fullAddress += self.city
    fullAddress += self.street
    fullAddress += restAddress
    
    return fullAddress
}
*/

/*
    기존에 사용했던 if let 바인딩보다는 조금 더 깜끔하고 명료하게 사용할 수 있습니다.
    조금 더 구체적인 조건을 추가하고 싶다면 쉼표(,)로 추가조건을 나열해주면 됩니다. 추가된 조건은 Bool 타입 값이어야 합니다.
    또, 쉽표로 추가된 조건은 AND 논리연산과 같은 결과를 줍니다. 즉, 쉼표를 && 치환해도 같은 결과를 얻을 수 있다는 뜻입니다.
 */

/// 14-13 guard 구문에 구체적인 조건을 추가

func enterClub(name: String?, age: Int?) {
    guard let name: String = name, let age: Int = age, age > 19, name.isEmpty == false else {
        print("You are too young to enter the club")
        return
    }
    
    print("Welcome \(name)!")
}

enterClub(name: "yagom", age: 99)



/*
    guard 구문의 한계는 자신을 감싸는 코드 블록, 즉 return, break, continue, threow 등의 제어문 전환 명령어를 
    쓸 수 없는 상황이라면 사용이 불가능하다는 점입니다. 함수나 메서드, 반복문 등 특정 블록 내부에 위치하지 않는다면
    사용이 제한 됩니다.
 */

// 14-14 guard 구문이 사용될 수 없는 경우

let first: Int = 3
let second: Int = 5

/*
guard first > second else {
    // 여기에 들어올 제어문 전환 명령은 딱히 없습니다. 오류
    // 이 안에 들어와야 하는 것은 return, continue, breake, throw 등인데 현재 이 안에 들어올수 있는 것이 없다. 
}
*/




