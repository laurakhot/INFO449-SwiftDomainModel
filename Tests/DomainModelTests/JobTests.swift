import XCTest
@testable import DomainModel

class JobTests: XCTestCase {
  
    func testCreateSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
        XCTAssert(job.calculateIncome(100) == 1000)
        // Salary jobs pay the same no matter how many hours you work
    }

    func testCreateHourlyJob() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
        XCTAssert(job.calculateIncome(20) == 300)
    }

    func testSalariedRaise() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)

        job.raise(byAmount: 1000)
        XCTAssert(job.calculateIncome(50) == 2000)

        job.raise(byPercent: 0.1)
        XCTAssert(job.calculateIncome(50) == 2200)
    }

    func testHourlyRaise() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)

        job.raise(byAmount: 1.0)
        XCTAssert(job.calculateIncome(10) == 160)

        job.raise(byPercent: 1.0) // Nice raise, bruh
        XCTAssert(job.calculateIncome(10) == 320)
    }
    
    // negative hours gets converted to 0 hourly
    func testNegativeHourly() {
        let job = Job(title: "Influencer", type: Job.JobType.Hourly(-5.0))
        XCTAssert(job.calculateIncome(10) == 0)
        
        job.raise(byAmount: 100)
        XCTAssert(job.calculateIncome(5) == 500)
    }
    
    // percentage raise for negative salary returns 0 income
    func testNegativeHourlyRaise() {
        let job = Job(title: "Student", type: Job.JobType.Hourly(-3.0))
        
        XCTAssert(job.calculateIncome(10) == 0)
        
        job.raise(byPercent: 1.0)
        XCTAssert(job.calculateIncome(5) == 0)
    }
    
    func testJobConversion() {
        let job = Job(title: "SWE", type: Job.JobType.Salary(100000))
        job.convert()
        XCTAssert(job.calculateIncome(5) == 100000)
    }
    
    func testHourlyToSalaryConversion() {
        let job = Job(title: "Teacher", type: Job.JobType.Hourly(25.0))
        job.convert() // 25.0 * 2000 = 50000
        XCTAssert(job.calculateIncome(5) == 50000)
    }
    
    static var allTests = [
        ("testCreateSalaryJob", testCreateSalaryJob),
        ("testCreateHourlyJob", testCreateHourlyJob),
        ("testSalariedRaise", testSalariedRaise),
        ("testHourlyRaise", testHourlyRaise),
        ("testNegativeHourly", testNegativeHourly),
        ("testNegativeHourlyRaise", testNegativeHourlyRaise),
        ("testJobConversion", testJobConversion),
        ("testHourlyToSalaryConversion", testHourlyToSalaryConversion)
    ]
}
