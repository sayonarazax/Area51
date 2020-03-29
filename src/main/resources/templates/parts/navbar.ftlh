<#include "security.ftlh">
<#import "login.ftlh" as l>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <img src="/img/ufoIco1.png" alt="">
    <a class="navbar-brand" href="/">Area51</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link ${(navbarHome??)?string('active', '')}" href="/">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${(navbarMsg??)?string('active', '')}" href="/main">Messages</a>
            </li>
            <#if isAdmin>
            <li class="nav-item">
                <a class="nav-link ${(navbarUsers??)?string('active', '')}" href="/user">User List</a>
            </li>
            </#if>
            <#if user??>
                <li class="nav-item ${(navbarProfile??)?string('active', '')}">
                    <a class="nav-link" href="/user/profile">Profile</a>
                </li>
            </#if>
        </ul>
        <#if user??><div class="navbar-text mr-3">${name}</div>
        <@l.logout /></#if>
    </div>
</nav>