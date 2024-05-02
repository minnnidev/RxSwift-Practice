import UIKit
import RxSwift

/*
 <reduce>
 seed 값과 옵저버블이 방출하는 요소를 대상으로 클로저를 실행하고
 최종 결과를 옵저버블로 방출
 cf. scan: scan은 중간 결과 + 최종 결과 / reduce는 최종 결과
 */

let disposeBag = DisposeBag()

Observable.range(start: 1, count: 5)
    .reduce(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// next(15)
// completed
