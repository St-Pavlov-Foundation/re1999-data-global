module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType29", package.seeall)

slot0 = class("FightRestartRequestType29", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0._fight_work = slot1
end

function slot0.requestFight(slot0)
	DungeonFightController.instance:restartStage()
	slot0._fight_work:onDone(true)
end

function slot0.releaseSelf(slot0)
	slot0:__onDispose()
end

return slot0
