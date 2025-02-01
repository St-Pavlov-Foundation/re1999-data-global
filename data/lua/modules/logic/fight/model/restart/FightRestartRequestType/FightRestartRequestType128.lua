module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType128", package.seeall)

slot0 = class("FightRestartRequestType128", FightRestartRequestType1)

function slot0.requestFight(slot0)
	slot0._fight_work:onDone(true)
	DungeonFightController.instance:restartStage()
end

return slot0
