module("modules.logic.fight.system.work.FightWorkEnterFightDeal", package.seeall)

slot0 = class("FightWorkEnterFightDeal", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getVersion() < 4 then
		slot0:onDone(true)

		return
	end

	slot2 = slot0:com_registWorkDoneFlowSequence()

	slot2:addWork(Work2FightWork.New(FightWorkDistributeCard))
	slot2:registWork(FightWorkFunction, slot0._afterDistribute, slot0)
	slot2:start()
end

function slot0._afterDistribute(slot0)
	FightController.instance:setCurStage(FightEnum.Stage.StartRound)
end

function slot0.clearWork(slot0)
end

return slot0
