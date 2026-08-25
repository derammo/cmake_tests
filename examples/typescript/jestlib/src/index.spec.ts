// initial test, discovered by jest via the .spec.ts suffix
import { greeting } from "./index.js";

test("greeting", () => {
	expect(greeting()).toBe("hello");
});

