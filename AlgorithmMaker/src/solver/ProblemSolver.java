package solver;

import static algorithmMaker.util.KernelUtil.*;
import static algorithmMaker.util.SugarUtil.convertToKernel;
import static kernelLanguage.KernelFactory.*;

import java.util.*;
import java.util.Map.Entry;
import java.util.stream.Collectors;

import algorithmMaker.QuickParser;
import algorithmMaker.util.*;
import bindings.*;
import display.Viewer;
import inputHandling.*;
import kernelLanguage.*;
import pseudocoders.*;
import theorems.MultistageTheorem;

/**
 * Translates an input between various states until a solution is reached.<br>
 * <br>
 * 
 * @author Dwight Naylor
 */
public class ProblemSolver {

	private static final boolean SHOW_GRAPH = true;

	/**
	 * A collection of all of the problems that have been solved. This means that either at least one of the subproblems
	 * of the problem has been solved, or the problem can be directly reduced to a solved state.
	 */
	public Hashtable<KInput, ProblemState> solvedProblems = new Hashtable<KInput, ProblemState>();

	/**
	 * The list of problem states that we still have to explore.
	 */
	public PriorityQueue<ProblemState> problemStates = new PriorityQueue<ProblemState>();

	private final KTheorem[] theorems;
	private final KTheorem[] invertedTheorems;

	public ProblemGroup initialProblem;

	public ProblemSolver(KInput problem, KTheorem... theorems) {
		this.theorems = theorems;
		this.invertedTheorems = new KTheorem[theorems.length];
		for (int i = 0; i < theorems.length; i++)
			invertedTheorems[i] = theorems[i] instanceof MultistageTheorem ? theorems[i] : theorems[i].getConverse();

		ProblemGroup initialProblem = new ProblemGroup(null, MultistageTheorem.GIVEN_MULTI, Binding.EMPTY,
				Collections.singletonList(new ProblemState(problem, theorems)));
		this.initialProblem = initialProblem;
		addProblemGroup(initialProblem);
	}

	private static int uniqueVarID = 0;

	private String getUniqueVarID() {
		return "v" + uniqueVarID++;
	}

	/**
	 * Gets the head of the problem tree that will lead to the solution for this solver's initial problem state.
	 */
	public ProblemState getSolution() {
		while (!problemStates.isEmpty() && !solvedProblems.containsKey(initialProblem.childStates.get(0).problem))
			branch();

		return solvedProblems.get(initialProblem.childStates.get(0).problem);
	}

