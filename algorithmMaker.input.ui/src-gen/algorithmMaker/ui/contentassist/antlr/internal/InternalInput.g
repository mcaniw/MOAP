/*
 * generated by Xtext
 */
grammar InternalInput;

options {
	superClass=AbstractInternalContentAssistParser;
	
}

@lexer::header {
package algorithmMaker.ui.contentassist.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.ui.editor.contentassist.antlr.internal.Lexer;
}

@parser::header {
package algorithmMaker.ui.contentassist.antlr.internal; 

import java.io.InputStream;
import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.ui.editor.contentassist.antlr.internal.AbstractInternalContentAssistParser;
import org.eclipse.xtext.ui.editor.contentassist.antlr.internal.DFA;
import algorithmMaker.services.InputGrammarAccess;

}

@parser::members {
 
 	private InputGrammarAccess grammarAccess;
 	
    public void setGrammarAccess(InputGrammarAccess grammarAccess) {
    	this.grammarAccess = grammarAccess;
    }
    
    @Override
    protected Grammar getGrammar() {
    	return grammarAccess.getGrammar();
    }
    
    @Override
    protected String getValueForTokenName(String tokenName) {
    	return tokenName;
    }

}




// Entry rule entryRuleInput
entryRuleInput 
:
{ before(grammarAccess.getInputRule()); }
	 ruleInput
{ after(grammarAccess.getInputRule()); } 
	 EOF 
;

// Rule Input
ruleInput
    @init {
		int stackSize = keepStackSize();
    }
	:
(
{ before(grammarAccess.getInputAccess().getGroup()); }
(rule__Input__Group__0)
{ after(grammarAccess.getInputAccess().getGroup()); }
)

;
finally {
	restoreStackSize(stackSize);
}



// Entry rule entryRuleProblem
entryRuleProblem 
:
{ before(grammarAccess.getProblemRule()); }
	 ruleProblem
{ after(grammarAccess.getProblemRule()); } 
	 EOF 
;

// Rule Problem
ruleProblem
    @init {
		int stackSize = keepStackSize();
    }
	:
(
{ before(grammarAccess.getProblemAccess().getGroup()); }
(rule__Problem__Group__0)
{ after(grammarAccess.getProblemAccess().getGroup()); }
)

;
finally {
	restoreStackSize(stackSize);
}



// Entry rule entryRuleORing
entryRuleORing 
:
{ before(grammarAccess.getORingRule()); }
	 ruleORing
{ after(grammarAccess.getORingRule()); } 
	 EOF 
;

// Rule ORing
ruleORing
    @init {
		int stackSize = keepStackSize();
    }
	:
(
{ before(grammarAccess.getORingAccess().getGroup()); }
(rule__ORing__Group__0)
{ after(grammarAccess.getORingAccess().getGroup()); }
)

;
finally {
	restoreStackSize(stackSize);
}



// Entry rule entryRuleANDing
entryRuleANDing 
:
{ before(grammarAccess.getANDingRule()); }
	 ruleANDing
{ after(grammarAccess.getANDingRule()); } 
	 EOF 
;

// Rule ANDing
ruleANDing
    @init {
		int stackSize = keepStackSize();
    }
	:
(
{ before(grammarAccess.getANDingAccess().getGroup()); }
(rule__ANDing__Group__0)
{ after(grammarAccess.getANDingAccess().getGroup()); }
)

;
finally {
	restoreStackSize(stackSize);
}



// Entry rule entryRulePrimary
entryRulePrimary 
:
{ before(grammarAccess.getPrimaryRule()); }
	 rulePrimary
{ after(grammarAccess.getPrimaryRule()); } 
	 EOF 
;

// Rule Primary
rulePrimary
    @init {
		int stackSize = keepStackSize();
    }
	:
(
{ before(grammarAccess.getPrimaryAccess().getAlternatives()); }
(rule__Primary__Alternatives)
{ after(grammarAccess.getPrimaryAccess().getAlternatives()); }
)

;
finally {
	restoreStackSize(stackSize);
}



// Entry rule entryRuleQuantifier
entryRuleQuantifier 
:
{ before(grammarAccess.getQuantifierRule()); }
	 ruleQuantifier
{ after(grammarAccess.getQuantifierRule()); } 
	 EOF 
;

// Rule Quantifier
ruleQuantifier
    @init {
		int stackSize = keepStackSize();
    }
	:
