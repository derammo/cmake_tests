// initial test, discovered by jest via the .spec.ts suffix
import { greeting } from "./index.js";

test("greeting", () => {
	expect(greeting()).toBe("hello");
});

// deliberately failing, to show how a jest failure is reported
test("deliberate failure", () => {
	expect(greeting()).toBe("goodbye");
});
