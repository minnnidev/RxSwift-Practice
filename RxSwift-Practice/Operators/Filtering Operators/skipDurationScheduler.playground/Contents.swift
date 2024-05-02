import UIKit
import RxSwift

/*
 <skip(duration:scheduler:)>
 지정된 시간 동안 이벤트 방출을 무시하는 skip 연산자
 */

let disposeBag = DisposeBag()
let o = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)

o.take(10)
    .skip(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// 시간상의 오차가 있어 next(3)부터 시작하지 않을 수도 있음
