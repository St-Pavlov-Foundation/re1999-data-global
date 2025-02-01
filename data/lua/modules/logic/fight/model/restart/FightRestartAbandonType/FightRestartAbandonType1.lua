module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType1", package.seeall)

slot0 = class("FightRestartAbandonType1", FightRestartAbandonTypeBase)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0._fight_work = slot1
	slot0._fightParam = slot2
	slot0._episode_config = slot3
	slot0._chapter_config = slot4
end

function slot0.canRestart(slot0)
	return slot0:episodeCostIsEnough()
end

function slot0.startAbandon(slot0)
	DungeonFightController.instance:registerCallback(DungeonEvent.OnEndDungeonReply, slot0._startRequestFight, slot0)
	DungeonFightController.instance:sendEndFightRequest(true)
end

function slot0._startRequestFight(slot0, slot1)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, slot0._startRequestFight, slot0)

	if slot1 ~= 0 then
		FightSystem.instance:restartFightFail()

		return
	end

	slot0._fight_work:onDone(true)
end

function slot0.releaseSelf(slot0)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, slot0._startRequestFight, slot0)
	slot0:__onDispose()
end

return slot0
