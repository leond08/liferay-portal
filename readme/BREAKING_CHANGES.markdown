# What are the Breaking Changes for Liferay 7.1?

This document presents a chronological list of changes that break existing
functionality, APIs, or contracts with third party Liferay developers or users.
We try our best to minimize these disruptions, but sometimes they are
unavoidable.

Here are some of the types of changes documented in this file:

* Functionality that is removed or replaced
* API incompatibilities: Changes to public Java or JavaScript APIs
* Changes to context variables available to templates
* Changes in CSS classes available to Liferay themes and portlets
* Configuration changes: Changes in configuration files, like
  `portal.properties`, `system.properties`, etc.
* Execution requirements: Java version, J2EE Version, browser versions, etc.
* Deprecations or end of support: For example, warning that a certain
  feature or API will be dropped in an upcoming version.
* Recommendations: For example, recommending using a newly introduced API that
  replaces an old API, in spite of the old API being kept in Liferay Portal for
  backwards compatibility.

*This document has been reviewed through commit `ef156169d4fa`.*

## Breaking Changes Contribution Guidelines

Each change must have a brief descriptive title and contain the following
information:

* **[Title]** Provide a brief descriptive title. Use past tense and follow
  the capitalization rules from
  <http://en.wikibooks.org/wiki/Basic_Book_Design/Capitalizing_Words_in_Titles>.
* **Date:** Specify the date you submitted the change. Format the date as
  *YYYY-MMM* (e.g., 2014-Mar) or *YYYY-MMM-DD* (e.g., 2014-Feb-25).
* **JIRA Ticket:** Reference the related JIRA ticket (e.g., LPS-123456)
  (Optional).
* **What changed?** Identify the affected component and the type of change that
  was made.
* **Who is affected?** Are end-users affected? Are developers affected? If the
  only affected people are those using a certain feature or API, say so.
* **How should I update my code?** Explain any client code changes required.
* **Why was this change made?** Explain the reason for the change. If
  applicable, justify why the breaking change was made instead of following a
  deprecation process.

Here's the template to use for each breaking change (note how it ends with a
horizontal rule):

```
### Title
- **Date:**
- **JIRA Ticket:**

#### What changed?

#### Who is affected?

#### How should I update my code?

#### Why was this change made?

---------------------------------------
```

