module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType1", package.seeall)

slot0 = class("FightRestartRequestType1", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0._fight_work = slot1
	slot0._fightParam = slot2
	slot0._episode_config = slot3
	slot0._chapter_config = slot4
end

function slot0.requestFight(slot0)
	slot0._fight_work:onDone(true)
	DungeonFightController.instance:restartStage()
end

function slot0.releaseSelf(slot0)
	slot0:__onDispose()
end

return slot0
