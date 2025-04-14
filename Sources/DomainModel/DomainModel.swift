struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency: String
        
    public init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    public func convert(_ currName : String) -> Money {
        // normalizing to USD
        var usdVal = 0
        switch self.currency {
        case "GBP":
            usdVal = self.amount * 2
        case "EUR":
            usdVal = self.amount * 2 / 3
        case "CAN":
            usdVal = self.amount * 4 / 5
        default:
            usdVal = self.amount
        }
        
        switch currName {
        case "GBP":
            usdVal /= 2
        case "EUR":
            usdVal = Int(Double(usdVal) * 1.5)
        case "CAN":
            usdVal = Int(Double(usdVal) * 1.25)
        default:
            break
        }
        return Money(amount: usdVal, currency: currName)
        
    }
    
    public func add(_ money : Money) -> Money {
        if self.currency == money.currency {
            return Money(amount: self.amount + money.amount, currency: self.currency)
        } else {
            let convertedSelf = self.convert(money.currency)
            return Money(amount: convertedSelf.amount + money.amount, currency: money.currency)
        }
    }
    
    public func subtract(_ money : Money) -> Money {
//        if self.currency == money.currency {
//            return Money(amount: self.amount - money.amount, currency: self.currency)
//        } else {
//            let convertedSelf = self.convert(money.currency)
//            return Money(amount: convertedSelf.amount - money.amount, currency: money.currency)
//        }
        add(Money(amount: -money.amount, currency: money.currency))
    }
}



////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
