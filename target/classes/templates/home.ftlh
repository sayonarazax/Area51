<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <h1>Hello, ${(user??)?string(name, 'Guest')}</h1>
    <div>this is the simple chat</div>
</@c.page>