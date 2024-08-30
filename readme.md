# summary

This is a demo sample repository to show how to highlight what , AFAIK, might be missing from structurizr .


#  context

Two teams are working on different part of a very big architecture.  One is a feature team  working on Sales (FTS), the other a feature team  working on logistics (FTL).

I would like FTS to be able to document its interactions with the surroundings in a explicit way, meaning able to reference containers owned by the FTL for instance.

Thas might go as follows  :

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
            
```

Sales/SalesProcessing/workspace.dsl
```dsl
workspace extends ../../platform/workspace.dsl {
    name "Sales - SalesProcessing" 
    model {
        !extend SalesProcessing {
            api = container "sales-processing-svc" {
                description "api"
                technology "c#"
                tags "sales-processing-svc"
                url "https://mygit.com/_git/isa_user"
            }
            
            api -> parkingLots.api "checks"
        }

    }
}
```


This is important , so that the FTS can exactly know what are his exact dependencies on the outside. These should then be included in the view owned by the FTS.
```dsl
    container SalesProcessing "Containers" {
            include *
        }
```dsl        



