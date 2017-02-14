//: Playground - noun: a place where people can play

import UIKit

/// Chapter28. 오류 처리

/*
    대부분의 프로그래밍 언어는 프로그램에서 발생하는 오류에 대비하기 위해 오류를 처리하는 기능을 제공합니다.
    스위프르도 오류를 적절히 처리할 수 있는 기능을 제공합니다. 스위프트가 제공하는 오류처리 기능에 대해 알아봅시다.
 */



/*
    오류처리란
 
    오류처리는 프로그램이 오류를 일으켰을 때 이것을 감지하고 회복시키는 일련의 과정입니다.
    프로그램에서 모든 기능이 우리가 원하는대로 100% 정확히 동작한다는 보장은 없습니다. 특히나 전달 받아야 하는 값이 까다롭거나
    데이터를 가공하는 데 소비하는 자원이 많을 경우 오류가 발생할 확률이 증가합니다 이런 가능성을 가진 기능을 구현할 때는 오류가
    발생할 수 있음을 항상 고려해야 합니다.
 
    예를 들어 디스크의 파일을 읽어오는 기능을 생각해 볼까요? 파일이 존재하지 않을수도 있으며, 읽기 권한이 없을수도 있고, 
    잘못된 파일일 가능성도 있습니다. 이렇게 파일을 읽어오는 간단한 기능에서도 오류가 발생할 수 있는 가능성이 여럿 존재합니다.
    오류처리 기능을 통해 이런 상황들을 구별하여 프로그램 자체적으로 오류를 해결할 수도 있고, 사용자와 상호작용을 통해 오류를 
    어떤 방향으로 풀어나갈지 제어할 수도 있습니다.
    다만 주의할 점은 스위프트의 오류처리 기능을 통해 시스템 ( 예를 들어 운영체제 등 우리가 작성하는 응용프로그램 외부 ) 에서 
    발생한 오류를 처리할 수 있는 것은 아님을 명심해야 합니다.
 */



/*
    오류의 표현 
    스위프트에서 오류는 Error라는 프로토콜을 준수하는 타입의 값을 통해 표현됩니다. Error 프로토콜은 사실상 요구사항이 없는
    빈 프로토콜일 뿐이지만, 오류를 표현하기 위한 타입(주로 열거형) 은 이 프로토콜을 채택합니다. 
    스위프트의 열거형은 오류의 종류르르 나타내기에 아주 적합한 기능입니다. 연관 값을 통해 오류에 관한 부가 정보를 제공할 수도
    있습니다. 프로그램 내에서 자판기를 작동시키려고 할 때 발생하는 오류의 종류를 열거형으로 표현해볼 수도 있습니다.
 */



/// 28-1 자판기 동작 오류의 종류를 표현한 VendingMachineError 열거형

enum VendingMachineError: Error {
    case invilidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}



/*
    VendingMachineError 열거형을 살펴보면 Error 프로토콜을 채택함으로써 오류처리를 위한 타입임을 알 수 있습니다.
    그리고 이 코드에서 오류의 종류는 invalidSelection( 유효하지 않은 선택 ), insufficientFunds ( coinNeeded: 
    Int ) ( 자금 부족 - 필요한 동전 개수 ), outOfStock ( 품절 ) 등 세 가지가 있습니다. 이처럼 열거형을 통해 오류의
    종류를 표현하는 것이 가장 일반적이며 편리한 방법입니다.
 
    이렇게 오류의 종류를 미리 예상한 후, 오류로 인해 다음 동작이 정상적으로 진행되지 않을 때 오류를 던져주면 됩니다. 오류를 
    던져줄 때는 throw 구문을 사용합니다. 만약 자금이 부족하고 동전이 5개 더 필요한 상황이라면 
    throw VendingMachineError.insufficientFunds(coinsNeeded: 5) 라고 오류를 던져줄 수 있습니다.
    이제 던져진 오류를 포착하고 처리하는 방법을 알아보겠습니다.
 */



