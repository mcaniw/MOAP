import static kernelLanguage.KernelFactory.*;
import static algorithmMaker.util.KernelUtil.*;
import static org.junit.Assert.*;
import kernelLanguage.KInput;

import org.junit.Test;

import solver.Chainer;
import theorems.MultistageTheorem;
import algorithmMaker.util.InputUtil;

public class ChainerTests {

	@Test
	public void testForFalsePositives() {
		Chainer basicChainer = new Chainer(parseTheorem("a(x)->b(x),0,\"GIVEN\""));
		basicChainer.chain(parseProperty("a(y)"), GIVEN);
		assertTrue("No false positives", !basicChainer.hasProperty(parseProperty("b(x)")));
		assertTrue("No false positives", !basicChainer.hasProperty(parseProperty("c(x)")));
		assertTrue("No false positives", !basicChainer.hasProperty(parseProperty("c(y)")));
	}

	@Test
	public void testBasicChainer() {
		Chainer basicChainer = new Chainer(parseTheorem("a(x)->b(x),0,\"GIVEN\""));
		basicChainer.chain(parseProperty("a(y)"), GIVEN);
		assertTrue("Chainer can accept assertions", basicChainer.hasProperty(parseProperty("a(y)")));
		assertTrue("Basic chaining works", basicChainer.hasProperty(parseProperty("b(y)")));
	}

	@Test
	public void testAndResultChainer() {
		Chainer basicChainer = new Chainer(parseTheorem("a(x)->b(x)&c(x),0,\"GIVEN\""));
		basicChainer.chain(parseProperty("a(x)"), GIVEN);
		assertTrue("Chainer can chain ANDed results", basicChainer.hasProperty(parseProperty("b(x)")));
		assertTrue("Chainer can chain ANDed results", basicChainer.hasProperty(parseProperty("c(x)")));
	}

	@Test
	public void testAndRequirementChainer() {
		Chainer basicChainer = new Chainer(parseTheorem("a(x)&b(x)->c(x),0,\"GIVEN\""));
		basicChainer.chain(parseProperty("a(x)"), GIVEN);
		basicChainer.chain(parseProperty("b(x)"), GIVEN);
		assertTrue("Chainer can chain ANDed requirements", basicChainer.hasProperty(parseProperty("c(x)")));
	}

	@Test
	public void testMultipleChaining() {
		Chainer basicChainer = new Chainer(parseTheorem("a(x)->b(x),0,\"GIVEN\""),
				parseTheorem("b(x)->c(x),0,\"GIVEN\""));
		basicChainer.chain(parseProperty("a(y)"), GIVEN);
		assertTrue("Multiple chaining works", basicChainer.hasProperty(parseProperty("c(y)")));
	}

	@Test
	public void testMultivarChaining() {
		Chainer basicChainer = new Chainer(parseTheorem("a(x,y)&b(y,z)->c(x,z),0,\"GIVEN\""));
		basicChainer.chain(parseProperty("a(d,e)"), GIVEN);
		basicChainer.chain(parseProperty("b(e,f)"), GIVEN);
		assertTrue("Multiple variable chaining works", basicChainer.hasProperty(parseProperty("c(d,f)")));
	}

	@Test
	public void testForTypeChaining() {
		Chainer basicChainer = new Chainer(parseTheorem(TYPE_MARKER + "hashset(x)->something(x),0,\"GIVEN\""));
		basicChainer.chain(parseInput("Given hashset x; Find y st nothing(y)").given.property, GIVEN);
		assertTrue("Type properties are properly chained", basicChainer.hasProperty(parseProperty("something(x)")));
	}

	@Test
	public void testForMultipleTypeChaining() {
		Chainer basicChainer = new Chainer(parseTheorem(TYPE_MARKER + "hashset(x)->something(x),0,\"GIVEN\""));
		basicChainer.chain(parseInput("Given hashset x, hashset z; Find y st nothing(x,z,y)").given.property, GIVEN);
		assertTrue("Type properties are properly chained", basicChainer.hasProperty(parseProperty("something(x)")));
		assertTrue("Type properties are properly chained", basicChainer.hasProperty(parseProperty("something(z)")));
	}

	@Test
	public void testForMultistageMultipleOptions() {
		Chainer chainer = new Chainer(new MultistageTheorem(
				parseProperty(BOUND + "(y) & " + TYPE_MARKER + "hashset(x)"), parseProperty("child(x,y)"),
				parseProperty("child(x,y)"), null, 0, "enumerable things", null));
		KInput input = parseInput("Given hashset x, hashset z; Find y st child(x,y)");
		chainer.addBoundVars(input.given.vars.toArray(new String[0]));
		chainer.chain(input.given.property, GIVEN);
		assertEquals(4, chainer.nextLevelTheorems.values().iterator().next().size());
	}

