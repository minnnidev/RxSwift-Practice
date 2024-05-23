import UIKit
import RxSwift

/*
1. multicast 연산자
    - 구독자가 아닌 파라미터 subject에게 이벤트 전달 -> subject가 전달 받은 이벤트를 구독자에게 전달
    - multicast 연산자를 사용하면 ConnectableObservable이 된다.
    - connectableObservable은 subscribe되어도 시퀀스 시작 x
    - connect 메소드를 호출해야 시작된다
 */

//let disposeBag = DisposeBag()
//
//let source = Observable<Int>
//    .interval(.seconds(1), scheduler: MainScheduler.instance)
//    .take(5)
//
//source
//    .subscribe { print("💙", $0) }
//    .disposed(by: disposeBag)
//
//source
//    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe { print("💚", $0) }
//    .disposed(by: disposeBag)

/*
 💙 next(0)
 💙 next(1)
 💙 next(2)
 💙 next(3)
 💚 next(0)
 💙 next(4)
 💙 completed
 💚 next(1)
 💚 next(2)
 💚 next(3)
 💚 next(4)
 💚 completed
 */

let disposeBag = DisposeBag()
let sb = PublishSubject<Int>()

let source = Observable<Int>
    .interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .multicast(sb)

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