**80 Columns Rule:** Text should not exceed 80 columns. Keeping text within 80
columns makes it easier to see the changes made between different versions of
the document. Titles, links, and tables are exempt from this rule. Code samples
must follow the column rules specified in Liferay's
[Development Style](http://www.liferay.com/community/wiki/-/wiki/Main/Liferay+development+style).

The remaining content of this document consists of the breaking changes listed
in ascending chronological order.

## Breaking Changes List

### Standardized Data Attribute Names Passed into Selectors
- **Date:** 2016-Oct-26
- **JIRA Ticket:** LPS-66646

#### What changed?

The data attributes passed into the event when someone uses a selector (e.g.,
asset selector, document selector, file selector, role selector, site selector,
user group selector, etc.) have been standardized from being selector specific
(e.g., `groupid`, `groupdescriptivename`, `teamid`, `teamname`, etc.) to being
more generic (e.g., `entityid` and `entityname`).

#### Who is affected?

This affects anyone passing selector specific data attributes to a selector.

#### How should I update my code?

Instead of using selector specific data attributes, you should change your data
attributes to use `entityid` and `entityname`.

**Example**

Old way:

    <portlet:namespace />selectFileEntryType(event.fileentrytypeid, event.fileentrytypename);

New way:

    <portlet:namespace />selectFileEntryType(event.entityid, event.entityname);

Old way:

    data.put("roleid", role.getRoleId());
    data.put("roletitle", role.getTitle(locale));

New way:

    data.put("entityid", role.getRoleId());
    data.put("entityname", role.getTitle(locale));

#### Why was this change made?

This change was made to standardize the data attribute names and allow utility
methods to accept standardized event parameters.

---------------------------------------

### Removed URL Parameters p_p_col_id, p_p_col_pos, and p_p_col_count from Every Portlet URL.
- **Date:** 2016-Dec-12
- **JIRA Ticket:** LPS-69482

#### What changed?

The parameters `p_p_col_count`, `p_p_col_id`, and `p_p_col_pos` are no longer
present in every portlet URL.

#### Who is affected?

This affects developers who are reading these parameters in their custom code.

#### How should I update my code?

You can no longer obtain these parameters from the portlet URL. If you need to
read them, you should do it from `PortletDisplay`.

- The parameter `p_p_col_count` can be obtained via the
  `portletDisplay.getColumnCount()` method.
- The parameter `p_p_col_id` can be obtained via the
  `portletDisplay.getColumnId()` method.
- The parameter `p_p_col_pos` can be obtained via the
  `portletDisplay.getColumnPos()` method.

#### Why was this change made?

This change simplifies portlet URLs so they only contain the required
parameters. This was done as a preliminary step of a bigger story to create
portlet URLs without passing the request as a necessary parameter.

---------------------------------------

### Moved Users File Uploads Portlet Properties to OSGi Configuration
- **Date:** 2017-Feb-06
- **JIRA Ticket:** LPS-69211

#### What changed?

The Users File Uploads portlet properties have been moved from Server
Administration to an OSGi configuration named
`UserFileUploadsConfiguration.java` in the `users-admin-api` module.

#### Who is affected?

This affects anyone using the following portlet properties:

- `users.image.check.token`
- `users.image.max.size`
- `users.image.max.height`
- `users.image.max.width`

#### How should I update my code?

Instead of overriding the `portal.properties` file, you can manage the
properties from Portal's configuration administrator. This can be accessed by
navigating to Liferay Portal's *Control Panel* &rarr; *Configuration* &rarr;
*System Settings* &rarr; *Foundation* &rarr; *User Images* and editing the
settings there.

If you would like to include the new configuration in your application, follow
the instructions for
[making your applications configurable in Liferay 7.0](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/making-your-applications-configurable).

#### Why was this change made?

This change was made as part of the modularization efforts to ease portal
configuration changes.

---------------------------------------

### Moved CAPTCHA Portal Properties to OSGi Configuration
- **Date:** 2017-Feb-13
- **JIRA Ticket:** LPS-67830

#### What changed?

The CAPTCHA properties have been moved from `portal.properties` and Server
Administration to an OSGi configuration named `CaptchaConfiguration.java` in the
`captcha-api` module.

#### Who is affected?

This affects anyone using the following portal properties:

- `captcha.max.challenges`
- `captcha.check.portal.create_account`
- `captcha.check.portal.send_password`
- `captcha.check.portlet.message_boards.edit_category`
- `captcha.check.portlet.message_boards.edit_message`
- `captcha.engine.impl`
- `captcha.engine.recaptcha.key.private`
- `captcha.engine.recaptcha.key.public`
- `captcha.engine.recaptcha.url.script`
- `captcha.engine.recaptcha.url.noscript`
- `captcha.engine.recaptcha.url.verify`
- `captcha.engine.simplecaptcha.height`
- `captcha.engine.simplecaptcha.width`
- `captcha.engine.simplecaptcha.background.producers`
- `captcha.engine.simplecaptcha.gimpy.renderers`
- `captcha.engine.simplecaptcha.noise.producers`
- `captcha.engine.simplecaptcha.text.producers`
- `captcha.engine.simplecaptcha.word.renderers`

#### How should I update my code?

Instead of overriding the `portal.properties` file, you can manage the
properties from Portal's configuration administrator. This can be accessed by
navigating to Liferay Portal's *Control Panel* &rarr; *Configuration* &rarr;
*System Settings* &rarr; *Captcha* and editing the settings there.

If you would like to include the new configuration in your application, follow
the instructions for
[making your applications configurable in Liferay 7.0](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/making-your-applications-configurable).

#### Why was this change made?

This change was made as part of the modularization efforts to ease portal
configuration changes.

---------------------------------------

### Moved OpenOffice Properties to OSGi Configuration
- **Date:** 2017-Mar-24
- **JIRA Ticket:** LPS-71382

#### What changed?

The OpenOffice properties have been moved from Server Administration to an OSGi
configuration named `OpenOfficeConfiguration.java` in the
`document-library-document-conversion` module.

#### Who is affected?

This affects anyone using the following portal properties:

- `openoffice.cache.enabled`
- `openoffice.server.enabled`
- `openoffice.server.host`
- `openoffice.server.port`

#### How should I update my code?

Instead of overriding the `portal.properties` file, you can manage the
properties from Portal's configuration administrator. This can be accessed by
navigating to Liferay Portal's *Control Panel* &rarr; *Configuration* &rarr;
*System Settings* &rarr; *Other* &rarr; *OpenOffice Integration* and editing the
settings there.

If you would like to include the new configuration in your application, follow
the instructions for
[making your applications configurable in Liferay 7.0](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/making-your-applications-configurable).

#### Why was this change made?

This change was made as part of the modularization efforts to ease portal
configuration changes.

---------------------------------------

### Removed Indexation of Fields ratings and viewCount
- **Date:** 2017-May-16
- **JIRA Ticket:** LPS-70724

#### What changed?

The fields `ratings` and `viewCount` are no longer indexed in the `BaseIndexer`
class for `AssetEntry` objects.

#### Who is affected?

This affects any search-related custom code where the `ratings` and `viewCount`
fields are used in queries.

#### How should I update my code?

To adapt to these changes, consider several alternatives:

 - Use the Highest Rated Assets and Most Viewed Assets Liferay portlets.
 - Replace the index query with a database query.
 - Implement an `IndexerPostProcessor` to index these fields in certain
   documents.

#### Why was this change made?

Keeping the Ratings and View Count options in the search index in sync with the
database has a negative impact on normal operations due to the significantly
increased number of index Write requests causing throughput issues and,
therefore, performance degradation.

In addition, the view count is not always up-to-date in the database. This
behavior is controlled by the *Buffered Increment* mechanism. You can find
more information about this in the `portal.properties` file.

---------------------------------------

### Moved Upload Servlet Request Portal Properties to OSGi Configuration
- **Date:** 2017-May-30
- **JIRA Ticket:** LPS-69102

#### What changed?

The Upload Servlet Request properties have been moved from the
`portal.properties` file and Server Administration to an OSGi configuration
named `UploadServletRequestConfiguration.java` in the `portal-upload` module.

#### Who is affected?

This affects anyone using the following portal properties:

- `com.liferay.portal.upload.UploadServletRequestImpl.max.size`
- `com.liferay.portal.upload.UploadServletRequestImpl.temp.dir`

#### How should I update my code?

Instead of overriding the `portal.properties` file, you can manage the
properties from Portal's configuration administrator. This can be accessed by
navigating to Liferay Portal's *Control Panel* &rarr; *Configuration* &rarr;
*System Settings* &rarr; *Upload Servlet Request* and editing the settings
there.

If you would like to include the new configuration in your application, follow
the instructions for
[making your applications configurable in Liferay 7.0](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/making-your-applications-configurable).

#### Why was this change made?

This change was made as part of the modularization efforts to ease portal
configuration changes.

---------------------------------------

### Moved Three DL File Properties to OSGi Configuration
- **Date:** 2017-Aug-01
- **JIRA Ticket:** LPS-69208

#### What changed?

Two DL File properties have been moved from Server Administration to the OSGi
configuration `DLConfiguration`, and one to `DLFileEntryConfiguration`. Both
configurations are located in the `document-library-api` module.

#### Who is affected?

This affects anyone who is using the following portal properties:

- `dl.file.entry.previewable.processor.max.size`
- `dl.file.extensions`
- `dl.file.max.size`

#### How should I update my code?

Instead of overriding the `portal.properties` file, you can manage the
properties from Portal's configuration administrator. This can be accessed by
navigating to Portal's *Control Panel* &rarr; *Configuration* &rarr; *System
Settings* &rarr; *Collaboration* &rarr; *Documents & Media Service* or
*Documents & Media File Entries* and editing the settings there.

If you would like to include the new configuration in your application, follow
the instructions for
[making your applications configurable](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/making-your-applications-configurable).

#### Why was this change made?

This change was made as part of the modularization efforts to ease portal
configuration changes.

---------------------------------------

### Removed the soyutils Module
- **Date:** 2017-Aug-28
- **JIRA Ticket:** LPS-69102

#### What changed?

The module `frontend-js-soyutils-web` is no longer available.

#### Who is affected?

This affects anyone using the `soyutils` module.

#### How should I update my code?

In the rare case that a component is affected, it is recommended that the code
is migrated to use the `metal-soy` module instead. You can do this by extending
the `Metal.js` provided `Component` classes.

#### Why was this change made?

The removed module exposed a legacy version of `soyutils`. This caused
interoperability issues between applications using different versions of the
Closure Template library.

---------------------------------------

### Changed Default Value for Browser Cache Properties
- **Date:** 2017-Sep-05
- **JIRA Ticket:** LPS-74452

#### What changed?

The default values for the portal properties `browser.cache.disabled` and
`browser.cache.signed.in.disabled` were changed to `true`.

#### Who is affected?

This affects anyone relying on proxies and load balancers to cache HTML content.

#### How should I update my code?

You should set both properties `browser.cache.disabled` and
`browser.cache.signed.in.disabled` to `false`, as documented in
`portal-legacy-7.0.properties`.

#### Why was this change made?

The load balancer and web proxy's behavior when Cache-Control headers are
missing is not defined. In the past, many preferred to not cache the content for
correctness; however, it is now common to cache the content for performance.

When an aggressive caching load balancer or web proxy appears in the network
architecture, the default value may result in security problems such as
personalized content being mistakenly shared, including names or other
personally identifiable information. As Liferay shifts towards use cases
providing personalized experiences, this is becoming a serious problem.

While this is ultimately a load balancer or web proxy configuration issue, it is
perceived as a Liferay issue because it is Liferay content being cached, and is
viewed negatively because leaking sensitive information in a production
environment is a very serious security issue.

A value of `true` will improve a portal administrator's experience, and a value
of `false` can be considered during performance tuning, if needed.

---------------------------------------

### Users Can Have Numeric Screen Names with No Limitations, and Sites Can No Longer Have Numeric Friendly URLs
- **Date:** 2017-Oct-10
- **JIRA Ticket:** LPS-66460

#### What changed?

- The portal property `users.screen.name.allow.numeric` now defaults to `true`.
- Numeric screen names are no longer limited by whether they correspond to an
  existing group ID.
- Sites can no longer set their group ID as their friendly URL.
- Sites can no longer be implicitly accessed by using their group ID in the URL
  (this used to be available automatically, even if it wasn't set that way).
- If the friendly URL of a site is already set to the group ID, it will continue
  to work as normal, but you will be forced to change it if you update the site
  in the Site Settings portlet.
- If a site is updated and no friendly URL is provided, it will default to
  `/group-<groupId>`. If that duplicates another friendly URL, the friendly URL
  will be incremented until a unique friendly URL is found (e.g.,
  `/group-<groupId>-1`).
- The default friendly URL for new sites has **not** changed.

#### Who is affected?

This affects anyone who

- has set the friendly URL of their site to the group ID.
- uses a group ID to navigate or direct to a site.

#### How should I update my code?

No code updates should be required, but if you fall under one of the scenarios
in the previous section, you should consider the following changes:

- If you have set the friendly URL of a site to its group ID, you should
  update the friendly URL of that site to something else. A site administrator
  can do this through the Site Settings portlet.
- If you have hard-coded the group ID in any links, you must change them to
  match the updated friendly URL.

#### Why was this change made?

There were common complaints from customers who used LDAP to import users
&mdash; if users were given a numeric screen name during import, some imports
would fail because those screen names conflicted with an existing group ID.

This was because a site's group ID could be used as its friendly URL, while a
user's screen name is used as the friendly URL to their personal site. This
could introduce a routing conflict, so numeric screen names were disallowed if
they conflicted with an existing group ID.

By removing sites' ability to use their group ID as their friendly URL, the
possible conflict with numeric screen names is expunged, allowing users to have
any number as their screen name. This makes it much less likely for LDAP imports
to fail when using numeric screen names for imported users.

Since LDAP import is more commonly used than a site using the group ID as its
friendly URL, the less useful feature was removed to stabilize the more common
one.

---------------------------------------

### Removed Support for Velocity in Themes
- **Date:** 2017-Oct-19
- **JIRA Ticket:** LPS-74379

#### What changed?

- Themes can no longer use Velocity for templates.
- Some helper methods have been removed from the public APIs
`com.liferay.portal.kernel.util.ThemeHelper` and
`com.liferay.taglib.util.ThemeUtil`.

#### Who is affected?

This affects anyone who has themes using Velocity templates or is using the
removed methods.

#### How should I update my code?

If you have a theme using Velocity, consider migrating it to FreeMarker for
better maintenance and improved security.

If you are using the removed methods, consider using the
`com.liferay.portal.kernel.template.Template` functionality directly to process
templates.

#### Why was this change made?

Velocity was deprecated in Liferay Portal 7.0 and the recommendation was to
migrate to FreeMarker. Also, Velocity has had no new releases for a long time.

The removal of Velocity support for Liferay Portal 7.1 themes allows for an
increased focus on existing and new template engines.

---------------------------------------

### Moved Organization Type Properties to OSGi Configuration
- **Date:** 2018-Jan-19
- **JIRA Ticket:** LPS-77183

#### What changed?

The organization type properties have been moved from `portal.properties` to an
OSGi configuration named `OrganizationsTypesConfiguration.java` in the
`users-admin-api` module.

#### Who is affected?

This affects anyone using the following portal properties:

- `organizations.types`
- `organizations.rootable`
- `organizations.children.types`
- `organizations.country.enabled`
- `organizations.country.required`

#### How should I update my code?

Instead of overriding the `portal.properties` file, you can manage the
properties from Portal's configuration administrator. This can be accessed by
navigating to Liferay Portal's *Control Panel* &rarr; *Configuration* &rarr;
*System Settings* &rarr; *Foundation* &rarr; *Organization Type* and editing
the settings there.

If you would like to include the new configuration in your application, follow
the instructions for
[making your applications configurable](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/making-your-applications-configurable).

#### Why was this change made?

This change was made as part of the modularization efforts to ease portal
configuration changes.

---------------------------------------

### Updated jQuery and Lodash Bundled Versions
- **Date:** 2018-Feb-07
- **JIRA Ticket:** LPS-66645, LPS-66646

#### What changed?

The bundled jQuery version has been updated from 2.1.4 to 3.3.1. The bundled
Lodash version has been updated from 3.10.1 to 4.17.4.

#### Who is affected?

This affects anyone using the previous API versions in their code.

#### How should I update my code?

Follow the changelogs on the [jQuery](http://jquery.com/upgrade-guide/3.0/) and
[Lodash](https://github.com/lodash/lodash/wiki/Changelog#v400) sites to update
any affected code.

#### Why was this change made?

This change provides the latest jQuery and Lodash versions available.

---------------------------------------

### Removed JavaScript Minification Properties minifier.javascript.impl and yui.compressor.* from portal.properties
- **Date:** 2018-Feb-28
- **JIRA Ticket:** LPS-74375

#### What changed?

The JavaScript minifiers have been extracted from `portal-kernel` and moved to
their own OSGi module. Thus, they are not configured in `portal.properties` any
more, but rather, through OSGi configuration.

#### Who is affected?

This affects anyone who had the Yahoo JavaScript minifier active and configured
to override its default settings.

#### How should I update my code?

If you are implementing your own JavaScript minifier, you should extract it to
its own OSGi module. See module
[frontend-js-minifier](https://github.com/liferay/liferay-portal/tree/master/modules/apps/frontend-js/frontend-js-minifier)
for an example of how to do this.

#### Why was this change made?

The JavaScript minifiers were not easy to customize. For example, the Google
minifier used an old version of the closure-compiler, which was difficult to
upgrade because it required `portal-kernel` dependency changes. This could
create conflicts.

Having JavaScript minifiers in their own OSGi modules requires less dependency
management and makes it easier to provide new implementations of JavaScript
minifiers. Also, configuration can now be done using OSGi standards.

---------------------------------------

### Changed Behavior of liferay-ui:input-date Taglib's showDisableCheckbox Argument
- **Date:** 2018-Mar-06
- **JIRA Ticket:** LPS-78475

#### What changed?

Previously, when the `liferay-ui:input-date` taglib's `showDisableCheckbox`
argument was set to `true`, the disable checkbox was hidden. Now, the value
`true` displays it, and `false` hides it.

#### Who is affected?

This affects anyone trying to hide the `liferay-ui:input-date` taglib's disable
checkbox.

#### How should I update my code?

If you are setting the `showDisableCheckbox` argument to `true` to hide the
`liferay-ui:input-date` taglib's disable checkbox, you should now set it to
`false`, and vice versa.

#### Why was this change made?

The behavior did not match with the name of the argument and was
counter-intuitive.

---------------------------------------

### Updated Liferay Portal's Portlet API Implementation
- **Date:** 2018-May-10
- **JIRA Ticket:** LPS-73282

#### What changed?

Liferay Portal 7.1 CE GA1 provides the Portlet 3.0 API dependency in the runtime
classpath. Previous versions provided the Portlet 2.0 API.

Full support for Portlet 3.0 will not be available until Liferay Portal 7.1 CE
GA2 is released.

#### Who is affected?

This affects developers planning to upgrade custom portlets from earlier
versions of Liferay Portal.

#### How should I update my code?

There are three development use-cases to plan for:

##### JSP Considerations

Portlet 3.0 is a binary-backward-compatible upgrade. This means that Java source
that was built against `portlet-api-2.0.0.jar` is compatible at runtime. Since
JSP files are typically not compiled until the first request, however, they do
not fall under the category of pre-compiled source.

Specifically, if a JSP contains a Java scriptlet that calls
[`MimeResponse.createActionURL()`](https://docs.liferay.com/portlet-api/3.0/javadocs/javax/portlet/MimeResponse.html#createActionURL())
and
[`MimeResponse.createRenderURL()`](https://docs.liferay.com/portlet-api/3.0/javadocs/javax/portlet/MimeResponse.html#createRenderURL()),
then there is a possibility that the JSP will fail to compile or throw a
`ClassCastException` at runtime. This is because the return type of these
methods has changed.

For example, a Liferay Portal sample portlet's `view.jsp` had to be changed
from

    <aui:form action="<%= renderResponse.createActionURL() %>" method="post" name="fm">

to

    <aui:form action="<%= (PortletURL)renderResponse.createActionURL() %>" method="post" name="fm">

##### Upgrade Considerations

To take advantage of new features in Portlet 3.0, you must rebuild portlet
projects against the `portlet-api-3.0.0.jar` dependency and *opt-in* by
specifying version 3.0 in one of two ways:

1. Add the following tag in your portlet's `portlet.xml` file:

        <portlet-app version="3.0">

2. Add the following property in your portlet's `@Component` tag:

        @Component(
            property = {
                "javax.portlet.version=3.0"
            },
            service = Portlet.class
        )

In addition, you must opt-in to new JSP features by specifying the Portlet 3.0
tag library in your JSP views. For example,

    <%@ taglib uri="http://xmlns.jcp.org/portlet_3_0" prefix="portlet" %>

JSPs that opt-in with the new tag library may encounter JSP compilation problems
related to the `<portlet:defineObjects>` tag. Specifically, if JSPs reference
variables with the following names in Java scriptlets, then a JSP compilation
will occur:

- `actionParams`
- `clientDataRequest`
- `cookies`
- `contextPath`
- `locale`
- `locales`
- `mutableRenderParams`
- `namespace`
- `portletContext`
- `portletMode`
- `portletRequest`
- `portletResponse`
- `resourceParams`
- `windowId`
- `windowState`
- `stateAwareResponse`

With the Portlet API 3.0 implementation, these variables are already added to
this context by default, so attempting to initialize them in the JSP would
duplicate them. Therefore, your JSP scriptlets adding them should be removed.

For example, JSP scriptlets like the following had to be removed from
several of Liferay Portal's out-of-the-box portlets' `view.jsp`:

    <%=
    PortletRequest portletRequest = (PortletRequest)request.getAttribute(JavaConstants.JAVAX_PORTLET_REQUEST);

    PortletResponse portletResponse = (PortletResponse)request.getAttribute(JavaConstants.JAVAX_PORTLET_RESPONSE);

    String namespace = AUIUtil.getNamespace(portletRequest, portletResponse);

    if (Validator.isNull(namespace)) {
        namespace = AUIUtil.getNamespace(request);
    }
    %>

##### JSF Considerations

JSF Portlets must be upgraded to the latest version of Liferay Faces Bridge,
which is planned for release in Q4, 2018. Download and upgrade instructions will
be made available at
[https://www.liferayfaces.org](https://www.liferayfaces.org) at that time.

#### Why was this change made?

This change provides the latest features offered by the Portlet 3.0
Specification, which was released in early 2017.

---------------------------------------

### Changed the Dependency for the liferay-util:html-top JSP tag
- **Date:** 2018-Jun-07
- **JIRA Ticket:** LPS-81983

#### What changed?

The usage of `portal-kernel`'s `StringBundler` has been deprecated in favor of
Liferay's Petra `StringBundler`.

#### Who is affected?

This affects anyone using the `<liferay-util:html-top>` JSP tag.

#### How should I update my code?

You must add the following dependency in your build file for your JSPs to
compile successfully:

**build.gradle**:

    dependencies {
        ...
        compileOnly group: "com.liferay", name: "com.liferay.petra.string", version: "1.2.0"
        ...
    }

**pom.xml**:

    <dependency>
        <groupId>com.liferay</groupId>
        <artifactId>com.liferay.petra.string</artifactId>
        <version>1.2.0</version>
        <scope>provided</scope>
    </dependency>

#### Why was this change made?

This change helps stabilize the foundation of Liferay Portal's utilities.

---------------------------------------

### Changed the From Last Publish Date Option in Staging
- **Date:** 2018-Jun-06
- **JIRA Ticket:** LPS-81695

#### What changed?

The *From Last Publish Date* option used in the publication process has
programmatically changed.

#### Who is affected?

This affects anyone who implemented Staging support for their custom entities.

#### How should I update my code?

You must create a `*StagingModelListener` class for your custom entity, which
extends the
[`com.liferay.portal.kernel.model.BaseModelListener`](https://docs.liferay.com/ce/portal/7.1-latest/javadocs/portal-kernel/com/liferay/portal/kernel/model/BaseModelListener.html).
You can examine the
[`BlogsEntryStagingModelListener`](https://github.com/liferay/liferay-portal/blob/7.1.0-ga1/modules/apps/blogs/blogs-service/src/main/java/com/liferay/blogs/internal/model/listener/BlogsEntryStagingModelListener.java)
class as an example.

You must also update the `doPrepareManifestSummary` method in your custom
`*PortletDataHandler` to use the `populateLastPublishDateCounts` method from the
[`com.liferay.exportimport.internal.staging.StagingImpl`](https://docs.liferay.com/ce/apps/web-experience/latest/javadocs/com/liferay/exportimport/staging/StagingImpl.html),
in case of a *From Last Publish Date* publication. See the
[`BlogsPortletDataHandler`](https://github.com/liferay/liferay-portal/blob/7.1.0-ga1/modules/apps/blogs/blogs-web/src/main/java/com/liferay/blogs/web/internal/exportimport/data/handler/BlogsPortletDataHandler.java)
as an example.

#### Why was this change made?

It was hard to collect which entities should be published to the live site.
Instead of running queries to find the contents that were modified since the
last publication, now changesets are used to track this information.

---------------------------------------

### Decoupled Several Classes from PortletURLImpl
- **Date:** 2018-Jun-08
- **JIRA Ticket:** LPS-82119

#### What changed?

All classes implementing `javax.portlet.BaseURL` have had their inheritance
hierarchy change. These classes include

- `PortletURLImplWrapper`
- `LiferayStrutsPortletURLImpl`
- `StrutsActionPortletURL`

#### Who is affected?

This affects code that attempts to subclass or create a new instance of the
classes listed previously.

#### How should I update my code?

You must refactor the constructors of your affected classes to receive
`com.liferay.portal.kernel.portlet.LiferayPortletResponse` instead of
`com.liferay.portlet.PortletResponseImpl`.

In addition, their class hierarchies must be changed. For example, the
`com.liferay.portal.struts.StrutsActionPortletURL` class hierarchy was changed
from

- `com.liferay.portlet.PortletURLImpl`
    - `com.liferay.portlet.PortletURLImplWrapper`
        - `com.liferay.portal.struts.StrutsActionPortletURL`

to

- `javax.portlet.filter.RenderStateWrapper`
    - `javax.portlet.filter.BaseURLWrapper`
        - `javax.portlet.filter.PortletURLWrapper`
            - `com.liferay.portal.kernel.portlet.LiferayPortletURLWrapper`
                - `com.liferay.portlet.PortletURLImplWrapper`
                    - `com.liferay.portal.struts.StrutsActionPortletURL`

#### Why was this change made?

This change corrects a best practice violation regarding
implementation-specific details being included within an API.

---------------------------------------

### Changed the Request Object in Web Content Templates
- **Date:** 2018-Jun-12
- **JIRA Ticket:** LPS-77766

#### What changed?

The request object is no longer accessible as a map, but rather, as an object of
type `javax.servlet.http.HttpServletRequest`.

#### Who is affected?

This affects users with Web Content templates that access request parameters
as a map like this:

    <#assign containerId = request["theme-display"]["portlet-display"]["instance-id"] >

#### How should I update my code?

To keep retrieving the request parameter values as a map, `requestMap` must be
used instead:

    <#assign containerId = requestMap["theme-display"]["portlet-display"]["instance-id"] >

#### Why was this change made?

This was done to allow template context contributors to work in Web Content
templates.

---------------------------------------

### Disabled Access to Gogo Shell Using Telnet
- **Date:** 2018-Jun-25
- **JIRA Ticket:** LPS-82849

#### What changed?

The ability to access and interact with Liferay Portal's OSGi framework using
the Gogo shell via your system's telnet client has been disabled.

#### Who is affected?

This affects anyone who used their system's telnet client to access the Gogo
shell, or leveraged the Gogo shell in external plugins/tooling using the telnet
client.

#### How should I update my code?

Liferay Portal now offers the Gogo Shell portlet, which you can access in the
Control Panel &rarr; *Configuration* &rarr; *Gogo Shell*.

If you prefer using your telnet client to access the Gogo shell, you must enable
Developer Mode. You can do this by creating a `portal-ext.properties` file in
your Liferay home folder and adding the following property:

    include-and-override=portal-developer.properties

Developer Mode is enabled upon starting your app server.

#### Why was this change made?

This was done to strengthen Liferay Portal's security due to potential XXE/SSRF
vulnerabilities.

---------------------------------------

### Removed Description HTML Escaping in PortletDisplay
- **Date:** 2018-Jul-17
- **JIRA Ticket:** LPS-83185

#### What changed?

The portlet description stored in `PortletDisplay.java` is no longer escaped
automatically.

#### Who is affected?

This affects anyone who relied on the portlet description's value already being
escaped and used it to generate HTML. In that case, a small UI change might be
observed as some characters could become unescaped.

#### How should I update my code?

If you were using the `portletDescription` value to generate HTML, you
should escape it using the proper escape sequence using `HtmlUtil.escape`.

#### Why was this change made?

This change corrects a best practice violation regarding content escaping.

---------------------------------------

### Mandatory modelName attribute in liferay-ui:input-permissions taglib
- **Date:** 2018-Oct-4
- **JIRA Ticket:** LPS-85998

#### What changed?

Previously the talib `liferay-ui:input-permissions` could be used
without providing the attribute `modelName`. Now the attribute
`modelName` is mandatory.

#### Who is affected?

This affects any developer who was using the taglib
`liferay-ui:input-permissions` in their own portlets and was not setting
the `modelName` attribute of the taglib.

#### How should I update my code?

You should invoke the taglib providing the model name you are assigning
the permissions to.

#### Why was this change made?

This change was done to remove some old logic that is not used anywhere
in Liferay.

---------------------------------------