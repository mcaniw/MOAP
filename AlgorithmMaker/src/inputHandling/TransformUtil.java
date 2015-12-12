package inputHandling;

import static kernelLanguage.KernelFactory.*;

import java.util.*;

import bindings.*;
import kernelLanguage.*;
import solver.Chainer;
import algorithmMaker.util.*;

/**
 * A class for fundamental transformations of input. All simple operations should instead go in InputUtil.java in the
 * algorithmMaker.input project.
 * 
 * @author Dwight Naylor
 */
public class TransformUtil {
	/**
	 * Reduces the given input by taking things out of the goal if they are in the given, and reducing variable use in
	 * both halves.
	 * 
	 * @return
	 */
	public static KInput removeGivenFromGoal(KInput input, Chainer chainer) {
		HashSet<KProperty> toRemove = new HashSet<KProperty>();
		ArrayList<String> vars = new ArrayList<String>();
		vars.addAll(input.given.vars);
		vars.addAll(input.goal.vars);
		for (String var : vars) {
			toRemove.add(atomic(InputUtil.EQUAL, var, var));
			toRemove.add(atomic(InputUtil.BOUND, var));
			toRemove.add(atomic(InputUtil.UNBOUND, var));
		}

		KProperty given = input.given.property;
		if (given != null) {
			KProperty reducedGiven = given.without(toRemove.toArray(new KProperty[0]));

			input = input.withGiven(input.given.withProperty(reducedGiven == null ? TRUE : reducedGiven));

			chainer.chain(input.given.property, GIVEN);
		}
		toRemove.addAll(chainer.properties.keySet());
		KProperty find = input.goal.property;
		if (find != null) {
			KProperty reducedGoal = find.without(toRemove.toArray(new KProperty[0]));
			input = input.withGoal(input.goal.withProperty(reducedGoal == null ? TRUE : reducedGoal));
		}

		HashSet<String> allUsedVars = new HashSet<String>();
		allUsedVars.addAll(input.given.vars);
		allUsedVars.addAll(input.goal.vars);
		KProblem newGiven = removeRenestedDeclarations(input.given, allUsedVars);
		KProblem newGoal = removeRenestedDeclarations(input.goal, allUsedVars);
		return input.withGiven(newGiven).withGoal(newGoal).withMinimumVariables();
	}

	private static KProblem removeRenestedDeclarations(KProblem problem, HashSet<String> allUsedVars) {
		MutableBinding revars = new MutableBinding();
		for (String var : KernelUtil.getDeclaredVars(problem.property)) {
			String newVar = InputUtil.getUnusedVar(allUsedVars);
			allUsedVars.add(newVar);
			revars.bind(var, newVar);
		}
		return problem.withProperty(KernelUtil.revar(problem.property, revars.getArguments()));
	}
}
