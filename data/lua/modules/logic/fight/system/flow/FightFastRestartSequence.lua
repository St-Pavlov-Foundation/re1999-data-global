module("modules.logic.fight.system.flow.FightFastRestartSequence", package.seeall)

slot0 = class("FightFastRestartSequence", BaseFightSequence)

function slot0.buildFlow(slot0)
	uv0.super.buildFlow(slot0)

	slot1 = FightModel.instance:getFightParam()

	slot0:addWork(FightWorkRestartBefore.New(slot1))
	slot0:addWork(FightWorkFastRestartRequest.New(slot1))
end

return slot0
