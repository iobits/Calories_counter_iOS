//
//  WeightVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 16/09/2025.
//

import UIKit
import Charts

class weightCell: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var kgLbl: UILabel!
    
}

class WeightVC: UIViewController {
    
    @IBOutlet weak var chartParentView: UIView!
    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var detailViewTop: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    private var lineChart = LineChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.separatorColor = .clear
        tblView.showsVerticalScrollIndicator = false
        setupChart()
        setChartData()
        tblView.isScrollEnabled = false
        
        // First load par reload + height adjust
        tblView.reloadData()
        updateTableHeight()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailViewTop.layer.cornerRadius = 15.0
        chartParentView.layer.cornerRadius = 15.0
        
    }
    /// ✅ Table ki height hamesha contentSize ke hisaab se adjust kare
       private func updateTableHeight() {
           DispatchQueue.main.async {
               self.tblViewHeight.constant = self.tblView.contentSize.height
               self.view.layoutIfNeeded()
           }
       }

    private func setupChart() {
        // chart ko container me embed
        lineChart.frame = chartContainer.bounds
        lineChart.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        chartContainer.addSubview(lineChart)
        
        // Chart style
        lineChart.legend.enabled = false
        lineChart.rightAxis.enabled = false
        
        // X Axis
        let xAxis = lineChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["22 Jul","23 Jul","24 Jul","25 Jul","27 Jul"])
        xAxis.granularity = 1
        
        // Y Axis
        let leftAxis = lineChart.leftAxis
        leftAxis.axisMinimum = 162
        leftAxis.axisMaximum = 167
        leftAxis.drawGridLinesEnabled = true
        leftAxis.gridColor = .lightGray
    }
    
    private func setChartData() {
        // Example values
        let values: [ChartDataEntry] = [
            ChartDataEntry(x: 0, y: 163),
            ChartDataEntry(x: 1, y: 164),
            ChartDataEntry(x: 2, y: 164.5),
            ChartDataEntry(x: 3, y: 165),
            ChartDataEntry(x: 4, y: 166.5)
        ]
        
        let set = LineChartDataSet(entries: values, label: "")
        set.mode = .cubicBezier        // 👈 smooth sinusoidal curve
        set.drawCirclesEnabled = false
        set.lineWidth = 2
        set.setColor(.black)
        set.drawValuesEnabled = false
        
        // Highlight ek yellow circle point (jaise 24 Jul pe)
        let highlightCircle = ChartDataEntry(x: 2, y: 164.5)
        let circleSet = LineChartDataSet(entries: [highlightCircle], label: "")
        circleSet.setColor(.clear)
        circleSet.circleColors = [.systemYellow]
        circleSet.circleRadius = 7
        circleSet.drawValuesEnabled = false
        
        // Goal line (horizontal)
        let goal = ChartLimitLine(limit: 164.0, label: "Goal")
        goal.lineColor = .darkGray
        goal.lineWidth = 1
        goal.labelPosition = .rightTop
        lineChart.leftAxis.addLimitLine(goal)
        
        // Set data
        let data = LineChartData(dataSets: [set, circleSet])
        lineChart.data = data
    }
}

extension WeightVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weightCell") as! weightCell
        cell.mainView.layer.cornerRadius = 15.0
        cell.clipsToBounds = true
        cell.selectionStyle = .none
        
        if indexPath.row % 2 == 0 {
            // Even rows (0,2,4...) → "new1" + green
            cell.imgView.image = UIImage(named: "greenArorow")
            cell.kgLbl.textColor = .systemGreen
        } else {
            // Odd rows (1,3,5...) → "new2" + red
            cell.imgView.image = UIImage(named: "redArrow")
            cell.kgLbl.textColor = .systemRed
        }
        
        // Example text
        cell.kgLbl.text = "\(60 + indexPath.row) kg"
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    // ✅ Jab bhi cell add/remove hoti hai, table height adjust karo
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        updateTableHeight()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        updateTableHeight()
    }
}
