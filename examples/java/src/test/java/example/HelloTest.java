package example;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class HelloTest {
    @Test
    void greeting() {
        assertEquals("Hello World!", Hello.greeting());
    }
}
