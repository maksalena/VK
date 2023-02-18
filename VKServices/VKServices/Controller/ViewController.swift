//
//  ViewController.swift
//  VKServices
//
//  Created by Алёна Максимова on 17.02.2023.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var serviceData = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ParsingJson { data in
            self.serviceData = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func ParsingJson(complition: @escaping ([Service])->() ) {
        let urlstring = "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json"
        let url = URL (string: urlstring)
        guard url != nil else {
            print ("Error during the request")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            // Checking errors
            if error == nil, data != nil {
                // parsing json file
                let decoder = JSONDecoder()
                do {
                    let ParsingData = try decoder.decode(Servises.self, from: data!)
                    complition(ParsingData.items)
                } catch {
                    print("Parsing error")
                }
            }
        }
        dataTask.resume()
    }
    var selectedRow: Int = 0
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.downloaded(from: serviceData[indexPath.row].icon_url!)
        cell.textLabel?.text = serviceData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ServiceInfoController {
            destination.serviceDescription = serviceData[selectedRow]
        }
    }
}

