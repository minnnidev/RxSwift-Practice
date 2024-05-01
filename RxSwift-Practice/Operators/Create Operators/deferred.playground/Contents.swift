import UIKit
import RxSwift

/*
 <deferred>
 특정 조건에 따라 옵저버블을 생성
 */

let disposeBag = DisposeBag()

let nums = ["1", "2", "3", "4", "5"]
let words = ["one", "two", "three", "four", "five"]
var flag = false

let factory = Observable<String>.deferred {
    flag.toggle()

    return flag ? Observable.from(nums) : Observable.from(words)
}

// flag: true
factory
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(1)
 next(2)
 next(3)
 next(4)
 next(5)
 completed
 */

// flag: false
factory
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(one)
 next(two)
 next(three)
 next(four)
 next(five)
 completed
 */
