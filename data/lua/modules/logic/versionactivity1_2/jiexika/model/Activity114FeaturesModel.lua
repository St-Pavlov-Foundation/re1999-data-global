module("modules.logic.versionactivity1_2.jiexika.model.Activity114FeaturesModel", package.seeall)

local var_0_0 = class("Activity114FeaturesModel", ListScrollModel)

function var_0_0.onFeatureListUpdate(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0 = 1, #arg_1_1 do
		var_1_0[iter_1_0] = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, arg_1_1[iter_1_0])
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0.getAllMaxLength(arg_2_0, arg_2_1)
	local var_2_0 = Activity114Config.instance:getFeatureName(Activity114Model.instance.id)
	local var_2_1 = 0

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_2 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_2_1, iter_2_1)

		var_2_1 = math.max(var_2_1, var_2_2)
	end

	return Mathf.Clamp(var_2_1 + 20, 276, 420)
end

function var_0_0.getFeaturePreferredLength(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0:getFeatureMaxLength(arg_3_1)

	return Mathf.Clamp(var_3_0 + 20, arg_3_2, arg_3_3)
end

function var_0_0.getFeatureMaxLength(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getList()
	local var_4_1 = 0

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_2 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_4_1, iter_4_1.features)

		var_4_1 = math.max(var_4_1, var_4_2)
	end

	return var_4_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