	public void branch() {
		ProblemState problemState = problemStates.poll();
		KInput problem = problemState.problem;
		if (problem.goal.solved()) {
			catchProblemState(problemState);
			return;
		}

		Chainer givenChainer = new Chainer(theorems);
		givenChainer.addBoundVars(problem.given.vars.toArray(new String[0]));
		// NOTE: This line has to go after the bound vars, or all variables in
		// the goal will be unbound.
		givenChainer.addUnboundVars(variables(problem.goal).toArray(new String[0]));
		if (problem.given.property != null)
			givenChainer.chain(problem.given.property, GIVEN);

		KTheorem[] goalTheorems = new KTheorem[invertedTheorems.length + givenChainer.theoremDerivations.size()];
		System.arraycopy(invertedTheorems, 0, goalTheorems, 0, invertedTheorems.length);
		int index = invertedTheorems.length;
		for (KTheorem derivedTheorem : givenChainer.theoremDerivations.keySet())
			goalTheorems[index++] = derivedTheorem.getConverse();

		Chainer goalChainer = new Chainer(false, goalTheorems);
		for (KTheorem derivedTheorem : givenChainer.theoremDerivations.keySet())
			goalChainer.theoremDerivations.put(derivedTheorem.getConverse(),
					givenChainer.theoremDerivations.get(derivedTheorem));

		goalChainer.addBoundVars(problem.given.vars.toArray(new String[0]));
		goalChainer.addBoundVars(problem.goal.vars.toArray(new String[0]));
		goalChainer.previousLevelTheorems = givenChainer.nextLevelTheorems;
		goalChainer.chain(problem.goal.property, GOAL);

		if (goalChainer.nextLevelTheorems.size() > 0) {
			for (Entry<MultistageTheorem, ArrayList<Binding>> entry : goalChainer.nextLevelTheorems.entrySet())
				for (Binding binding : entry.getValue()) {
					MultistageTheorem mst = entry.getKey();
					KInput newProblem = problem;

					// Make the new given (just add in all the multi-theorem
					// results)
					ArrayList<KProperty> newGivenParts = new ArrayList<KProperty>();
					newGivenParts.add(newProblem.given.property);
					ArrayList<KProperty> newGoalParts = new ArrayList<KProperty>();
					newGoalParts.add(newProblem.goal.property);

					HashSet<String> usedVars = new HashSet<String>();
					usedVars.addAll(newProblem.given.vars);
					usedVars.addAll(newProblem.goal.vars);

					MutableBinding newBinding = new MutableBinding();
					newBinding.addBindingsFrom(binding);

					KProperty givenResult = mst.getGivenResult();
					KProperty goalResult = mst.getGoalResult();

					if (givenResult != null) {
						for (String var : KernelUtil.getDeclaredVars(givenResult))
							if (usedVars.contains(var)) {
								String newVar = InputUtil.getUnusedVar(usedVars);
								usedVars.add(newVar);
								newBinding.bind(var, newVar);
							}

						Binding rebinding = rebind(KernelUtil.getAtomics(givenResult, BOUND).stream()
								.map(x -> x.args.get(0)).collect(Collectors.toList()), usedVars);
						List<String> newVars = new ArrayList<String>();
						newVars.addAll(newProblem.goal.vars);
						newVars.addAll(rebinding.getArguments().keySet());
						newBinding.addBindingsFrom(rebinding);
						newGivenParts.add(revar(givenResult, newBinding.getArguments()));
					}
					if (goalResult != null) {
						for (String var : getDeclaredVars(goalResult))
							if (usedVars.contains(var)) {
								String newVar = InputUtil.getUnusedVar(usedVars);
								usedVars.add(newVar);
								newBinding.bind(var, newVar);
							}

						Binding rebinding = rebind(KernelUtil.getAtomics(goalResult, BOUND).stream()
								.map(x -> x.args.get(0)).collect(Collectors.toList()), usedVars);
						List<String> newVars = new ArrayList<String>();
						newVars.addAll(newProblem.goal.vars);
						newVars.addAll(rebinding.getArguments().keySet());
						newProblem = newProblem.withGoal(newProblem.goal.withVars(newVars));
						newBinding.addBindingsFrom(rebinding);
						newGoalParts.add(revar(goalResult, newBinding.getArguments()));
					}

					binding = newBinding.getImmutable();

					newProblem = newProblem.withGiven(newProblem.given.withProperty(and(newGivenParts)));
					newProblem = newProblem.withGoal(newProblem.goal.withProperty(and(newGoalParts)));

					addProblemGroup(new ProblemGroup(problemState, mst, binding,
							Collections.singletonList(new ProblemState(newProblem, theorems))));
				}
		}
		// Our stupid way of looking for quantifiers for theorems...
		for (KProperty property : goalChainer.properties.keySet())
			doSubProblemMultitheorems(problemState, property, givenChainer.properties.keySet(),
					goalChainer.properties.keySet());

		// We can also look for properties that are in the given...maybe
		// TODO: This is not done very well, looks through all the possible
		// properties instead of only the useful ones.
		// TODO: Should be methodized
		for (KProperty property : givenChainer.properties.keySet()) {
			// At the moment, this whole chunk of code is just for testing if we
			// can/should declare a hashset containing
			// all the elements of something in order to get faster child check
			// time later.
			// if (property instanceof KAtomic && false) {
			// KAtomic atomic = (KAtomic) property;
			// if (atomic.function.startsWith(InputUtil.TYPE_MARKER)
			// && InputUtil.getDeclaredType(atomic.function).equals(COLLECTION))
			// {
			// String originalObject = atomic.args.get(0);
			// // Make sure the variable isn't already a set
			// if (givenChainer.hasProperty(atomic(TYPE_MARKER + "hashset",
			// originalObject)))
			// continue;
			//
			// // We don't want to add the set if it's already in effect
			// ArrayList<Binding> fulfillments =
			// givenChainer.getAllFulfillmentsOf(quantifier(Quantifier.forall,
			// problem(atomic("child", originalObject, "z"), "z"),
			// atomic("child", "x", "z")),
			// Collections.singleton(originalObject));
			// if (fulfillments.size() > 0)
			// continue;
			//
			// HashSet<String> usedVars = new
			// HashSet<String>(KernelUtil.variables(problem.given));
			// String setName = InputUtil.getUnusedVar(usedVars);
			// usedVars.add(setName);
			// String quantifierVariable = InputUtil.getUnusedVar(usedVars);
			// Set<String> newVars = new HashSet<String>(problem.given.vars);
			// newVars.add(setName);
			// KProblem newGiven = problem.given
			// .withProperty(and(problem.given.property, atomic(TYPE_MARKER +
			// "hashset", setName),
			// quantifier(Quantifier.forall,
			// problem(atomic("child", originalObject, quantifierVariable),
			// quantifierVariable),
			// atomic("child", setName, quantifierVariable))))
			// .withVars(newVars);
			//
			// Pseudocoder coder = new Pseudocoder() {
			// @Override
			// public void appendPseudocode(StringBuffer builder, int numTabs,
			// ProblemState problemState,
			// Pseudocoder returnCoder, Binding unusedBinding) {
			// Pseudocoder.appendTabs(builder, numTabs);
			// builder.append(setName + " = new HashSet(" + originalObject +
			// ")");
			// }
			// };
			//
			// addProblemState(new ProblemGroup(problemState,
			// new MultistageTheorem(null, null, null, new AdditionMerger(1),
			// "Declaration of a hashset for inclusion testing", coder),
			// Binding.EMPTY, Collections.singletonList(new
			// ProblemState(input(newGiven, problem.goal)))));
			// }
			// }
		}
	}

