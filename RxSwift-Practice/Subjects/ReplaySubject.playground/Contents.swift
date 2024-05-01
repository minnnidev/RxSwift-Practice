import UIKit
import RxSwift

enum CustomError: Error {
    case error
}

let disposeBag = DisposeBag()

/*
 2개 이상의 이벤트를 저장하여 새로운 구독자에게 전달하고 싶을 때
 버퍼는 메모리에 저장되기 때문에 메모리 사용량을 신경쓸 필요가 있다
 종료 여부와 관계 없이 버퍼 내에 있는 이벤트들을 새로운 구독자에게 전달
 */

let r = ReplaySubject<Int>.create(bufferSize: 3)
(1...10).forEach {
    r.onNext($0)
}

r.subscribe {
    print("ReplaySubject1 >>", $0)
}
.disposed(by: disposeBag)

/*
 버퍼의 크기를 3으로 지정하였기에 마지막 3개의 이벤트 저장됨
 ReplaySubject1 >> next(8)
 ReplaySubject1 >> next(9)
 ReplaySubject1 >> next(10)
 */

r.subscribe {
    print("ReplaySubject2 >>", $0)
}
.disposed(by: disposeBag)

// 새로운 이벤트 전달 - 버퍼의 가장 오래된 이벤트가 삭제됨
r.onNext(11)

r.subscribe {
    print("ReplaySubject3 >>", $0)
}
.disposed(by: disposeBag)

/*
 ReplaySubject3 >> next(9)
 ReplaySubject3 >> next(10)
 ReplaySubject3 >> next(11)
 */

//r.onCompleted()
///*
// ReplaySubject1 >> completed
// ReplaySubject2 >> completed
// ReplaySubject3 >> completed
// */
//
//r.subscribe {
//    print("ReplaySubject4 >>", $0)
//}
//.disposed(by: disposeBag)
///*
// ReplaySubject4 >> next(9)
// ReplaySubject4 >> next(10)
// ReplaySubject4 >> next(11)
// ReplaySubject4 >> completed
// */

r.onError(CustomError.error)
r.subscribe {
    print("ReplaySubject4 >>", $0)
}
.disposed(by: disposeBag)
/*
 ReplaySubject4 >> next(9)
 ReplaySubject4 >> next(10)
 ReplaySubject4 >> next(11)
 ReplaySubject4 >> error(error)
 */