/*
    오류 포착 및 처리
 
    오류를 던질 수도 있지만 오류가 던져지는 것에 대비하여 던져진 오류를 처리하기 위한 코드도 작성해야 합니다. 예를 들어 던져진
    오류가 무엇인지 판단하여 다시 문제를 해결한다든지, 다른 방법으로 시도해 본다든지, 사용자에게 오류를 알리고 사용자에게 선택
    권한을 넘겨주어 다음에 어떤 동작을 하게 할 것인지 결정하도록 유도하는 등의 코드를 작성해야 합니다.
 
    스위프트에는 오류를 처리하기 위한 네 가지 방법 있습니다.
    
    1. 함수에서 발생한 오류를 그 함수를 호출한 코드에 알리는 방법
    2. do-catch 구문을 이용하여 오률ㄹ 처리하는 방법
    3. 옵셔널 값으로 오류를 처리하는 방법
    4. 오류가 발생하지 않을 것이라고 확신하는 방법
 */



/*
    함수에서 발생한 오류를 그 함수를 호출한 코드에 알리는 방법
 
    먼저 함수에서 발생한 오류를 그 함수를 호출한 코드에 알리는 방법입니다. 함수가 오류를 던지면 프로그램의 흐름이 바뀔 가능성이
    매우 큽니다. 그러므로 어디서 오류를 던지고 받을 것인가 경정하는 것은 매우 중요합니다. try 키워드로 던져진 오류를 받을 수 
    있습니다. try키워드는 try 또는 try?, try! 등으로 표현될 수 있습니다.
    함수, 메서드, 이니셜라이저의 매개변수 뒤에 throws 키워드를 사용하면 해당 함수, 메서드, 이니셜라이저는 오류를 던질 수
    있습니다. 일반적으로 func cannotThrowErrors() -> String 처럼 표현하던 것에 func canThrowError() 
    throws -> String처럼 throws 키워드를 명시해주면 오류를 던질 수 있습니다. 이런 함수는 호출되었을 때, 동작 오류가
    발생하면 자신을 호출한 코드에 오류를 던져서 오류를 알릴수 있습니다. 
 
    throws는 함수, 메서드의 자체 타입에도 영햡을 미칩니다. 즉, throws함수, 메서드는 같은 이름의 throws가 명시되지 않는
    함수, 메서드와 구분됩니다. 또 throws를 포함한 함수, 메서드, 이니셜라이저는 일반 함수, 메서드, 이니셜라이저롤 재정의될 수 
    없습니다. 반대로 일반 함수, 메서드, 이니셜라이저는 throws 함수, 메서드, 이니셜라이저로 재정의될 수 있습니다.
 */



/// 28-2 자판기 동작 도중 발생한 오류 던지기

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar":Item(price: 12, count : 7),
        "Chips":Item(price: 10, count: 4),
        "Biscuit":Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispense(snack: String) {
        print("\(snack) 제공")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = self.inventory[name] else {
            print("This name product not have")
            throw VendingMachineError.invilidSelection
        }
        
        guard item.count > 0 else {
            print("Product count is not enough")
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= self.coinsDeposited else {
            print("Coins is not enough")
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - self.coinsDeposited)
        }
        
        self.coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        self.inventory[name] = newItem
        
        self.dispense(snack: name)
    }
}

let favoriteSnacks = [
    "yagom":"Chips",
    "jinsung":"Biscuit",
    "heejin":"Chocolate"
]

/*
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchaseSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}


let machine: VendingMachine = VendingMachine()
machine.coinsDeposited = 100

var purchase: PurchaseSnack = try PurchaseSnack(name: "Biscuit", vendingMachine: machine)

print(purchase.name)    // Biscuit

for (person, favoriteSnacks) in favoriteSnacks {
    print(person, favoriteSnacks)
    try buyFavoriteSnack(person: person, vendingMachine: machine)
}
*/