	private void doSubProblemMultitheorems(ProblemState problemState, KProperty property, Set<KProperty> givenChainer,
			Set<KProperty> findChainer) {
		// This whole way of catching multi-theorems is sort of hacky. Ideally
		// we'd like to have it all done within the
		// theorem chainer, and then we could just "pick them up" here. The
		// reason that isn't done is because the
		// chainer doesn't handle quantifiers very well.
		if (property instanceof KQuantifier) {
			KQuantifier quantifier = (KQuantifier) property;
			doQuantifierSubProblemFor(problemState, quantifier, givenChainer, findChainer);
			if (quantifier.isUniversal()) {
				// if the the quantifier's predicate is transitive...
				if (TRANSITIVITY.satisfiedBy(quantifier.predicate)) {
					doTransitiveQuantifierClosure(problemState, quantifier, givenChainer, findChainer);
				}
			}
		}
	}

	private void doTransitiveQuantifierClosure(ProblemState problemState, KQuantifier quantifier,
			Set<KProperty> givenChainer, Set<KProperty> findChainer) {
		String arg0 = ((KAtomic) quantifier.predicate).args.get(0);
		String arg1 = ((KAtomic) quantifier.predicate).args.get(1);
		// We then have to make sure this quantifier is a true transitive quantifier.
		ArrayList<Binding> bindings = Binding.findBindingWithin(problemState.problem.goal.property,
				quantifier.subject.property);
		// We do this by finding all possible "matches" from outside the quantifier to the inside of the quantifier
		if (bindings != null)
			for (Binding binding : bindings) {
				ArrayList<String> lines = new ArrayList<String>();
				Hashtable<String, String> bindingArgs = binding.getArguments();
				for (String originalVar : bindingArgs.keySet()) {
					String newVar = bindingArgs.get(originalVar);
					if (!originalVar.equals(newVar))
						lines.add(originalVar + " = null;");
				}
				lines.add(LineCoder.EXIT_STRING + "0");
				lines.add(">if " + (quantifier.subject.vars.contains(arg0) ? arg1 : arg0) + " == null");
				for (String originalVar : bindingArgs.keySet()) {
					String newVar = bindingArgs.get(originalVar);
					if (!originalVar.equals(newVar))
						lines.add(">>" + originalVar + " = " + newVar);
				}
				lines.add(">" + LineCoder.EXIT_STRING + "1");
				for (String originalVar : bindingArgs.keySet()) {
					String newVar = bindingArgs.get(originalVar);
					if (!originalVar.equals(newVar))
						lines.add(">>" + originalVar + " = " + newVar);
				}
				lines.add(LineCoder.EXIT_STRING + "2");

				LineCoder coder = new LineCoder(lines.toArray(new String[0]));

				KInput newProblem = problemState.problem;
				newProblem = newProblem.withGiven(newProblem.given.withProperty(
						and(quantifier, revar(quantifier.subject.property, binding.getInverse().getArguments()))));
				newProblem = TransformUtil.removeGivenFromGoal(newProblem, new Chainer(theorems));

				KProperty transitivityGiven = and(problemState.problem.given.property, quantifier.subject.property,
						revar(quantifier.subject.property, binding.getInverse().getArguments()));
				KInput testProblem = KernelUtil.cleanDeclarations(
						input(problem(KernelUtil.getUndeclaredVars(transitivityGiven), transitivityGiven),
								problem(Collections.emptyList(), quantifier.predicate)));

				addProblemGroup(new ProblemGroup(problemState,
						new MultistageTheorem(null, null, null, r -> r[0] * r[1] + r[2],
								"Basic optimization on a transitive quantifier", coder),
						Binding.EMPTY,
						new ProblemState(getTransitiveQuantifierEnumerationSubProblem(problemState, quantifier),
								theorems),
						new ProblemState(testProblem, theorems), new ProblemState(newProblem, theorems)));
			}
	}

