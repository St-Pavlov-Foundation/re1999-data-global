module("modules.common.others.SendWeWorkFileHelper", package.seeall)

slot0 = class("SendWeWorkFileHelper")
slot1 = "https://qyapi.weixin.qq.com/cgi-bin/webhook/upload_media?key=002753ef-1871-480a-bad0-7981b40003b5&type=file"
slot2 = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=002753ef-1871-480a-bad0-7981b40003b5"

function slot0.SendFile(slot0)
	ZProj.SendWeWorkFileHelper.Instance:SendFile(uv0, uv1, slot0)
end

return slot0
