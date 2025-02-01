module("framework.core.taskdispatcher.TaskDispatcher", package.seeall)

return {
	Idle = 1,
	Active = 2,
	ToInsert = 3,
	ToDelete = 4,
	init = function ()
		UpdateBeat:Add(uv0._onUnityUpdate, uv0)

		uv0._taskPool = TaskItem.createPool()
		uv0._allTasks = {}
		uv0._onceIdxList = {}
		uv0._deltaTasks = {}
		uv0._isDispatching = false
	end,
	runDelay = function (slot0, slot1, slot2)
		if not slot0 or not slot2 then
			logError("TaskDispatcher.runDelay, callback or delay should not be null!")

			return
		end

		uv0._addNewTask(slot0, slot1, slot2, 1, false)
	end,
	runRepeat = function (slot0, slot1, slot2, slot3)
		if not slot0 or not slot2 then
			logError("TaskDispatcher.runDelay, callback or interval should not be null!")

			return
		end

		uv0._addNewTask(slot0, slot1, slot2, slot3 or -1, true)
	end,
	cancelTask = function (slot0, slot1)
		if uv0._isDispatching then
			if uv0._getTaskWhichCbInDispatch(slot0, slot1) then
				slot2.status = uv0.ToDelete
			end

			uv0._removeFromDeltaQueue(slot0, slot1)

			slot3 = uv0._taskPool:getObject()
			slot3.status = uv0.ToDelete

			slot3:setCb(slot0, slot1)
			table.insert(uv0._deltaTasks, slot3)
		else
			uv0._directDelete(slot0, slot1)
		end
	end,
	_addNewTask = function (slot0, slot1, slot2, slot3, slot4)
		slot5 = false

		if uv0._isDispatching and uv0._getTaskInDeltaQueue(slot0, slot1) then
			if uv0.ToInsert == slot6.status then
				return
			elseif uv0.ToDelete == slot6.status then
				slot5 = true
			end
		end

		if uv0._getTaskWhichCbInDispatch(slot0, slot1) ~= nil and slot6.isLoop and slot6.status ~= uv0.ToDelete and not slot5 then
			return
		end

		if uv0._isDispatching then
			uv0._removeFromDeltaQueue(slot0, slot1)
		end

		slot7 = uv0._taskPool:getObject()

		slot7:setCb(slot0, slot1)

		slot7.interval = slot2
		slot7.isLoop = slot4
		slot7.repeatCount = slot3
		slot7.addFrame = TaskItem.frameCount
		slot7.status = uv0.Active

		if uv0._isDispatching then
			slot7.status = uv0.ToInsert

			table.insert(uv0._deltaTasks, slot7)
		else
			uv0._directAdd(slot7)
		end
	end,
	_onUnityUpdate = function ()
		uv0._isDispatching = true

		uv0._taskTick(Time.deltaTime)

		uv0._isDispatching = false

		uv0._doAddOrRemove()

		TaskItem.frameCount = TaskItem.frameCount + 1
	end,
	_doAddOrRemove = function ()
		slot1 = nil

		for slot5 = 1, #uv0._deltaTasks do
			if uv0.ToDelete == uv0._deltaTasks[slot5].status then
				uv0._directDelete(slot1.callback, slot1.cbObj)
			elseif uv0.ToInsert == slot1.status then
				uv0._directAdd(slot1)
			end

			uv0._deltaTasks[slot5] = nil
		end
	end,
	_removeFromDeltaQueue = function (slot0, slot1)
		slot3 = nil

		for slot7 = #uv0._deltaTasks, 1, -1 do
			if uv0._deltaTasks[slot7].callback == slot0 and slot3.cbObj == slot1 then
				uv0._taskPool:putObject(slot3)
				table.remove(uv0._deltaTasks, slot7)

				break
			end
		end
	end,
	_directAdd = function (slot0)
		slot1, slot2 = uv0._getTaskWhichCbInDispatch(slot0.callback, slot0.cbObj)

		if slot1 and slot1.status ~= uv0.ToDelete then
			uv0._taskPool:putObject(slot0)

			return
		end

		if slot1 then
			table.remove(uv0._allTasks, slot2)
		end

		slot0.status = uv0.Active

		table.insert(uv0._allTasks, slot0)
	end,
	_directDelete = function (slot0, slot1)
		slot3 = nil

		for slot7 = #uv0._allTasks, 1, -1 do
			if uv0._allTasks[slot7].callback == slot0 and slot3.cbObj == slot1 then
				uv0._taskPool:putObject(slot3)
				table.remove(uv0._allTasks, slot7)
			end
		end
	end,
	_getTaskWhichCbInDispatch = function (slot0, slot1)
		slot3 = nil

		for slot7 = #uv0._allTasks, 1, -1 do
			if uv0._allTasks[slot7].callback == slot0 and slot3.cbObj == slot1 then
				return slot3, slot7
			end
		end

		return nil, 0
	end,
	_getTaskInDeltaQueue = function (slot0, slot1)
		slot2 = nil

		for slot7 = #uv0._deltaTasks, 1, -1 do
			if uv0._deltaTasks[slot7].callback == slot0 and slot2.cbObj == slot1 then
				return slot2
			end
		end

		return nil
	end,
	_taskTick = function (slot0)
		slot2 = false
		slot3 = nil

		for slot7 = 1, #uv0._allTasks do
			if uv0.ToDelete ~= uv0._allTasks[slot7].status and slot3:update(slot0) and slot3.repeatCount == 0 then
				table.insert(uv0._onceIdxList, slot7)
			end
		end

		for slot7 = #uv0._onceIdxList, 1, -1 do
			slot8 = uv0._onceIdxList[slot7]

			uv0._taskPool:putObject(uv0._allTasks[slot8])
			table.remove(uv0._allTasks, slot8)
			table.remove(uv0._onceIdxList, slot7)
		end
	end,
	_logToBeDeleteItems = function ()
		for slot4, slot5 in ipairs(uv0._allTasks) do
			if slot5.status == uv0.ToDelete then
				slot0 = "TaskDispatcher._logToBeDeleteItems: " .. slot4 .. " = " .. slot5:logStr() .. "\n"
			end
		end

		logWarn(slot0)
	end,
	_logAllTasks = function ()
		for slot4, slot5 in ipairs(uv0._allTasks) do
			slot0 = "TaskDispatcher._logToBeDeleteItems: " .. slot4 .. " = " .. slot5:logStr() .. "\n"
		end

		logWarn(slot0)
	end
}
