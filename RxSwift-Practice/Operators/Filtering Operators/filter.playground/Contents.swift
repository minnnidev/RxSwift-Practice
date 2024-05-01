import UIKit
import RxSwift

/*
 <filter>
 특정 조건에 맞는 항목을 필터링하는 연산자
 */

let disposeBag = DisposeBag()
let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.from(nums)
    .filter { $0.isMultiple(of: 2) }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(2)
 next(4)
 next(6)
 next(8)
 next(10)
 completed
 */
