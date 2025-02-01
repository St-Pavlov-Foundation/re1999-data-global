module("modules.logic.fight.system.work.FightWorkFastRestartRequest", package.seeall)

slot0 = class("FightWorkFastRestartRequest", BaseWork)

function slot0.onStart(slot0)
	DungeonFightController.instance:restartStage()
	slot0:onDone(true)
end

return slot0
