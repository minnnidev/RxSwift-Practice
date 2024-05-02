import UIKit
import RxSwift

/*
 <take>
 처음 n개의 이벤트만 방출하는 연산자
 */

let disposeBag = DisposeBag()
let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.from(nums)
    .take(5)
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
