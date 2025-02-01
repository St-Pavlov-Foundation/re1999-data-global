module("modules.logic.room.view.RoomViewBuildingResItem", package.seeall)

slot0 = class("RoomViewBuildingResItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goselect = gohelper.findChild(slot0._go, "go_select")
	slot0._gounselect = gohelper.findChild(slot0._go, "go_unselect")
	slot0._goline = gohelper.findChild(slot0._go, "go_line")
	slot0._txt1 = gohelper.findChildText(slot0._go, "go_select/txt")
	slot0._txt2 = gohelper.findChildText(slot0._go, "go_unselect/txt")
	slot0._btnItem = SLFramework.UGUI.ButtonWrap.Get(slot0._go)

	slot0._btnItem:AddClickListener(slot0._btnitemOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnItem:RemoveClickListener()

	slot0._callback = nil
	slot0._callbackObj = nil
end

function slot0._btnitemOnClick(slot0)
	if slot0._callback then
		if slot0._callbackObj ~= nil then
			slot0._callback(slot0._callbackObj, slot0._data)
		else
			slot0._callback(slot0._data)
		end
	end
end

function slot0.getGO(slot0)
	return slot0._go
end

function slot0.setCallback(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2
end

function slot0.setSelect(slot0, slot1)
	if slot0._isSelect == slot1 then
		return
	end

	slot0._isSelect = slot1 and true or false

	gohelper.setActive(slot0._goselect, slot1)
	gohelper.setActive(slot0._gounselect, not slot1)
end

function slot0.getData(slot0)
	return slot0._data
end

function slot0.setData(slot0, slot1)
	if slot0._data ~= slot1 then
		slot0._data = slot1

		slot0:_refreshUI()
	end
end

function slot0.setLineActive(slot0, slot1)
	if slot1 ~= null then
		gohelper.setActive(slot0._goline, slot1)
	end
end

function slot0._refreshUI(slot0)
	if slot0._data and slot0._txt1 then
		slot1 = luaLang(slot0._data.nameLanguage)
		slot0._txt1.text = slot1
		slot0._txt2.text = slot1
	end
end

return slot0
