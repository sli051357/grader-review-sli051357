import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test 
  public void testFilter() {
    List<String> input = Arrays.asList("sun", "moon", "star");
    List<String> expectedResult = Arrays.asList("moon");
    IsMoon isMoon = new IsMoon();
    assertEquals(expectedResult, ListExamples.filter(input, isMoon));
  }

  @Test 
  public void testFilter1() {
    List<String> input1 = Arrays.asList("sun", "moon", "star");
    List<String> expected1 = Arrays.asList("moon");

    List<String> input2 = Arrays.asList("sun", "moon", "moon", "star");
    List<String> expected2 = Arrays.asList("moon", "moon");

    IsMoon isMoon = new IsMoon();
    assertEquals(expected1, ListExamples.filter(input1, isMoon));
    assertEquals(expected2, ListExamples.filter(input2, isMoon));
  }
}
