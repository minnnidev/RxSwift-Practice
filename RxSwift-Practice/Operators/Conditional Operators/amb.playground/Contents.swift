import UIKit
import RxSwift

/*
 <amb>
 여러 옵저버블 중에서 가장 먼저 이벤트를 방출하는 옵저버블을 선택
 */

let disposeBag = DisposeBag()

let a = PublishSubject<String>()
let b = PublishSubject<String>()
let c = PublishSubject<String>()


a.amb(b)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

//a.onNext("A")
//b.onNext("B")
// next(A)

b.onNext("B")
a.onNext("A")
// next(B)

b.onCompleted()
// completed
