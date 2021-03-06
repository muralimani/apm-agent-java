<#-- @ftlvariable name="config" type="java.util.Map<java.lang.String,java.util.List<org.stagemonitor.configuration.ConfigurationOption<?>>>" -->
[[configuration]]
== Configuration
To adapt the Elastic APM agent to your needs,
you can configure it using different configuration sources,
which have different naming conventions for the property key.
The first configuration sources override the configuration values of over the latter sources.

[arabic]
. Java system properties +
  All configuration keys are prefixed with `elastic.apm.`
. Environment variables +
  All configuration keys are in uppercase and prefixed with `ELASTIC_APM_`
. `elasticapm.properties` file +
  You can place a `elasticapm.properties` in the same directory the agent jar resides in.
  No prefix is required for the configuration keys.

Configuration options marked with Dynamic true can be changed at runtime
via configuration sources which support dynamic reloading.
Java system properties can be set from within the application.

In order to get started with Elastic APM,
the most important configuration options are <<config-service-name>> (required),
<<config-server-url>> and <<config-application-packages>>.
So a minimal version of a configuration might look like this:

[source,bash]
.System properties
----
-Delastic.apm.service_name=my-cool-service
-Delastic.apm.application_packages=org.example
-Delastic.apm.server_url=http://localhost:8300
----

[source,properties]
.elasticapm.properties
----
service_name=my-cool-service
application_packages=org.example
server_url=http://localhost:8300
----

[source,bash]
.Environment variables
----
ELASTIC_APM_SERVICE_NAME=my-cool-service
ELASTIC_APM_APPLICATION_PACKAGES=org.example
ELASTIC_APM_SERVER_URL=http://localhost:8300
----

<#list config as category, options>
[[config-${category?lower_case?replace(" ", "-")}]]
=== ${category} configuration options
    <#list options as option>
        <#if !option.tags?seq_contains("internal")>
[float]
[[config-${option.key?replace("[^a-z]", "-", "r")}]]
==== `${option.key}`

${option.description}

<#if option.validOptions?has_content>
Valid options: <#list option.validOptionsLabelMap?values as validOption>`${validOption}`<#if validOption_has_next>, </#if></#list>
</#if>

[options="header"]
|============
| Default                          | Type                | Dynamic
| `<@defaultValue option/>` | ${option.valueType} | ${option.dynamic?c}
|============


[options="header"]
|============
| Java System Properties      | Property file   | Environment
| `elastic.apm.${option.key}` | `${option.key}` | `ELASTIC_APM_${option.key?upper_case?replace(".", "_")}`
|============

        </#if>
    </#list>
</#list>

<#macro defaultValue option>${option.defaultValueAsString?has_content?then("${option.defaultValueAsString?replace(',([^\\\\s])', ', $1', 'r')}", '<none>')}</#macro>

