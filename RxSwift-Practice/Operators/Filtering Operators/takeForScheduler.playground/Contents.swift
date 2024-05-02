import UIKit
import RxSwift

/*
 <take(for:scheduler:)>
 지정한 시간 동안만 이벤트를 방출하는 연산자
 */

let disposeBag = DisposeBag()

// 1초마다 1씩 증가하는 정수 방출
let o = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)

o.take(for: .seconds(5), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(0)
 next(1)
 next(2)
 next(3)
 completed
 -> skip(duration:scheduler:)처럼 시간상의 오차 주의!
 */
