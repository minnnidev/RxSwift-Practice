import UIKit
import RxSwift

/*
 <distinctUntilChanged>
 동일한 요소가 연속적으로 방출되는 것을 막아주는 연산자
 */

let disposeBag = DisposeBag()

let numbers = [1, 1, 3, 2, 2, 3, 1, 5, 5, 7, 7, 7]

// distinctUntilChanged() : 이전 이벤트와 동일하다면 방출하지 않음
Observable.from(numbers)
    .distinctUntilChanged()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(1)
 next(3)
 next(2)
 next(3)
 next(1)
 next(5)
 next(7)
 completed
 */

// distinctUntilChanged(_ comparer:): comparer을 사용해서 이벤트를 비교
Observable.from(numbers)
    .distinctUntilChanged { !$0.isMultiple(of: 2) && !$1.isMultiple(of: 2) } // 둘다 홀수일 때만 true return -> 홀수가 연속되는 것을 막는다
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(1)
 next(2)
 next(2)
 next(3)
 completed
 */

let tuples = [(1, "하나"), (1, "일"), (1, "one")]

Observable.from(tuples)
    .distinctUntilChanged { $0.0 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next((1, "하나"))
 completed
 */

Observable.from(tuples)
    .distinctUntilChanged { $0.1 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next((1, "하나"))
 next((1, "일"))
 next((1, "one"))
 completed
 */

struct Person {
    let name: String
    let age: Int
}

let persons = [
    Person(name: "Kim", age: 22),
    Person(name: "Lee", age: 22),
    Person(name: "Moon", age: 22),
    Person(name: "Park", age: 18),
]

Observable.from(persons)
    .distinctUntilChanged(at: \.age) // 나이가 같으면 전달되지 않겠지?
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(Person(name: "Kim", age: 22))
 next(Person(name: "Park", age: 18))
 completed
 */

Observable.from(persons)
    .distinctUntilChanged(at: \.name)
    .subscribe { print($0) }
    .disposed(by: disposeBag)


/*
 next(Person(name: "Kim", age: 22))
 next(Person(name: "Lee", age: 22))
 next(Person(name: "Moon", age: 22))
 next(Person(name: "Park", age: 18))
 completed
 */
