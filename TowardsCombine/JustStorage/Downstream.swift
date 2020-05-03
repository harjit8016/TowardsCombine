//
//  Downstream.swift
//  TowardsCombine
//
//  Created by Harjit Singh on 03/05/20.
//  Copyright © 2020 Harjit Singh. All rights reserved.
//
import Combine
import UIKit
class ViewControllerExample: UIViewController{
    
    var data : Welcome?
    let postUserPublisher =  try! ApiPublishers.api( url: "http://dummy.restapiexample.com/api/v1/employees")
    
    private var apiCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        apiCancellable?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getData(){
        apiCancellable = postUserPublisher
            .map({$0.data})
            .receive(on: RunLoop.main)
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (completionError) in
                switch completionError {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }) { (data) in
                
                self.data = data
               // self.tblVw.reloadData()
                
        }
    }
}
