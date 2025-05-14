module("modules.logic.guide.controller.action.impl.GuideActionPlayEffect", package.seeall)

local var_0_0 = class("GuideActionPlayEffect", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._effectRoot = var_1_0[1]
	arg_1_0._effectPathList = string.split(var_1_0[2], ",")
	arg_1_0._effectGoList = {}

	local var_1_1 = MultiAbLoader.New()

	arg_1_0._loader = var_1_1

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._effectPathList) do
		var_1_1:addPath(iter_1_1)
	end

	var_1_1:startLoad(arg_1_0._loadedFinish, arg_1_0)
	arg_1_0:onDone(true)
end

function var_0_0._loadedFinish(arg_2_0, arg_2_1)
	local var_2_0 = gohelper.find(arg_2_0._effectRoot)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._effectPathList) do
		local var_2_1 = arg_2_0._loader:getAssetItem(iter_2_1):GetResource(iter_2_1)

		table.insert(arg_2_0._effectGoList, gohelper.clone(var_2_1, var_2_0))
	end
end

function var_0_0.onDestroy(arg_3_0)
	var_0_0.super.onDestroy(arg_3_0)

	if arg_3_0._loader then
		arg_3_0._loader:dispose()
	end

	if arg_3_0._effectGoList then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._effectGoList) do
			UnityEngine.GameObject.Destroy(iter_3_1)
		end
	end
end

return var_0_0
