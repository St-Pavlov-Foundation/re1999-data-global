module("modules.logic.settings.view.SettingsCategoryListItem", package.seeall)

local var_0_0 = class("SettingsCategoryListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gooff = gohelper.findChild(arg_1_0.viewGO, "#go_off")
	arg_1_0._txtitemcn1 = gohelper.findChildText(arg_1_0.viewGO, "#go_off/#txt_itemcn1")
	arg_1_0._txtitemen1 = gohelper.findChildText(arg_1_0.viewGO, "#go_off/#txt_itemen1")
	arg_1_0._goon = gohelper.findChild(arg_1_0.viewGO, "#go_on")
	arg_1_0._txtitemcn2 = gohelper.findChildText(arg_1_0.viewGO, "#go_on/#txt_itemcn2")
	arg_1_0._txtitemen2 = gohelper.findChildText(arg_1_0.viewGO, "#go_on/#txt_itemen2")
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_select")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnselect:AddClickListener(arg_2_0._btnselectOnClick, arg_2_0)
	SettingsController.instance:registerCallback(SettingsEvent.PlayCloseCategoryAnim, arg_2_0._playCloseAnim, arg_2_0)
	SettingsController.instance:registerCallback(SettingsEvent.OnChangeLangTxt, arg_2_0._onChangeLangTxt, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnselect:RemoveClickListener()
	SettingsController.instance:unregisterCallback(SettingsEvent.PlayCloseCategoryAnim, arg_3_0._playCloseAnim, arg_3_0)
	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeLangTxt, arg_3_0._onChangeLangTxt, arg_3_0)
end

function var_0_0._btnselectOnClick(arg_4_0)
	SettingsController.instance:dispatchEvent(SettingsEvent.SelectCategory, arg_4_0._mo.id)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	local var_8_0 = arg_8_0:_isSelected()

	gohelper.setActive(arg_8_0._gooff, not var_8_0)
	gohelper.setActive(arg_8_0._goon, var_8_0)

	if var_8_0 then
		arg_8_0._txtitemcn2.text = luaLang(arg_8_1.name)
		arg_8_0._txtitemen2.text = arg_8_1.subname
	else
		arg_8_0._txtitemcn1.text = luaLang(arg_8_1.name)
		arg_8_0._txtitemen1.text = arg_8_1.subname
	end
end

function var_0_0._onChangeLangTxt(arg_9_0, arg_9_1)
	if arg_9_0:_isSelected() then
		arg_9_0._txtitemcn2.text = luaLang(arg_9_0._mo.name)
		arg_9_0._txtitemen2.text = arg_9_0._mo.subname
	else
		arg_9_0._txtitemcn1.text = luaLang(arg_9_0._mo.name)
		arg_9_0._txtitemen1.text = arg_9_0._mo.subname
	end
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0._isSelected(arg_12_0)
	return arg_12_0._mo.id == SettingsModel.instance:getCurCategoryId()
end

function var_0_0._playCloseAnim(arg_13_0)
	arg_13_0._anim:Play("settingitem_out", 0, 0)
end

return var_0_0
