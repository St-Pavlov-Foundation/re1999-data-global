module("modules.logic.fight.system.work.FightWorkCachotEnding", package.seeall)

slot0 = class("FightWorkCachotEnding", BaseWork)

function slot0.onStart(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) or slot2.type ~= DungeonEnum.EpisodeType.Cachot then
		slot0:onDone(true)

		return
	end

	if V1a6_CachotModel.instance:getRogueEndingInfo() ~= nil then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
		V1a6_CachotController.instance:openV1a6_CachotFinishView()
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotResultView then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

return slot0
