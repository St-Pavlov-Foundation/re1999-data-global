module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType34", package.seeall)

slot0 = class("FightRestartRequestType34", FightRestartRequestType1)

function slot0.requestFight(slot0)
	slot0._fight_work:onDone(true)
	TowerController.instance:restartStage()
end

return slot0
