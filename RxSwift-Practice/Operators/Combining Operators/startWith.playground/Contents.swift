import UIKit
import RxSwift

/*
 <startWith>
 옵저버블 앞에 새로운 요소를 추가
 */

let disposeBag = DisposeBag()

let nums = [1, 2, 3, 4, 5]

Observable.from(nums)
    .startWith(0, 100)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(0)
 next(100)
 next(1)
 next(2)
 next(3)
 next(4)
 next(5)
 completed
 */
