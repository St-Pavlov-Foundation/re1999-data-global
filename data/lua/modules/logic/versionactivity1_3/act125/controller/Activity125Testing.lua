module("modules.logic.versionactivity1_3.act125.controller.Activity125Testing", package.seeall)

slot0 = _G.class("TestingBase")

function slot0.ctor(slot0)
	slot0._pb = Activity125Module_pb
	slot0._cCfg = Activity125Config
end

function slot0.build_test(slot0)
end

function slot0.link(slot0, slot1)
	slot0._obj = slot1
end

slot1 = 0
slot2 = 1
slot3 = "服务器异常"
slot4 = "returnCode: -2"
slot5 = _G.class("STesting", slot0)

function slot5.ctor(slot0)
	uv0.ctor(slot0)

	slot0._actId2InfoDict = {}
end

function slot5._make_Act125Episode(slot0, slot1, slot2)
	return {
		id = slot1,
		state = slot2 or math.random(0, 99999) % 2 == 0 and uv0 or uv1
	}
end

function slot5._make_Info(slot0, slot1)
	assert(slot1, uv0)

	slot8 = slot1

	for slot8, slot9 in pairs(assert(slot0._cCfg.instance:getAct125Config(slot8), uv0 .. slot1)) do
		slot10 = slot9.id
	end

	slot5 = {
		activityId = slot1,
		act125Episodes = {
			[slot10] = slot0:_make_Act125Episode(slot10, uv1)
		}
	}

	for slot10 = 1, 0 do
		slot4[slot10].state = uv2
	end

	return slot5
end

function slot5.handleGetInfos(slot0, slot1, slot2)
	if not slot0:_getInfo(slot1.activityId) then
		slot0._actId2InfoDict[slot3] = slot0:_make_Info(slot3)
	end

	rawset(slot2, "activityId", slot3)
	rawset(slot2, "act125Episodes", slot0:_getEpisodeList(slot3))
end

function slot5.handleFinishAct125Episode(slot0, slot1, slot2)
	slot3 = slot1.activityId
	slot6 = slot0._cCfg.instance
	slot7 = slot6:getAct125Config(slot3)
	slot8 = assert(slot0:_getInfo(slot3), uv0)
	slot10 = {}

	if slot6:getEpisodeConfig(slot3, slot1.episodeId).targetFrequency <= slot1.targetFrequency then
		table.insert(slot10, slot0:_retainEpisodeNewState(slot3, slot4, uv1))
	end

	rawset(slot2, "activityId", slot3)
	rawset(slot2, "episodeId", slot4)
	rawset(slot2, "updateAct125Episodes", slot10)
end

function slot5._getInfo(slot0, slot1)
	return slot0._actId2InfoDict[slot1]
end

function slot5._getEpisodeList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(slot0:_getInfo(slot1).act125Episodes) do
		table.insert(slot3, slot8)
	end

	table.sort(slot3, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot3
end

function slot5._retainEpisodeNewState(slot0, slot1, slot2, slot3)
	assert(slot1, uv0)
	assert(slot2, uv0)
	assert(slot3, uv0)

	if not assert(slot0:_getInfo(slot1), uv0).act125Episodes[slot2] then
		logError(uv1)

		return
	end

	slot5.state = slot3

	return slot5
end

slot6 = 0
slot7 = _G.class("CTesting", slot0)

function slot7.ctor(slot0)
	uv0.ctor(slot0)

	slot0._cRpc = Activity125Rpc
	slot0._cCtrl = Activity125Controller
	slot0._cModel = Activity125Model
	slot0._cActivity125WarmUpViewBaseContainer = Activity125WarmUpViewBaseContainer
end

function slot7.build_test(slot0)
	slot1 = slot0._cCfg.instance
	slot2 = slot0._cRpc.instance
	slot3 = slot0._cCtrl.instance
	slot4 = slot0._cModel.instance
	slot5 = slot0._pb

	function slot0._cRpc.sendGetAct125InfosRequest(slot0, slot1, slot2, slot3)
		slot4 = uv0.GetAct125InfosRequest()
		slot4.activityId = slot1
		slot5 = uv0.GetAct125InfosReply()

		uv1._obj:handleGetInfos(slot4, slot5)
		uv2:onReceiveGetAct125InfosReply(uv3, slot5)

		if slot2 then
			if slot3 then
				slot2(slot3, LuaSocketMgr.instance:getCmdByPbStructName(slot4.__cname), uv3)
			else
				slot2(slot6, uv3)
			end
		end
	end

	function slot0._cRpc.sendFinishAct125EpisodeRequest(slot0, slot1, slot2, slot3, slot4, slot5)
		slot6 = uv0.FinishAct125EpisodeRequest()
		slot6.activityId = slot1
		slot6.episodeId = slot2
		slot6.targetFrequency = slot3
		slot7 = uv0.FinishAct125EpisodeReply()

		uv1._obj:handleFinishAct125Episode(slot6, slot7)
		uv2:onReceiveFinishAct125EpisodeReply(uv3, slot7)

		if slot4 then
			if slot5 then
				slot4(slot5, LuaSocketMgr.instance:getCmdByPbStructName(slot6.__cname), uv3)
			else
				slot4(slot8, uv3)
			end
		end
	end

	slot6 = Activity125MO
	slot8 = true
	slot9 = true

	if true and slot6 then
		slot10 = {}

		function slot6.setLocalIsPlay(slot0, slot1)
			uv0[slot0.id] = uv0[slot0.id] or {}
			uv0[slot0.id][slot1] = true
		end

		function slot6.checkLocalIsPlay(slot0, slot1)
			uv0[slot0.id] = uv0[slot0.id] or {}

			return uv0[slot0.id][slot1]
		end
	end

	if not slot9 then
		function slot0._cActivity125WarmUpViewBaseContainer.saveInt(slot0, slot1, slot2)
			logError("[Activity125Testing] saveInt: key=" .. slot1 .. " value=" .. tostring(slot2))
		end
	end

	if slot8 and slot6 then
		function slot6.isEpisodeDayOpen(slot0, slot1)
			return true
		end

		function slot6.isEpisodeReallyOpen(slot0, slot1)
			return true
		end

		function slot6.isEpisodeUnLock(slot0, slot1)
			return true
		end
	end
end

slot8 = _G.class("Activity125Testing")

function slot8.ctor(slot0)
	slot0._client = uv0.New()
	slot0._sever = uv1.New()

	slot0._sever:link(slot0._client)
	slot0._client:link(slot0._sever)
end

function slot8._test(slot0)
	slot0._client:build_test()
	slot0._sever:build_test()
end

slot8.instance = slot8.New()

return slot8
