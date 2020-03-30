<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="form-row">
    <form method="get" action="main" class="form-inline">
        <input type="text" name="filter" class="form-control mr-3" value="${filter!}" placeholder="Search by tag">
        <button type="submit" class="btn btn-primary">Search</button>
    </form>
    </div>
    <a class="btn btn-primary mt-3 mb-3" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
        Add new Message
    </a>
    <div class="collapse <#if message??>show</#if>" id="collapseExample">
        <div class="form-group">
            <form method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}"
                           value="<#if message??>${message.text}</#if>" name="text" placeholder="Введите сообщение" />
                    <#if textError??>
                    <div class="invalid-feedback">
                        ${textError}
                    </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control ${(tagError??)?string('is-invalid', '')}"
                           value="<#if message??>${message.tag}</#if>" name="tag" placeholder="Тэг" />
                    <#if tagError??>
                        <div class="invalid-feedback">
                            ${tagError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <input type="hidden" value="<#if message??>${message.datemsg}</#if>" name="datemsg">
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">Добавить</button>
                    </div>
                </div>
    </form>
    </div>
    </div>
<div>
    <div class="card-columns">
    <#list messages as message>
        <div class="card my-3">
            <div class="m-2">
            <span>${message.text}</span>
            <i>${message.tag}</i>
            </div>
            <div class="card-footer text-muted">
                <b>${message.authorName}</b>
                <div>
                <#if message.datemsg??>
                    <span>${message.datemsg}</span>
                </#if>
                </div>
            </div>
        </div>
    <#else>
        No messages
    </#list>
    </div>
</@c.page>