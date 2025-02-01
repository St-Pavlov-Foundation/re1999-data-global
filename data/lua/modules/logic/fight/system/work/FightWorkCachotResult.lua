module("modules.logic.fight.system.work.FightWorkCachotResult", package.seeall)

slot0 = class("FightWorkCachotResult", BaseWork)

function slot0.onStart(slot0, slot1)
	slot3 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if FightModel.instance:getRecordMO() and slot2.fightResult == FightEnum.FightResult.Succ and slot3 and slot3.type == DungeonEnum.EpisodeType.Cachot then
		if V1a6_CachotRoomModel.instance:getNowBattleEventMo() and slot4:isBattleSuccess() and not ViewMgr.instance:isOpen(ViewName.V1a6_CachotRewardView) then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, slot4)
		else
			slot0:onDone(true)
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0)
	if PopupController.instance:getPopupCount() > 0 then
		return
	end

	if V1a6_CachotRoomModel.instance:getNowTopEventMo() and slot1:getEventCo() and (slot2.type ~= V1a6_CachotEnum.EventType.Battle or slot2.type == V1a6_CachotEnum.EventType.Battle and slot1:isBattleSuccess()) then
		return
	end

	for slot6, slot7 in ipairs({
		ViewName.V1a6_CachotTipsView,
		ViewName.V1a6_CachotRewardView
	}) do
		if ViewMgr.instance:isOpen(slot7) then
			return
		end
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

return slot0
