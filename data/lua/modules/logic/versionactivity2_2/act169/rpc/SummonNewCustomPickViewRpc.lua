module("modules.logic.versionactivity2_2.act169.rpc.SummonNewCustomPickViewRpc", package.seeall)

slot0 = class("SummonNewCustomPickViewRpc", BaseRpc)

function slot0.sendGet169InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity169Module_pb.Get169InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet169InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SummonNewCustomPickViewModel.instance:onGetInfo(slot2.activityId, slot2.heroId)
		SummonNewCustomPickViewController.instance:dispatchEvent(SummonNewCustomPickEvent.OnGetServerInfoReply, slot2.activityId, slot2.heroId)
	end
end

function slot0.sendAct169SummonRequest(slot0, slot1, slot2)
	Activity169Module_pb.Act169SummonRequest().activityId = slot1
	slot3.heroId = slot2 or 0

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct169SummonReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
			SummonNewCustomPickViewController.instance:dispatchEvent(SummonNewCustomPickEvent.OnSummonCustomGet, slot2.activityId, slot2.heroId)
		end

		SummonNewCustomPickViewModel.instance:setReward(slot2.activityId, slot2.heroId)
		SummonNewCustomPickViewModel.instance:setGetRewardFxState(slot2.activityId, true)
		SummonNewCustomPickViewController.instance:dispatchEvent(SummonNewCustomPickEvent.OnGetReward, slot2.activityId, slot2.heroId)
		CharacterModel.instance:setGainHeroViewShowState(false)
	end
end

slot0.instance = slot0.New()

return slot0
