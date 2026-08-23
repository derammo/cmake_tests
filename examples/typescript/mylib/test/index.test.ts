// initial test
// this file was generated via `make -f ../../cmake/setup.make typescript`
import { expect, test } from "vitest";

import { greeting } from "../src/index.js";

test("greeting", () => {
	expect(greeting()).toBe("hello");
});

// deliberately failing, to show how a vitest failure is reported
test("deliberate failure", () => {
	expect(greeting()).toBe("goodbye");
});
