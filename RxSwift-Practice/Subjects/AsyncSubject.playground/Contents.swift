import UIKit
import RxSwift

enum CustomError: Error {
    case error
}

let disposeBag = DisposeBag()

/*
 AsyncSubject는 completed 이벤트가 전달되기 전까지 어떠한 이벤트도 전달되지 않음
 completed 이벤트가 전달된 시점에 가장 최근에 전달됐던 next 이벤트가 구독자에게 전달됨
 */

let a = AsyncSubject<Int>()

a.subscribe {
    print($0)
}
.disposed(by: disposeBag)

a.onNext(1)
a.onNext(2)
a.onNext(3)

//a.onCompleted()

/*
 next(3)
 completed
 */

a.onError(CustomError.error)
// error(error)
// 에러 발생 시에는 next 이벤트 전달되지 않고 error 이벤트만 전달됨
