//: Playground - noun: a place where people can play

import UIKit

/// Chapter27. ARC

/*
    매번 전달될 때마다 값이 복사되는 값 타입과는 달리 참조 타입은 하나의 인스턴스가 참조를 통해 여러 곳에서 접근하기 떄문에 언제 
    메모리에서 해제되는지가 중요한 문제입니다. 인스턴스가 메모리에서 적절한 시점에 해제되지 않으면 한정적인 메모리 자원을 
    낭비하게 되고 성능의 저하로 이어지게 됩니다. 스위프트는 프로그램의 메모리 사용을 관리하기 위하여 메모리 관리 기법인 ARC
    를 사용합니다.
 */



/*
    ARC 란
    ARC 기능은 이름에 나타나 있듯이 자동으로 메모리를 관리해주는 방식입니다. 아무애도 프로그래머가 메모리 관리에 신경을 덜 편리
    쓸 수 있기에 편리합니다. ARC는 더 이상 필요하지 않은 크래스의 인스턴스를 메모리에서 해제하는 방식으로 동작합니다. 그렇다면 
    자바 등 다른 프로그래밍 언어에서 사용되는 메모리 관리 기법인 가비지 컬렉션기법과 어떤 차이가 있을까요?? 
    ARC 가비지 컬렉션의 가장 큰 차이는 참조를 계산하는 시점입니다. ARC는 인스턴스가 언제 메모리에서 해제되어야 할지를 컴파일과
    동시에 결정합니다. 가비지 컬렉션은 그렇지 않죠. 이 차이로 인해 생기는 장점돠 단점은 명확합니다.
 
    우리가 ARC에 의해 자동으로 메모리 관리를 받기 위해서는 몇가지 규칙을 알아야 합니다. 왜냐하면 가비지 컬렉셕과 달리 ARC는
    컴파일과 동시에 인스턴스를 메모리에서 해제하는 시점이 결정되므로 우리가 원하는 방향으로 메모리관리가 이루어지려면 ARC에 명
    확한 힌트를 주어야 합니다.
 
    클래스의 인스턴스를 생성할 때마다 ARC는 그 인스턴스에 대한 정보를 저장하기 위한 메모리 공간을 따로 또 할당해야합니다.
    그 메모리 공간에는 인스턴스의 타입 정보와 함께 그 인스턴스와 관련된 저장 프로터티의 값 등을 저장합니다. 그 후에 인스턴스
    가 더이상 필요없는 상태가 되면 인스턴스가 차지하고 있던 메모리 공간을 다른 용도로 활용할 수 있도록 ARC가 메모리에서 
    인스턴스를 없앱니다.
 
    그런데 만약 아직 더 사용해야 하는 인스턴스를 메모리에서 해제시킨다면 인스턴스와 관련된 프로퍼티에 접근하거나 인스턴스의 
    메소드를 호출할 수 없습니다. 게다가 인스턴스에 강제로 접근하려고 하면 잘못된 메모리 접근으로 인해 프로그램이 강제 종료될 
    확률이 큽니다.
    
    인스턴스가 지속적으로 필요한 상황에서 ARC는 인스턴스가 메모리에서 해제되지 않도록 인스턴스 참조 여부를 계속 추적합니다.
    다른 인스턴스의 프로퍼티나 변수, 상수 등 어느 한 곳에서 인스턴스를 참조한다면 ARC가 해당 인스턴스를 해제하지 않고 유지해야
    하는 명분이 됩니다. 인스턴스를 메모리에 유지시키려면 이런 명분을 ARC에 제공해야 한다는 것을 명심해야 합니다.
 
    인스턴스가 언제 메모리에서 해제될지 예측할 수 있도록 ARC에 적용되는 몇가지 규칙을 알아봅시다. 그리고 이런 규칙을 
    알지 못할 때 벌어질 수 있는 문제점과 해결방안도 알아봅시다.
 */



/*
    강한참조
    인스턴스가 계속해서 메모리에 남아있어야 하는 명분을 문들어 주는 것이 바로 강한참조입니다. 인스턴스는 참조 횟수가 0이 되는 
    순간 메모리에서 해제되는데, 인스턴스가 다른 인스턴스의 프로퍼티나 변수, 상수 등에 할당할 때 강한함조를 사용하면 참조 횟수가
    1이 증가됩니다. 또, 강한참조를 사용하는 프로퍼티, 변수, 상수 등에 nil을 할당해주면 원래 자신에게 할당되어 있던 인스턴스의
    참조 횟수가 1 감소합니다. 
 
    참조의 기본은 강한 참조이므로 클래스 타입의 프로퍼티, 변수, 상수 등을 선언할 때 별도의 식별자를 명시하지 않으면 강한 참조를
    합니다. 이제까지 우리는 알지 못하고 써왔지만 프로퍼티와 변수, 상수를 모두 강한참조로 선언해주었던 것입니다.
 */



