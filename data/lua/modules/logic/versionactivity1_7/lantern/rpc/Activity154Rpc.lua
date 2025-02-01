module("modules.logic.versionactivity1_7.lantern.rpc.Activity154Rpc", package.seeall)

slot0 = class("Activity154Rpc", BaseRpc)

function slot0.sendGet154InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity154Module_pb.Get154InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet154InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	LanternFestivalModel.instance:setActivity154Infos(slot2)
	LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.InfosRefresh)
end

function slot0.sendAnswer154PuzzleRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity154Module_pb.Answer154PuzzleRequest()
	slot6.activityId = slot1
	slot6.puzzleId = slot2
	slot6.optionId = slot3

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAnswer154PuzzleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	LanternFestivalModel.instance:updatePuzzleInfo(slot2.info)
	LanternFestivalModel.instance:setCurPuzzleId(0)
	LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.PuzzleRewardGet)
end

slot0.instance = slot0.New()

return slot0
