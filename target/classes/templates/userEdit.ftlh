<#import "parts/common.ftlh" as c>

<@c.page>
    User Editor
    <form action="/user" method="post" xmlns="http://www.w3.org/1999/html">
        <input type="text" name="username" value="${user.getUsername()}">
        <#list roles as role>
            <div>
                <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</input></label>
            </div>
        </#list>
        <input type="hidden" name="userId" value="${user.getId()}" />
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit">Save</button>
    </form>
</@c.page>