module("modules.logic.fight.system.work.FightWorkItem", package.seeall)

slot0 = class("FightWorkItem", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0.CALLBACK = {}
	slot0.SAFETIME = 0.5
end

function slot0.start(slot0, slot1)
	if slot0.WORKFINISHED then
		logError("work已经结束了,但是又被调用了start,请检查代码,类名:" .. slot0.__cname)

		return
	end

	if slot0.STARTED then
		logError("work已经开始了,但是又被调用了start,请检查代码,类名:" .. slot0.__cname)

		return
	end

	if slot0.IS_DISPOSED then
		logError("work已经被释放了,但是又被调用了start,请检查代码,类名:" .. slot0.__cname)

		return
	end

	slot0.context = slot1
	slot0.STARTED = true
	slot0.EXCLUSIVETIMER = {}
	slot0.SAFETIMER = slot0:com_registTimer(slot0._fightWorkSafeTimer, slot0.SAFETIME)

	table.insert(slot0.EXCLUSIVETIMER, slot0.SAFETIMER)
	slot0:beforeStart()

	return slot0:onStart()
end

function slot0.cancelFightWorkSafeTimer(slot0)
	return slot0:com_cancelTimer(slot0.SAFETIMER)
end

function slot0._fightWorkSafeTimer(slot0)
	logError("战斗保底 fightwork ondone, className = " .. slot0.__cname)

	return slot0:onDone(false)
end

function slot0._delayAfterPerformance(slot0)
	return slot0:onDone(true)
end

function slot0._delayDone(slot0)
	return slot0:onDone(true)
end

function slot0.finishWork(slot0)
	return slot0:onDone(true)
end

function slot0.com_registTimer(slot0, slot1, slot2, slot3)
	if slot1 == slot0._delayDone or slot1 == slot0._delayAfterPerformance then
		slot0:releaseExclusiveTimer()

		slot4 = uv0.super.com_registTimer(slot0, slot1, slot2, slot3)

		table.insert(slot0.EXCLUSIVETIMER, slot4)

		return slot4
	end

	return uv0.super.com_registTimer(slot0, slot1, slot2, slot3)
end

function slot0.releaseExclusiveTimer(slot0)
	if slot0.EXCLUSIVETIMER then
		for slot4 = #slot0.EXCLUSIVETIMER, 1, -1 do
			slot0:com_cancelTimer(slot0.EXCLUSIVETIMER[slot4])
			table.remove(slot0.EXCLUSIVETIMER, slot4)
		end
	end
end

function slot0.com_registWorkDoneFlowSequence(slot0)
	slot1 = slot0:com_registCustomFlow(FightWorkDoneFlowSequence)

	slot1:registFinishCallback(slot0.finishWork, slot0)

	return slot1
end

function slot0.com_registWorkDoneFlowParallel(slot0)
	slot1 = slot0:com_registCustomFlow(FightWorkDoneFlowParallel)

	slot1:registFinishCallback(slot0.finishWork, slot0)

	return slot1
end

function slot0.beforeStart(slot0)
end

function slot0.onStart(slot0)
end

function slot0.beforeClearWork(slot0)
end

function slot0.clearWork(slot0)
end

function slot0.registFinishCallback(slot0, slot1, slot2, slot3)
	if slot0.IS_DISPOSED or slot0.WORKFINISHED then
		return slot1(slot2, slot3)
	end

	table.insert(slot0.CALLBACK, {
		callback = slot1,
		handle = slot2,
		param = slot3
	})
end

function slot0.onDestructor(slot0)
	if slot0.STARTED then
		slot0:beforeClearWork()

		return slot0:clearWork()
	end
end

function slot0.onDestructorFinish(slot0)
	slot0:playCallback(slot0.CALLBACK)

	slot0.CALLBACK = nil
end

function slot0.playCallback(slot0, slot1)
	if slot0.WORKFINISHED or slot0.STARTED then
		slot2 = slot0.SUCCEEDED and true or false
		slot3 = #slot1

		for slot7, slot8 in ipairs(slot1) do
			slot9 = slot0.WORKFINISHED

			if not slot0.WORKFINISHED and slot0.STARTED and isTypeOf(slot8.handle, FightBaseClass) and not slot10.IS_RELEASING then
				slot9 = true
			end

			if slot9 then
				if slot8.handle then
					if not slot10.IS_DISPOSED then
						if slot7 == slot3 then
							return slot8.callback(slot10, slot8.param, slot2)
						else
							slot11(slot10, slot12, slot2)
						end
					end
				elseif slot7 == slot3 then
					return slot11(slot12, slot2)
				else
					slot11(slot12, slot2)
				end
			end
		end
	end
end

function slot0.onDone(slot0, slot1)
	if slot0.FIGHT_WORK_ENTRUSTED then
		slot0.FIGHT_WORK_ENTRUSTED = nil
	end

	if slot0.IS_DISPOSED then
		logError("work已经被释放了,但是又被调用了onDone,请检查代码,类名:" .. slot0.__cname)

		return
	end

	if slot0.WORKFINISHED then
		logError("work已经完成了,但是又被调用了onDone,请检查代码,类名:" .. slot0.__cname)

		return
	end

	slot0.WORKFINISHED = true
	slot0.SUCCEEDED = slot1

	return slot0:disposeSelf()
end

function slot0.onDoneAndKeepPlay(slot0)
	slot0.FIGHT_WORK_ENTRUSTED = true
	slot0.SUCCEEDED = true
	slot0.CALLBACK = {}

	slot0:playCallback(tabletool.copy(slot0.CALLBACK))

	if not slot0:com_sendMsg(FightMsgId.EntrustFightWork, slot0) then
		logError("托管fightwork未成功,类名:" .. slot0.__cname)

		slot0.FIGHT_WORK_ENTRUSTED = nil

		slot0:disposeSelf()
	end
end

function slot0.disposeSelf(slot0)
	if slot0.FIGHT_WORK_ENTRUSTED then
		return
	end

	uv0.super.disposeSelf(slot0)
end

return slot0