///  27-1 강한참조의 참조 횟수 확인

class Person {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name:"yagom")
// yagom is being iniitalized
// 인스턴스의 참조 횟수 : 1

reference2 = reference1 // 인스턴스의 참조 횟수 2
reference3 = reference1 // 인스턴스의 참조 횟수 3

reference3 = nil    // 인스턴스의 참조 횟수 2
reference2 = nil    // 인스턴스의 참조 횟수 1
reference1 = nil    // 인스턴스의 참조 횟수 0
// yagome is being deinitialized



/// 27-2 강한참조 지역변수(상수)의 참조 횟수 확인

func foo() {
    let yagom: Person = Person(name: "yagom")   // yagom is being initialized
    // 인스턴스의 참조 횟수 : 1
    // 함수 종료 시점 -> yagom의 참조 횟수가 줄어듬.
    // 인스턴스의 참조 횟수 : 0
    // yagom is being deinitialized
}


/// 27-3 강한참조 지역변수(상수)의 참조 횟수 확인과 전역변수

var globalReference: Person?

func foo1() {
    let yagom: Person = Person(name: "yagom")    // yagom is being initialized
    
    globalReference = yagom // 인스턴스의 참조 횟수 : 2
    
    // 함수 종료 시점
    // 인스턴스의 참조횟수 : 1
}



/// 27-4 강한참조 순환 문제

class Person1 {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var room: Room1?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Room {
    let number: String
    
    init(number : String) {
        self.number = number
    }
    
    var host: Person1?
    
    deinit {
        print("Room \(number) is being deinitialized")
    }
}

/*
var yagom: Person1? = Person1(name: "yagom") // Person 인스턴스의 참조 횟수 : 1
var room: Room? = Room(number: "505")   // Room 인스턴스의 참조 횟수 : 1

room?.host = yagom  // Person 인스턴스의 참조 횟수 : 2
yagom?.room = room  // Room 인스턴스의 참조 횟수 : 2

yagom = nil // Person 인스턴스의 참조 횟수 : 1
room = nil  // Room 인스턴스의 참조 횟수 : 2
*/
 
// Person 인스턴스를 참조할 방법 상실 - 메모리에 잔존
// Room 인스턴스를 참조할 방법 상싱 - 메모리 잔존


/*
    yagom = nil , room = nil 이 되는순간 room 과 yagom에 접근할 방법이 사라짐 .
 */

/// 27-5 강한참조 순환 문제를 수동으로 해결

/*
 
 var yagom: Person? = Person(name:"yagom")
 var romm: Room? = Room(number: "505")
 
 room?.host = yagom
 yagom?.room = room
 
 yagom?.room = nil 
 yagom = nil
 
 room?.hot = nil
 room = nil
 
 
 */



/*
    약한 참조는 옵셔널과 변수만 가능합니다.
 */



/// 27-6 강한참조 순환 문제를 약한참조로 해결

class Room1 {
    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    weak var host: Person1?
    
    deinit {
        print("Room \(number) is being deinitialized")
    }
}

var yagom1: Person1? = Person1(name:"yagom")
var room1: Room1? = Room1(number: "505")

room1?.host = yagom1
yagom1?.room = room1

yagom1 = nil

print(room1?.host)

room1 = nil



/// 27-7 미소유참조

class Person2 {
    let name: String
    
    var card: CreditCard?
    // 카드를 소지할 수도, 소지하지 않을 수도 있기 때문에 옵셔널로 정의해야 합니다.
    // 또, 카드를 한 번 가진 후 잃어 버리면 안되기 때문에 강한참조를 해야합니다.
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitailized")
    }
}

class CreditCard {
    let number: UInt
    
    unowned let owner: Person2  // 카드는 소유자가 분명히 존재해야 합니다.
    
