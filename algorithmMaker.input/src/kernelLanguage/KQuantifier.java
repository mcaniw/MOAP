package kernelLanguage;

import static kernelLanguage.KernelFactory.*;

import java.util.HashSet;

import algorithmMaker.util.KernelUtil;

public class KQuantifier extends KProperty {
	public static enum Quantifier {
		forall, exists
	}

	public final Quantifier quantifier;
	public final KProblem subject;
	public final KProperty predicate;

	KQuantifier(Quantifier quantifier, KProblem subject, KProperty predicate) {
		this.quantifier = quantifier;
		this.subject = subject;
		this.predicate = predicate;
		HashSet<String> subjectVars = new HashSet<String>(subject.vars);
		if (KernelUtil.ERROR_ON_NESTED_VARS)
			for (KObject object : KernelUtil.contents(predicate))
				if (object instanceof KProblem)
					for (String var : ((KProblem) object).vars)
						if (subjectVars.contains(var))
							throw new IllegalKernelException("The variable \"" + var
									+ "\" was declared in both a quantifier subject and the predicate.");
	}

	@Override
	protected KProperty without(HashSet<KProperty> toRemove) {
		if(toRemove.contains(this))
			return TRUE;
		
		KProperty newSubjectProperty = subject.property.without(toRemove);
		if (newSubjectProperty.equals(TRUE) && quantifier == Quantifier.forall)
			return predicate;

		if (newSubjectProperty.equals(FALSE))
			return TRUE;
		

		return withSubject(subject.withProperty(newSubjectProperty));
	}

	public KQuantifier withSubject(KProblem newSubject) {
		return KernelFactory.quantifier(quantifier, newSubject, predicate);
	}

	public boolean isUniversal() {
		return quantifier.equals(Quantifier.forall);
	}

	@Override
	int calculateHashCode() {
		return (quantifier == Quantifier.forall ? 1 : -1) * subject.hashCode() * predicate.hashCode();
	}

	@Override
	String calculateToString() {
		StringBuffer ret = new StringBuffer();
		ret.append(quantifier);
		ret.append('(');
		ret.append(subject.toString());
		ret.append(" : ");
		ret.append(predicate.toString());
		ret.append(')');
		return ret.toString();
	}

	@Override
	public void validate() {
		subject.validate();
		predicate.validate();
		for (KObject subObject : KernelUtil.contents(predicate)) {
			if (subObject instanceof KProblem) {
				for (String otherVar : ((KProblem) subObject).vars) {
					if (subject.vars.contains(otherVar)) {
						throw new DirtyKernelException(
								"The variable " + otherVar + " was declared in both the given of \"" + this
										+ "\" and in \"" + subObject + "\", which is in the goal.");
					}
				}
			}
		}
	}
}