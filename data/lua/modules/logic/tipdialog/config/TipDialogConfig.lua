module("modules.logic.tipdialog.config.TipDialogConfig", package.seeall)

slot0 = class("TipDialogConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"tip_dialog"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "tip_dialog" then
		slot0:_initDialog()
	end
end

function slot0._initDialog(slot0)
	slot0._dialogList = {}
	slot1 = nil

	for slot6, slot7 in ipairs(lua_tip_dialog.configList) do
		if not slot0._dialogList[slot7.id] then
			slot1 = "0"
			slot0._dialogList[slot7.id] = {}
		end

		slot8[slot1] = slot8[slot1] or {}

		table.insert(slot8[slot1], slot7)
	end
end

function slot0.getDialog(slot0, slot1, slot2)
	return slot0._dialogList[slot1] and slot3[slot2]
end

slot0.instance = slot0.New()

return slot0
