//
//  ViewController.swift
//  countryfacts
//
//  Created by Kristoffer Eriksson on 2020-10-15.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    
    let countryNames = ["Sweden", "Norway", "Denmark", "Finland", "Iceland"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJson), with: nil)
    }
    @objc func fetchJson(){
        
        for name in countryNames{
            let urlString = "https://en.wikipedia.org/api/rest_v1/page/summary/\(name)"
            
            if let url = URL(string: urlString){
                if let data = try? Data(contentsOf: url){
                    parse(json: data)
                    
                }
            }
        }
    }
    
    func parse(json: Data){
        let jsonDecoder = JSONDecoder()
        
        // här är felet.
        if let jsonCountries = try? jsonDecoder.decode(Country.self, from: json){
            
            countries.append(jsonCountries)
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
            
            print("did load json")
        } else {
            print("could not load json")
        }
    }
    
    //table view cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return countryNames.count
        return countries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].title
        //cell.textLabel?.text = countries[indexPath.row].title
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "detailView") as? DetailViewController{
            vc.detailItem = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }


}

