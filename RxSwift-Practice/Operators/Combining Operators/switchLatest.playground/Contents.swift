import UIKit
import RxSwift

/*
 <switchLatest>
 가장 최근에 방출된 옵저버블을 구독하고, 이 옵저버블이 전달하는 이벤트를 구독자에게 전달
*/
let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()

let source = PublishSubject<Observable<String>>()

source
    .switchLatest()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

a.onNext("a")
b.onNext("b")
// nothing...

source.onNext(a) // 가장최신 옵저버블 a 구독
a.onNext("aa")
// next(aa)

source.onNext(b) // 가장 최신 옵저버블 b 구독
b.onNext("bb")


//source.onCompleted()
// source에 onCompleted 이벤트가 와야 구독자에게 completed 이벤트 전달

a.onError(MyError.error)
b.onError(MyError.error) // 현재 가장 최신 옵저버블인 b는 구독자에게 completed 이벤트 전달
// error(error)
