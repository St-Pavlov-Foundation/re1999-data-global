module("modules.logic.versionactivity1_3.act125.view.VersionActivity1_3RadioChannelItem", package.seeall)

slot0 = class("VersionActivity1_3RadioChannelItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtFMChannelNumSelected = gohelper.findChildText(slot1, "txt_FMChannelNumSelected")
	slot0._txtFMChannelNumUnSelected = gohelper.findChildText(slot1, "txt_FMChannelNumUnSelected")
	slot0._click = gohelper.getClick(slot1)
end

function slot0.addEventListeners(slot0)
	Activity125Controller.instance:registerCallback(Activity125Event.OnFMScrollValueChange, slot0._refreshFMSliderItem, slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.OnFMScrollValueChange, slot0._refreshFMSliderItem, slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0._txtFMChannelNumSelected.gameObject, not slot1.isEmpty)
	gohelper.setActive(slot0._txtFMChannelNumUnSelected.gameObject, not slot1.isEmpty)

	slot0._id = slot1.id

	if slot1.isEmpty then
		return
	end

	slot0._txtFMChannelNumSelected.text = slot1.value
	slot0._txtFMChannelNumUnSelected.text = slot1.value
end

slot1 = 0.05

function slot0._refreshFMSliderItem(slot0, slot1)
	slot0:onSelect(false)

	if Mathf.Abs(transformhelper.getPos(slot0.go.transform) - slot1) <= uv0 then
		slot0._view:selectCell(slot0._index, true)
	end
end

function slot0._onClick(slot0)
	if slot0._index and not slot0._mo.isEmpty then
		slot0._view:selectCell(slot0._index, true)
		Activity125Controller.instance:dispatchEvent(Activity125Event.OnChannelItemClick, slot0._id)
	end
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._txtFMChannelNumSelected.gameObject, slot1 and not slot0._mo.isEmpty)
	gohelper.setActive(slot0._txtFMChannelNumUnSelected.gameObject, not slot1 and not slot0._mo.isEmpty)

	if slot1 then
		Activity125Controller.instance:dispatchEvent(Activity125Event.OnChannelSelected, slot0._id)
	end
end

function slot0.onDestroy(slot0)
end

return slot0
