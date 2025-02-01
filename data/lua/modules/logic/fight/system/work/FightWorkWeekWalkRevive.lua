module("modules.logic.fight.system.work.FightWorkWeekWalkRevive", package.seeall)

slot0 = class("FightWorkWeekWalkRevive", BaseWork)

function slot0.onStart(slot0)
	slot1 = DungeonModel.instance.curSendEpisodeId

	if not (DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot2.type == DungeonEnum.EpisodeType.WeekWalk) then
		slot0:_done()

		return
	end

	if not WeekWalkModel.instance:getCurMapInfo() or not slot4.isShowSelectCd then
		slot0:_done()

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	WeekWalkController.instance:openWeekWalkReviveView()
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.WeekWalkReviveView then
		slot0:_done()
	end
end

function slot0._done(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

return slot0
