module("modules.logic.voice.view.VoiceChooseItem", package.seeall)

local var_0_0 = class("VoiceChooseItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goSelect = gohelper.findChild(arg_1_1, "#go_selected")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_1, "#txt_title")
	arg_1_0._txtDec = gohelper.findChildText(arg_1_1, "#txt_dec")
	arg_1_0._click = gohelper.getClick(arg_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	gohelper.setActive(arg_4_0._goSelect, arg_4_0._mo.choose)

	local var_4_0 = "langtype_" .. arg_4_0._mo.lang

	arg_4_0._txtTitle.text = luaLang(var_4_0)

	local var_4_1 = SettingsConfig.instance:getVoiceTips(arg_4_0._mo.lang)

	arg_4_0._txtDec.text = var_4_1
end

function var_0_0._onClickThis(arg_5_0)
	VoiceChooseModel.instance:choose(arg_5_0._mo.lang)
end

return var_0_0
