module("modules.logic.summon.controller.SummonPoolHistoryController", package.seeall)

slot0 = class("SummonPoolHistoryController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.updateSummonQueryToken(slot0, slot1)
	SummonPoolHistoryModel.instance:setToken(slot1.token)
	slot0:_requestWeb()
end

function slot0.request(slot0)
	if LoginModel.instance.serverIp == nil or LoginModel.instance.serverPort == nil then
		logNormal("serverIp is nil, or serverPort is nil")

		return
	end

	if slot0._httpWebRequestId then
		return
	end

	if SummonPoolHistoryModel.instance:isTokenValidity() then
		slot0:_requestWeb()
	else
		SummonRpc.instance:sendSummonQueryTokenRequest()
	end
end

function slot0._requestWeb(slot0)
	if slot0._httpWebRequestId then
		return
	end

	slot1 = nil

	if type(UrlConfig.getConfig().login) == "table" then
		if not slot2[tostring(SDKMgr.instance:getChannelId()) or "100"] then
			for slot7, slot8 in pairs(slot2) do
				logError(string.format("httpLoginUrl not exist, channelId=%s\nuse %s:%s", slot3, slot7, slot8 or "nil"))

				break
			end
		end
	else
		slot1 = slot2
	end

	slot4 = {}

	table.insert(slot4, string.format("userId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(slot4, string.format("token=%s", SummonPoolHistoryModel.instance:getToken()))

	slot3 = string.format("%s/query/summon", slot1) .. "?" .. table.concat(slot4, "&")
	slot0._httpWebRequestId = SLFramework.SLWebRequest.Instance:Get(slot3, slot0._onHttpWebHistoryDataResponse, slot0)

	logNormal(slot3)
end

function slot0._onHttpWebHistoryDataResponse(slot0, slot1, slot2)
	slot0._httpWebRequestId = nil

	if not slot1 or string.nilorempty(slot2) then
		logNormal(string.format("获取卡池历史失败"))

		return
	end

	if cjson.decode(slot2) and slot3.code and slot3.code == 200 then
		slot0._lastGetTime = Time.time

		logNormal(string.format("获取卡池历史成功！！"))
		SummonPoolHistoryModel.instance:onGetInfo(slot3.data)
		SummonController.instance:dispatchEvent(SummonEvent.onGetSummonPoolHistoryData)
	elseif slot3 then
		logNormal(string.format("获取卡池历史出错了 code = %d", slot3.code))
	else
		logNormal(string.format("获取卡池历史出错了"))
	end
end

slot0.instance = slot0.New()

return slot0
