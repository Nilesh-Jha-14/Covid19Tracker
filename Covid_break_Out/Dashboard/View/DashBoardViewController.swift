//
//  DashboardViewController.swift
//  Covid_break_Out
//
//  Created by JHA Nilesh Kumar on 25/03/20.
//  Copyright © 2020 JHA Nilesh Kumar. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

protocol DashBoardView : class{
    func covidAPISuccess(model : DashBoardModel)
    func covidAPIFailureBlock(message : String?)
    func showActivityIndicator()
    func hideActivityIndicator()
}



class DashBoardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: DashboardPresentation?

    var model : DashBoardModel?
    var segmentIndex  = 0
    var firstTimeLoad = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        setUpNavigationBar()

        // Do any additional setup after loading the view.
    }


    private func setUpNavigationBar(){
           self.title = "Covid - INDIA"
           let addButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
           addButtonItem.tintColor = UIColor.black
           navigationItem.rightBarButtonItem = addButtonItem


       }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getAllCovidData()
    }

    private func updateUI(model : DashBoardModel){
        self.model = model
        tableView.reloadData()
    }

    @objc
    private func refreshButtonTapped(){
        self.presenter?.getAllCovidData()
    }

    @objc private func segmentTapped(sender : UISegmentedControl) {
        segmentIndex = sender.selectedSegmentIndex
        tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
    }



   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DashBoardViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {

        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverAllInfoTableViewCell", for: indexPath) as? OverAllInfoTableViewCell else {
                fatalError()
            }
            if let model = model {
                cell.configureData(model: model)
                
            }

            return cell

        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentTableViewCell", for: indexPath) as? SegmentTableViewCell else {
                fatalError()
            }
            cell.segmentControl.addTarget(self, action: #selector(segmentTapped(sender:)), for: .valueChanged)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BarChartTableViewCell", for: indexPath) as? BarChartTableViewCell else {
                fatalError()
            }
            if let model = model {
                switch segmentIndex {
                case 0:
                    if let dataEntry = self.presenter?.getConfirmedDataEntry(data: model)  {
                        cell.barChartView.updateDataEntries(dataEntries: dataEntry, animated: true)
                    }
                case 1:
                    if let dataEntry = self.presenter?.getrecoveredDataEntry(data: model)  {
                        cell.barChartView.updateDataEntries(dataEntries: dataEntry, animated: true)
                    }
                case 2:
                    if let dataEntry = self.presenter?.getDeceasedDataEntry(data: model)  {
                        cell.barChartView.updateDataEntries(dataEntries: dataEntry, animated: true)
                    }
                default:
                    print("")
                }

            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StateLevelTableViewCell", for: indexPath) as? StateLevelTableViewCell else {
                fatalError()
            }
            if let model = model {
                cell.model = model
                if  firstTimeLoad {
                    cell.configureData(isFirstTime: firstTimeLoad)
                    firstTimeLoad = false
                } else {
                    cell.configureData(isFirstTime: firstTimeLoad)
                }


                
            }

            return cell
        default:
            fatalError()
        }
    }


}

extension DashBoardViewController : DashBoardView {

    func covidAPISuccess(model: DashBoardModel) {
        updateUI(model: model)
    }

    func covidAPIFailureBlock(message: String?) {
        print("Failure")
    }

    func showActivityIndicator() {
        MBProgressIndicator.showIndicator(self.view)
    }

    func hideActivityIndicator() {
        MBProgressIndicator.hideIndicator(self.view)
    }


    
}
