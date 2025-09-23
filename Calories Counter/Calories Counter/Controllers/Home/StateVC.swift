//
//  StateVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 17/09/2025.
//

import UIKit
import Charts

class StateVC: UIViewController {
    
    @IBOutlet weak var chartParentView: UIView!
    @IBOutlet weak var chartContainer: UIView!
    
    @IBOutlet weak var chartParentView2: UIView!
    @IBOutlet weak var chartContainer2: UIView!
    
    @IBOutlet weak var chartParentView3: UIView!
    @IBOutlet weak var chartContainer3: UIView!
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    private var lineChart1 = LineChartView()
    private var lineChart2 = LineChartView()
    private var lineChart3 = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChart(chart: lineChart1, container: chartContainer)
        setupChart(chart: lineChart2, container: chartContainer2)
        setupChart(chart: lineChart3, container: chartContainer3)
        
        setChartData(chart: lineChart1)
        setChartData2(chart: lineChart2)
        setChartData3(chart: lineChart3)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [chartParentView, chartParentView2, chartParentView3, view1,view2, view3, view4].viewsCornerRadius(15)
    }
    
    // MARK: - Setup
    private func setupChart(chart: LineChartView, container: UIView) {
        chart.frame = container.bounds
        chart.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        container.addSubview(chart)
        
        // ✅ Disable chart's own scroll/zoom
        chart.scaleXEnabled = false
        chart.scaleYEnabled = false
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        chart.dragEnabled = false
        
        // Common style
        chart.legend.enabled = false
        chart.rightAxis.enabled = false
        
        // X Axis
        let xAxis = chart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["22 Jul","23 Jul","24 Jul","25 Jul","27 Jul"])
        xAxis.granularity = 1
        
        // Y Axis
        let leftAxis = chart.leftAxis
        leftAxis.axisMinimum = 162
        leftAxis.axisMaximum = 167
        leftAxis.drawGridLinesEnabled = true
        leftAxis.gridColor = .lightGray
    }
    
    // MARK: - Dummy Data
    private func setChartData(chart: LineChartView) {
        let values: [ChartDataEntry] = [
            ChartDataEntry(x: 0, y: 163),
            ChartDataEntry(x: 1, y: 164),
            ChartDataEntry(x: 2, y: 164.5),
            ChartDataEntry(x: 3, y: 165),
            ChartDataEntry(x: 4, y: 166.5)
        ]
        
        let set = LineChartDataSet(entries: values, label: "")
        set.mode = .cubicBezier
        set.drawCirclesEnabled = false
        set.lineWidth = 2
        set.setColor(.black)
        set.drawValuesEnabled = false
        
        let highlightCircle = ChartDataEntry(x: 2, y: 164.5)
        let circleSet = LineChartDataSet(entries: [highlightCircle], label: "")
        circleSet.setColor(.clear)
        circleSet.circleColors = [.systemYellow]
        circleSet.circleRadius = 7
        circleSet.drawValuesEnabled = false
        
        let goal = ChartLimitLine(limit: 164.0, label: "Goal")
        goal.lineColor = .darkGray
        goal.lineWidth = 1
        goal.labelPosition = .rightTop
        chart.leftAxis.addLimitLine(goal)
        
        chart.data = LineChartData(dataSets: [set, circleSet])
    }
    
    private func setChartData2(chart: LineChartView) {
        let values: [ChartDataEntry] = [
            ChartDataEntry(x: 0, y: 165),
            ChartDataEntry(x: 1, y: 165.5),
            ChartDataEntry(x: 2, y: 166),
            ChartDataEntry(x: 3, y: 166.5),
            ChartDataEntry(x: 4, y: 167)
        ]
        
        let set = LineChartDataSet(entries: values, label: "")
        set.mode = .cubicBezier
        set.drawCirclesEnabled = false
        set.lineWidth = 2
        set.setColor(.systemBlue)
        set.drawValuesEnabled = false
        
        chart.data = LineChartData(dataSets: [set])
    }
    
    private func setChartData3(chart: LineChartView) {
        let values: [ChartDataEntry] = [
            ChartDataEntry(x: 0, y: 162.5),
            ChartDataEntry(x: 1, y: 163),
            ChartDataEntry(x: 2, y: 163.5),
            ChartDataEntry(x: 3, y: 164),
            ChartDataEntry(x: 4, y: 164.5)
        ]
        
        let set = LineChartDataSet(entries: values, label: "")
        set.mode = .cubicBezier
        set.drawCirclesEnabled = false
        set.lineWidth = 2
        set.setColor(.systemGreen)
        set.drawValuesEnabled = false
        
        chart.data = LineChartData(dataSets: [set])
    }
}
