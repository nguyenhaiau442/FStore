//
//  DistrictTableViewController.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 5/11/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit
import Alamofire

var districtId: Int = 0
var districtName: String = ""

class DistrictTableViewController: UITableViewController {
    
    private let cellId = "cellId"
    var districts: [DistrictResponse]?
    var districtsFiltered: [DistrictResponse]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        tableView.register(DistrictTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        fetchData()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Quận/Huyện"
        navigationController?.navigationBar.setGradientBackground(colors: [FIRST_GRADIENT_COLOR, SECOND_GRADIENT_COLOR], startPoint: .bottomLeft, endPoint: .topRight)
        let dismissButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(handleDismiss))
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    private func fetchData() {
        guard let url = URL(string: DISTRICT_API_URL) else { return }
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let districts = try decoder.decode([DistrictResponse].self, from: data)
                        self.districts = districts
                        self.tableView.reloadData()
                    }
                    catch let err {
                        print(err)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension DistrictTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let districtsFiltered = districts?.filter { $0.province_city_id == provinceCityId }
        self.districtsFiltered = districtsFiltered
        return self.districtsFiltered?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DistrictTableViewCell
        cell.district = districtsFiltered?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = districtsFiltered?[indexPath.row].id, let name = districtsFiltered?[indexPath.row].name {
            
            districtId = id
            districtName = name
            
            communeWardTownId = -1
            communeWardTownName = ""
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