(
{ before(grammarAccess.getQuantifierAccess().getGroup()); }
(rule__Quantifier__Group__0)
{ after(grammarAccess.getQuantifierAccess().getGroup()); }
)

;
finally {
	restoreStackSize(stackSize);
}



// Entry rule entryRuleAtomic
entryRuleAtomic 
:
{ before(grammarAccess.getAtomicRule()); }
	 ruleAtomic
{ after(grammarAccess.getAtomicRule()); } 
	 EOF 
;

// Rule Atomic
ruleAtomic
    @init {
		int stackSize = keepStackSize();
    }
	:
(
{ before(grammarAccess.getAtomicAccess().getGroup()); }
(rule__Atomic__Group__0)
{ after(grammarAccess.getAtomicAccess().getGroup()); }
)

;
finally {
	restoreStackSize(stackSize);
}



// Entry rule entryRuleTheorem
entryRuleTheorem 
:
{ before(grammarAccess.getTheoremRule()); }
	 ruleTheorem
{ after(grammarAccess.getTheoremRule()); } 
	 EOF 
;

// Rule Theorem
ruleTheorem
    @init {
		int stackSize = keepStackSize();
    }
	:
(
{ before(grammarAccess.getTheoremAccess().getGroup()); }
(rule__Theorem__Group__0)
{ after(grammarAccess.getTheoremAccess().getGroup()); }
)

;
finally {
	restoreStackSize(stackSize);
}




rule__Primary__Alternatives
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getPrimaryAccess().getAtomicParserRuleCall_0()); }
	ruleAtomic
{ after(grammarAccess.getPrimaryAccess().getAtomicParserRuleCall_0()); }
)

    |(
{ before(grammarAccess.getPrimaryAccess().getQuantifierParserRuleCall_1()); }
	ruleQuantifier
{ after(grammarAccess.getPrimaryAccess().getQuantifierParserRuleCall_1()); }
)

    |(
{ before(grammarAccess.getPrimaryAccess().getGroup_2()); }
(rule__Primary__Group_2__0)
{ after(grammarAccess.getPrimaryAccess().getGroup_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__QuantifierAlternatives_0_0
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getQuantifierForallKeyword_0_0_0()); }

	'forall' 

{ after(grammarAccess.getQuantifierAccess().getQuantifierForallKeyword_0_0_0()); }
)

    |(
{ before(grammarAccess.getQuantifierAccess().getQuantifierExistsKeyword_0_0_1()); }

	'exists' 

{ after(grammarAccess.getQuantifierAccess().getQuantifierExistsKeyword_0_0_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}



rule__Input__Group__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group__0__Impl
	rule__Input__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getGivenKeyword_0()); }

	'Given' 

{ after(grammarAccess.getInputAccess().getGivenKeyword_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group__1__Impl
	rule__Input__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getGivenAssignment_1()); }
(rule__Input__GivenAssignment_1)
{ after(grammarAccess.getInputAccess().getGivenAssignment_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group__2
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group__2__Impl
	rule__Input__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group__2__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getCommaKeyword_2()); }

	',' 

{ after(grammarAccess.getInputAccess().getCommaKeyword_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group__3
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group__3__Impl
	rule__Input__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group__3__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getFindKeyword_3()); }

	'Find' 

{ after(grammarAccess.getInputAccess().getFindKeyword_3()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group__4
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group__4__Impl
	rule__Input__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group__4__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getGoalAssignment_4()); }
(rule__Input__GoalAssignment_4)
{ after(grammarAccess.getInputAccess().getGoalAssignment_4()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group__5
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group__5__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group__5__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getGroup_5()); }
(rule__Input__Group_5__0)?
{ after(grammarAccess.getInputAccess().getGroup_5()); }
)

;
finally {
	restoreStackSize(stackSize);
}














rule__Input__Group_5__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group_5__0__Impl
	rule__Input__Group_5__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group_5__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getSemicolonKeyword_5_0()); }

	';' 

{ after(grammarAccess.getInputAccess().getSemicolonKeyword_5_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group_5__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group_5__1__Impl
	rule__Input__Group_5__2
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group_5__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getTheoremsKeyword_5_1()); }

	'Theorems:' 

