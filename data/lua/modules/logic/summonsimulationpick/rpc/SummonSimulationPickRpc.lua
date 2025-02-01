module("modules.logic.summonsimulationpick.rpc.SummonSimulationPickRpc", package.seeall)

slot0 = class("SummonSimulationPickRpc", BaseRpc)

function slot0.getInfo(slot0, slot1, slot2, slot3)
	slot4 = Activity170Module_pb.Get170InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet170InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.info

	SummonSimulationPickModel.instance:setActInfo(slot3.activityId, slot3)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onGetSummonInfo, slot3.activityId)
end

function slot0.summonSimulation(slot0, slot1, slot2, slot3)
	slot4 = Activity170Module_pb.Act170SummonRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct170SummonReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.info

	SummonSimulationPickModel.instance:setActInfo(slot3.activityId, slot3)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSummonSimulation, slot3.activityId)
end

function slot0.saveResult(slot0, slot1, slot2, slot3)
	slot4 = Activity170Module_pb.Act170SaveRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct170SaveReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.info

	SummonSimulationPickModel.instance:setActInfo(slot3.activityId, slot3, true)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSaveResult, slot3.activityId)
end

function slot0.selectResult(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity170Module_pb.Act170SelectRequest()
	slot5.activityId = slot1
	slot5.select = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct170SelectReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.info

	SummonSimulationPickModel.instance:setActInfo(slot3.activityId, slot3)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSelectResult, slot3.activityId)
	CharacterModel.instance:setGainHeroViewShowState(false)
	CharacterModel.instance:setGainHeroViewNewShowState(false)
end

slot0.instance = slot0.New()

return slot0
