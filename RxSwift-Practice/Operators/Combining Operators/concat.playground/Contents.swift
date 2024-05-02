import UIKit
import RxSwift

/*
 <concat>
 2개의 옵저버블을 연결
 하나의 옵저버블 뒤에 다른 옵저버블을 연결
 */

let disposeBag = DisposeBag()

let words1 = Observable.from(["first", "second", "third"])
let words2 = Observable.from(["one", "two", "three"])

Observable.concat([words1, words2])
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(first)
 next(second)
 next(third)
 next(one)
 next(two)
 next(three)
 completed
 */

words1.concat(words2)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(first)
 next(second)
 next(third)
 next(one)
 next(two)
 next(three)
 completed
 */
