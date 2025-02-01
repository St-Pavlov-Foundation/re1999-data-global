module("modules.logic.settings.view.SettingsCategoryListItem", package.seeall)

slot0 = class("SettingsCategoryListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gooff = gohelper.findChild(slot0.viewGO, "#go_off")
	slot0._txtitemcn1 = gohelper.findChildText(slot0.viewGO, "#go_off/#txt_itemcn1")
	slot0._txtitemen1 = gohelper.findChildText(slot0.viewGO, "#go_off/#txt_itemen1")
	slot0._goon = gohelper.findChild(slot0.viewGO, "#go_on")
	slot0._txtitemcn2 = gohelper.findChildText(slot0.viewGO, "#go_on/#txt_itemcn2")
	slot0._txtitemen2 = gohelper.findChildText(slot0.viewGO, "#go_on/#txt_itemen2")
	slot0._btnselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_select")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnselect:AddClickListener(slot0._btnselectOnClick, slot0)
	SettingsController.instance:registerCallback(SettingsEvent.PlayCloseCategoryAnim, slot0._playCloseAnim, slot0)
	SettingsController.instance:registerCallback(SettingsEvent.OnChangeLangTxt, slot0._onChangeLangTxt, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnselect:RemoveClickListener()
	SettingsController.instance:unregisterCallback(SettingsEvent.PlayCloseCategoryAnim, slot0._playCloseAnim, slot0)
	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeLangTxt, slot0._onChangeLangTxt, slot0)
end

function slot0._btnselectOnClick(slot0)
	SettingsController.instance:dispatchEvent(SettingsEvent.SelectCategory, slot0._mo.id)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot0:_isSelected()

	gohelper.setActive(slot0._gooff, not slot2)
	gohelper.setActive(slot0._goon, slot2)

	if slot2 then
		slot0._txtitemcn2.text = luaLang(slot1.name)
		slot0._txtitemen2.text = slot1.subname
	else
		slot0._txtitemcn1.text = luaLang(slot1.name)
		slot0._txtitemen1.text = slot1.subname
	end
end

function slot0._onChangeLangTxt(slot0, slot1)
	if slot0:_isSelected() then
		slot0._txtitemcn2.text = luaLang(slot0._mo.name)
		slot0._txtitemen2.text = slot0._mo.subname
	else
		slot0._txtitemcn1.text = luaLang(slot0._mo.name)
		slot0._txtitemen1.text = slot0._mo.subname
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0._isSelected(slot0)
	return slot0._mo.id == SettingsModel.instance:getCurCategoryId()
end

function slot0._playCloseAnim(slot0)
	slot0._anim:Play("settingitem_out", 0, 0)
end

return slot0
