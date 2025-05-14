module("framework.core.eventsystem.LuaEventSystem", package.seeall)

local var_0_0 = {}

var_0_0.Idle = 1
var_0_0.Active = 2
var_0_0.ToInsert = 3
var_0_0.ToDelete = 4
var_0_0.High = 1
var_0_0.Common = 2
var_0_0.Low = 3

function var_0_0.addEventMechanism(arg_1_0)
	arg_1_0._allEvents = {}
	arg_1_0._allDeltaEvents = {}
	arg_1_0._inDispatching = {}
	arg_1_0._dispatchDelta = {}

	function arg_1_0.registerCallback(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		if arg_2_2 == nil then
			logError("LuaEventSystem registerCallback callback shoule not be nil, please check it!")

			return
		end

		local var_2_0 = false

		if arg_2_0._inDispatching[arg_2_1] then
			local var_2_1 = arg_2_0:_getStatusInDeltaList(arg_2_1, arg_2_2, arg_2_3)

			if var_2_1 == var_0_0.ToDelete then
				var_2_0 = true
			elseif var_2_1 == var_0_0.ToInsert then
				return
			end
		end

		if arg_2_0:_isInEventQueue(arg_2_1, arg_2_2, arg_2_3) and not var_2_0 then
			return
		end

		local var_2_2 = EventItem.getPool():getObject()

		var_2_2.eventName = arg_2_1
		var_2_2.callback = arg_2_2

		var_2_2:setCbObj(arg_2_3)

		var_2_2.priority = arg_2_4 or var_0_0.Common

		if arg_2_0._inDispatching[arg_2_1] then
			arg_2_0:_removeFromDeltaList(arg_2_1, arg_2_2, arg_2_3)

			var_2_2.status = var_0_0.ToInsert

			local var_2_3 = arg_2_0._allDeltaEvents[arg_2_1]

			if not var_2_3 then
				var_2_3 = {}
				arg_2_0._allDeltaEvents[arg_2_1] = var_2_3
			end

			table.insert(var_2_3, var_2_2)
		else
			arg_2_0:_directAddEvent(var_2_2)
		end
	end

	function arg_1_0.unregisterCallback(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if not arg_3_0._allEvents[arg_3_1] then
			return
		end

		if arg_3_0._inDispatching[arg_3_1] then
			arg_3_0:_removeFromDeltaList(arg_3_1, arg_3_2, arg_3_3, arg_3_4)

			local var_3_0 = EventItem.getPool():getObject()

			var_3_0.eventName = arg_3_1
			var_3_0.callback = arg_3_2

			var_3_0:setCbObj(arg_3_3)

			var_3_0.status = var_0_0.ToDelete
			var_3_0.removeAll = arg_3_4

			local var_3_1 = arg_3_0._allDeltaEvents[arg_3_1]

			if not var_3_1 then
				var_3_1 = {}
				arg_3_0._allDeltaEvents[arg_3_1] = var_3_1
			end

			table.insert(var_3_1, var_3_0)
		else
			arg_3_0:_directRemoveEvent(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		end
	end

	function arg_1_0.unregisterAllCallback(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0._allEvents[arg_4_1]

		if not var_4_0 then
			return
		end

		local var_4_1 = {}
		local var_4_2

		for iter_4_0 = var_0_0.High, var_0_0.Low do
			local var_4_3 = var_4_0[iter_4_0]

			for iter_4_1 = 1, #var_4_3 do
				local var_4_4 = var_4_3[iter_4_1]
				local var_4_5 = EventItem.getPool():getObject()

				var_4_5.callback = var_4_4.callback

				var_4_5:setCbObj(var_4_4:getCbObj())
				table.insert(var_4_1, var_4_5)
			end
		end

		for iter_4_2, iter_4_3 in ipairs(var_4_1) do
			arg_4_0:unregisterCallback(arg_4_1, iter_4_3.callback, iter_4_3:getCbObj())
		end
	end

	function arg_1_0.dispatchEvent(arg_5_0, arg_5_1, ...)
		if arg_1_0._allEvents == nil or arg_1_0._allEvents[arg_5_1] == nil then
			return
		end

		if arg_1_0._inDispatching[arg_5_1] then
			local var_5_0 = DispatchItem.getPool():getObject()

			var_5_0.eventName = arg_5_1

			if ... == nil then
				var_5_0.eventArgs = nil
			else
				var_5_0.eventArgs = {
					...
				}
			end

			table.insert(arg_1_0._dispatchDelta, var_5_0)

			return
		end

		arg_1_0._inDispatching[arg_5_1] = true

		arg_5_0:_directDispatch(arg_5_1, ...)

		arg_1_0._inDispatching[arg_5_1] = nil

		local var_5_1 = arg_5_0._allDeltaEvents[arg_5_1]

		if var_5_1 ~= nil then
			local var_5_2 = #var_5_1
			local var_5_3

			for iter_5_0 = 1, var_5_2 do
				local var_5_4 = var_5_1[iter_5_0]

				if var_0_0.ToInsert == var_5_4.status then
					arg_5_0:_directAddEvent(var_5_4)
				elseif var_0_0.ToDelete == var_5_4.status then
					arg_5_0:_directRemoveEvent(var_5_4.eventName, var_5_4.callback, var_5_4:getCbObj(), var_5_4.removeAll)
					EventItem.getPool():putObject(var_5_4)
				end

				var_5_1[iter_5_0] = nil
			end
		end

		if #arg_5_0._dispatchDelta > 0 then
			local var_5_5 = table.remove(arg_5_0._dispatchDelta, 1)

			if not arg_5_0._inDispatching[var_5_5.eventName] then
				if var_5_5.eventArgs ~= nil then
					arg_5_0:dispatchEvent(var_5_5.eventName, unpack(var_5_5.eventArgs))
				else
					arg_5_0:dispatchEvent(var_5_5.eventName)
				end

				DispatchItem.getPool():putObject(var_5_5)
			else
				table.insert(arg_5_0._dispatchDelta, 1, var_5_5)
			end
		end
	end

	function arg_1_0._directDispatch(arg_6_0, arg_6_1, ...)
		local var_6_0 = arg_1_0._allEvents[arg_6_1]
		local var_6_1
		local var_6_2
		local var_6_3

		for iter_6_0 = var_0_0.High, var_0_0.Low do
			local var_6_4 = var_6_0[iter_6_0]
			local var_6_5 = #var_6_4

			for iter_6_1 = 1, var_6_5 do
				local var_6_6 = var_6_4[iter_6_1]

				if not var_6_6:dispatch(...) then
					arg_6_0:unregisterCallback(arg_6_1, var_6_6.callback, var_6_6:getCbObj())
				end
			end
		end
	end

	function arg_1_0._directAddEvent(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0._allEvents[arg_7_1.eventName]

		if var_7_0 == nil then
			var_7_0 = {}

			for iter_7_0 = var_0_0.High, var_0_0.Low do
				var_7_0[iter_7_0] = {}
			end

			arg_7_0._allEvents[arg_7_1.eventName] = var_7_0
		end

		if arg_7_0:_isInEventQueue(arg_7_1.eventName, arg_7_1.callback, arg_7_1:getCbObj()) then
			EventItem.getPool():putObject(arg_7_1)

			return
		end

		arg_7_1.status = var_0_0.Active

		table.insert(var_7_0[arg_7_1.priority], arg_7_1)
	end

	function arg_1_0._isInEventQueue(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_8_0._allEvents[arg_8_1]

		if var_8_0 == nil then
			return false
		end

		local var_8_1

		for iter_8_0 = var_0_0.High, var_0_0.Low do
			local var_8_2 = var_8_0[iter_8_0]

			for iter_8_1 = 1, #var_8_2 do
				local var_8_3 = var_8_2[iter_8_1]

				if var_8_3.callback == arg_8_2 and var_8_3:getCbObj() == arg_8_3 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0._directRemoveEvent(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		local var_9_0 = arg_9_0._allEvents[arg_9_1]

		if var_9_0 == nil then
			return
		end

		local var_9_1

		for iter_9_0 = var_0_0.High, var_0_0.Low do
			local var_9_2 = var_9_0[iter_9_0]

			for iter_9_1 = #var_9_2, 1, -1 do
				local var_9_3 = var_9_2[iter_9_1]

				if var_9_3.callback == arg_9_2 then
					if arg_9_4 then
						EventItem.getPool():putObject(var_9_3)
						table.remove(var_9_2, iter_9_1)
					elseif var_9_3:getCbObj() == arg_9_3 then
						EventItem.getPool():putObject(var_9_3)
						table.remove(var_9_2, iter_9_1)

						break
					end
				end
			end
		end
	end

	function arg_1_0._getStatusInDeltaList(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = arg_10_0._allDeltaEvents[arg_10_1]

		if var_10_0 == nil then
			return 0
		end

		local var_10_1

		for iter_10_0 = #var_10_0, 1, -1 do
			local var_10_2 = var_10_0[iter_10_0]

			if var_10_2.eventName == arg_10_1 and var_10_2.callback == arg_10_2 and var_10_2:getCbObj() == arg_10_3 then
				return var_10_2.status
			end
		end
	end

	function arg_1_0._removeFromDeltaList(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		local var_11_0 = arg_11_0._allDeltaEvents[arg_11_1]

		if not var_11_0 then
			return
		end

		local var_11_1

		for iter_11_0 = #var_11_0, 1, -1 do
			local var_11_2 = var_11_0[iter_11_0]

			if var_11_2.callback == arg_11_2 then
				if arg_11_4 then
					EventItem.getPool():putObject(var_11_2)
					table.remove(var_11_0, iter_11_0)
				elseif var_11_2:getCbObj() == arg_11_3 then
					EventItem.getPool():putObject(var_11_2)
					table.remove(var_11_0, iter_11_0)

					break
				end
			end
		end
	end
end

return var_0_0
