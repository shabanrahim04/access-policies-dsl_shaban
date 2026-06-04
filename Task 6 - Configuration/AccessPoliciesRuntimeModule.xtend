#This file tells the Xtext framework to use your custom validator and other custom services instead of the defaults.

package gse.xtext.assignment

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
class AccessPoliciesRuntimeModule extends AbstractAccessPoliciesRuntimeModule {
    
    // This automatically links your Validator defined above
    override bindIValidator() {
        return gse.xtext.assignment.validation.AccessPoliciesValidator
    }
}

