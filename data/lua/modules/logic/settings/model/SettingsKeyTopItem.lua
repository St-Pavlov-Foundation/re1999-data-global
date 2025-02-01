module("modules.logic.settings.model.SettingsKeyTopItem", package.seeall)

slot0 = class("SettingsKeyTopItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goUnchoose = gohelper.findChild(slot0._go, "#go_unchoose")
	slot0._goChoose = gohelper.findChild(slot0._go, "#go_choose")
	slot0._btn = gohelper.findChildButtonWithAudio(slot0._go, "btn")
	slot0._txtunchoose = gohelper.findChildText(slot0._go, "#go_unchoose/#txt_unchoose")
	slot0._txtchoose = gohelper.findChildText(slot0._go, "#go_choose/#txt_choose")
end

function slot0.onSelect(slot0, slot1)
	slot0._goUnchoose:SetActive(not slot1)
	slot0._goChoose:SetActive(slot1)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtunchoose.text = slot1.name
	slot0._txtchoose.text = slot1.name
end

function slot0.addEventListeners(slot0)
	slot0._btn:AddClickListener(slot0.OnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0.onDestroy(slot0)
end

function slot0.OnClick(slot0)
	slot0._view:selectCell(slot0._index, true)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyMapChange, slot0._index)
end

return slot0
