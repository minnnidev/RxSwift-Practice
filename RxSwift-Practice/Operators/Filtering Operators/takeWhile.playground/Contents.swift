import UIKit
import RxSwift

/*
 <take(while:)>
 조건을 충족하는 동안만 이벤트를 방출
 조건을 충족하지 못할 시에는 completed 이벤트 전달
 */

let disposeBag = DisposeBag()
let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.from(nums)
    .take(while: { !$0.isMultiple(of: 2)})
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(1)
 completed
 */


Observable.from(nums)
    .take(while: { !$0.isMultiple(of: 2)}, behavior: .inclusive)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 inclusive: 마지막에 확인한 값도 방출됨 (조건이 false인 값도)
 next(1)
 next(2)
 completed
 */
