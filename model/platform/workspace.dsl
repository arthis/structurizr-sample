workspace {

    !identifiers hierarchical

    name " Platform - big enterprise"

    model {
        customer = person "Customer"

        group Identity&AccessManagement {
            identity = softwareSystem "Identity"
            license = softwareSystem "License"
            accessManagement = softwareSystem "Access Management"
        }

        group  Logistics {
            vehicles = softwareSystem "Vehicles" 
            parkingLots = softwareSystem "ParkingLots"

            vehicles -> identity "Uses"
            parkingLots -> identity "Uses"
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