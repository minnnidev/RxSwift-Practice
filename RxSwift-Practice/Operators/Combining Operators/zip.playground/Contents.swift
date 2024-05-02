import UIKit
import RxSwift

/*
 <zip>
 인덱스에 맞는 짝을 결합하여 방출
 알맞은 인덱스 짝이 없다면 기다림
 결합할 짝이 없다면 구독자에게 전달되지 않음
 (indexed sequencing 구현)
 */

enum MyError: Error {
    case error
}

let disposeBag = DisposeBag()

let nums = PublishSubject<Int>()
let strings = PublishSubject<String>()

Observable.zip(nums, strings) { "\($0) - \($1)" }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

nums.onNext(1)
strings.onNext("one")
// next(1 - one)

nums.onNext(2)
// nothing
strings.onNext("two")
// next(2 - two)

//nums.onError(MyError.error)
// error(error)

nums.onCompleted()
strings.onNext("three")
// 소스 옵저버블 중 하나라도 completed 이벤트를 전달하면 이후에는 이벤트가 전달되지 않음

strings.onCompleted()
// completed
// 모든 소스 옵저버블이 completed 이벤트를 전달하면 구독자에게 completed 이벤트 전달

