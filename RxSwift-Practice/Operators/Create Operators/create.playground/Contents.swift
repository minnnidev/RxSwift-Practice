import UIKit
import RxSwift

/*
 <create>
 옵저버블이 동작하는 방식을 직접 구현할 수 있음
 */

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// url의 html을 방출하는 옵저버블
let ob = Observable<String>.create { observer in
    guard let url = URL(string: "https://www.naver.com") else {  observer.onError(MyError.error)
        return Disposables.create()
    }

    guard let html = try? String(contentsOf: url, encoding: .utf8) else {
        observer.onError(MyError.error)
            return Disposables.create()
    }

    observer.onNext(html)
    observer.onCompleted()
    
    return Disposables.create()
}

ob
    .subscribe { print($0) }
    .disposed(by: disposeBag)