/*
    자판기 VendingMachine 클래스는 오류를 던질 수 있는 vending(itemNamed:) 메서드를 가지고 있습니다. 
    vend(itemNamed:) 메서드 내부에서는 오류가 발생했을 때 흐름을 제어하기 위해 guard를 통한 빠른 종료 구문은 사용하고 
    있습니다. 특정 조건이 충족되지 않는다면 throws 키워드를 통해 오류를 던져서 오류가 발생하였다는 것을 자신을 호출한 코드에게
    알립니다. vend(itemNamed:) 메서드가 오류를 던질 가능성이 잇으므로, vend(itemNamed:) 메서드를 호출하는 함수 또한 
    오류를 던질 수 있어야 합니다. 그래서 buyFavoriteSnack(person:vendingMachine:) 함수도 throws 키웓를 통해
    오류를 던질 수 있는 함수로 구현해주어야 합니다.
    오류르 던질 수 있는 함수, 메서드, 이니셜라이저를 호출하는 코드는 반드시 오류를 처리할 수 있는 구문을 작성해주어야 합니다.
    그러나 오류가 발생할 수 있는 메서드와 함수를 호출하면서도 try로 시도만 할 뿐 오류가 발생했을 때 처리할 수 있는 코드는
    작성되어 있지 않습니다.  for-in 구문 내에서 buyFavoriteSnack(person:vendingMachine:) 함수 호출 중 오류가
    발생한 후 적절한 처리를 해주지 않았기 때문에 다음 코드가 정상적으로 동작하지 않을 것입니다. 이렇게 발생된 오류는 자신을 
    호출한 코드로 던져서 알릴수는 있지만, 오류를 받은 코드가 적절히 오류를 처리해주지 않는다면 이루의 코드는 작동하지 
    않습니다. 던져진 오류를 처리하는 방법에 대해 알아보겠습니다.
 
    문법에 대한 자세한 설명이 없어서 직접 작성!!!
 
    throws 에 대한 return 형은 try 이다. 반환 타입에 throws 라고 되어 있으면 return 대신에 try로 해주면 
    되는것 같다.
    ?? 연산자는 기본적으로는 ?? 왼쪽에 있는 값이 들어가지만 값이 nil일 경우 오른쪽에 있는 값이 들어가게 하는 것이다.
 */



/*
    do-catch 구문을 이용한 오류처리
 
    다음은 do-catch 구문을 이용하여 오류를 처리하는 방법입니다. 함수, 메서드, 이니셜라이저등에서 오류를 던저주면 오류 발생을
    전달받은 코드 블록은 do-catch 구문을 사용하여 오류를 처리해주어야 합니다. do 절 내부의 코드에서 오류를 던지게 되면 
    catch 절에서 오류를 전달받아 적절히 처리해주면 됩니다. do-catch 구문은 보통 다음처럼 표현합니다.
 
    do {
        try 오류 발생 가능 코드
        오류가 발생하지 않으면 실핼할 코드
    } catch 오류 패턴 1 {
        처리 코드
    } catch 오류 패턴 2 where 추가 조건 {
        처리 코드
    }
 
    catch 절에서는 catch 키워드 뒤에 처리할 오류의 종류를 써줍니다. 만약 catch 뒤에 오류의 종류를 명시하지 않고 코드블록
    을 생성하면 블록 내부에 암시적으로 error라는 이름의 지역 상수가 오류의 내용으로 들어옵니다.
 */



/// 28-3 do-catch 구문을 사용하여 던져진 오류를 처리

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    tryingVend(itemNamed: snackName, vendingMachine: vendingMachine)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) {
        tryingVend(itemNamed: name, vendingMachine: vendingMachine)
        self.name = name;
    }
}

func tryingVend(itemNamed: String, vendingMachine: VendingMachine) {
    do {
        try vendingMachine.vend(itemNamed: itemNamed)
    } catch VendingMachineError.invilidSelection {
        print("유효하지 않은 선택")
    } catch VendingMachineError.outOfStock {
        print("품절")
    } catch VendingMachineError.insufficientFunds(let coinsNeed) {
        print("자금 부족 - 동전 \(coinsNeed)개를 추가로 지급해 주세요.")
    } catch {
        print("그 외 오류 발생 : ", error)
    }
}

let machine: VendingMachine = VendingMachine()
machine.coinsDeposited = 20

var purchase: PurchasedSnack = PurchasedSnack(name: "Biscuit", vendingMachine: machine)
// Biscuit 제공

print(purchase.name)    // Biscuit

purchase = PurchasedSnack(name: "Ice Cream", vendingMachine: machine)
// 유효하지 않은 선택

print(purchase.name)

for (person, favoriteSnacks) in favoriteSnacks {
    print(person,favoriteSnacks)
    buyFavoriteSnack(person: person, vendingMachine: machine)
}

/*
    [코드 28-3]에서 던져진 오류를 do-catch 구문을 사용하여 처리하는 함수를 별도로 만들어 주었습니다. 그에 따라 오류룰
    받아서 다시 던지던 함수들이 더이상 다른 곳으로 오류를 던지지 않아도 되는 형태가 되었습니다. 더불어 오류를 적절히 처리해주자
    코드가 중간에 중단되지 않고 끝까지 정상 동작하는 것을 볼 수 있습니다.
 */