	private KInput getTransitiveQuantifierEnumerationSubProblem(ProblemState problemState, KQuantifier quantifier) {
		// TODO: Check and make sure that uninvolvedParts is being used correctly here.
		return input(problemState.problem.given, quantifier.subject
				.withVars(KernelUtil.getUndeclaredVars(quantifier.subject.withVars(problemState.problem.given.vars))));
	}

	private void doQuantifierSubProblemFor(ProblemState problemState, KQuantifier quantifier,
			Set<KProperty> givenChainer, Set<KProperty> findChainer) {
		// First we check and see if all the variables used in the quantifier
		// are bound. If any aren't, we can't solve
		// the quantifier.
		HashSet<String> boundVars = new HashSet<String>();
		boundVars.addAll(getDeclaredVars(quantifier));
		// Add all the declarations from the given
		boundVars.addAll(problemState.problem.given.vars);
		for (String variable : variables(quantifier))
			if (!boundVars.contains(variable))
				return;

		// The new problem with the quantifier constraint removed and added to
		// the given
		KInput newProblem = problemState.problem
				.withGoalProperty(problemState.problem.goal.property.without(quantifier))
				.withGivenProperty(and(problemState.problem.given.property, quantifier));

		String newVar = getUniqueVarID();
		ArrayList<String> lines = new ArrayList<String>();
		lines.add("boolean " + newVar + " = true;");
		lines.add(LineCoder.EXIT_STRING + "0");
		lines.add(">" + newVar + " = false");
		lines.add("if " + newVar + " == " + quantifier.isUniversal());
		lines.add(">" + LineCoder.EXIT_STRING + "1");
		LineCoder coder = new LineCoder(lines.toArray(new String[0]));

		addProblemGroup(new ProblemGroup(problemState,
				new MultistageTheorem(null, null, null, r -> r[0] + r[1], "Brute-force checking of a quantifier.",
						coder),
				Binding.EMPTY, new ProblemState(getSubProblemForQuantifier(problemState.problem, quantifier), theorems),
				new ProblemState(newProblem, theorems)));
	}

