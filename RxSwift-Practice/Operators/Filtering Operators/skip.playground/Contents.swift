import UIKit
import RxSwift

/*
 <skip>
 지정된 수만큼 next 이벤트를 무시하고, 이후에 방출된 이벤트만 구독자에게 전달하는 연산자
 */

let disposeBag = DisposeBag()
let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.from(nums)
    .skip(3)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(4)
 next(5)
 next(6)
 next(7)
 next(8)
 next(9)
 next(10)
 completed
 */
