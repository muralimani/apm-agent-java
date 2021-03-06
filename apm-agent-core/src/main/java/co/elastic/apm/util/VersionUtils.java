/*-
 * #%L
 * Elastic APM Java agent
 * %%
 * Copyright (C) 2018 Elastic and contributors
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * #L%
 */
package co.elastic.apm.util;

import javax.annotation.Nullable;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public final class VersionUtils {

    private VersionUtils() {
    }

    @Nullable
    public static String getAgentVersion() {
        return getVersionFromPomProperties(VersionUtils.class, "co.elastic.apm", "elastic-apm-agent");
    }

    @Nullable
    public static String getVersionFromPomProperties(Class clazz, String groupId, String artifactId) {
        final String classpathLocation = "/META-INF/maven/" + groupId + "/" + artifactId + "/pom.properties";
        final Properties pomProperties = getFromClasspath(classpathLocation, clazz);
        if (pomProperties != null) {
            return pomProperties.getProperty("version");
        }
        return null;
    }

    @Nullable
    private static Properties getFromClasspath(String classpathLocation, Class clazz) {
        final Properties props = new Properties();
        try (InputStream resourceStream = clazz.getResourceAsStream(classpathLocation)) {
            if (resourceStream != null) {
                props.load(resourceStream);
                return props;
            }
        } catch (IOException ignore) {
        }
        return null;
    }

}
