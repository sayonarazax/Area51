<#import "parts/common.ftlh" as c>

<@c.page>
List of users
    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Role</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
            <#list users as user>
                <tr>
                    <td>${user.getUsername()}</td>
                    <td><#list user.getRoles() as role>${role}<#sep>, </#list></td>
                    <td><a href="/user/${user.getId()}">edit</a></td>
                </tr>
            </#list>
        </tbody>
    </table>
</@c.page>