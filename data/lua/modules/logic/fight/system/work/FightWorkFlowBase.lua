module("modules.logic.fight.system.work.FightWorkFlowBase", package.seeall)

slot0 = class("FightWorkFlowBase", FightWorkItem)
slot1 = 10

function slot0.start(slot0, slot1)
	if slot0.PARENT_ROOT_CLASS then
		if isTypeOf(slot0.PARENT_ROOT_CLASS, FightWorkFlowSequence) or isTypeOf(slot0.PARENT_ROOT_CLASS, uv0) then
			slot0.ROOTFLOW = slot0.PARENT_ROOT_CLASS.ROOTFLOW
			slot0.ROOTFLOW.COUNTERDEEP = slot0.ROOTFLOW.COUNTERDEEP + 1
			slot0.COUNTERDEEP = slot0.ROOTFLOW.COUNTERDEEP
		else
			slot0.ROOTFLOW = slot0
			slot0.COUNTERDEEP = 0
		end
	else
		slot0.ROOTFLOW = slot0
		slot0.COUNTERDEEP = 0
	end

	if slot0.COUNTERDEEP == 0 then
		return FightWorkItem.start(slot0, slot1)
	elseif slot0.COUNTERDEEP % uv1 == 0 then
		return slot0:com_registTimer(FightWorkItem.start, 0.01, slot1)
	else
		return FightWorkItem.start(slot0, slot1)
	end
end

function slot0.onDestructorFinish(slot0)
	if not slot0.COUNTERDEEP then
		return FightWorkItem.onDestructorFinish(slot0)
	end

	if slot0.COUNTERDEEP == 0 then
		return FightWorkItem.onDestructorFinish(slot0)
	elseif slot0.COUNTERDEEP % uv0 == 0 then
		return FightTimer.registTimer(FightWorkItem.onDestructorFinish, slot0, 0.01)
	else
		return FightWorkItem.onDestructorFinish(slot0)
	end
end

return slot0
