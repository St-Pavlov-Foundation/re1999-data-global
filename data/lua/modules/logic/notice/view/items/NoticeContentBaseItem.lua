module("modules.logic.notice.view.items.NoticeContentBaseItem", package.seeall)

slot0 = class("NoticeContentBaseItem", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.itemGo = slot1
	slot0.types = slot2
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1

	if slot0:includeType(slot0.mo.type) then
		slot0:show()
	else
		slot0:hide()
	end
end

function slot0.includeType(slot0, slot1)
	return tabletool.indexOf(slot0.types, slot1)
end

function slot0.show(slot0)
end

function slot0.hide(slot0)
end

function slot0.jump(slot0, slot1, slot2, slot3, slot4, slot5)
	slot2 = string.trim(slot2)

	if slot1 == NoticeContentType.LinkType.InnerLink then
		logNormal("click inner link : " .. slot2)
		GameFacade.jump(slot2)
	elseif slot1 == NoticeContentType.LinkType.OutLink then
		logNormal("Open Url :" .. tostring(string.gsub(NoticeModel.instance:getNoticeUrl(tonumber(slot2)) and (string.find(slot6, "http") and slot6 or "http://" .. slot6) or slot2, "\\", "")))

		if slot4 then
			WebViewController.instance:openWebView(slot6, slot5)
		else
			if slot5 then
				slot6 = WebViewController.instance:getRecordUserUrl(slot6)
			end

			GameUtil.openURL(slot6)
		end
	elseif slot1 == NoticeContentType.LinkType.DeepLink then
		slot6 = slot2

		if string.nilorempty(slot3 and string.trim(slot3)) then
			slot7 = "https://" .. string.split(slot6, "//")[2]
		end

		logNormal("Open Http Url : " .. slot7)
		logNormal("Open Deep Url : " .. slot6)
		GameUtil.openDeepLink(slot7, slot6)
	elseif slot1 == NoticeContentType.LinkType.Time then
		logNormal("时间戳 ： " .. slot2)
	end
end

function slot0.onDestroy(slot0)
	slot0:__onDispose()
end

return slot0
