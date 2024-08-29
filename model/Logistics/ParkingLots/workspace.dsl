


 
workspace extends ../../platform/workspace.dsl   {

    name "Logistics - Parking Lots"

     configuration {
        users {
            yoann write
        } 
    }

    model {
            
        
            !extend parkingLots {
                api = container "logistics-parkinglots-svc" {
                    description "api"
                    technology "c#"
                    tags "logistics-parkinglots-svc"
                    url "https://mygit.com/_git/gi_parkinglots"
                }

                spa = container "logistics-parkinglots-spa" {
                    description "front, allow user to schedule and manage appointments"
                    technology "angular"
                    tags "logistics-parkinglots-spa"
                    url "https://mygit.com/_git/gi_parkinglots"

                }

                database = container "logistics-parkinglots-db"
                api -> database "Reads from and writes to"
                spa -> api "Uses"
                
            }

    }

    views {


        systemContext Parkinglots "SystemContext" {
            include *
            
        }

        container Parkinglots "Containers" {
            include *
            
        }
    }

    configuration {
        scope softwaresystem
    }

}