/*
    옵셔널 값으로 오류처리
    try?를 사용하여 옵셔널 값으로 변환하여 오류를 처리할 수도 있습니다. try? 표현을 통해 동작하던 코드가 오류를 던지면
    그 코드의 반환 값은 nil 이 됩니다.
 */



/// 28-4 옵셔널 값으로 오류를 처리

/*
func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    
    if shouldThrowError {
        enum SomeError: Error {
            case justSomeError
        }
        
        throw SomeError.justSomeError
    }
    return 100
}

let x: Optional = try? someThrowingFunction(shouldThrowError: true)
print(x)

let y: Optional = try? someThrowingFunction(shouldThrowError: false)
print(y)
 */

/*
    [코드 28-4]를 보면 try? 표현을 사용하여 호출한 함수가 오류를 던지면 반환 값이 nil로 반환되고, 오류가 발생하지 않으면
    옵셔널 값으로 반환되는 것을 확인할 수 있습니다. 이렇게 do-catch 구문을 사용하지 않더라고 옵셔널을 사용하여 오류를 처리할
    수도 있습니다. 여기서 주목할 점은 someThrowingFunction(shouldThrowError:)의 반환 타입이 Int라도 try?
    표현을 사용하게 되면 반환 타입이 옵셔널이 된다는 점입니다.
 
    우리가 기존에 반환 타입으로 옵셔널을 활용하던 방법과 결합하여 사용할 수도 있습니다.
 */



/// 28-5 옵셔널 값으로 오류를 처리하는 방법과 기존 옵셔널 반환 타입과의 결합

/*
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() {
        return data
    }
    if let data = try? fetchDataFromServer() {
        return data
    }
    
    return nil
}
 
    fetchData() 함수는 반환 타입이 옵셔널로 정의되어 있습니다. 즉, 함수 내부에서 제대로 처리가 이루어지지 않으면 반환값이
    nil이 될수 있음을 내포하고 있는것이죠. 데이터를 디스크에서 가져오기 못하면 서버에서 가져오는 것을 시도해보고 그조차 없으면
    nil을 반환해주도록 응용해볼 수 있습니다.
 */



/*
    오류가 발생하지 않을 것이라고 확신하는 방법
    오류를 처리하는 마지막 방법으로는 오류가 발생하지 않을 것이라는 확신을 가지고 처리하는 방법입니다. 코드를 작성하는
    프로그래머가 오류를 던질 수 있는 함수등을 호출할 때 오류가 절대로 발생하지 않을 것이라고 확신할 수 있는 상황이라면 오류가
    발생하지 않을 것이라는 전제 하에 try! 표현을 사용할 수 있습니다. 이 표현은 다른 느낌표 표현과 마찬가지로 실제 오류가
    발생하면 런타임 오류가 발생하여 프로그램이 강제 종료 됩니다.
 */



/// 28-6 오류가 발생하지 않음을 확신하여 오류처리

func someThrowingFunction(shouldThrowError: Bool)  throws -> Int {
    
    if shouldThrowError {
        enum SomeError: Error {
            case justSomeError
        }
        
        throw SomeError.justSomeError
    }
    
    return 100
}

let y: Int = try! someThrowingFunction(shouldThrowError: false)
print(y)

/*
let x: Int = try! someThrowingFunction(shouldThrowError: true)
print(x)
 */



/*
    다시 던지기
     함수나 메서드는 rethrows 키워드를 사용하여 자신의 매개변수로 전달받은 함수가 오류를 던진다는 것을 나타낼 수 있습니다.
    rethrows 키워드를 사용하여 다시던지기가 가능하게 하려면 최소 하나 이상의 오류 발생 가능한 함수를 매개변수로 전달받아야 
    합니다.
 */



/// 28-7 오류의 다시던지기

// 오류를 던지는 함수

/*
func someThrowingFunction() throws -> Void {
    
    enum SomeError: Error {
        case justSomeError
    }
    
    throw SomeError.justSomeError
}

func someFuction(callback: () throws -> Void) rethrows {
    try callback()  // 다시던지기 함수는 오류를 다시 던질 뿐 따로 처리하지는 않습니다.
}

do {
    try someFuction(callback: someThrowingFunction)
} catch {
    print(error)
}
 */
// justSomeError