{ after(grammarAccess.getInputAccess().getTheoremsKeyword_5_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group_5__2
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group_5__2__Impl
	rule__Input__Group_5__3
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group_5__2__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getTheoremsAssignment_5_2()); }
(rule__Input__TheoremsAssignment_5_2)
{ after(grammarAccess.getInputAccess().getTheoremsAssignment_5_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group_5__3
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group_5__3__Impl
	rule__Input__Group_5__4
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group_5__3__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getGroup_5_3()); }
(rule__Input__Group_5_3__0)*
{ after(grammarAccess.getInputAccess().getGroup_5_3()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group_5__4
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group_5__4__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group_5__4__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getSemicolonKeyword_5_4()); }
(
	';' 
)?
{ after(grammarAccess.getInputAccess().getSemicolonKeyword_5_4()); }
)

;
finally {
	restoreStackSize(stackSize);
}












rule__Input__Group_5_3__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group_5_3__0__Impl
	rule__Input__Group_5_3__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group_5_3__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getSemicolonKeyword_5_3_0()); }

	';' 

{ after(grammarAccess.getInputAccess().getSemicolonKeyword_5_3_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Input__Group_5_3__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Input__Group_5_3__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Input__Group_5_3__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getTheoremsAssignment_5_3_1()); }
(rule__Input__TheoremsAssignment_5_3_1)
{ after(grammarAccess.getInputAccess().getTheoremsAssignment_5_3_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}






rule__Problem__Group__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Problem__Group__0__Impl
	rule__Problem__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__Group__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getGroup_0()); }
(rule__Problem__Group_0__0)
{ after(grammarAccess.getProblemAccess().getGroup_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Problem__Group__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Problem__Group__1__Impl
	rule__Problem__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__Group__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getStKeyword_1()); }

	'st' 

{ after(grammarAccess.getProblemAccess().getStKeyword_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Problem__Group__2
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Problem__Group__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__Group__2__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getPropertyAssignment_2()); }
(rule__Problem__PropertyAssignment_2)
{ after(grammarAccess.getProblemAccess().getPropertyAssignment_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}








rule__Problem__Group_0__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Problem__Group_0__0__Impl
	rule__Problem__Group_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__Group_0__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getVarsAssignment_0_0()); }
(rule__Problem__VarsAssignment_0_0)
{ after(grammarAccess.getProblemAccess().getVarsAssignment_0_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Problem__Group_0__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Problem__Group_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__Group_0__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getGroup_0_1()); }
(rule__Problem__Group_0_1__0)*
{ after(grammarAccess.getProblemAccess().getGroup_0_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}






rule__Problem__Group_0_1__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Problem__Group_0_1__0__Impl
	rule__Problem__Group_0_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__Group_0_1__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getCommaKeyword_0_1_0()); }

	',' 

{ after(grammarAccess.getProblemAccess().getCommaKeyword_0_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Problem__Group_0_1__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Problem__Group_0_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__Group_0_1__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getVarsAssignment_0_1_1()); }
(rule__Problem__VarsAssignment_0_1_1)
{ after(grammarAccess.getProblemAccess().getVarsAssignment_0_1_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}






rule__ORing__Group__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ORing__Group__0__Impl
	rule__ORing__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__ORing__Group__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getORingAccess().getANDingParserRuleCall_0()); }
	ruleANDing
{ after(grammarAccess.getORingAccess().getANDingParserRuleCall_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__ORing__Group__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ORing__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__ORing__Group__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getORingAccess().getGroup_1()); }
(rule__ORing__Group_1__0)*
{ after(grammarAccess.getORingAccess().getGroup_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}






rule__ORing__Group_1__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ORing__Group_1__0__Impl
	rule__ORing__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__ORing__Group_1__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getORingAccess().getORingLeftAction_1_0()); }
(

)
{ after(grammarAccess.getORingAccess().getORingLeftAction_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__ORing__Group_1__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ORing__Group_1__1__Impl
	rule__ORing__Group_1__2
;
finally {
	restoreStackSize(stackSize);
}

rule__ORing__Group_1__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getORingAccess().getVerticalLineKeyword_1_1()); }

	'|' 

