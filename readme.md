# summary

This is a demo sample repository to show how to highlight what , AFAIK, might be missing from structurizr .


#  context

Two teams are working on differnt part of a very big architecture.  One is a platform team (PT) working on Identity and access management, the other a feature team (FT) working on logistics.

I would like FT to be able to document its interactions with the surroundings in a explicit way, meaning able to reference containers owned by the PT.

Thas might go as follows  :
Identity&AccessManagement/Identity/workspace.dsl
```dsl
workspace extends ../../platform/workspace.dsl {
    name "Identity & Access Management - Identity" 
    model {
        !extend identity {
            api = container "isa-user-svc" {
                description "api"
                technology "c#"
                tags "isa-user-svc"
                url "https://mygit.com/_git/isa_user"
            }
        }
    }
}
```

Logistics/ParkingLots/workspace.dsl
```dsl
workspace extends ../../platform/workspace.dsl   {
    name "Logistics - Parking Lots"
    model {
            !extend parkingLots {
                api = container "logistics-parkinglots-svc" {
                    description "api"
                    technology "c#"
                    tags "logistics-parkinglots-svc"
                    url "https://mygit.com/_git/gi_parkinglots"
                }
            }
            parkingLots -> identity.api "authenticates with"
```


This is important , so that the FT can exactly know what are his exact dependencies on the outside. These should then be included in the view.
```dsl
    container Parkinglots "Containers" {
            include *
        }
```dsl        


THe only way I see to do it, would be to 
