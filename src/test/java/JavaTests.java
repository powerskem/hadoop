import static org.junit.Assert.assertEquals;
import org.junit.Test;
import java.lang.*;

public class JavaTests {

    @Test
    public void check_assertEquals() {
        assertEquals("TESTING_HOME not set",6,6);
    }

    @Test
    public void check_getEnv() {
        assertEquals("HADOOP_CONF_DIR not set","/home/hduser/hadoop/conf",System.getenv("HADOOP_CONF_DIR"));
    }

}
