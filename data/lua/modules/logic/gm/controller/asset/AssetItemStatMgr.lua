module("modules.logic.gm.controller.asset.AssetItemStatMgr", package.seeall)

local var_0_0 = class("AssetItemStatMgr", BaseController)
local var_0_1 = SLFramework.ResMgr.Instance

function var_0_0.start(arg_1_0)
	return
end

function var_0_0.initReflection()
	if var_0_0.initedRef then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	local var_2_0 = tolua.findtype("SLFramework.ResMgr")
	local var_2_1 = System.Reflection.BindingFlags
	local var_2_2 = var_2_1.GetMask(var_2_1.Instance, var_2_1.NonPublic)
	local var_2_3 = tolua.getfield(var_2_0, "assetCache", var_2_2):Get(var_0_1):GetEnumerator()

	while var_2_3:MoveNext() do
		local var_2_4 = var_2_3.Current.Key
		local var_2_5 = var_2_3.Current.Value

		logError(var_2_5.ReferenceCount)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
