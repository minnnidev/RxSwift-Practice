import UIKit
import RxSwift

// Observable 셍성 빙밥1 - create로 직접 생성
let o1 = Observable.create { ob in
    ob.onNext(0)
    ob.onNext(1)

    // completed 이벤트가 전달되면 observable 종료, 이후에는 다른 이벤트 전달 불가
    ob.onCompleted()
    return Disposables.create()
}

// subscribe 방법1
o1.subscribe { // 클로저가 바로 옵저버
    print("=== start ===")
    print($0)

    if let elem = $0.element {
        print(elem)
    }
    print("=== end ===")
}

/*
 출력 - 항상 하나의 이벤트가 처리된 후 다음 이벤트가 전달됨
 === start ===
 next(0)
 0
 === end ===
 === start ===
 next(1)
 1
 === end ===
 === start ===
 completed
 === end ===
 */

// subscribe 방법2 - 각 이벤트들을 별도의 클로저로 처리
o1.subscribe(onNext: {
    print($0)
})

/*
 출력
 0
 1
 */


// Observable 생성 방법2 - sugar api들 (from, on, just...)
Observable.from([0, 1, 2]) // 배열 안의 요소들을 순서대로 방출 후 completed 메소드 전달