{ after(grammarAccess.getORingAccess().getVerticalLineKeyword_1_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__ORing__Group_1__2
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ORing__Group_1__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__ORing__Group_1__2__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getORingAccess().getRightAssignment_1_2()); }
(rule__ORing__RightAssignment_1_2)
{ after(grammarAccess.getORingAccess().getRightAssignment_1_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}








rule__ANDing__Group__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ANDing__Group__0__Impl
	rule__ANDing__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__ANDing__Group__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getANDingAccess().getPrimaryParserRuleCall_0()); }
	rulePrimary
{ after(grammarAccess.getANDingAccess().getPrimaryParserRuleCall_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__ANDing__Group__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ANDing__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__ANDing__Group__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getANDingAccess().getGroup_1()); }
(rule__ANDing__Group_1__0)*
{ after(grammarAccess.getANDingAccess().getGroup_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}






rule__ANDing__Group_1__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ANDing__Group_1__0__Impl
	rule__ANDing__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__ANDing__Group_1__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getANDingAccess().getANDingLeftAction_1_0()); }
(

)
{ after(grammarAccess.getANDingAccess().getANDingLeftAction_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__ANDing__Group_1__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ANDing__Group_1__1__Impl
	rule__ANDing__Group_1__2
;
finally {
	restoreStackSize(stackSize);
}

rule__ANDing__Group_1__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getANDingAccess().getAmpersandKeyword_1_1()); }

	'&' 

{ after(grammarAccess.getANDingAccess().getAmpersandKeyword_1_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__ANDing__Group_1__2
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__ANDing__Group_1__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__ANDing__Group_1__2__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getANDingAccess().getRightAssignment_1_2()); }
(rule__ANDing__RightAssignment_1_2)
{ after(grammarAccess.getANDingAccess().getRightAssignment_1_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}








rule__Primary__Group_2__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Primary__Group_2__0__Impl
	rule__Primary__Group_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Primary__Group_2__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getPrimaryAccess().getLeftParenthesisKeyword_2_0()); }

	'(' 

{ after(grammarAccess.getPrimaryAccess().getLeftParenthesisKeyword_2_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Primary__Group_2__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Primary__Group_2__1__Impl
	rule__Primary__Group_2__2
;
finally {
	restoreStackSize(stackSize);
}

rule__Primary__Group_2__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getPrimaryAccess().getORingParserRuleCall_2_1()); }
	ruleORing
{ after(grammarAccess.getPrimaryAccess().getORingParserRuleCall_2_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Primary__Group_2__2
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Primary__Group_2__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Primary__Group_2__2__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getPrimaryAccess().getRightParenthesisKeyword_2_2()); }

	')' 

{ after(grammarAccess.getPrimaryAccess().getRightParenthesisKeyword_2_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}








rule__Quantifier__Group__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Quantifier__Group__0__Impl
	rule__Quantifier__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__Group__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getQuantifierAssignment_0()); }
(rule__Quantifier__QuantifierAssignment_0)
{ after(grammarAccess.getQuantifierAccess().getQuantifierAssignment_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Quantifier__Group__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Quantifier__Group__1__Impl
	rule__Quantifier__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__Group__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getLeftParenthesisKeyword_1()); }

	'(' 

{ after(grammarAccess.getQuantifierAccess().getLeftParenthesisKeyword_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Quantifier__Group__2
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Quantifier__Group__2__Impl
	rule__Quantifier__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__Group__2__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getSubjectAssignment_2()); }
(rule__Quantifier__SubjectAssignment_2)
{ after(grammarAccess.getQuantifierAccess().getSubjectAssignment_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Quantifier__Group__3
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Quantifier__Group__3__Impl
	rule__Quantifier__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__Group__3__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getColonKeyword_3()); }

	':' 

{ after(grammarAccess.getQuantifierAccess().getColonKeyword_3()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Quantifier__Group__4
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Quantifier__Group__4__Impl
	rule__Quantifier__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__Group__4__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getPredicateAssignment_4()); }
(rule__Quantifier__PredicateAssignment_4)
{ after(grammarAccess.getQuantifierAccess().getPredicateAssignment_4()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Quantifier__Group__5
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Quantifier__Group__5__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__Group__5__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getRightParenthesisKeyword_5()); }

	')' 

{ after(grammarAccess.getQuantifierAccess().getRightParenthesisKeyword_5()); }
)

;
finally {
	restoreStackSize(stackSize);
}














rule__Atomic__Group__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Atomic__Group__0__Impl
	rule__Atomic__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__Group__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getFunctionAssignment_0()); }
(rule__Atomic__FunctionAssignment_0)
{ after(grammarAccess.getAtomicAccess().getFunctionAssignment_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Atomic__Group__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Atomic__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__Group__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getGroup_1()); }
(rule__Atomic__Group_1__0)?
{ after(grammarAccess.getAtomicAccess().getGroup_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}






rule__Atomic__Group_1__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Atomic__Group_1__0__Impl
	rule__Atomic__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__Group_1__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getLeftParenthesisKeyword_1_0()); }

	'(' 

