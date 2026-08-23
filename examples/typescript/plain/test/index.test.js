// initial test, discovered by `node --test`
import assert from "node:assert/strict";
import { test } from "node:test";

import { greeting } from "../index.js";

test("greeting", () => {
	assert.equal(greeting(), "hello");
});

// deliberately failing, to show how a node:test failure is reported
test("deliberate failure", () => {
	assert.equal(greeting(), "goodbye");
});
