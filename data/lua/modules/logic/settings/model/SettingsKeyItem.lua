module("modules.logic.settings.model.SettingsKeyItem", package.seeall)

slot0 = class("SettingsKeyItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._txtdec = gohelper.findChildText(slot0._go, "#txt_dec")
	slot0._btnshortcuts = gohelper.findChildButtonWithAudio(slot0._go, "#btn_shortcuts")
	slot0._txtshortcuts = gohelper.findChildText(slot0._go, "#btn_shortcuts/#txt_shortcuts")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtdec.text = slot0._mo.value.description
	slot0._txtshortcuts.text = PCInputController.instance:KeyNameToDescName(slot0._mo.value.key)

	recthelper.setAnchorY(slot0._go.transform, 0)
end

function slot0.addEventListeners(slot0)
	slot0._btnshortcuts:AddClickListener(slot0.OnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnshortcuts:RemoveClickListener()
end

function slot0.onDestroy(slot0)
end

function slot0.OnClick(slot0)
	ViewMgr.instance:openView(ViewName.KeyMapAlertView, slot0._mo)
end

return slot0
