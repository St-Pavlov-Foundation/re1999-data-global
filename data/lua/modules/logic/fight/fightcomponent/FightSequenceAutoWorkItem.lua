module("modules.logic.fight.fightcomponent.FightSequenceAutoWorkItem", package.seeall)

slot0 = class("FightSequenceAutoWorkItem", FightBaseClass)

function slot0.onInitialization(slot0)
	slot0._sequeueWork = {}
end

function slot0.registAutoWork(slot0, slot1, ...)
	slot2 = slot0:registClass(slot1, ...)

	slot0:insert(slot2)

	return slot2
end

function slot0.playAutoWork(slot0, slot1)
	if slot1.PARENTROOTCLASS and slot1.PARENTROOTCLASS.PARENTROOTCLASS then
		logError("战斗任务流添加work,但是此work是被组件初始化的,已经拥有父节点,请检查代码,类名:" .. slot1.PARENTROOTCLASS.PARENTROOTCLASS.__cname)
	end

	slot1.PARENTROOTCLASS = slot0

	slot0:insert(slot1)

	return slot1
end

function slot0.insert(slot0, slot1)
	slot1:registFinishCallback(slot0._onQueueWorkFinish, slot0)
	table.insert(slot0._sequeueWork, slot1)

	if #slot0._sequeueWork == 1 then
		return slot1:start()
	end
end

function slot0._onQueueWorkFinish(slot0)
	if slot0._sequeueWork then
		table.remove(slot1, 1)

		if slot1[1] then
			return slot2:start()
		end
	end
end

function slot0.onDestructor(slot0)
end

return slot0
