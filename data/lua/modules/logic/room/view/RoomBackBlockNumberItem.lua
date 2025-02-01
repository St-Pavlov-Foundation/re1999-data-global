module("modules.logic.room.view.RoomBackBlockNumberItem", package.seeall)

slot0 = class("RoomBackBlockNumberItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goTrs = slot1.transform
	slot0._txtnumber = gohelper.findChildText(slot1, "txt_number")
end

function slot0.getGO(slot0)
	return slot0._go
end

function slot0.getGOTrs(slot0)
	return slot0._goTrs
end

function slot0.setNumber(slot0, slot1)
	slot0._txtnumber.text = slot1
end

function slot0.setBlockMO(slot0, slot1)
	slot0._blockMO = slot1

	if slot0._blockMO then
		gohelper.setActive(slot0._go, true)
	else
		gohelper.setActive(slot0._go, false)
	end
end

function slot0.getBlockMO(slot0, slot1)
	return slot0._blockMO
end

return slot0
