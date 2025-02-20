module("modules.logic.fight.system.work.FightWorkDouQuQuGMEnd", package.seeall)

slot0 = class("FightWorkDouQuQuGMEnd", FightWorkItem)

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()
	slot0:_onDouQuQuSettlementFinish()
end

function slot0._onDouQuQuSettlementFinish(slot0)
	FightSystem.instance:dispose()
	FightModel.instance:clearRecordMO()
	FightController.instance:exitFightScene()
end

return slot0
