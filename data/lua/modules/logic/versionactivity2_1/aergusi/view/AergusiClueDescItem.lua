module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueDescItem", package.seeall)

local var_0_0 = class("AergusiClueDescItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_1, "txt_desc")
end

function var_0_0.hide(arg_2_0)
	gohelper.setActive(arg_2_0.go, false)
end

function var_0_0.refreshItem(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.go, true)

	arg_3_0._txtDesc.text = arg_3_1
end

function var_0_0.destroy(arg_4_0)
	gohelper.destroy(arg_4_0.go)
end

return var_0_0
