import UIKit
import RxSwift


/*
 retry
 소스 옵저버블에서 오류가 발생하면 구독을 해제하고 새로운 구독을 시작
 옵저버블의 모든 작업은 새로! 시작
 에러 발생 시 반복...
 횟수 제한을 둘 수도 있다
 */

/*
 retryWhen
 trigger 옵저버블이 next 이벤트를 방출하는 시점에 소스 옵저버블에 새로운 구독을 시작
 ex. 유저가 새로고침 버튼을 눌렀을 때만 retry하게 하고 싶다면...?
 */


let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}


// retry
//var attempts = 1
//let source = Observable<Int>.create { observer in
//    let currentAttempts = attempts
//    print("#\(currentAttempts) start")
//
//    if attempts < 3 {
//        observer.onError(MyError.error)
//        attempts += 1
//    }
//
//    observer.onNext(1)
//    observer.onNext(2)
//
//    observer.onCompleted()
//
//    return Disposables.create {
//        print("#\(currentAttempts) end")
//    }
//}
//
//source
//    .retry(7) // 재시도 6번 -> 첫 번째 시도는 재시도가 아니니까!
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)

// maxAttemptsCount 내에 실패하면 error event
/*
 #1 start
 #1 end
 #2 start
 #2 end
 #3 start
 next(1)
 next(2)
 completed
 #3 end
 */

// retry(when:)
var attempts = 1

let source = Observable<Int>.create { observer in
    let currentAttempts = attempts
    print("#\(currentAttempts) start")

    if attempts < 3 {
        observer.onError(MyError.error)
        attempts += 1
    }

    observer.onNext(1)
    observer.onNext(2)

    observer.onCompleted()

    return Disposables.create {
        print("#\(currentAttempts) end")
    }
}

let trigger = PublishSubject<Void>()

source
    .retry(when: { _ in trigger })
    .subscribe { print($0) }
    .disposed(by: disposeBag)

trigger.onNext(())
trigger.onNext(())
