import UIKit
import RxSwift

Observable.from([1, 2, 3])
    .subscribe { elem in
        print("Next event:", elem)
    } onError: { err in
        print("Error event:", err)
    } onCompleted: {
        print("Compeleted")
    } onDisposed: {
        print("Disposed")
    }

/*
 출력
 Next event: 1
 Next event: 2
 Next event: 3
 Compeleted
 Disposed
 */

// 공식 문서: dispose를 직접 호출하기보다 disposeBag을 사용하라!
var disposeBag = DisposeBag()

Observable.from([1, 2, 3])
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