{ after(grammarAccess.getAtomicAccess().getLeftParenthesisKeyword_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Atomic__Group_1__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Atomic__Group_1__1__Impl
	rule__Atomic__Group_1__2
;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__Group_1__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getGroup_1_1()); }
(rule__Atomic__Group_1_1__0)?
{ after(grammarAccess.getAtomicAccess().getGroup_1_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Atomic__Group_1__2
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Atomic__Group_1__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__Group_1__2__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getRightParenthesisKeyword_1_2()); }

	')' 

{ after(grammarAccess.getAtomicAccess().getRightParenthesisKeyword_1_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}








rule__Atomic__Group_1_1__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Atomic__Group_1_1__0__Impl
	rule__Atomic__Group_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__Group_1_1__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getArgsAssignment_1_1_0()); }
(rule__Atomic__ArgsAssignment_1_1_0)
{ after(grammarAccess.getAtomicAccess().getArgsAssignment_1_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Atomic__Group_1_1__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Atomic__Group_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__Group_1_1__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getGroup_1_1_1()); }
(rule__Atomic__Group_1_1_1__0)*
{ after(grammarAccess.getAtomicAccess().getGroup_1_1_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}






rule__Atomic__Group_1_1_1__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Atomic__Group_1_1_1__0__Impl
	rule__Atomic__Group_1_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__Group_1_1_1__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getCommaKeyword_1_1_1_0()); }

	',' 

{ after(grammarAccess.getAtomicAccess().getCommaKeyword_1_1_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Atomic__Group_1_1_1__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Atomic__Group_1_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__Group_1_1_1__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getArgsAssignment_1_1_1_1()); }
(rule__Atomic__ArgsAssignment_1_1_1_1)
{ after(grammarAccess.getAtomicAccess().getArgsAssignment_1_1_1_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}






rule__Theorem__Group__0
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Theorem__Group__0__Impl
	rule__Theorem__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__Group__0__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getRequirementAssignment_0()); }
(rule__Theorem__RequirementAssignment_0)
{ after(grammarAccess.getTheoremAccess().getRequirementAssignment_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Theorem__Group__1
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Theorem__Group__1__Impl
	rule__Theorem__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__Group__1__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getColonHyphenMinusKeyword_1()); }

	':-' 

{ after(grammarAccess.getTheoremAccess().getColonHyphenMinusKeyword_1()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Theorem__Group__2
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Theorem__Group__2__Impl
	rule__Theorem__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__Group__2__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getResultAssignment_2()); }
(rule__Theorem__ResultAssignment_2)
{ after(grammarAccess.getTheoremAccess().getResultAssignment_2()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Theorem__Group__3
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Theorem__Group__3__Impl
	rule__Theorem__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__Group__3__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getCommaKeyword_3()); }

	',' 

{ after(grammarAccess.getTheoremAccess().getCommaKeyword_3()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Theorem__Group__4
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Theorem__Group__4__Impl
	rule__Theorem__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__Group__4__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getCostAssignment_4()); }
(rule__Theorem__CostAssignment_4)
{ after(grammarAccess.getTheoremAccess().getCostAssignment_4()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Theorem__Group__5
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Theorem__Group__5__Impl
	rule__Theorem__Group__6
;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__Group__5__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getCommaKeyword_5()); }

	',' 

{ after(grammarAccess.getTheoremAccess().getCommaKeyword_5()); }
)

;
finally {
	restoreStackSize(stackSize);
}


rule__Theorem__Group__6
    @init {
		int stackSize = keepStackSize();
    }
:
	rule__Theorem__Group__6__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__Group__6__Impl
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getDescriptionAssignment_6()); }
(rule__Theorem__DescriptionAssignment_6)
{ after(grammarAccess.getTheoremAccess().getDescriptionAssignment_6()); }
)

;
finally {
	restoreStackSize(stackSize);
}

















