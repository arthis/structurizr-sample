package org.example;

import com.structurizr.Workspace;
import com.structurizr.api.WorkspaceApiClient;
import com.structurizr.api.WorkspaceMetadata;
import com.structurizr.configuration.WorkspaceScope;
import com.structurizr.dsl.StructurizrDslParser;
import com.structurizr.model.SoftwareSystem;
import com.structurizr.util.WorkspaceUtils;
import com.structurizr.view.SystemLandscapeView;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Properties;


public class Example2 extends AbstractExample {

    private final static Collection<BusinessCapacity> capacities = new ArrayList<>();
    private final static Collection<Workspace> workspaces = new ArrayList<>();

    

    public static void main(String[] args) throws Exception {
        //get current args
        System.out.println("args: " + Arrays.toString(args));

        Properties prop = new Properties();
        String fileName = "app.config";
        try (FileInputStream fis = new FileInputStream(fileName)) {
            prop.load(fis);
        } catch (FileNotFoundException ex) {
            System.out.println("cannot find app.config file");    
            
        } catch (IOException ex) {
            System.out.println("cannot open app.config file");    
            
        }
        System.out.println("modules: " + prop.getProperty("modules"));

        // split prop.getProperty("modules") wth comma to modules ArrayList
        var fullModulesArray = prop.getProperty("modules").split(",");
        //foreach module in modulesArray add it to modules
        for (String fullModule : fullModulesArray) {
            String district = fullModule.split(":")[0];
            String capacity = fullModule.split(":")[1];
            BusinessCapacity businessCapacity = new BusinessCapacity(district, capacity);
            capacities.add(businessCapacity);
        }
        
        String rootDir = args[0];
        
        loadExampleWorkspaces(rootDir);
        generateSystemLandscapeWorkspace(rootDir);

    }

    private static void loadExampleWorkspaces(String rootDir) throws Exception {
        
        System.out.println("Loading workspaces from " + rootDir);
        for (BusinessCapacity capacity : capacities) {
            StructurizrDslParser parser = new StructurizrDslParser();
            var fileName = rootDir + "/" + capacity.getDistrict() + "/" + capacity.getBusinessCapacity() + "/workspace.dsl";
            System.out.println("Loading workspace from " + fileName);
            parser.parse(new File(fileName));
            // System.out.println("workspace loaded from " + fileName);
            workspaces.add(parser.getWorkspace());    
        }
        System.out.println("Workspaces loaded from " + rootDir);
    }

    private static void generateSystemLandscapeWorkspace(String rootDir) throws Exception {
        System.out.println("Generating system landscape workspace");
        // create a workspace based upon the system catalog ... this has people and software systems, but no relationships
        StructurizrDslParser parser = new StructurizrDslParser();
        parser.parse(new File(rootDir + "/platform/workspace.dsl"));

        Workspace systemLandscapeWorkspace = parser.getWorkspace();
        systemLandscapeWorkspace.setName("Platform");

        // extract all relationships between people/software systems from all software system scoped workspaces
        // so they can be added to the system landscape workspace
        for (Workspace workspace : workspaces) {
            if (workspace.getConfiguration().getScope() == WorkspaceScope.SoftwareSystem) {
                findAndCloneRelationships(workspace, systemLandscapeWorkspace);
            }
        }

        // create a system landscape view
        SystemLandscapeView view = systemLandscapeWorkspace.getViews().createSystemLandscapeView("Platform", "An automatically generated system platform view.");
        view.addAllElements();
        // view.enableAutomaticLayout();

        // and save the resulting workspace as a JSON file, for use with other tools
        WorkspaceUtils.saveWorkspaceToJson(systemLandscapeWorkspace, new File(rootDir + "/platform/workspace.json"));
        // System.out.println("System landscape workspace generated");
    }


}