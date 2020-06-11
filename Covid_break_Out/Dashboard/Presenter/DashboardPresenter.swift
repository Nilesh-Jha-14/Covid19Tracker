//
//  DashboardPresenter.swift
//  Covid_break_Out
//
//  Created by JHA Nilesh Kumar on 25/03/20.
//  Copyright © 2020 JHA Nilesh Kumar. All rights reserved.
//

import Foundation
import UIKit


protocol DashboardPresentation {
      func getAllCovidData() -> Void
      func getConfirmedDataEntry(data : DashBoardModel) -> [DataEntry]?
      func getDeceasedDataEntry(data : DashBoardModel) -> [DataEntry]?
      func getrecoveredDataEntry(data : DashBoardModel) -> [DataEntry]?
}


class DashboardPresenter {
    var interactor : DashBoardInteration
    var router: DashBoardRouting
    weak var view : DashBoardView?

    init(view: DashBoardView? , interactor: DashBoardInteration , router : DashBoardRouting) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

}

extension DashboardPresenter : DashboardPresentation {
    func getConfirmedDataEntry(data : DashBoardModel ) -> [DataEntry]? {


        guard var casesTimeSeries =  data.casesTimeSeries else {
            return nil
        }
        casesTimeSeries = Array(casesTimeSeries.reversed())
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [DataEntry] = []
        var app = casesTimeSeries
        for (index,item)  in app.enumerated() {
            if item.dailyconfirmed.isEmpty {
                app.remove(at: index)
            }
        }
        let array = app.sorted (by: {Int($0.dailyconfirmed)! > Int($1.dailyconfirmed)!})

        guard let maxValue = array.first else{
            return nil
        }

        var count = 0
        count = maxValue.dailyconfirmed.count
        var numValue = 10.0
        for i in 0..<count-1 {
            if i != 0 {
               numValue =  numValue * 10
            }
        }



        for i in 0..<casesTimeSeries.count {
            var vv = "0.0"
            if !casesTimeSeries[i].dailyconfirmed.isEmpty {
                vv = casesTimeSeries[i].dailyconfirmed
            }

            let value = vv
            let height: Float = Float(value)! / Float(maxValue.dailyconfirmed)!

            if let dateValue = casesTimeSeries[i].date {
                 result.append(DataEntry(color: colors[i % colors.count], height: height, textValue: "\(value)", title: dateValue))

            }

        }
        return result
    }

    func getDeceasedDataEntry(data : DashBoardModel ) -> [DataEntry]? {


           guard var casesTimeSeries =  data.casesTimeSeries else {
               return nil
           }
           casesTimeSeries = Array(casesTimeSeries.reversed())
           let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
           var result: [DataEntry] = []
           var app = casesTimeSeries
           for (index,item)  in app.enumerated() {
               if item.dailyconfirmed.isEmpty {
                   app.remove(at: index)
               }
           }
           let array = app.sorted (by: {Int($0.dailydeceased)! > Int($1.dailydeceased)!})

           guard let maxValue = array.first else{
               return nil
           }

           var count = 0
           count = maxValue.dailydeceased.count
           var numValue = 10.0
           for i in 0..<count-1 {
               if i != 0 {
                  numValue =  numValue * 10
               }
           }



           for i in 0..<casesTimeSeries.count {
               var vv = "0.0"
               if !casesTimeSeries[i].dailydeceased.isEmpty {
                   vv = casesTimeSeries[i].dailydeceased
               }

               let value = vv
               let height: Float = Float(value)! / Float(maxValue.dailydeceased)!

               if let dateValue = casesTimeSeries[i].date {
                    result.append(DataEntry(color: colors[i % colors.count], height: height, textValue: "\(value)", title: dateValue))

               }

           }
           return result
       }

    func getrecoveredDataEntry(data : DashBoardModel ) -> [DataEntry]? {


           guard var casesTimeSeries =  data.casesTimeSeries else {
               return nil
           }
           casesTimeSeries = Array(casesTimeSeries.reversed())
           let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
           var result: [DataEntry] = []
           var app = casesTimeSeries
           for (index,item)  in app.enumerated() {
               if item.dailyconfirmed.isEmpty {
                   app.remove(at: index)
               }
           }
           let array = app.sorted (by: {Int($0.dailyrecovered)! > Int($1.dailyrecovered)!})

           guard let maxValue = array.first else{
               return nil
           }

           var count = 0
           count = maxValue.dailyrecovered.count
           var numValue = 10.0
           for i in 0..<count-1 {
               if i != 0 {
                  numValue =  numValue * 10
               }
           }



           for i in 0..<casesTimeSeries.count {
               var vv = "0.0"
               if !casesTimeSeries[i].dailyrecovered.isEmpty {
                   vv = casesTimeSeries[i].dailyrecovered
               }

               let value = vv
               let height: Float = Float(value)! / Float(maxValue.dailyrecovered)!

               if let dateValue = casesTimeSeries[i].date {
                    result.append(DataEntry(color: colors[i % colors.count], height: height, textValue: "\(value)", title: dateValue))

               }

           }
           return result
       }

    func getAllCovidData() {
        view?.showActivityIndicator()
        interactor.getCovidData { [weak self](success, dashBoardModel, message) in
            DispatchQueue.main.async {
                self?.view?.hideActivityIndicator()
                guard let model = dashBoardModel else {
                    self?.view?.covidAPIFailureBlock(message: message)
                    return
                }
                self?.view?.covidAPISuccess(model: model)
            }

        }
    }
    
}