rule__Input__GivenAssignment_1
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getGivenProblemParserRuleCall_1_0()); }
	ruleProblem{ after(grammarAccess.getInputAccess().getGivenProblemParserRuleCall_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Input__GoalAssignment_4
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getGoalProblemParserRuleCall_4_0()); }
	ruleProblem{ after(grammarAccess.getInputAccess().getGoalProblemParserRuleCall_4_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Input__TheoremsAssignment_5_2
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getTheoremsTheoremParserRuleCall_5_2_0()); }
	ruleTheorem{ after(grammarAccess.getInputAccess().getTheoremsTheoremParserRuleCall_5_2_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Input__TheoremsAssignment_5_3_1
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getInputAccess().getTheoremsTheoremParserRuleCall_5_3_1_0()); }
	ruleTheorem{ after(grammarAccess.getInputAccess().getTheoremsTheoremParserRuleCall_5_3_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__VarsAssignment_0_0
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getVarsIDTerminalRuleCall_0_0_0()); }
	RULE_ID{ after(grammarAccess.getProblemAccess().getVarsIDTerminalRuleCall_0_0_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__VarsAssignment_0_1_1
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getVarsIDTerminalRuleCall_0_1_1_0()); }
	RULE_ID{ after(grammarAccess.getProblemAccess().getVarsIDTerminalRuleCall_0_1_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Problem__PropertyAssignment_2
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getProblemAccess().getPropertyORingParserRuleCall_2_0()); }
	ruleORing{ after(grammarAccess.getProblemAccess().getPropertyORingParserRuleCall_2_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__ORing__RightAssignment_1_2
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getORingAccess().getRightANDingParserRuleCall_1_2_0()); }
	ruleANDing{ after(grammarAccess.getORingAccess().getRightANDingParserRuleCall_1_2_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__ANDing__RightAssignment_1_2
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getANDingAccess().getRightPrimaryParserRuleCall_1_2_0()); }
	rulePrimary{ after(grammarAccess.getANDingAccess().getRightPrimaryParserRuleCall_1_2_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__QuantifierAssignment_0
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getQuantifierAlternatives_0_0()); }
(rule__Quantifier__QuantifierAlternatives_0_0)
{ after(grammarAccess.getQuantifierAccess().getQuantifierAlternatives_0_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__SubjectAssignment_2
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getSubjectProblemParserRuleCall_2_0()); }
	ruleProblem{ after(grammarAccess.getQuantifierAccess().getSubjectProblemParserRuleCall_2_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Quantifier__PredicateAssignment_4
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getQuantifierAccess().getPredicateORingParserRuleCall_4_0()); }
	ruleORing{ after(grammarAccess.getQuantifierAccess().getPredicateORingParserRuleCall_4_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__FunctionAssignment_0
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getFunctionIDTerminalRuleCall_0_0()); }
	RULE_ID{ after(grammarAccess.getAtomicAccess().getFunctionIDTerminalRuleCall_0_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__ArgsAssignment_1_1_0
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getArgsIDTerminalRuleCall_1_1_0_0()); }
	RULE_ID{ after(grammarAccess.getAtomicAccess().getArgsIDTerminalRuleCall_1_1_0_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Atomic__ArgsAssignment_1_1_1_1
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getAtomicAccess().getArgsIDTerminalRuleCall_1_1_1_1_0()); }
	RULE_ID{ after(grammarAccess.getAtomicAccess().getArgsIDTerminalRuleCall_1_1_1_1_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__RequirementAssignment_0
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getRequirementORingParserRuleCall_0_0()); }
	ruleORing{ after(grammarAccess.getTheoremAccess().getRequirementORingParserRuleCall_0_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__ResultAssignment_2
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getResultORingParserRuleCall_2_0()); }
	ruleORing{ after(grammarAccess.getTheoremAccess().getResultORingParserRuleCall_2_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__CostAssignment_4
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getCostINTTerminalRuleCall_4_0()); }
	RULE_INT{ after(grammarAccess.getTheoremAccess().getCostINTTerminalRuleCall_4_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}

rule__Theorem__DescriptionAssignment_6
    @init {
		int stackSize = keepStackSize();
    }
:
(
{ before(grammarAccess.getTheoremAccess().getDescriptionSTRINGTerminalRuleCall_6_0()); }
	RULE_STRING{ after(grammarAccess.getTheoremAccess().getDescriptionSTRINGTerminalRuleCall_6_0()); }
)

;
finally {
	restoreStackSize(stackSize);
}


RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*;

RULE_INT : ('0'..'9')+;

RULE_STRING : ('"' ('\\' .|~(('\\'|'"')))* '"'|'\'' ('\\' .|~(('\\'|'\'')))* '\'');

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

RULE_ANY_OTHER : .;


