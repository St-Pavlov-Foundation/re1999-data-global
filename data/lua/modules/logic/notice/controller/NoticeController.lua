module("modules.logic.notice.controller.NoticeController", package.seeall)

local var_0_0 = class("NoticeController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	arg_2_0:addEventCb(arg_2_0, NoticeEvent.OnSelectNoticeItem, arg_2_0.onSelectNoticeMo, arg_2_0)

	if SLFramework.FrameworkSettings.IsEditor then
		NoticeGmController.active()
	end
end

function var_0_0.onSelectNoticeMo(arg_3_0, arg_3_1)
	StatController.instance:track(StatEnum.EventName.NoticeShow, {
		[StatEnum.EventProperties.NoticeShowType] = arg_3_0.autoOpen and StatEnum.NoticeShowType.Auto or StatEnum.NoticeShowType.Click,
		[StatEnum.EventProperties.NoticeType] = arg_3_0:getNoticeTypeStr(arg_3_1),
		[StatEnum.EventProperties.NoticeTitle] = arg_3_1:getTitle()
	})
	arg_3_0:setAutoOpenNoticeView(false)
end

function var_0_0.setAutoOpenNoticeView(arg_4_0, arg_4_1)
	arg_4_0.autoOpen = arg_4_1
end

function var_0_0.getNoticeTypeStr(arg_5_0, arg_5_1)
	if not arg_5_1 or not arg_5_1.noticeTypes then
		return ""
	end

	local var_5_0 = ""

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.noticeTypes) do
		local var_5_1 = StatEnum.NoticeType[iter_5_1] or ""

		if string.nilorempty(var_5_0) then
			var_5_0 = var_5_1
		else
			var_5_0 = var_5_0 .. "-" .. var_5_1
		end
	end

	return var_5_0
end

function var_0_0.openNoticeView(arg_6_0)
	local var_6_0 = Time.time

	if not arg_6_0._lastGetNoticeTime or var_6_0 - arg_6_0._lastGetNoticeTime > 10 then
		arg_6_0:startRequest(arg_6_0._openNoticeView, arg_6_0)

		arg_6_0._lastGetNoticeTime = var_6_0

		return
	end

	arg_6_0:_openNoticeView()
end

function var_0_0._openNoticeView(arg_7_0)
	ViewMgr.instance:openView(ViewName.NoticeView)
end

function var_0_0.startRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if GameFacade.isExternalTest() then
		if arg_8_1 then
			arg_8_1(arg_8_2, true, "")
		end
	else
		arg_8_0._callback = arg_8_1
		arg_8_0._callbackObj = arg_8_2
		arg_8_0._beforeLogin = arg_8_3

		arg_8_0:stopRequest()

		local var_8_0 = tostring(SDKMgr.instance:getGameId())
		local var_8_1 = tostring(SDKMgr.instance:getChannelId())
		local var_8_2 = tostring(SDKMgr.instance:getSubChannelId())
		local var_8_3 = tostring(GameChannelConfig.getServerType())
		local var_8_4 = GameUrlConfig.getNoticeUrl() .. "/noticecp/client/query"
		local var_8_5 = string.format("%s?gameId=%s&channelId=%s&subChannelId=%s&serverType=%s", var_8_4, var_8_0, var_8_1, var_8_2, var_8_3)

		logNormal(string.format("发起公告请求 url : %s", var_8_5))

		arg_8_0._reqId = SLFramework.SLWebRequest.Instance:Get(var_8_5, arg_8_0._reqCallback, arg_8_0)
	end
end

function var_0_0.stopRequest(arg_9_0)
	if arg_9_0._reqId then
		SLFramework.SLWebRequest.Instance:Stop(arg_9_0._reqId)

		arg_9_0._reqId = nil
		arg_9_0._callback = nil
		arg_9_0._callbackObj = nil
	end
end

