<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>
${message!}
add new user
<@l.login "/registration" true/>
</@c.page>