//
//  ViewController.swift
//  ios_EvaluationTest
//
//  Created by Mac on 26/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var continentCollectionViiew: UICollectionView!
    
    var continentCollectionViewCell : ContinntsCollectionViewCell?
    
    private var continentsDetailViewController : ContinentsDetailViewController?
    
    private let reuseIdentifier = "ContinntsCollectionViewCell"
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var continents : [Continents] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
        jsonSerilizatiion()
        registerWithXIB()
        
    }
    func registerWithXIB(){
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        self.continentCollectionViiew.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    func initSetting(){
        continentCollectionViiew.dataSource = self
        continentCollectionViiew.delegate = self
        url = URL(string: "https://dummy-json.mock.beeceptor.com/continents")
        urlRequest = URLRequest(url : url!)
        urlSession = URLSession(configuration: .default)
    }
    func jsonSerilizatiion(){
        let dataTask = urlSession?.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            let res = try! JSONSerialization.jsonObject(with: data!) as! [[String  : Any]]
            
            for eachcontinent in res{
                
                let code = eachcontinent["code"] as! String
                let name = eachcontinent["name"] as! String
                let areaSqKm = eachcontinent["areaSqKm"] as! Double
                let population = eachcontinent["population"] as! Double
                let lines = eachcontinent["lines"]as! [String]
                let countries = eachcontinent["countries"]as! Int
                let oceans = eachcontinent["oceans"]as! [String]
                let developedCountries = eachcontinent["developedCountries"] as! [String]
                
                self.continents.append(Continents(code: code,
                                                  name: name,
                                                  areaSqKm: areaSqKm,
                                                  population: population,
                                                  lines: lines,
                                                  countries: countries,
                                                  oceans: oceans,
                                                  developedCountries: developedCountries))
                print(self.continents)
            }
            DispatchQueue.main.async{
                self.continentCollectionViiew.reloadData()
            }
        })
        dataTask?.resume()
    }
}
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        continents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.continentCollectionViiew.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ContinntsCollectionViewCell
        
        cell.nameLabel.text = continents[indexPath.row].name
        cell.areaLabel.text = "\(continents[indexPath.row].areaSqKm)"
        cell.populationLabel.text = "\(continents[indexPath.row].population)"
        
        return cell
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (continentCollectionViiew.frame.width - 10.0)/2, height: (continentCollectionViiew.frame.height))
    }
}

extension ViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        continentsDetailViewController = self.storyboard?.instantiateViewController(identifier: "continentsDetailViewController") as! ContinentsDetailViewController
        
        continentsDetailViewController?.continentsContiner = continents[indexPath.item]
        
        navigationController?.pushViewController(continentsDetailViewController!, animated: true)
    }
}