/*
    다시던지기 함수 또는 메서드는 기본적으로 스스로 오류를 던지지 못합니다. 즉, 자신 내부에 직접적을 throw 구문은 사용할수 없
    습니다. 그러나 catch 절 내부에서는 throws 구문을 작성할 수 있습니다. 다시던지기 함수나 메서드가 오류를 던지는 함수를 
    do-catch 구문 내부에서 호출하고 catch 절 내부에서 다른 오류를 던짐으로써 오류를 던지는 함수에서 발생한 오류를 제어할 수 
    있습니다. 다시 던지기 내부의 catch절에서는 다시 던지기 함수의 매개변수로 전달받은 오류던지기 함수만 호출하고 결과로 던져진
    오류만 제어할 수 있습니다.
 */



/// 28-8 다시던지기 함수의 오류 던지기

// 오류르 던지는 함수
func someThrowingFunction() throws {
    
    enum SomeError: Error {
        case justSomeError
    }
    
    throw SomeError.justSomeError
}

// 다시던지기 함수

func someFunction(callback : () throws -> Void) rethrows {
    
    enum AnotherError: Error {
        case justAnotherError
    }
    
    do {
        // 매개변수로 전달된 오류 던지기 함수이므로
        // catch에서 제어할 수 있습니다.
        try callback()
    } catch {
        throw AnotherError.justAnotherError
    }
    
    /*
    do {
        // 매개변수로 전달된 오류 던지기 함수가 아니므로
        // catch에서 저어할 수 없습니다.
        try someThrowingFunction()
    } catch {
        // 오류 발생
        throw AnotherError.justAnotherError
    }
    
    // catch절 외부에서 단독으로 오류를 던질 수는 없습니다.
    throw AnotherError.justAnotherError
    */
}

/*
    부모클래스의 다시던지기 메서드(rethrows 메서드)는 자식클래스에서 던지기 메서드(throws 메서드)로 재정의할 수 없스빈다.
    그러나 부모클래스의 던지기 메서드는 자식클래스에서 다시던지기 메서드로 재정의할 수 있습니다.
    그리고 만약 프로토콜 요구사항 중에 다시던지기 메서드가 있다면, 던지기 메서드를 구현한다고 해서 그 요구사항 중에 다시던지기
    메서드가 있다면 다시던지기 메서드를 구현해서 그 요구사항을 충족시킬 수 있습니다.
 */



/// 28-9 프로토콜과 상속에서 던지기 함수와 다시던지기 함수

protocol SomeProtocol {
    func someThrowingFunctionFromProtocol(callback:() throws -> Void) throws
    func someRethrowingFunctionFromProtocol(callback:() throws -> Void) rethrows
}

/*
class SomeClass : SomeProtocol {
    func someThrowingFuction(callback: () throws -> Void) throws { }
    func someFunction(callback: () throws -> Void) rethrows { }
    
    
    // 던지기 메서든느 다시 던지기 메서드를 요구하는 프로토콜을 충족할 수 없습니다.
    // 오류
    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) throws { }
    
    
    // 다시던지기 메서드는 던지기 메서드를 요구하는 프로토콜의 요구사항에 부합합니다.
    func someThrowingFunctionFromProtocol(callback: () throws -> Void) rethrows { }
}

class SomeChildClass : SomeClass {
    // 부모 클래스의 던지기 메서드는 자식클래스에서 다시던지기 메서드로 재정의할 수 있습니다.
    override func someThrowingFuction(callback: () throws -> Void) rethrows {  }
    
    // 부모 클래스의 다시던지기 메서드는 자식클래스에서 던지기 메서드로 재정의할 수 없습니다.
    // override func someFunction(callback: () throws -> Void) throws { }
    
}
*/

/*
    SomeProtocol에서 요구한 던지기 함수 someThrowingFunctionFromProtocol(callback():) 과 다시던지기 함수
    someRethrowingFunctionFromProtocol(callback:)을 각각 다시던지기 함수와 던지기 함수로 구현해보았습니다.
    던지기 메서드는 다시던지기 메서드 요구에 부합하지만 다시 던지기 메서드는 던지기 메서드 요구에 부합하지 못합을 확인할 수 
    있습니다. 또 부모클래스의 던지기 메서드는 자식클래스에서 다시던지기 메서드로 재정의할 수 있는 반면, 부모클래스의 다시던지기
    메서드는 던지기 메서드로 재정의할 수 없음을 확인할 수 있습니다.
 */



