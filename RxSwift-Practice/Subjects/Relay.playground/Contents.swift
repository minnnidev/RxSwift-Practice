import UIKit
import RxSwift
import RxCocoa

/*
 Relay
 RxCocoa framework
 Subject와 가장 큰 차이점은 next 이벤트만 전달하고 전달받는다는 것
 */
let disposeBag = DisposeBag()

let pRelay = PublishRelay<Int>()
pRelay.subscribe {
    print("p:", $0)
}
.disposed(by: disposeBag)

pRelay.accept(1)
// 1: next(1)

let bRelay = BehaviorRelay<Int>(value: 1)
bRelay.accept(2)

bRelay.subscribe {
    print("b:", $0)
}
.disposed(by: disposeBag)

bRelay.accept(3)

print(bRelay.value) // 3

// RxSwift6부터는 ReplayRelay도 사용 가능
let rRelay = ReplayRelay<Int>.create(bufferSize: 3)
(1...10).forEach {
    rRelay.accept($0)
}

rRelay.subscribe {
    print("r:", $0)
}

/*
 r: next(8)
 r: next(9)
 r: next(10)
 */
