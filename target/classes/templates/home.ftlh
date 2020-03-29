<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <h1>Hello, ${(user??)?string(name, 'Guest')}</h1>
    <div>this the simple copy of twitter</div>
</@c.page>