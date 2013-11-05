// Turnstile-specific, handwritten code 
public class TurnstileHandler implements Handler<Action> {
    public void handle(Action a) {
	switch (a) {
	case collect : 
	    System.out.println("collect");
	    break;
	case alarm : 
	    System.out.println("alarm");
	    break;
	case eject : 
	    System.out.println("eject");
	    break;
	}
    }
}