/*
    후처리 defer
 
    defer 구문을 사용하여 현재 코드 블록을 나가기 전에 꼭 실행되야 하는 코드를 작성해줄 수 있습니다. 즉, defer 구문은 
    코드가 블록을 어떤 식으로 빠져나가든 간에 꼭 실행되어야 하는 마무리 작업을 할 수 있도록 도와줍니다. 그 말인즉슨, 오류가 
    발생하여 코드 블록을 빠져나가는 것이든, 정상적으로 코드가 블록을 빠져나가는 것이든 간에 defer 구문은 코드가 블록을 
    빠져나가기 전에 무조건 실행되는 것을 보장한다는 뜻입니다. 예를 들어 함수 내에서 파일을 열어 사용하다 오류가 발생하여
    코드가 블록을 빠져나가더라도 파일을 정상적으로 닫아 메모리에서 해제해야 하기 때문에 defer 구문 내부에 파일을 닫는 코드를
    작성해주어 정상적으로 파일이 메모리에서 해제될 수 있도록 해야합니다.
 
    defer와 오류처리
    defer 구문은 꼭 오류처리 상황에서만 사용해야 하는 것은 아니지만, 오류처리를 할 때 유용하게 쓰이기에 오류처리 파트에서 
    소개합니다. defer 구문은 오류처리 상황뿐만 아니라 함수, 메서드, 반복문, 조건문 등등 보통의 코드 들록 어디서든 사용할수 
    있습니다.
 */

/// 예시

for i in 0...2 {
    defer {
        print("A", terminator:" ")
    }
    print(i, terminator:" ")
    
    if i % 2 == 0 {
        defer {
            print("", terminator: "\n")
        }
        
        print("It's even", terminator: " ")
    }
}

/// 28-10 파일쓰기 에제에서 defer 구문 활용

/*
func writeData() {
    let file = openfile()
    
    // 함수 코드 블록을 빠져나가기 직전 무조건 실행되어 파일을 잊지 않고 닫아줍니다.
    defer {
        closeFile(file)
    }
    
    if ... {
        return
    }
    
    if ... {
        return
    }
    
    // 처리 끝
}
 */

/*
    만약 defer 구문이 없었다면 중복된 코드가 많아질 것이고 차후 유지관리도 어려울뿐더러 코드가 길어지다보면 프로그래머가 
    파일닫기 코드를 닫지 않는 실수를 할 가능성도 높아집니다.
 */



/// 28-11 파일쓰기 예제에서 defer 구문이 없다면 

/*
    
 func writeData() {
    let file = openFile()
 
    if ... {
        closeFile(file)
        return 
    }
 
    if ... {
        closeFile(file)
        return
    }
 
    closeFile(file)
 }

    defer 구문은 현재 코드 범위를 벗어나기 전까지 실행을 미루고 (defer) 있다가 프로그램 실행 흐름이 코드 범위를 벗어나기
    직전 실행됩니다. defer 구문 내부에서 break, return 등과 같이 구분을 빠져나갈수 있는 코드 또는 오류를 던지는 코드는 
    작성하면 안됩니다. 여러개의 defer 구문이 하나의 범위(블록) 내부에 속해 있다면 맨 마지막에 작성된 구문부터 역순으로 실행
    됩니다.
 */



/// 28-12 defer 구문의 실행 순서 

func someThrowingFuction(shouldThrowError: Bool) throws -> Int {
    
    defer {
        print("First")
    }
    
    if shouldThrowError {
        enum SomeError : Error {
            case justSomeError
        }
        
        throw SomeError.justSomeError
    }
    
    defer {
        print("Second")
    }
    
    defer {
        print("Third")
    }
    
    return 100
}

try? someThrowingFuction(shouldThrowError: true)
// First 
// 오류를 던지기 직전까지 작성된 defer 구문 까지만 실행 됩니다.

try? someThrowingFunction(shouldThrowError: false)
// Thrid
// Second
// First



/*
    do 구문을 catch와 함께 사용하지 않고 단독으로 사용할 수도 있습니다. 코드 불록 내부에 또 한 단계 하위의 블록을 
    만들고자 할 때 do 구문을 사용할 수 있습니다.
 */

/// 28-13 복합적인 defer 구문의 실행 순서

func someFunction() {
    print("1")
    
    defer {
        print("2")
    }
    
    do {
        defer {
            print("3")
        }
        print("4")
    }
    
    defer {
        print("5")
    }
    
    print("6")
}

someFunction()

