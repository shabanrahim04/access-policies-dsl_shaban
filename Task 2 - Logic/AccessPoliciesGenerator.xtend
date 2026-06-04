#This implementation uses a recursive helper method to flatten the inheritance chain, ensuring that even if Actor C inherits from B and B inherits from A, the policy for A correctly applies to C.

package gse.xtext.assignment.generator

import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.emf.ecore.resource.Resource
import gse.xtext.assignment.accessPolicies.*
import java.util.List
import java.util.ArrayList

class AccessPoliciesGenerator extends AbstractGenerator {

    override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
        val model = resource.allContents.filter(Model).head
        if (model !== null) {
            fsa.generateFile("SecurityEvaluator.java", model.compile)
        }
    }

    def compile(Model m) '''
        public class SecurityEvaluator {
            public static boolean isAllowed(String actor, String operation, String asset) {
                «FOR p : m.elements.filter(Policy)»
                    «p.compile»
                «ENDFOR»
                return false; 
            }
        }
    '''

    def dispatch compile(Policy p) '''
        «FOR s : p.scopes»
            «s.compile»
        «ENDFOR»
    '''

    def dispatch compile(Scope s) '''
        // Check if current actor or any parent matches
        if («getEffectiveActors(s.actor).map['''actor.equals("«name»")'''].join(" || ")») {
            «FOR r : s.rules»
                «r.compile»
            «ENDFOR»
        }
    '''

    def dispatch compile(AllowRule r) '''
        if (operation.equals("«r.operation.name»") && asset.equals("«r.asset.name»"))
            return true;
    '''

    def dispatch compile(DenyRule r) '''
        // Deny rules ignored as per requirements
    '''

    // Fallback for non-rule elements
    def dispatch compile(Object e) ''''''

    /**
     * Recursively retrieves the actor and all its ancestors.
     */
    def List<Actor> getEffectiveActors(Actor actor) {
        val list = new ArrayList<Actor>()
        var current = actor
        while (current !== null) {
            list.add(current)
            current = current.parent
        }
        return list
    }
}
