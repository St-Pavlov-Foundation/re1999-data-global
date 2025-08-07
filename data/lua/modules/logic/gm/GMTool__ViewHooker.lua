local var_0_0 = _G.getGlobal
local var_0_1 = var_0_0("Partial_GMTool")
local var_0_2 = _G.addGlobalModule
local var_0_3 = string.format
local var_0_4 = {
	onClear = function(arg_1_0)
		arg_1_0._sHookSet = arg_1_0._sHookSet or {}

		ViewMgr.instance:unregisterCallback(ViewEvent.BeforeOpenView, arg_1_0._onBeforeOpenView, arg_1_0)

		return arg_1_0
	end,
	_isInSet = function(arg_2_0, arg_2_1)
		if not arg_2_1 then
			return false
		end

		return arg_2_0._sHookSet[arg_2_1]
	end,
	_addInSet = function(arg_3_0, arg_3_1, arg_3_2)
		if not arg_3_1 then
			return
		end

		arg_3_0._sHookSet[arg_3_1] = arg_3_2
	end,
	_try_inject = function(arg_4_0, arg_4_1)
		if arg_4_0:_isInSet(arg_4_1) then
			return
		end

		local var_4_0 = var_0_0(arg_4_1)

		if not var_4_0 then
			return
		end

		local var_4_1 = var_0_3("_hook_%s", arg_4_1)

		if not arg_4_0[var_4_1] then
			logError(var_0_3("[GMTool__ViewHooker] please add M:%s(T)!!!", var_4_1))

			return
		end

		arg_4_0[var_4_1](arg_4_0, var_4_0)
		arg_4_0:_addInSet(arg_4_1, var_4_0)
	end
}
local var_0_5 = "GM_"

function var_0_4._onBeforeOpenView(arg_5_0, arg_5_1)
	local var_5_0 = var_0_5 .. arg_5_1
	local var_5_1 = _G.getModulePath(var_5_0)

	if not var_5_1 then
		return
	end

	var_0_2(var_5_1).register()
end

local var_0_6 = require("modules.setting.module_views_GM")

for iter_0_0, iter_0_1 in pairs(var_0_6) do
	if ViewMgr.instance:getSetting(iter_0_0) then
		logWarn("module_views_GM warning: 重复定义 ViewName." .. iter_0_0)
	else
		ViewMgr.instance._viewSettings[iter_0_0] = iter_0_1

		rawset(ViewName, iter_0_0, iter_0_0)
	end
end

var_0_1._viewHooker = var_0_4:onClear()

ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenView, var_0_4._onBeforeOpenView, var_0_4)

local var_0_7 = {
	"GMToolView",
	"MainController"
}

function var_0_4._hook_GMToolView(arg_6_0, arg_6_1)
	arg_6_0:_onBeforeOpenView(ViewName.GMToolView)
end

function var_0_4._hook_MainController(arg_7_0, arg_7_1)
	return
end

;(function()
	for iter_8_0, iter_8_1 in ipairs(var_0_7) do
		var_0_4:_try_inject(iter_8_1)
	end
end)()

return {}
