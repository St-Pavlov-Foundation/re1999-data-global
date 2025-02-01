module("modules.logic.notice.controller.NoticeController", package.seeall)

slot0 = class("NoticeController", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(slot0, NoticeEvent.OnSelectNoticeItem, slot0.onSelectNoticeMo, slot0)

	if SLFramework.FrameworkSettings.IsEditor then
		NoticeGmController.active()
	end
end

function slot0.onSelectNoticeMo(slot0, slot1)
	StatController.instance:track(StatEnum.EventName.NoticeShow, {
		[StatEnum.EventProperties.NoticeShowType] = slot0.autoOpen and StatEnum.NoticeShowType.Auto or StatEnum.NoticeShowType.Click,
		[StatEnum.EventProperties.NoticeType] = slot0:getNoticeTypeStr(slot1),
		[StatEnum.EventProperties.NoticeTitle] = slot1:getTitle()
	})
	slot0:setAutoOpenNoticeView(false)
end

function slot0.setAutoOpenNoticeView(slot0, slot1)
	slot0.autoOpen = slot1
end

function slot0.getNoticeTypeStr(slot0, slot1)
	if not slot1 or not slot1.noticeTypes then
		return ""
	end

	for slot6, slot7 in ipairs(slot1.noticeTypes) do
		slot8 = StatEnum.NoticeType[slot7] or ""
		slot2 = string.nilorempty("") and slot8 or slot8 .. "-" .. slot8
	end

	return slot2
end

function slot0.openNoticeView(slot0)
	slot1 = Time.time

	if not slot0._lastGetNoticeTime or slot1 - slot0._lastGetNoticeTime > 10 then
		slot0:startRequest(slot0._openNoticeView, slot0)

		slot0._lastGetNoticeTime = slot1

		return
	end

	slot0:_openNoticeView()
end

function slot0._openNoticeView(slot0)
	ViewMgr.instance:openView(ViewName.NoticeView)
end

function slot0.startRequest(slot0, slot1, slot2, slot3)
	if GameFacade.isExternalTest() then
		if slot1 then
			slot1(slot2, true, "")
		end
	else
		slot0._callback = slot1
		slot0._callbackObj = slot2
		slot0._beforeLogin = slot3

		slot0:stopRequest()

		slot9 = string.format("%s?gameId=%s&channelId=%s&subChannelId=%s&serverType=%s", GameUrlConfig.getNoticeUrl() .. "/noticecp/client/query", tostring(SDKMgr.instance:getGameId()), tostring(SDKMgr.instance:getChannelId()), tostring(SDKMgr.instance:getSubChannelId()), tostring(GameChannelConfig.getServerType()))

		logNormal(string.format("发起公告请求 url : %s", slot9))

		slot0._reqId = SLFramework.SLWebRequest.Instance:Get(slot9, slot0._reqCallback, slot0)
	end
end

function slot0.stopRequest(slot0)
	if slot0._reqId then
		SLFramework.SLWebRequest.Instance:Stop(slot0._reqId)

		slot0._reqId = nil
		slot0._callback = nil
		slot0._callbackObj = nil
	end
end

function slot0._reqCallback(slot0, slot1, slot2)
	slot0._reqId = nil

	if slot1 and not string.nilorempty(slot2) then
		if cjson.decode(slot2) and slot3.code and slot3.code == 200 then
			slot0._lastGetNoticeTime = Time.time

			logNormal(string.format("获取公告：%s", cjson.encode(slot3.data)))
			NoticeModel.instance:onGetInfo(slot3.data)
			uv0.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfo)
		elseif slot3 then
			logNormal(string.format("获取公告出错了 code = %d", slot3.code))
			uv0.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfoFail)
		else
			logNormal(string.format("获取公告出错了"))
			uv0.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfoFail)
		end
	else
		logNormal(string.format("获取公告失败了"))
		uv0.instance:dispatchEvent(NoticeEvent.OnGetNoticeInfoFail)
	end

	if slot0._beforeLogin and NoticeModel.instance:hasBeforeLoginNotice() then
		BootNoticeView.instance:init(slot0._beforeLoginNoticeFinished, slot0, slot1, slot2)
	else
		slot0:_beforeLoginNoticeFinished(slot1, slot2)
	end
end

function slot0._beforeLoginNoticeFinished(slot0, slot1, slot2)
	slot4 = slot0._callbackObj
	slot0._callback = nil
	slot0._callbackObj = nil
	slot0._beforeLogin = nil

	if slot0._callback then
		if slot4 then
			slot3(slot4, slot1, slot2)
		else
			slot3(slot1, slot2)
		end
	end
end

function slot0.getNoticeConfig(slot0, slot1, slot2)
	if GameFacade.isExternalTest() then
		if slot1 then
			slot1(slot2, true, "")
		end
	else
		slot0._getCoCallback = slot1
		slot0._getCoCallbackObj = slot2

		slot0:stopGetConfigRequest()

		slot8 = string.format("%s?gameId=%s&channelId=%s&subChannelId=%s&serverType=%s", GameUrlConfig.getNoticeUrl() .. "/noticecp/config", tostring(SDKMgr.instance:getGameId()), tostring(SDKMgr.instance:getChannelId()), tostring(SDKMgr.instance:getSubChannelId()), tostring(GameChannelConfig.getServerType()))

		logNormal(string.format("拿公告配置url : %s", slot8))

		slot0._getCoReqId = SLFramework.SLWebRequest.Instance:Get(slot8, slot0._getCoReqCallback, slot0)
	end
end

function slot0._isNil(slot0)
	return not slot0 or tostring(slot0) == "userdata: NULL"
end

function slot0._getCoReqCallback(slot0, slot1, slot2)
	slot0._getCoReqId = nil

	if slot1 and not string.nilorempty(slot2) then
		logNormal(string.format("获取公告配置：%s", slot2))

		if cjson.decode(slot2) and slot3.code and slot3.code == 200 then
			slot5 = nil

			if not slot0._isNil(slot3.data.shootFaceConfig) then
				slot5 = slot4.shootFaceConfig.type
			end

			NoticeModel.instance:setAutoSelectType(slot5 and tonumber(slot5) or nil)
		end
	end

	slot4 = slot0._getCoCallbackObj
	slot0._getCoCallback = nil
	slot0._getCoCallbackObj = nil

	if slot0._getCoCallback then
		if slot4 then
			slot3(slot4, slot1, slot2)
		else
			slot3(slot1, slot2)
		end
	end
end

function slot0.stopGetConfigRequest(slot0)
	if slot0._getCoReqId then
		SLFramework.SLWebRequest.Instance:Stop(slot0._getCoReqId)

		slot0._getCoReqId = nil
		slot0._getCoCallback = nil
		slot0._getCoCallbackObj = nil
	end
end

slot0.instance = slot0.New()

return slot0
