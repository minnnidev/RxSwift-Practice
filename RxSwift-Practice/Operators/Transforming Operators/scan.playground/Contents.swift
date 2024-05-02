import UIKit
import RxSwift

/*
 <scan>
 기본값으로 연산 시작
 원본 옵저버블이 방출하는 항목을 대상으로 accumulator closure을 실행하여 옵저버블로 방출
 */

let disposeBag = DisposeBag()

Observable.range(start: 1, count: 10)
    .scan(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(1)
 next(3)
 next(6)
 next(10)
 next(15)
 next(21)
 next(28)
 next(36)
 next(45)
 next(55)
 completed
 */
