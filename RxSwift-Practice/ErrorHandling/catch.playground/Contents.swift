import UIKit
import RxSwift


/*
 catch
 소스 옵저버블이 방출한 에러를 새로운 옵저버블로 교체하는 방식으로 처리
 */

/*
 catchAndReturn
 소스 옵저버블에서 에러 이벤트 발생 시 파라미터의 기본값 방출
 */


let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// catch
let subject = PublishSubject<Int>()
let recovery = PublishSubject<Int>()

subject
    .catch { _ in recovery }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onError(MyError.error)
subject.onNext(1)
// ...

recovery.onNext(33)
// next(33)


// catchAndReturn
let sb = PublishSubject<Int>()

sb.catchAndReturn(-1)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

sb.onError(MyError.error)

/*
 next(-1)
 completed
 */
