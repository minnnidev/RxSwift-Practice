import UIKit
import RxSwift

enum CustomError: Error {
    case error
}

let disposeBag = DisposeBag()

/*
 1. behaviorSubject를 생성할 때는 기본값을 전달
 2. 가장 최신 next 이벤트를 저장하고 세로운 구독자에 전달
 */

let p = PublishSubject<Int>()
p.subscribe {
    print("PublishSubject >>", $0)
}
.disposed(by: disposeBag)

let b = BehaviorSubject<Int>(value: 0)
b.subscribe {
    print("BehaviorSubject >>", $0)
}
.disposed(by: disposeBag)
/*
 BehaviorSubject를 생성하고 구독되는 시점 사이에 next 이벤트가 전달된다.
 BehaviorSubject >> next(0)
 가 출력됨
 -> BehaviorSubject를 생성하면 내부에 next 이벤트가 하나 만들어지고, 생성자로 전달된 값이 저장됨
 */

b.onNext(1)
/*
 BehaviorSubject >> next(0)
 BehaviorSubject >> next(1)
 */

b.subscribe {
    print("BehaviorSubject2 >>", $0)
}
.disposed(by: disposeBag)
// BehaviorSubject2 >> next(1)

//b.onCompleted()
b.onError(CustomError.error)
/*
 completed 전달 시
 BehaviorSubject >> completed
 BehaviorSubject2 >> completed
 error 전달 시
 BehaviorSubject >> error(error)
 BehaviorSubject2 >> error(error)
 */

b.subscribe {
    print("BehaviorSubject3 >>", $0)
}
.disposed(by: disposeBag)
// BehaviorSubject3 >> completed
// BehaviorSubject3 >> error(error)
