module("framework.core.eventsystem.LuaEventSystem", package.seeall)

return {
	Idle = 1,
	Active = 2,
	ToInsert = 3,
	ToDelete = 4,
	High = 1,
	Common = 2,
	Low = 3,
	addEventMechanism = function (slot0)
		slot0._allEvents = {}
		slot0._allDeltaEvents = {}
		slot0._inDispatching = {}
		slot0._dispatchDelta = {}

		function slot0.registerCallback(slot0, slot1, slot2, slot3, slot4)
			if slot2 == nil then
				logError("LuaEventSystem registerCallback callback shoule not be nil, please check it!")

				return
			end

			slot5 = false

			if slot0._inDispatching[slot1] then
				if slot0:_getStatusInDeltaList(slot1, slot2, slot3) == uv0.ToDelete then
					slot5 = true
				elseif slot6 == uv0.ToInsert then
					return
				end
			end

			if slot0:_isInEventQueue(slot1, slot2, slot3) and not slot5 then
				return
			end

			slot7 = EventItem.getPool():getObject()
			slot7.eventName = slot1
			slot7.callback = slot2

			slot7:setCbObj(slot3)

			slot7.priority = slot4 or uv0.Common

			if slot0._inDispatching[slot1] then
				slot0:_removeFromDeltaList(slot1, slot2, slot3)

				slot7.status = uv0.ToInsert

				if not slot0._allDeltaEvents[slot1] then
					slot0._allDeltaEvents[slot1] = {}
				end

				table.insert(slot8, slot7)
			else
				slot0:_directAddEvent(slot7)
			end
		end

		function slot0.unregisterCallback(slot0, slot1, slot2, slot3, slot4)
			if not slot0._allEvents[slot1] then
				return
			end

			if slot0._inDispatching[slot1] then
				slot0:_removeFromDeltaList(slot1, slot2, slot3, slot4)

				slot6 = EventItem.getPool():getObject()
				slot6.eventName = slot1
				slot6.callback = slot2

				slot6:setCbObj(slot3)

				slot6.status = uv0.ToDelete
				slot6.removeAll = slot4

				if not slot0._allDeltaEvents[slot1] then
					slot0._allDeltaEvents[slot1] = {}
				end

				table.insert(slot7, slot6)
			else
				slot0:_directRemoveEvent(slot1, slot2, slot3, slot4)
			end
		end

		function slot0.unregisterAllCallback(slot0, slot1)
			if not slot0._allEvents[slot1] then
				return
			end

			slot3 = {}
			slot4 = nil

			for slot8 = uv0.High, uv0.Low do
				for slot12 = 1, #slot2[slot8] do
					slot13 = slot4[slot12]
					slot14 = EventItem.getPool():getObject()
					slot14.callback = slot13.callback

					slot14:setCbObj(slot13:getCbObj())
					table.insert(slot3, slot14)
				end
			end

			for slot8, slot9 in ipairs(slot3) do
				slot0:unregisterCallback(slot1, slot9.callback, slot9:getCbObj())
			end
		end

		function slot0.dispatchEvent(slot0, slot1, ...)
			if uv0._allEvents == nil or uv0._allEvents[slot1] == nil then
				return
			end

			if uv0._inDispatching[slot1] then
				DispatchItem.getPool():getObject().eventName = slot1

				if ... == nil then
					slot2.eventArgs = nil
				else
					slot2.eventArgs = {
						...
					}
				end

				table.insert(uv0._dispatchDelta, slot2)

				return
			end

			uv0._inDispatching[slot1] = true

			slot0:_directDispatch(slot1, ...)

			uv0._inDispatching[slot1] = nil

			if slot0._allDeltaEvents[slot1] ~= nil then
				slot4 = nil

				for slot8 = 1, #slot2 do
					if uv1.ToInsert == slot2[slot8].status then
						slot0:_directAddEvent(slot4)
					elseif uv1.ToDelete == slot4.status then
						slot0:_directRemoveEvent(slot4.eventName, slot4.callback, slot4:getCbObj(), slot4.removeAll)
						EventItem.getPool():putObject(slot4)
					end

					slot2[slot8] = nil
				end
			end

			if #slot0._dispatchDelta > 0 then
				if not slot0._inDispatching[table.remove(slot0._dispatchDelta, 1).eventName] then
					if slot3.eventArgs ~= nil then
						slot0:dispatchEvent(slot3.eventName, unpack(slot3.eventArgs))
					else
						slot0:dispatchEvent(slot3.eventName)
					end

					DispatchItem.getPool():putObject(slot3)
				else
					table.insert(slot0._dispatchDelta, 1, slot3)
				end
			end
		end

		function slot0._directDispatch(slot0, slot1, ...)
			slot2 = uv0._allEvents[slot1]
			slot3, slot4, slot5 = nil

			for slot9 = uv1.High, uv1.Low do
				for slot13 = 1, #slot2[slot9] do
					if not slot3[slot13]:dispatch(...) then
						slot0:unregisterCallback(slot1, slot5.callback, slot5:getCbObj())
					end
				end
			end
		end

		function slot0._directAddEvent(slot0, slot1)
			if slot0._allEvents[slot1.eventName] == nil then
				for slot6 = uv0.High, uv0.Low do
				end

				slot0._allEvents[slot1.eventName] = {
					[slot6] = {}
				}
			end

			if slot0:_isInEventQueue(slot1.eventName, slot1.callback, slot1:getCbObj()) then
				EventItem.getPool():putObject(slot1)

				return
			end

			slot1.status = uv0.Active

			table.insert(slot2[slot1.priority], slot1)
		end

		function slot0._isInEventQueue(slot0, slot1, slot2, slot3)
			if slot0._allEvents[slot1] == nil then
				return false
			end

			slot5 = nil

			for slot9 = uv0.High, uv0.Low do
				for slot13 = 1, #slot4[slot9] do
					if slot5[slot13].callback == slot2 and slot14:getCbObj() == slot3 then
						return true
					end
				end
			end

			return false
		end

		function slot0._directRemoveEvent(slot0, slot1, slot2, slot3, slot4)
			if slot0._allEvents[slot1] == nil then
				return
			end

			slot6 = nil

			for slot10 = uv0.High, uv0.Low do
				for slot14 = #slot5[slot10], 1, -1 do
					if slot6[slot14].callback == slot2 then
						if slot4 then
							EventItem.getPool():putObject(slot15)
							table.remove(slot6, slot14)
						elseif slot15:getCbObj() == slot3 then
							EventItem.getPool():putObject(slot15)
							table.remove(slot6, slot14)

							break
						end
					end
				end
			end
		end

		function slot0._getStatusInDeltaList(slot0, slot1, slot2, slot3)
			if slot0._allDeltaEvents[slot1] == nil then
				return 0
			end

			slot5 = nil

			for slot9 = #slot4, 1, -1 do
				if slot4[slot9].eventName == slot1 and slot5.callback == slot2 and slot5:getCbObj() == slot3 then
					return slot5.status
				end
			end
		end

		function slot0._removeFromDeltaList(slot0, slot1, slot2, slot3, slot4)
			if not slot0._allDeltaEvents[slot1] then
				return
			end

			slot6 = nil

			for slot10 = #slot5, 1, -1 do
				if slot5[slot10].callback == slot2 then
					if slot4 then
						EventItem.getPool():putObject(slot6)
						table.remove(slot5, slot10)
					elseif slot6:getCbObj() == slot3 then
						EventItem.getPool():putObject(slot6)
						table.remove(slot5, slot10)

						break
					end
				end
			end
		end
	end
}
