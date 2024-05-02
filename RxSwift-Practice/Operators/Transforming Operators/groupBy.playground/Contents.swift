import UIKit
import RxSwift

/*
 <groupBy>
 옵저버블이 방출하는 요소를 원하는 조건에 따라 grouping
 */

let disposeBag = DisposeBag()
let words = ["Apple", "Banana", "Orange", "Book", "City", "Axe"]

Observable.from(words)
    .groupBy { $0.count }
    .subscribe(onNext: { groupedObservable in
        print("\(groupedObservable.key)")
        groupedObservable.subscribe { print("\($0)") }
    })
    .disposed(by: disposeBag)

/*
 5
 next(Apple)
 6
 next(Banana)
 next(Orange)
 4
 next(Book)
 next(City)
 3
 next(Axe)
 completed
 completed
 completed
 completed
 */

Observable.from([1, 2, 3, 4, 5])
    .groupBy { $0.isMultiple(of: 2) }
    .flatMap { $0.toArray() }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next([1, 3, 5])
 next([2, 4])
 completed
 */
