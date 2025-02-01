module("modules.logic.main.view.MainNoticeRequestView", package.seeall)

slot0 = class("MainNoticeRequestView", BaseView)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.RequestCD = 600

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0, LuaEventSystem.Low)
	slot0:requestNotice()
end

function slot0._onCloseView(slot0)
	if ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:requestNotice()
	end
end

function slot0.requestNotice(slot0)
	if MainController.instance:getLastRequestNoticeTime() and Time.realtimeSinceStartup - slot1 < uv0.RequestCD then
		return
	end

	MainController.instance:setRequestNoticeTime()
	NoticeController.instance:startRequest()
end

return slot0
