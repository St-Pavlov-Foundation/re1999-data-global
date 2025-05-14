module("modules.logic.versionactivity2_2.common.VersionActivity2_2JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_2JumpHandleFunc")

function var_0_0.jumpTo12201(arg_1_0)
	VersionActivity2_2EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12202(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterView(nil, nil, var_2_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12210(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_3_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12203(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		TianShiNaNaController.instance:openMainView()
	end, nil, var_4_0)
end

function var_0_0.jumpTo12204(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		LoperaController.instance:openLoperaMainView()
	end, nil, var_6_0)
end

return var_0_0
