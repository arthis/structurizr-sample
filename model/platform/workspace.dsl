workspace {

    !identifiers hierarchical

    name " Platform - big enterprise"

    model {
        customer = person "Customer"

        group Sales {
            SalesProcessing = softwareSystem "SalesProcessing"
        }

        group  Logistics {
            vehicles = softwareSystem "Vehicles" 
            parkingLots = softwareSystem "ParkingLots"

            vehicles -> SalesProcessing "Uses"
            parkingLots -> SalesProcessing "Uses"
        }
        
    }

    views {
        styles {
            element "Person" {
                shape person
            }
        }

    }
        
}