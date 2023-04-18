//
//  APICallingViewController.swift
//  LoginUI
//
//  Created by Rahul on 14/02/23.
//

import UIKit
import Alamofire

class APICallingViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var loginAPITableView: UITableView!
    
    var arrUsers: [Dictionary<String,AnyObject>] = []

    
    // MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        configuer()
    }
    
    func configuer() {
        loginAPITableView.register(UINib(nibName: "APICallingTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        loginAPITableView.estimatedRowHeight = 500
        loginAPITableView.rowHeight = UITableView.automaticDimension
    }
    
    
    private func getUsers(){
        guard let url = URL(string: "https://gorest.co.in/public/v2/users") else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.httpBody = nil
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let apiData = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: apiData) as! [Dictionary<String, AnyObject>]
                self.arrUsers = json
                
                DispatchQueue.main.async {
                    self.loginAPITableView.reloadData()
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
}

extension APICallingViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = loginAPITableView.dequeueReusableCell(withIdentifier: "cell") as! APICallingTableViewCell
        let rowDictionary = arrUsers[indexPath.row]
        cell.nameLabel.text = (rowDictionary["name"] as! String)
        cell.emailLabel.text = (rowDictionary["email"] as! String)
        cell.genderLabel.text = (rowDictionary["gender"] as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


    

   
