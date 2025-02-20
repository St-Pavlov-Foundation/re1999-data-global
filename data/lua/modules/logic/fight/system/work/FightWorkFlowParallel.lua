module("modules.logic.fight.system.work.FightWorkFlowParallel", package.seeall)

slot0 = class("FightWorkFlowParallel", FightWorkFlowBase)

function slot0.onInitialization(slot0)
	slot0._workList = {}
	slot0._finishCount = 0
end

function slot0.registWork(slot0, slot1, ...)
	slot2 = slot0:registClass(slot1, ...)

	slot2:registFinishCallback(slot0.onWorkItemDone, slot0, slot2)
	table.insert(slot0._workList, slot2)

	return slot2
end

function slot0.addWork(slot0, slot1)
	if slot1.PARENTROOTCLASS and slot1.PARENTROOTCLASS.PARENTROOTCLASS then
		logError("战斗任务流添加work,但是此work是被组件初始化的,已经拥有父节点,请检查代码,类名:" .. slot1.PARENTROOTCLASS.PARENTROOTCLASS.__cname)
	end

	slot1.PARENTROOTCLASS = slot0

	table.insert(slot0._instantiateClass, slot1)
	slot1:registFinishCallback(slot0.onWorkItemDone, slot0, slot1)
	table.insert(slot0._workList, slot1)
end

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()

	if #slot0._workList == 0 then
		return slot0:onDone(true)
	else
		for slot4, slot5 in ipairs(slot0._workList) do
			if not slot5.STARTED then
				slot5:start(slot0.context)
			end
		end
	end
end

function slot0.onWorkItemDone(slot0, slot1)
	slot0._finishCount = slot0._finishCount + 1

	if slot0._finishCount == #slot0._workList then
		return slot0:onDone(true)
	end
end

return slot0
