package example;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class HelloTest {
    @Test
    void greeting() {
        assertEquals("Hello World!", Hello.greeting());
    }

    // deliberately failing, to show how a JUnit failure is reported
    @Test
    void deliberateFailure() {
        assertEquals("Goodbye World!", Hello.greeting());
    }
}
