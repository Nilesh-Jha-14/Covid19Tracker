//
//  StateLevelTableViewCell.swift
//  Covid_break_Out
//
//  Created by JHA Nilesh Kumar on 25/03/20.
//  Copyright © 2020 JHA Nilesh Kumar. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl
import Charts

class StateLevelTableViewCell: UITableViewCell {

    @IBOutlet weak var scrollableSegmentControl: ScrollableSegmentedControl!

    
    @IBOutlet weak var piechartView: PieChartView!
    var model : DashBoardModel?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func scrollableSegmentControl(sender:ScrollableSegmentedControl) {
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
        showChart(index: sender.selectedSegmentIndex)
    }

    

    func configureData(isFirstTime : Bool) {
        guard let model = model else {
            return
        }
        scrollableSegmentControl.segmentStyle = .textOnly
        scrollableSegmentControl.selectedSegmentContentColor = UIColor(red: 209/255.0, green: 72/255.0, blue: 54/255.0, alpha: 1.0)
        scrollableSegmentControl.backgroundColor = UIColor(red: 108/255.0, green: 117/255.0, blue: 125/255.0, alpha: 0.6)

        if var states = model.statewise {
            states = states.filter { $0.state != "Total" }
            for (index,item) in states.enumerated() {
                scrollableSegmentControl.insertSegment(withTitle: item.state, at: index)
            }
        }
        if isFirstTime {
            showChart(index: 0)
            scrollableSegmentControl.selectedSegmentIndex = 0
        }
        scrollableSegmentControl.addTarget(self, action: #selector(scrollableSegmentControl(sender:)), for: .valueChanged)


        
    }

    func showChart(index : Int) {

        guard let statewise = model?.statewise else {
            return
        }

        var dataEntries: [ChartDataEntry] = []
        let itemLoop = ["Active", "Confirmed" , "Recovered" , "Deaths"]
        let colorLoop = [
        UIColor(red: CGFloat(0/255), green: CGFloat(123/255), blue: CGFloat(255/255), alpha: 0.6),
        UIColor(red: CGFloat(255/255), green: CGFloat(7/255), blue: CGFloat(58/255), alpha: 0.6),
        UIColor.green,
        UIColor(red: CGFloat(108/255), green: CGFloat(117/255), blue: CGFloat(125/255), alpha: 0.6)]
        var itemValues : [Double] = [0.0,0.0,0.0,0.0]
        if let active = statewise[index + 1].active {
            itemValues[0] = Double(active)!
        }
        if let confirmed = statewise[index + 1].confirmed {
            itemValues[1] = Double(confirmed)!
        }
        if let recovered = statewise[index + 1].recovered {
            itemValues[2] = Double(recovered)!
        }
        if let deaths = statewise[index + 1].deaths {
            itemValues[3] = Double(deaths)!
        }


        for (index,item) in itemLoop.enumerated(){
            let dataEntry1 = PieChartDataEntry(value: itemValues[index], label: item, data:  itemValues[index] as AnyObject)
            dataEntries.append(dataEntry1)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "State_Wise_Data")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        piechartView.data = pieChartData
        pieChartDataSet.colors = colorLoop

        let l = piechartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.xEntrySpace = 10
        l.yEntrySpace = 0
        self.piechartView.drawHoleEnabled = false
        self.piechartView.drawEntryLabelsEnabled = true
        self.piechartView.notifyDataSetChanged()



    }

}
