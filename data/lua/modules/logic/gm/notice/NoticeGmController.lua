module("modules.logic.gm.notice.NoticeGmController", package.seeall)

slot0 = NoticeController

function slot0.active()
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
end

function slot0.onOpenView(slot0, slot1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if slot1 == ViewName.NoticeView then
		NoticeGmView.showGmView(ViewMgr.instance:getContainer(ViewName.NoticeView).viewGO)
	end
end

function slot0.onCloseView(slot0, slot1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if slot1 == ViewName.NoticeView then
		NoticeGmView.closeGmView()
	end
end

function slot0.startRequest(slot0, slot1, slot2, slot3)
	slot0._callback = slot1
	slot0._callbackObj = slot2
	slot0._beforeLogin = slot3

	slot0:stopRequest()

	slot5 = GameUrlConfig.getNoticeUrl() .. "/noticecp/client/query" .. slot0:getUrlSuffix()

	logNormal(string.format("发起公告请求 url : %s", slot5))

	slot0._reqId = SLFramework.SLWebRequest.Instance:Get(slot5, slot0._reqCallback, slot0)
end

function slot0.getUrlSuffix(slot0)
	slot1, slot2, slot3, slot4 = nil

	if not slot0.sdkType then
		slot1 = tostring(SDKMgr.instance:getGameId())
		slot2 = tostring(SDKMgr.instance:getChannelId())
		slot3 = tostring(SDKMgr.instance:getSubChannelId())
		slot4 = tostring(GameChannelConfig.getServerType())
	else
		slot5 = NoticeGmDefine.SDKConfig[slot0.sdkType]
		slot1 = slot5.gameId
		slot2 = slot5.channelId
		slot3 = slot5.subChannelId[slot0.subChannelType or NoticeGmDefine.SubChannelType.Android]
		slot4 = slot0.serverType or NoticeGmDefine.ServerType.Dev
	end

	return string.format("?gameId=%s&channelId=%s&subChannelId=%s&serverType=%s", slot1, slot2, slot3, slot4)
end

function slot0.setSdkType(slot0, slot1)
	slot0.sdkType = slot1
end

function slot0.setSubChannelId(slot0, slot1)
	slot0.subChannelType = slot1
end

function slot0.setServerType(slot0, slot1)
	slot0.serverType = slot1
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)
slot0.instance:__onInit()
slot0.instance:onInit()
slot0.instance:onInitFinish()
slot0.instance:addConstEvents()

return slot0
