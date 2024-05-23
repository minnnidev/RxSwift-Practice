import UIKit
import RxSwift

/*
 publish
 연산자 내부에서 알아서 subject를 생성하여 multicast 연산자 사용
 */

let disposeBag = DisposeBag()

let source = Observable<Int>
    .interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .publish()

source
    .subscribe { print("💙", $0) }
    .disposed(by: disposeBag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("💚", $0) }
    .disposed(by: disposeBag)

source.connect() // connect() 를 하지 않으면 아무 일이 일어나지 않음!!

/*
 💙 next(0)
 💙 next(1)
 💙 next(2)
 💚 next(2)
 💙 next(3)
 💚 next(3)
 💙 next(4)
 💚 next(4)
 💙 completed
 💚 completed
 */
