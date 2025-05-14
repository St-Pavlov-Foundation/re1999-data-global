module("modules.logic.gm.notice.NoticeGmController", package.seeall)

local var_0_0 = NoticeController

function var_0_0.active()
	return
end

function var_0_0.addConstEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0.onCloseView, arg_2_0)
end

function var_0_0.onOpenView(arg_3_0, arg_3_1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	local var_3_0 = ViewMgr.instance:getContainer(ViewName.NoticeView)

	if arg_3_1 == ViewName.NoticeView then
		NoticeGmView.showGmView(var_3_0.viewGO)
	end
end

function var_0_0.onCloseView(arg_4_0, arg_4_1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if arg_4_1 == ViewName.NoticeView then
		NoticeGmView.closeGmView()
	end
end

function var_0_0.startRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._callback = arg_5_1
	arg_5_0._callbackObj = arg_5_2
	arg_5_0._beforeLogin = arg_5_3

	arg_5_0:stopRequest()

	local var_5_0 = (GameUrlConfig.getNoticeUrl() .. "/noticecp/client/query") .. arg_5_0:getUrlSuffix()

	logNormal(string.format("发起公告请求 url : %s", var_5_0))

	arg_5_0._reqId = SLFramework.SLWebRequest.Instance:Get(var_5_0, arg_5_0._reqCallback, arg_5_0)
end

function var_0_0.getUrlSuffix(arg_6_0)
	local var_6_0
	local var_6_1
	local var_6_2
	local var_6_3

	if not arg_6_0.sdkType then
		var_6_0 = tostring(SDKMgr.instance:getGameId())
		var_6_1 = tostring(SDKMgr.instance:getChannelId())
		var_6_2 = tostring(SDKMgr.instance:getSubChannelId())
		var_6_3 = tostring(GameChannelConfig.getServerType())
	else
		local var_6_4 = NoticeGmDefine.SDKConfig[arg_6_0.sdkType]

		var_6_0 = var_6_4.gameId
		var_6_1 = var_6_4.channelId
		var_6_2 = var_6_4.subChannelId[arg_6_0.subChannelType or NoticeGmDefine.SubChannelType.Android]
		var_6_3 = arg_6_0.serverType or NoticeGmDefine.ServerType.Dev
	end

	return string.format("?gameId=%s&channelId=%s&subChannelId=%s&serverType=%s", var_6_0, var_6_1, var_6_2, var_6_3)
end

function var_0_0.setSdkType(arg_7_0, arg_7_1)
	arg_7_0.sdkType = arg_7_1
end

function var_0_0.setSubChannelId(arg_8_0, arg_8_1)
	arg_8_0.subChannelType = arg_8_1
end

function var_0_0.setServerType(arg_9_0, arg_9_1)
	arg_9_0.serverType = arg_9_1
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)
var_0_0.instance:__onInit()
var_0_0.instance:onInit()
var_0_0.instance:onInitFinish()
var_0_0.instance:addConstEvents()

return var_0_0