	/**
	 * Produces a subproblem K for which: <br>
	 * If the quantifier is universal, a solution for K is a counterexample.<br>
	 * If the quantifier is existential, a solution for K is an example.
	 */
	public static KInput getSubProblemForQuantifier(KInput problem, KQuantifier quantifier) {
		MutableBinding rebindingForQuantifier = new MutableBinding();
		HashSet<String> usedVars = new HashSet<String>(variables(problem.given));
		for (String var : getDeclaredVars(quantifier.subject)) {
			String newVar = InputUtil.getUnusedVar(usedVars);
			usedVars.add(newVar);
			rebindingForQuantifier.bind(var, newVar);
		}
		KProblem newGoal = revar(quantifier.subject, rebindingForQuantifier.getArguments());
		KProperty newPredicate = revar(quantifier.predicate, rebindingForQuantifier.getArguments());
		newGoal = newGoal.withProperty((KProperty) canonicalize(
				and(newGoal.property, quantifier.isUniversal() ? negate(newPredicate) : newPredicate)));
		return problem.withGoal(newGoal);
	}

	private static Binding rebind(List<String> vars, HashSet<String> usedVars) {
		MutableBinding binding = new MutableBinding();
		for (String var : vars) {
			String unusedVar = InputUtil.getUnusedVar(usedVars);
			binding.bind(var, unusedVar);
			break;
		}

		return binding.getImmutable();
	}

	/**
	 * Called when a problem group has been completed.
	 */
	private void catchProblemGroup(ProblemGroup problemGroup) {
		if (problemGroup.parentState != null) {
			problemGroup.parentState.solutionIndex = problemGroup.parentIndex;
			catchProblemState(problemGroup.parentState);
		}
	}

	private void catchProblemState(ProblemState problemState) {
		if (!solvedProblems.containsKey(problemState.problem))
			solvedProblems.put(problemState.problem, problemState);

		if (problemState.parentIndex == problemState.parentGroup.childStates.size() - 1) {
			catchProblemGroup(problemState.parentGroup);
		} else {
			addProblemState(problemState.parentGroup.childStates.get(problemState.parentIndex + 1));
		}
	}

	private void addProblemState(ProblemState problemState) {
		if (!problemState.isSolvable())
			return;

		if (solvedProblems.containsKey(problemState.problem))
			catchProblemState(problemState);
		else
			problemStates.add(problemState);
	}

	private void addProblemGroup(ProblemGroup problemGroup) {
		addProblemState(problemGroup.childStates.get(0));
	}

	// private ProblemState getRootSolvedState(KInput enumerationProblem) {
	// ProblemState head = subSolvers.get(enumerationProblem).solved;
	// while (head.parentState != null) {
	// head.parentState.childGroups = Collections.singletonList(head);
	// head = head.parentState;
	// }
	// return head.childGroups.get(0);
	// }

	// public static String runWebSolver(String[] problemString) {
	// return
	// ProblemState.getOutputString(runSolver(problemString[0]).getSolution());
	// }

	public static ProblemSolver runSolver(String problemString) {
		ArrayList<KTheorem> theorems = TheoremParser.parseFiles();
		theorems.addAll(MultiTheoremParser.getMultiTheorems());
		ProblemSolver ret = new ProblemSolver((KInput) convertToKernel(QuickParser.parseInput(problemString)),
				theorems.toArray(new KTheorem[0]));
		ret.getSolution();
		return ret;
	}

	public static void main(String[] args) {
		ArrayList<KTheorem> theorems = TheoremParser.parseFiles();
		theorems.addAll(MultiTheoremParser.getMultiTheorems());
		System.out.println("GIMME A PROBLEM!");
		Scanner s = new Scanner(System.in);
		while (true) {
			String problemString = s.nextLine();
			if (problemString.equalsIgnoreCase("exit")) {
				s.close();
				System.exit(0);
			}
			if (problemString.length() < 4)
				continue;
			KInput input = (KInput) convertToKernel(QuickParser.parseInput(problemString));
			ProblemSolver solver = new ProblemSolver(input, theorems.toArray(new KTheorem[0]));
			ProblemState solution = solver.getSolution();
			if (solution == null) {
				System.out.println("I couldn't solve your problem. You'll have to find a better robot :-(");
				System.out.println("This is as far as I got:");
				solver.initialProblem.printSolutionContents(0);
			} else {
				solution.parentGroup.printSolutionContents(0);
				System.out.println("\n" + ProblemState.getOutputString(solution.parentGroup, problemString));
			}
			if (SHOW_GRAPH)
				Viewer.displaySolverResults(solver, true);

			System.out.println("HIT ME WITH ANOTHER ONE!");
		}
	}
}
