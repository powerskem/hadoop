import static org.junit.Assert.assertEquals;
import org.junit.Test;
import java.lang.*;

public class JavaTests {

    @Test
    public void checkEnvVars() {
        // Check the currently set env vars against the preferred ones in pom.xml
        // These should be set in .hadooprc and sourced in ~hduser/.bashrc
        assertEquals("HADOOP_HOME not set",
            System.getenv("pref_HADOOP_HOME"),
            System.getenv("HADOOP_HOME"));
        assertEquals("YARN_CONF_DIR not set",
            System.getenv("pref_YARN_CONF_DIR"),
            System.getenv("YARN_CONF_DIR"));
        assertEquals("HADOOP_CONF_DIR not set",
            System.getenv("pref_HADOOP_CONF_DIR"),
            System.getenv("HADOOP_CONF_DIR"));
        assertEquals("HADOOP_COMMON_HOME not set",
            System.getenv("pref_HADOOP_COMMON_HOME"),
            System.getenv("HADOOP_COMMON_HOME"));
        assertEquals("HADOOP_HDFS_HOME not set",
            System.getenv("pref_HADOOP_HDFS_HOME"),
            System.getenv("HADOOP_HDFS_HOME"));
        assertEquals("HADOOP_YARN_HOME not set",
            System.getenv("pref_HADOOP_YARN_HOME"),
            System.getenv("HADOOP_YARN_HOME"));
        assertEquals("HADOOP_MAPRED_HOME not set",
            System.getenv("pref_HADOOP_MAPRED_HOME"),
            System.getenv("HADOOP_MAPRED_HOME"));
    }

}
