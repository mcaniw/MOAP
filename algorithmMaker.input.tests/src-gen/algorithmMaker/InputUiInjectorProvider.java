/*
 * generated by Xtext
 */
package algorithmMaker;

import org.eclipse.xtext.junit4.IInjectorProvider;

import com.google.inject.Injector;

public class InputUiInjectorProvider implements IInjectorProvider {
	
	@Override
	public Injector getInjector() {
		return algorithmMaker.ui.internal.InputActivator.getInstance().getInjector("algorithmMaker.Input");
	}
	
}