function var_0_0._reqCallback(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._reqId = nil

	if arg_10_1 and not string.nilorempty(arg_10_2) then
		local var_10_0 = cjson.decode(arg_10_2)

		if var_10_0 and var_10_0.code and var_10_0.code == 200 then
			arg_10_0._lastGetNoticeTime = Time.time

			logNormal(string.format("获取公告：%s", cjson.encode(var_10_0.data)))
			NoticeModel.instance:onGetInfo(var_10_0.data)
			var_0_0.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfo)
		elseif var_10_0 then
			logNormal(string.format("获取公告出错了 code = %d", var_10_0.code))
			var_0_0.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfoFail)
		else
			logNormal(string.format("获取公告出错了"))
			var_0_0.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfoFail)
		end
	else
		logNormal(string.format("获取公告失败了"))
		var_0_0.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfoFail)
	end

	if arg_10_0._beforeLogin and NoticeModel.instance:hasBeforeLoginNotice() then
		BootNoticeView.instance:init(arg_10_0._beforeLoginNoticeFinished, arg_10_0, arg_10_1, arg_10_2)
	else
		arg_10_0:_beforeLoginNoticeFinished(arg_10_1, arg_10_2)
	end
end

function var_0_0._beforeLoginNoticeFinished(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._callback
	local var_11_1 = arg_11_0._callbackObj

	arg_11_0._callback = nil
	arg_11_0._callbackObj = nil
	arg_11_0._beforeLogin = nil

	if var_11_0 then
		if var_11_1 then
			var_11_0(var_11_1, arg_11_1, arg_11_2)
		else
			var_11_0(arg_11_1, arg_11_2)
		end
	end
end

function var_0_0.getNoticeConfig(arg_12_0, arg_12_1, arg_12_2)
	if GameFacade.isExternalTest() then
		if arg_12_1 then
			arg_12_1(arg_12_2, true, "")
		end
	else
		arg_12_0._getCoCallback = arg_12_1
		arg_12_0._getCoCallbackObj = arg_12_2

		arg_12_0:stopGetConfigRequest()

		local var_12_0 = tostring(SDKMgr.instance:getGameId())
		local var_12_1 = tostring(SDKMgr.instance:getChannelId())
		local var_12_2 = tostring(SDKMgr.instance:getSubChannelId())
		local var_12_3 = tostring(GameChannelConfig.getServerType())
		local var_12_4 = GameUrlConfig.getNoticeUrl() .. "/noticecp/config"
		local var_12_5 = string.format("%s?gameId=%s&channelId=%s&subChannelId=%s&serverType=%s", var_12_4, var_12_0, var_12_1, var_12_2, var_12_3)

		logNormal(string.format("拿公告配置url : %s", var_12_5))

		arg_12_0._getCoReqId = SLFramework.SLWebRequest.Instance:Get(var_12_5, arg_12_0._getCoReqCallback, arg_12_0)
	end
end

function var_0_0._isNil(arg_13_0)
	return not arg_13_0 or tostring(arg_13_0) == "userdata: NULL"
end

function var_0_0._getCoReqCallback(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._getCoReqId = nil

	if arg_14_1 and not string.nilorempty(arg_14_2) then
		logNormal(string.format("获取公告配置：%s", arg_14_2))

		local var_14_0 = cjson.decode(arg_14_2)

		if var_14_0 and var_14_0.code and var_14_0.code == 200 then
			local var_14_1 = var_14_0.data
			local var_14_2

			if not arg_14_0._isNil(var_14_1.shootFaceConfig) then
				var_14_2 = var_14_1.shootFaceConfig.type
			end

			NoticeModel.instance:setAutoSelectType(var_14_2 and tonumber(var_14_2) or nil)
		end
	end

	local var_14_3 = arg_14_0._getCoCallback
	local var_14_4 = arg_14_0._getCoCallbackObj

	arg_14_0._getCoCallback = nil
	arg_14_0._getCoCallbackObj = nil

	if var_14_3 then
		if var_14_4 then
			var_14_3(var_14_4, arg_14_1, arg_14_2)
		else
			var_14_3(arg_14_1, arg_14_2)
		end
	end
end

function var_0_0.stopGetConfigRequest(arg_15_0)
	if arg_15_0._getCoReqId then
		SLFramework.SLWebRequest.Instance:Stop(arg_15_0._getCoReqId)

		arg_15_0._getCoReqId = nil
		arg_15_0._getCoCallback = nil
		arg_15_0._getCoCallbackObj = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
