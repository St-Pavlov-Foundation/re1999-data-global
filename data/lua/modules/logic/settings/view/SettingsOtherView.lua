module("modules.logic.settings.view.SettingsOtherView", package.seeall)

slot0 = class("SettingsOtherView", BaseView)

function slot0.onInitView(slot0)
	slot0._goscreenshot = gohelper.findChild(slot0.viewGO, "#go_screenshot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._itemTableDict = {}

	slot0:_initItem(slot0._goscreenshot, "screenshot")
end

function slot0._initItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.btn = gohelper.findChildButtonWithAudio(slot1, "switch/btn")
	slot3.off = gohelper.findChild(slot1, "switch/btn/off")
	slot3.on = gohelper.findChild(slot1, "switch/btn/on")

	slot3.btn:AddClickListener(slot0._onSwitchClick, slot0, slot2)

	slot0._itemTableDict[slot2] = slot3
end

function slot0._onSwitchClick(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if slot1 == "screenshot" then
		SettingsModel.instance:setScreenshotSwitch(not SettingsModel.instance:getScreenshotSwitch())
	end

	slot0:_refreshSwitchUI(slot1)
end

function slot0._refreshSwitchUI(slot0, slot1)
	if not slot0._itemTableDict[slot1] then
		return
	end

	slot3 = false

	if slot1 == "screenshot" then
		slot3 = SettingsModel.instance:getScreenshotSwitch()
	end

	gohelper.setActive(slot2.on, slot3)
	gohelper.setActive(slot2.off, not slot3)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0:_refreshSwitchUI("screenshot")
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._itemTableDict) do
		slot5.btn:RemoveClickListener()
	end
end

return slot0
