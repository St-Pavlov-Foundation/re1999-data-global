module("modules.logic.fight.system.work.FightWorkItem", package.seeall)

slot0 = class("FightWorkItem", FightBaseClass)

function slot0.onInitialization(slot0)
	slot0.CALLBACK = {}
	slot0.SAFETIME = 0.5
end

function slot0.start(slot0, slot1)
	if slot0.WORKFINISHED then
		return
	end

	if slot0.STARTED then
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

function slot0.beforeStart(slot0)
end

function slot0.onStart(slot0)
end

function slot0.beforeClearWork(slot0)
end

function slot0.clearWork(slot0)
end

function slot0.registFinishCallback(slot0, slot1, slot2, slot3)
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
	if slot0.WORKFINISHED then
		for slot5, slot6 in ipairs(slot0.CALLBACK) do
			if slot6.handle then
				if not slot6.handle.INVOKEDDISPOSE then
					if slot5 == #slot0.CALLBACK then
						return slot6.callback(slot6.handle, slot6.param, slot0.SUCCEEDED)
					else
						slot6.callback(slot6.handle, slot6.param, slot0.SUCCEEDED)
					end
				end
			elseif slot5 == slot1 then
				return slot6.callback(slot6.param, slot0.SUCCEEDED)
			else
				slot6.callback(slot6.param, slot0.SUCCEEDED)
			end
		end
	end

	slot0.CALLBACK = nil
end

function slot0.onDone(slot0, slot1)
	if slot0.INVOKEDDISPOSE then
		return
	end

	if slot0.WORKFINISHED then
		return
	end

	slot0.WORKFINISHED = true
	slot0.SUCCEEDED = slot1

	return slot0:disposeSelf()
end

return slot0
