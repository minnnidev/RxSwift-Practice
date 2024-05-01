import UIKit
import RxSwift

enum CustomError: Error {
    case error
}

let observable = Observable.create { ob in
    ob.onNext("hi")
    ob.onNext("hello")

//    ob.onError(CustomError.error)

    ob.onCompleted()
    return Disposables.create()
}

// next, onCompleted 이벤트만 방출하는 새로운 Observable
let infallible = Infallible.create { ob in
    ob(.next("안녕하세요"))
    ob(.completed)

    return Disposables.create()
}
