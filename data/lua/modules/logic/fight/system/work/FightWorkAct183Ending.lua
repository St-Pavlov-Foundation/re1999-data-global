module("modules.logic.fight.system.work.FightWorkAct183Ending", package.seeall)

slot0 = class("FightWorkAct183Ending", BaseWork)

function slot0.onStart(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) or slot2.type ~= DungeonEnum.EpisodeType.Act183 then
		slot0:onDone(true)

		return
	end

	slot5 = slot3 and slot3.episodeMo

	if (slot5 and slot5:getGroupType()) ~= Act183Enum.GroupType.Daily and (Act183Model.instance:getBattleFinishedInfo() and slot3.record ~= nil) then
		slot8 = {
			activityId = slot3.activityId,
			groupRecordMo = slot3.record
		}
		slot0._flow = FlowSequence.New()

		slot0._flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Act183FinishView, slot8))
		slot0._flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Act183SettlementView, slot8))
		slot0._flow:addWork(FunctionWork.New(slot0.onDone, slot0, true))
		slot0._flow:start()
	else
		slot0:onDone(true)
	end
end

return slot0
