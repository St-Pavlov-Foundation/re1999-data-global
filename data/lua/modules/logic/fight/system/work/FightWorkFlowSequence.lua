module("modules.logic.fight.system.work.FightWorkFlowSequence", package.seeall)

slot0 = class("FightWorkFlowSequence", FightWorkFlowBase)

function slot0.onInitialization(slot0)
	slot0._workList = {}
	slot0._curIndex = 0
	slot0._startIndex = 0
	slot0._playStartCount = 0
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

	return slot0:_playNext()
end

function slot0._playNext(slot0)
	slot0._curIndex = slot0._curIndex + 1

	if slot0._workList[slot0._curIndex] then
		if slot1.WORKFINISHED then
			return slot0:_playNext()
		elseif not slot1.STARTED then
			slot0._playStartCount = slot0._playStartCount + 1

			if slot0._playStartCount == 1 then
				slot0._startIndex = slot0._curIndex

				while slot0._playStartCount ~= 0 do
					slot2 = slot0._workList[slot0._startIndex]

					xpcall(slot2.start, __G__TRACKBACK__, slot2, slot0.context)

					slot0._playStartCount = slot0._playStartCount - 1
					slot0._startIndex = slot0._startIndex + 1
				end

				if slot0._curIndex > #slot0._workList then
					return slot0:onDone(true)
				end
			elseif slot0._playStartCount < 1 then
				return slot0:onDone(true)
			end
		end
	elseif slot0._playStartCount == 0 then
		return slot0:onDone(true)
	end
end

function slot0.onWorkItemDone(slot0, slot1)
	if slot1 == slot0._workList[slot0._curIndex] then
		return slot0:_playNext()
	end
end

return slot0
