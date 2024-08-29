


 
workspace extends ../../platform/workspace.dsl {

    name "Identity & Access Management - Identity" 

     configuration {
        users {
            yoann write
            stephane write
            stephanie write
            christophe write
            gildas write
        } 
    }

    model {
            
        
            !extend identity {
                api = container "isa-user-svc" {
                    description "api"
                    technology "c#"
                    tags "isa-user-svc"
                    url "https://mygit.com/_git/isa_user"
                }

                spa = container "isa-user-spa" {
                    description "front, allow user to interact throughout the profile micro frontend"
                    technology "angular"
                    tags "isa-user-spa"
                    url "https://mygit.com/_git/isa_user"

                }

                database = container "isa-user-db"
                api -> database "Reads from and writes to"
                spa -> api "Uses"
                
            }

    }

    views {
        systemContext identity "SystemContext" {
            include *
            
        }

        container identity "Containers" {
            include *
            
        }

    }

    configuration {
        scope softwaresystem
    }

}