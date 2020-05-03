//
//  ViewController.swift
//  TowardsCombine
//
//  Created by Harjit Singh on 01/05/20.
//  Copyright © 2020 Harjit Singh. All rights reserved.
//

import UIKit
import Combine
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblVw: UITableView!
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
        self.getData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellClass", for: indexPath) as? CellClass
        cell?.dataObj = data?.data[indexPath.row]
        return cell!
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
                self.tblVw.reloadData()
                
        }
    }
}

class CellClass: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    
    var dataObj : Datum?{
        didSet{
            lblName.text = dataObj?.employeeName
            lblAge.text = dataObj?.employeeAge
            lblSalary.text = dataObj?.employeeSalary
        }
    }
}


