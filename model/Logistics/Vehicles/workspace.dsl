


 
workspace extends ../../platform/workspace.dsl   {

    name "Logistics - Vehicles"

     configuration {
        users {
            yoann write
        } 
    }

    model {
            
        
            !extend vehicles {
                api = container "logistics-vehicles-svc" {
                    description "api"
                    technology "c#"
                    tags "logistics-vehicles-svc"
                    url "https://mygit.com/_git/gi_Vehicles"
                }

                spa = container "logistics-vehicles-spa" {
                    description "front, allow user to schedule and manage appointments"
                    technology "angular"
                    tags "logistics-vehicles-spa"
                    url "https://mygit.com/_git/gi_Vehicles"

                }

                database = container "logistics-vehicles-db"
                api -> database "Reads from and writes to"
                spa -> api "Uses"
                
            }

    }

    views {


        systemContext Vehicles "SystemContext" {
            include *
            
        }

        container Vehicles "Containers" {
            include *
            
        }
    }

    configuration {
        scope softwaresystem
    }

}