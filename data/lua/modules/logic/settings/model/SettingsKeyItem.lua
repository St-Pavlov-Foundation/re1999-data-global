module("modules.logic.settings.model.SettingsKeyItem", package.seeall)

local var_0_0 = class("SettingsKeyItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0._go, "#txt_dec")
	arg_1_0._btnshortcuts = gohelper.findChildButtonWithAudio(arg_1_0._go, "#btn_shortcuts")
	arg_1_0._txtshortcuts = gohelper.findChildText(arg_1_0._go, "#btn_shortcuts/#txt_shortcuts")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1
	arg_2_0._txtdec.text = arg_2_0._mo.value.description
	arg_2_0._txtshortcuts.text = PCInputController.instance:KeyNameToDescName(arg_2_0._mo.value.key)

	recthelper.setAnchorY(arg_2_0._go.transform, 0)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnshortcuts:AddClickListener(arg_3_0.OnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnshortcuts:RemoveClickListener()
end

function var_0_0.onDestroy(arg_5_0)
	return
end

function var_0_0.OnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.KeyMapAlertView, arg_6_0._mo)
end

return var_0_0
