module("modules.logic.fight.system.work.FightWorkDouQuQuEnd", package.seeall)

slot0 = class("FightWorkDouQuQuEnd", FightWorkItem)

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()
	slot0:com_registFightEvent(FightEvent.DouQuQuSettlementFinish, slot0._onDouQuQuSettlementFinish)
	Activity174Controller.instance:openFightResultView()
end

function slot0._onDouQuQuSettlementFinish(slot0)
	FightSystem.instance:dispose()
	FightModel.instance:clearRecordMO()
	FightController.instance:exitFightScene()
end

return slot0
