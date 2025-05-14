module("modules.logic.tipdialog.config.TipDialogConfig", package.seeall)

local var_0_0 = class("TipDialogConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"tip_dialog"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "tip_dialog" then
		arg_3_0:_initDialog()
	end
end

function var_0_0._initDialog(arg_4_0)
	arg_4_0._dialogList = {}

	local var_4_0
	local var_4_1 = "0"

	for iter_4_0, iter_4_1 in ipairs(lua_tip_dialog.configList) do
		local var_4_2 = arg_4_0._dialogList[iter_4_1.id]

		if not var_4_2 then
			var_4_2 = {}
			var_4_0 = var_4_1
			arg_4_0._dialogList[iter_4_1.id] = var_4_2
		end

		var_4_2[var_4_0] = var_4_2[var_4_0] or {}

		table.insert(var_4_2[var_4_0], iter_4_1)
	end
end

function var_0_0.getDialog(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._dialogList[arg_5_1]

	return var_5_0 and var_5_0[arg_5_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
