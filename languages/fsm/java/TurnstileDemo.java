// Turnstile-specific, handwritten code
public class TurnstileDemo {
    public static void main(String [] args) {
	TurnstileHandler handler =
	    new TurnstileHandler();
	TurnstileStepper stepper =
	    new TurnstileStepper(handler);
	stepper.step(Input.ticket);
	stepper.step(Input.pass);
	stepper.step(Input.ticket);
	stepper.step(Input.pass);
	stepper.step(Input.ticket);
	stepper.step(Input.ticket);
	stepper.step(Input.pass);
	stepper.step(Input.pass);
	stepper.step(Input.ticket);
	stepper.step(Input.pass);
	stepper.step(Input.mute);
	stepper.step(Input.release);
	stepper.step(Input.ticket);
	stepper.step(Input.pass);
    }
}
