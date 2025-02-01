module("modules.logic.versionactivity1_3.act126.rpc.Activity126Rpc", package.seeall)

slot0 = class("Activity126Rpc", BaseRpc)

function slot0.sendGet126InfosRequest(slot0, slot1)
	slot2 = Activity126Module_pb.Get126InfosRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGet126InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity126Model.instance:updateInfo(slot2)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onGet126InfosReply)
end

function slot0.sendUpdateProgressRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity126Module_pb.UpdateProgressRequest()
	slot4.activityId = slot1
	slot4.progressStr = slot2

	for slot8, slot9 in ipairs(slot3) do
		table.insert(slot4.activeStarId, slot9)
	end

	slot0:sendMsg(slot4)
end

function slot0.onReceiveUpdateProgressReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity126Model.instance:updateStarProgress(slot2)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onUpdateProgressReply)
end

function slot0.sendResetProgressRequest(slot0, slot1)
	slot2 = Activity126Module_pb.ResetProgressRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveResetProgressReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity126Controller.instance:dispatchEvent(Activity126Event.onBeforeResetProgressReply)
	Activity126Model.instance:updateStarProgress(slot2)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onUpdateProgressReply, {
		fromReset = true
	})
	Activity126Controller.instance:dispatchEvent(Activity126Event.onResetProgressReply)
end

function slot0.sendGetProgressRewardRequest(slot0, slot1, slot2)
	slot3 = Activity126Module_pb.GetProgressRewardRequest()
	slot3.activityId = slot1
	slot3.getRewardId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveGetProgressRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity126Model.instance:updateGetProgressBonus(slot2)
end

function slot0.sendHoroscopeRequest(slot0, slot1, slot2)
	slot3 = Activity126Module_pb.HoroscopeRequest()
	slot3.activityId = slot1
	slot3.id = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveHoroscopeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity126Model.instance:updateHoroscope(slot2.horoscope)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onHoroscopeReply)
end

function slot0.sendGetHoroscopeRequest(slot0, slot1, slot2)
	slot3 = Activity126Module_pb.GetHoroscopeRequest()
	slot3.activityId = slot1
	slot3.id = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveGetHoroscopeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity126Model.instance:updateGetHoroscope(slot2.getHoroscope)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onGetHoroscopeReply)
end

function slot0.sendUnlockBuffRequest(slot0, slot1, slot2)
	slot3 = Activity126Module_pb.UnlockBuffRequest()
	slot3.activityId = slot1
	slot3.unlockId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveUnlockBuffReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Stat1_3Controller.instance:trackUnlockBuff(slot2)
	Activity126Model.instance:updateBuffInfo(slot2)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onUnlockBuffReply)
end

function slot0.onReceiveAct126InfoUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity126Model.instance:updateInfo(slot2)
end

function slot0.onReceiveExchangeStarPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = slot2.dataList
	slot5 = slot2.getApproach

	if #MaterialRpc.receiveMaterial(slot2) > 0 then
		if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
			VersionActivity1_3AstrologyModel.instance:setExchangeList(slot6)

			return
		end

		VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyPropView(slot6)
	end
end

function slot0.sendEnterFightRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity126Module_pb.EnterFightRequest()
	slot4.activityId = slot1
	slot4.dreamlandCard = slot2
	slot4.episodeId = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveEnterFightReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.dreamlandCard
	slot4 = slot2.episodeId
end

slot0.instance = slot0.New()

return slot0
