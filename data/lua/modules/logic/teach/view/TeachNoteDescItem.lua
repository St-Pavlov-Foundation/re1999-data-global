module("modules.logic.teach.view.TeachNoteDescItem", package.seeall)

local var_0_0 = class("TeachNoteDescItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.go = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0.id = arg_1_3
	arg_1_0._txtdesccn = gohelper.findChildText(arg_1_1, "desccn")
	arg_1_0._txtdescen = gohelper.findChildText(arg_1_1, "descen")

	arg_1_0:_refreshItem()
end

function var_0_0._refreshItem(arg_2_0)
	local var_2_0 = string.split(TeachNoteConfig.instance:getInstructionLevelCO(arg_2_0.id).desc, "#")
	local var_2_1 = string.split(TeachNoteConfig.instance:getInstructionLevelCO(arg_2_0.id).desc_en, "#")

	arg_2_0._txtdesccn.text = string.gsub(var_2_0[arg_2_0.index], "<i>(.-)</i>", "<i><size=24>%1</size></i>")
	arg_2_0._txtdescen.text = var_2_1[arg_2_0.index]
end

function var_0_0.onDestroyView(arg_3_0)
	gohelper.destroy(arg_3_0.go)
end

return var_0_0
