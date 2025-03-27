module("modules.logic.versionactivity2_4.pinball.view.PinballTalentTabItem", package.seeall)

slot0 = class("PinballTalentTabItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goselect = gohelper.findChild(slot1, "selectbg")
	slot0._gounselect = gohelper.findChild(slot1, "unselectbg")
	slot0._txtname = gohelper.findChildTextMesh(slot1, "#txt_name")
	slot0._click = gohelper.getClick(slot1)
	slot0._red = gohelper.findChild(slot1, "go_reddot")
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
	PinballController.instance:registerCallback(PinballEvent.TalentRedChange, slot0._onTalentRedChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.TalentRedChange, slot0._onTalentRedChange, slot0)
end

function slot0.setData(slot0, slot1)
	slot0._txtname.text = slot1.co.name
	slot0._data = slot1

	slot0:_onTalentRedChange()
end

function slot0._onTalentRedChange(slot0)
	gohelper.setActive(slot0._red, PinballModel.instance:getTalentRed(slot0._data.co.id))
end

function slot0.setSelectData(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1 == slot0._data)
	gohelper.setActive(slot0._gounselect, slot1 ~= slot0._data)
end

function slot0.setClickCall(slot0, slot1, slot2)
	slot0.callback = slot1
	slot0.callobj = slot2
end

function slot0._onClick(slot0)
	if slot0.callback then
		slot0.callback(slot0.callobj, slot0._data)
	end
end

return slot0
