//
//  DashboardInteractor.swift
//  Covid_break_Out
//
//  Created by JHA Nilesh Kumar on 25/03/20.
//  Copyright © 2020 JHA Nilesh Kumar. All rights reserved.
//

import Foundation

protocol DashBoardInteration {
    func getCovidData(completionBlock:@escaping (Bool,DashBoardModel?,String?) -> ())
}


class DashBoardInteractor { }

extension DashBoardInteractor : DashBoardInteration {
    func getCovidData(completionBlock: @escaping (Bool, DashBoardModel?, String?) -> ()) {
        SessionManager.sharedInstance.apiRequest(url: "https://api.covid19india.org/data.json", method: .GET, parameter: nil, headers: nil) { (success, response, errorMessage) in

            if success {
                if let responseData = response as? Data {
                    let decoder = JSONDecoder()

                    do {
                        let dashBoardModel = try decoder.decode(DashBoardModel.self, from: responseData)
                        completionBlock(success,dashBoardModel,errorMessage)
                        return


                    } catch {
                        print(error.localizedDescription)
                        completionBlock(success, nil ,error.localizedDescription)
                        return
                    }
                }
            }

            completionBlock(success,nil, errorMessage)
        }
    }


}


