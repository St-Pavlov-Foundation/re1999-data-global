module("framework.helper.boxCollider2dhelper", package.seeall)

local var_0_0 = {}
local var_0_1 = SLFramework.UGUI.BoxCollider2DHelper

function var_0_0.getOffset(arg_1_0)
	return var_0_1.GetOffset(arg_1_0, 0, 0)
end

function var_0_0.setOffset(arg_2_0, arg_2_1, arg_2_2)
	return var_0_1.SetOffset(arg_2_0, arg_2_1, arg_2_2)
end

function var_0_0.getSize(arg_3_0)
	return var_0_1.GetSize(arg_3_0, 0, 0)
end

function var_0_0.setSize(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.SetSize(arg_4_0, arg_4_1, arg_4_2)
end

return var_0_0
