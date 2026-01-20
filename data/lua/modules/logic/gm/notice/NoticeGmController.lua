-- chunkname: @modules/logic/gm/notice/NoticeGmController.lua

module("modules.logic.gm.notice.NoticeGmController", package.seeall)

local NoticeController = NoticeController

function NoticeController.active()
	return
end

function NoticeController:addConstEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function NoticeController:onOpenView(viewName)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	local viewContainer = ViewMgr.instance:getContainer(ViewName.NoticeView)

	if viewName == ViewName.NoticeView then
		NoticeGmView.showGmView(viewContainer.viewGO)
	end
end

function NoticeController:onCloseView(viewName)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if viewName == ViewName.NoticeView then
		NoticeGmView.closeGmView()
	end
end

function NoticeController:startRequest(callback, callbackObj, beforeLogin)
	self._callback = callback
	self._callbackObj = callbackObj
	self._beforeLogin = beforeLogin

	self:stopRequest()

	local url = GameUrlConfig.getNoticeUrl() .. "/noticecp/client/query"
	local reqUrl = url .. self:getUrlSuffix()

	logNormal(string.format("发起公告请求 url : %s", reqUrl))

	self._reqId = SLFramework.SLWebRequestClient.Instance:Get(reqUrl, self._reqCallback, self)
end

function NoticeController:getUrlSuffix()
	local gameId, channelId, subChannelId, serverType

	if not self.sdkType then
		gameId = tostring(SDKMgr.instance:getGameId())
		channelId = tostring(SDKMgr.instance:getChannelId())
		subChannelId = tostring(SDKMgr.instance:getSubChannelId())
		serverType = tostring(GameChannelConfig.getServerType())
	else
		local sdkCo = NoticeGmDefine.SDKConfig[self.sdkType]

		gameId = sdkCo.gameId
		channelId = sdkCo.channelId
		subChannelId = sdkCo.subChannelId[self.subChannelType or NoticeGmDefine.SubChannelType.Android]
		serverType = self.serverType or NoticeGmDefine.ServerType.Dev
	end

	return string.format("?gameId=%s&channelId=%s&subChannelId=%s&serverType=%s", gameId, channelId, subChannelId, serverType)
end

function NoticeController:setSdkType(sdkType)
	self.sdkType = sdkType
end

function NoticeController:setSubChannelId(subChannelType)
	self.subChannelType = subChannelType
end

function NoticeController:setServerType(serverType)
	self.serverType = serverType
end

NoticeController.instance = NoticeController.New()

LuaEventSystem.addEventMechanism(NoticeController.instance)
NoticeController.instance:__onInit()
NoticeController.instance:onInit()
NoticeController.instance:onInitFinish()
NoticeController.instance:addConstEvents()

return NoticeController
