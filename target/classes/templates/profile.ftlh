<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<#include "parts/security.ftlh">

<@c.page>
    <h1>${username}</h1>
    ${message!}
    <form method="post">
        <div class="form-group-row">
            <label class="col-form-label"><#if userIp??>User Ip: ${userIp}</#if></label>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" placeholder="Password" />
            </div>
        </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Email:</label>
                <div class="col-sm-6">
                    <input type="email" name="email" class="form-control" placeholder="some@some.com" value="${email!''}"/>
                </div>
            </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <label class="input-group-text" for="inputGroupSelect01">Select timezone</label>
          </div>
          <select class="custom-select" id="inputGroupSelect01" name="timeZone">
            <#list availableZones as zoneId>
                <option <#if selectedZone??>${(selectedZone == zoneId)?string('selected', '')}<#else>${(user.timezone == zoneId)?string('selected', '')}</#if> value="${zoneId}">${zoneId}</option>
            </#list>
          </select>
        </div>
        <button class="btn btn-primary" type="submit">Save</button>
    </form>
</@c.page>