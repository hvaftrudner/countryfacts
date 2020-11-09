//
//  DetailViewController.swift
//  countryfacts
//
//  Created by Kristoffer Eriksson on 2020-10-15.
//
import WebKit
import UIKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem : Country?
    
    var allSentences = [String]()
    
    var population : String?
    var currency : String?
    var capital : String?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = detailItem?.title
        
        guard let detailItem = detailItem else {return}
        
        parseString()
        
        let html = """
            <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style> body { font-size: 80%; text-align: Center; background-color: black; color: white; } </style>
            </head>
            <body>
                <div class="title">
                    \(detailItem.title)

                </div>
                <br>
                <div>
                    Population:
                </div>
            \(population ?? "empty")
                
                <div>
                <br>
                    Currency:
                </div>
            \(currency ?? "empty")
                
                <div>
                <br>
                    Capital:
                </div>
            \(capital ?? "empty")
            </body>
            </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        
        
    }
    
    func parseString(){
        guard let extracts = detailItem?.extract else {return}
        
        allSentences = extracts.components(separatedBy: ". ")
        
        for (index, sentence) in allSentences.enumerated(){
            if sentence.contains("population "){
                population = allSentences[index]
                break
            }
            
        }
        for (index, sentence) in allSentences.enumerated(){
            if sentence.contains("currency "){
                currency = allSentences[index]
                break
            }
            
        }
        for (index, sentence) in allSentences.enumerated(){
            if sentence.contains("capital "){
                capital = allSentences[index]
                break
            }
            
        }
        print(population ?? "didnt find")
        
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
