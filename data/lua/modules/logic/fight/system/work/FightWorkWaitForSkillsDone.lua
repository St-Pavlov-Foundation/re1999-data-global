module("modules.logic.fight.system.work.FightWorkWaitForSkillsDone", package.seeall)

slot0 = class("FightWorkWaitForSkillsDone", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._skillFlowList = slot1
end

function slot0.onStart(slot0, slot1)
	if slot0:_checkDone() then
		slot0:onDone(true)
	else
		TaskDispatcher.runRepeat(slot0._onTick, slot0, 0.1)
		TaskDispatcher.runDelay(slot0._timeOut, slot0, 5 / Mathf.Clamp(math.min(FightModel.instance:getSpeed(), FightModel.instance:getUISpeed()), 0.01, 1))
	end
end

function slot0._onTick(slot0)
	if slot0:_checkDone() then
		slot0:onDone(true)
	end
end

function slot0._timeOut(slot0)
	if slot0._skillFlowList then
		for slot4, slot5 in ipairs(slot0._skillFlowList) do
			if not slot5:hasDone() then
				logError("检测回合技能完成超时，技能id = " .. slot5._fightStepMO.actId)
			end
		end
	end

	slot0:onDone(true)
end

function slot0._checkDone(slot0)
	if slot0._skillFlowList then
		for slot4, slot5 in ipairs(slot0._skillFlowList) do
			if not slot5:hasDone() then
				return false
			end
		end
	end

	return true
end

function slot0.clearWork(slot0)
	slot0._skillFlowList = nil

	TaskDispatcher.cancelTask(slot0._onTick, slot0)
	TaskDispatcher.cancelTask(slot0._timeOut, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
end

return slot0
