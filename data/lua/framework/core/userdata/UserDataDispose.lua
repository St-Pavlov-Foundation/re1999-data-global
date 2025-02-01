module("framework.core.userdata.UserDataDispose", package.seeall)

slot0 = class("UserDataDispose")

function slot0.__onInit(slot0)
	getmetatable(slot0).__newindex = function (slot0, slot1, slot2)
		rawset(slot0, slot1, slot2)

		if type(slot2) == "userdata" then
			if not rawget(slot0, "__userDataKeys") then
				rawset(slot0, "__userDataKeys", {})
			end

			slot0.__userDataKeys[slot1] = true
		end
	end

	slot0.__userDataTbs = {}
	slot0.__eventTbs = {}
	slot0.__clickObjs = {}
end

function slot0.__onDispose(slot0)
	if slot0.__userDataKeys then
		for slot5, slot6 in pairs(slot0.__userDataKeys) do
			rawset(slot0, slot5, nil)
		end

		slot0.__userDataKeys = nil
	end

	if slot0.__userDataTbs then
		for slot4, slot5 in ipairs(slot0.__userDataTbs) do
			for slot9 in pairs(slot5) do
				rawset(slot5, slot9, nil)
			end

			rawset(slot0.__userDataTbs, slot4, nil)
		end

		slot0.__userDataTbs = nil
	end

	if slot0.__eventTbs then
		for slot4, slot5 in ipairs(slot0.__eventTbs) do
			slot5[1]:unregisterCallback(slot5[2], slot5[3], slot5[4])
		end

		slot0.__eventTbs = nil
	end

	if slot0.__clickObjs then
		for slot4, slot5 in pairs(slot0.__clickObjs) do
			if not slot4:Equals(nil) then
				slot4:RemoveClickListener()
			end
		end

		slot0.__clickObjs = nil
	end
end

function slot0.getUserDataTb_(slot0)
	slot1 = {}

	if slot0.__userDataTbs then
		table.insert(slot0.__userDataTbs, slot1)
	end

	return slot1
end

function slot0.addEventCb(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot1 or not slot2 or not slot3 then
		logError("UserDataDispose:addEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	slot1:registerCallback(slot2, slot3, slot4, slot5)

	if slot0.__eventTbs then
		for slot9, slot10 in ipairs(slot0.__eventTbs) do
			if slot10[1] == slot1 and slot10[2] == slot2 and slot10[3] == slot3 and slot10[4] == slot4 then
				return
			end
		end
	end

	table.insert(slot0.__eventTbs, {
		slot1,
		slot2,
		slot3,
		slot4
	})
end

function slot0.removeEventCb(slot0, slot1, slot2, slot3, slot4)
	if not slot1 or not slot2 or not slot3 then
		logError("UserDataDispose:removeEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	if slot0.__eventTbs then
		for slot8, slot9 in ipairs(slot0.__eventTbs) do
			if slot9[1] == slot1 and slot9[2] == slot2 and slot9[3] == slot3 and slot9[4] == slot4 then
				table.remove(slot0.__eventTbs, slot8)

				break
			end
		end
	end

	slot1:unregisterCallback(slot2, slot3, slot4)
end

function slot0.addClickCb(slot0, slot1, slot2, slot3, slot4)
	if not slot1 or slot1:Equals(nil) or not slot2 or not slot3 then
		logError("UserDataDispose:addClickCb clickObj or callback or cbObj is null!")

		return
	end

	if slot0.__clickObjs and not slot0.__clickObjs[slot1] then
		slot0.__clickObjs[slot1] = true

		slot1:AddClickListener(slot2, slot3, slot4)
	end
end

function slot0.removeClickCb(slot0, slot1)
	if not slot1 or slot1:Equals(nil) then
		logError("UserDataDispose:removeClickCb clickObj is null!")

		return
	end

	if slot0.__clickObjs and slot0.__clickObjs[slot1] then
		slot0.__clickObjs[slot1] = nil

		slot1:RemoveClickListener()
	end
end

return slot0
