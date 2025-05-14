module("modules.common.touch.TouchEventMgrHepler", package.seeall)

local var_0_0 = class("TouchEventMgrHepler")
local var_0_1 = ZProj.TouchEventMgr
local var_0_2 = {}

function var_0_0.getTouchEventMgr(arg_1_0)
	local var_1_0 = var_0_1.Get(arg_1_0)

	if SDKNativeUtil.isGamePad() and tabletool.indexOf(var_0_2, var_1_0) == nil then
		table.insert(var_0_2, var_1_0)
		var_1_0:SetDestroyCb(var_0_0._remove, nil)
	end

	return var_1_0
end

function var_0_0.getAllMgrs()
	return var_0_2
end

function var_0_0.remove(arg_3_0)
	if not gohelper.isNil(arg_3_0) then
		arg_3_0:ClearAllCallback()
		var_0_0._remove(arg_3_0)
	end
end

function var_0_0._remove(arg_4_0)
	tabletool.removeValue(var_0_2, arg_4_0)
end

return var_0_0
