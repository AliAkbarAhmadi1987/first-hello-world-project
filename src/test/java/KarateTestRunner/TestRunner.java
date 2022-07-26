package KarateTestRunner;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

    @Karate.Test
    Karate runMyTest() {
        return Karate.run("classpath:features").tags("@Smoke");
    } 
}