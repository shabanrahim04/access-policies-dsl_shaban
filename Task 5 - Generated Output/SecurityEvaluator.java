public class SecurityEvaluator {

    public static boolean isAllowed(String actor, String operation, String asset) {
        
        // --- Logic from Policy: CorporateAccess ---

        // Scope for Admin (and inherited actors)
        if (actor.equals("Admin")) {
            if (operation.equals("Read") && asset.equals("Database"))
                return true;
            if (operation.equals("Write") && asset.equals("Database"))
                return true;
            if (operation.equals("Delete") && asset.equals("Database"))
                return true;
        }

        // Scope for Manager (and inherited actors)
        if (actor.equals("Manager") || actor.equals("Admin")) {
            if (operation.equals("Read") && asset.equals("FileServer"))
                return true;
            if (operation.equals("Write") && asset.equals("FileServer"))
                return true;
        }

        // Scope for Employee (and inherited actors)
        if (actor.equals("Employee") || actor.equals("Manager") || actor.equals("Admin")) {
            if (operation.equals("Read") && asset.equals("FileServer"))
                return true;
        }

        // Default fallback
        return false; 
    }
}
