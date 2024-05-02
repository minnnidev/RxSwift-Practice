import UIKit
import RxSwift

/*
 <single>
 옵저버블에서 첫 번째 요소만 방출을 보장
 단 하나의 요소만 방출될 수 있어야 정상적으로 종료됨
 */

let disposeBag = DisposeBag()
let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.just(1)
    .single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(1)
 completed
 */

Observable.from(nums)
    .single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(1)
 error(Sequence contains more than one element.)
 */

Observable.from(nums)
    .single { $0 == 3 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 배열에는 3만
 next(3)
 completed
 */