	@Test
	public void testMultistageChaining() {
		MultistageTheorem multiTheorem = new MultistageTheorem(parseProperty("enumerable(x)"),
				parseProperty("child(x,y)"), parseProperty("child(x,y)"), null, 0, "enumerable things", null);
		Chainer stage1Chainer = new Chainer(multiTheorem);
		stage1Chainer.chain(parseProperty("enumerable(a)"), GIVEN);
		assertTrue("Stage 1 of multichaining works", stage1Chainer.nextLevelTheorems.size() == 1);
		Chainer stage2Chainer = new Chainer(false, multiTheorem);
		stage2Chainer.previousLevelTheorems = stage1Chainer.nextLevelTheorems;
		stage2Chainer.chain(parseProperty("child(a,b)"), GIVEN);
		assertTrue("Stage 2 of multichaining works", stage2Chainer.nextLevelTheorems.size() == 1);
	}

	@Test
	public void testBasicPrerequisites() {
		Chainer basicChainer = new Chainer(parseTheorem("a(x)->b(x),0,\"GIVEN\""));
		basicChainer.chain(parseProperty("a(x)"), GIVEN);
		assertTrue("Fact recording works", basicChainer.getProperty(parseProperty("b(x)")).prerequisites.length == 1);
	}

	@Test
	public void testBoundVariableDetection() {
		Chainer basicChainer = new Chainer(parseTheorem(InputUtil.BOUND + "(x)&a(x)->b(x),0,\"GIVEN\""));
		basicChainer.addBoundVars("q");
		basicChainer.chain(parseProperty("a(q)"), GIVEN);
		assertTrue(basicChainer.hasProperty(parseProperty("b(q)")));
	}

	@Test
	public void testMultipleOfSameAtomicRequirement() {
		Chainer basicChainer = new Chainer(parseTheorem("a(x)&a(y)->b(x,y),0,\"GIVEN\""));
		basicChainer.chain(parseProperty("a(a)"), GIVEN);
		basicChainer.chain(parseProperty("a(b)"), GIVEN);
		assertTrue(basicChainer.hasProperty(parseProperty("b(a,a)")));
		assertTrue(basicChainer.hasProperty(parseProperty("b(a,b)")));
		assertTrue(basicChainer.hasProperty(parseProperty("b(b,a)")));
		assertTrue(basicChainer.hasProperty(parseProperty("b(b,b)")));
	}

	@Test
	public void testBindingNormalMix() {
		Chainer basicChainer = new Chainer(parseTheorem(InputUtil.BOUND + "(x)&a(y)->b(x,y),0,\"GIVEN\""));
		basicChainer.addBoundVars("q");
		basicChainer.chain(parseProperty("a(w)"), GIVEN);
		assertTrue(basicChainer.hasProperty(parseProperty("b(q,w)")));
	}

	@Test
	public void testEqualityChaining() {
		Chainer basicChainer = new Chainer();
		basicChainer.chain(parseProperty(InputUtil.EQUAL + "(x,y)"), GIVEN);
		basicChainer.chain(parseProperty(InputUtil.EQUAL + "(y,z)"), GIVEN);
		basicChainer.chain(parseProperty(InputUtil.EQUAL + "(z,a)"), GIVEN);
		basicChainer.chain(parseProperty(InputUtil.EQUAL + "(a,b)"), GIVEN);
		basicChainer.chain(parseProperty("a(x)"), GIVEN);
		assertTrue(basicChainer.hasProperty(parseProperty("a(b)")));
	}

	@Test
	public void testNegationChaining() {
		Chainer basicChainer = new Chainer(parseTheorem("!a(x)->b(x),0,\"GIVEN\""));
		basicChainer.chain(parseProperty("!a(q)"), GIVEN);
		assertTrue(basicChainer.hasProperty(parseProperty("b(q)")));
	}

	@Test
	public void testForBoundExclusion() {
		Chainer basicChainer = new Chainer(parseTheorem(BOUND + "(apb) & plus(a,b,apb)->something(apb)"));
		basicChainer.chain(parseProperty(BOUND + "(a)"), GIVEN);
		basicChainer.chain(parseProperty("plus(a,b,c)"), GIVEN);
		assertFalse(basicChainer.hasProperty(parseProperty("something(c)")));
	}

	@Test
	public void testForQuantifierAsTheorem() {
		{
			// One test for when the quantifier comes first
			Chainer basicChainer = new Chainer();
			basicChainer.chain(parseProperty("forall(x st aq(x) : bq(x))"), GIVEN);
			basicChainer.chain(parseProperty("aq(q)"), GIVEN);
			assertTrue(basicChainer.hasProperty(parseProperty("bq(q)")));
		}
		{
			// One test for when the quantifier comes second
			Chainer basicChainer = new Chainer();
			basicChainer.chain(parseProperty("aq(q)"), GIVEN);
			basicChainer.chain(parseProperty("forall(x st aq(x) : bq(x))"), GIVEN);
			assertTrue(basicChainer.hasProperty(parseProperty("bq(q)")));
		}
	}

	@Test
	public void testQuantifierChaining() {
		Chainer basicChainer = new Chainer(parseTheorem("c(y)->forall(x st a(x,y) : b(x,y)),0,GIVEN"));
		basicChainer.chain(parseProperty("c(y)"), GIVEN);
		assertTrue(basicChainer.propertiesByStructure.containsKey(devar(parseProperty("forall(q st a(q,y) : b(q,y))"))));
	}
}