    init(number: UInt, owner: Person2) {
        self.number = number
        self.owner = owner
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var jisoo: Person2? = Person2(name: "jisoo")

if let person: Person2 = jisoo {
    // CreditCard 인스턴스의 참조 횟수 : 1
    person.card = CreditCard(number: 1004, owner: person)
    // Person 인스턴스의 참조 횟수 : 1
}

jisoo = nil



/*
    미소유참조와 암시적 추출 옵셔널 프로퍼티
     서로 참조해야 하는 프로퍼티가 값을 꼭 가지고 있어야 하면서도 한번 초기화되면 그 이후에는 nil이 할당될 수 없는 조건
 */


/// 27-8 미소유참조와 암시적 추출 옵셔널 프로퍼티의 활용

class Company {
    let name: String
    
    var ceo: CEO!
    
    init(name: String, ceoName: String) {
        self.name = name
        self.ceo = CEO(name: ceoName, company: self)
    }
    
    func introduce() {
        print("\(name)의 CEO는 \(ceo.name)입니다.")
    }
}

class CEO {
    let name: String
    
    unowned let company: Company
    
    init(name: String, company: Company) {
        self.name = name
        self.company = company
    }
    
    func introduce() {
        print("\(name)는 \(company.name)의 CEO 입니다")
    }
}

let company: Company = Company(name: "무한상사", ceoName: "김태호")
company.introduce()
company.ceo.introduce()

/*
    암시적 추출 옵셔널 프로퍼티는 이니셜라이저의 2단계 초기화조건을 충족시키기 위해 사용되었으며 미소유참조 프로퍼티는 약한참조를
    사용할 수 없는 경우에 강한참조를 피하기 위하여 사용할 수 있습니다.
 */



/*
    클로저의 강한참조 순환
    강한참조 순환문제는 두 인스턴스끼리의 참조일 때에만 발생하는 것 외에도 클로저 때문에 발생할 수도 있습니다. 바로 클로저가
    인스턴스의 프로퍼티일 때 발생할수 있는데, 클로저의 값 획득 특성 때문에 발생합니다. 클로저 내부에서 self.someProperty
    처럼 인스턴스의 프로퍼티에 접근할 때나 클로저 내부에서 self.someMethod() 처럼 인스턴스의 메소드를 호출할 떄 값 획등이
    발생할 수 있스니다. 두 경우 모두 클로저가 self를 획득하게 되므로 강한참조 순환이 발생합니다.
 
    강한참조 순환이 발생하는 이유는 클로저가 클래스와 같은 참조 타입이기 때문입니다. 클로저를 클래스 인스턴스의 프로퍼티로 할당
    하게되면 클로저의 참조가 할당되는 것입니다. 이때 참조타입과 참조타입이 서로 강한 참조를 하기 때문에 강한 참조순환 문제가
    발생합니다.
 
    이러한 클로저의 강한참조 순환 문제는 클로저의 획득 목록을 통해 해결할 수 있습니다. 클로저의 획득 목록을 통해 강한참조
    순환문제를 핼결하는 방법을 알아보기 전에 강한참조 순환이 어떻게 일어나게 되는지 알아보는 것도 중요합니다.
 */



/// 27-9 클로저의 강한참조 순환 문제

class Person3 {
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = {
        
        var introduction: String = "My name is \(self.name)"
        
        guard let hobby = self.hobby else {
            return introduction
        }
        
        introduction += " "
        introduction += "My hobby is \(hobby)"
        
        return introduction
    }
    
    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var yagom3: Person3? = Person3(name: "yagom3", hobby: "eationg")
print(yagom3?.introduce())  // My name is yagom3. My hobby is eation.)
yagom3 = nil



/*
    획득목록
    우리는 앞의 문제를 획득목록을 통해 해결할 수 있습니다. 획득목록은 클로저 내부에서 참조 타입을 획득하는 규칙을 제시해줄 수
    있는 기능입니다. 예를 들어 클로저 내부의 self 참조를 약한참조를 하도록 지정할 수도, 강한 참조를 하도록 지정할 수도 있
    다는 뜻입니다. 예제에서는 self를 약한참조하도록 변경하면 문제를 해결할 수 있습니다. 획득목록을 사용하면 때에 따라서, 혹은
    각 관계에 따라서 참조 방식을 클로저로 제안할 수 있습니다.
 
    획득목록은 클로저 내부의 매개변수 목록 이전의 위치에 작성해줍니다. 획득목록은 참조 방식과 참조할 대상을 대괄호로 둘러싸인
    목록 형식으로 작성하며 획득목록 뒤에는 in 키워드를 써줍니다. 획득목록에 명시된 요소가 참조 타입이 아니라면 해당 요소들은
    클로저가 생성될 때 초기화됩니다.
 */



/// 27-10 획득목록을 통한 값 획득

var a = 0
var b = 0
let closure = { [a] in
    print(a, b)
    b = 20
}

a = 10
b = 10
closure()
print(b)



/*
    변수 a는 클로저의 획득목록을 통해 클로저가 생성될 때 값 0으로 획득되었지만 b는 따로 획득되지 않았습니다. 차후에 a와 b의
    값을 변경한 후 클로저를 실행하면 a는 클로저가 생성되었을 때 획득한 값을 갖지만 b는 변경된 값으로 사용되는 것을 확일할 수
    있습니다. a 변수는클로저가 생성됨과 동시에 획득목록 내에서 다시 a라는 이름의 상수로 초기화된 것입니다. 그렇기 때문에 
    외부에서 a의 값을 변경하더라고 클로저의 획득목록의 a와는 별개가 되는 것입니다. 그러나 b의 경우에는 클로저의 내부와 외부
    상관없이 값이 변하는대로 모두 반영되고 있음을 확인할 수 있습니다.
 */



/// 27-11 참조 타입의 획득목록 동작

class SimpleClass {
    var value: Int = 0
}

var x = SimpleClass()
var y = SimpleClass()

let closure11 = { [x] in
    print(x.value, y.value)
}

x.value = 10
y.value = 10

closure11()  // 10 10

/*
    두 변수 모두 참조 타입의 인스턴스를 가지고 있기 때문입니다. 그렇지만 참조 타입은 획득목록에서 어떤 방식으로 참조할 것인지, 
    즉 획득을 어떤 방식으로 할지를 정해줄 수 있습니다. 강한획득을 할 것인지, 약한획득을 할 것인지, 미소유획득을 할 것인지를
    정해줄 수 있습니다. 또 획득의 종류에 따라 참조 획득의 종류에 따라 참조 횟수를 증가시킬지 경정할 수 있습니다. 다만 명심할
    것은 약한획득을 하게 되면 획득목록에서 획득되는 상수는 옵셔널 상수로 지정된다는 것입니다. 그 이유는 차후에 클로저 내부에서
    약한획득된 상수를 사용하려고 할 때 이미 메모리에서 해제된 사태일 수 있기 때문입니다. 해제된 후에 접근하려 하면 잘못된
    접근으로 오류가 발생되므로 안전을 위해 약한획득을 기본적으로 타입을 옵셔널으로 사용하는 것입니다.
 */



/// 27-12 획득목록의 획득 종류 명시

class SimpleClass1 {
    var value: Int = 0
}

var x1: SimpleClass1? = SimpleClass1()
var y1 = SimpleClass1()

let closure1 = { [weak x1, unowned y1] in
    print(x1?.value, y1.value)
}

x1 = nil
y1.value = 10

closure1()

/*
    unowned로 실행되면 참조카운트는 증가되지 않지만 nil이 된 경우에는 실행오류가 일어난다.
 */



/// 27-13 획득목록을 통한 클로저의 강한참조 순환 문제 해결

class Person4 {
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = { [unowned self] in
        var introduction: String = "My name is \(self.name)."
        
        guard let hobby = self.hobby else {
            return introduction
        }
        
        introduction += " "
        
        introduction += "My hobby is \(hobby)."
        
        return introduction
    }
    
    init(name: String, hobby: String) {
        self.name = name
        self.hobby = hobby
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var yagom4: Person4? = Person4(name: "yagom4", hobby: "eating")

print(yagom4?.introduce())

yagom4 = nil    // yagom4 is being deinitialized



/// 27-14 획득목록의 미소유참조로 인한 차후 접근 문제 발생

var yagom6: Person4? = Person4(name: "yagom6", hobby: "eating")
var hana: Person4? = Person4(name: "hana", hobby: "playing guitar")

// hana의 inroduce 프로퍼티
hana?.introduce = yagom6?.introduce ?? {" " }

// 아직 yagom5이 참조하는 인스턴스가 해제되지 않았기 때문에 
// 클로저 내부에서 self(yagom5 변수가 참조하는 인스턴스) 참조 가능
print(yagom6?.introduce())

yagom6 = nil

// print(hana?.introduce())



/// 27-15 획득목록의 약한참조를 통한 차후 접근 문제 방지

class Person5 {
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = { [weak self] in
        
        // `self`를 사용한 이유는 2장의 예약어와 키워드 팁(60쪽) 및 부록 ( 494쪽)을 참고하세요
        guard let `self` = self else {
            return "원래의 참조 인스턴스가 없어졌습니다."
        }
        
        var introduction: String = "My name is \(self.name)"
        
        guard let hobby = self.hobby else {
            return introduction
        }
        
        introduction += " "
        
        introduction += "My hobby is \(hobby)"
        
        return introduction
    }
    
    init(name: String, hobby: String? = nil ) {
        self.name = name
        self.hobby = hobby
    }
    
    deinit {
        print("\(name) is being deinitialize")
    }
}

var yagom5: Person5? = Person5(name: "yagom5", hobby: "eating")
var hana5: Person5? = Person5(name: "hana5", hobby: "playing guitar")

// hana5의 introduce 프로퍼티에 yagom5의 introduce 프로퍼티 클로저의 참조 할당
hana5?.introduce = yagom5?.introduce ?? { "" }

// 아직 yagom5이 참조하는 인스턴스가 해제되지 않았기 때문에
// 클로저 내부에서 slef(yagom5 변수가 참조하는 인스턴스) 참조 가능

print(yagom5?.introduce())  // 

yagom5 = nil
print(hana5?.introduce())   // 원래의 참조 인스턴스가 없어졌습니다."




