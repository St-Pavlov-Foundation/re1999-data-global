module("modules.spine.SpineFpsMgr", package.seeall)

local var_0_0 = class("SpineFpsMgr")
local var_0_1 = 30

var_0_0.FightScene = "FightScene"
var_0_0.Story = "Story"
var_0_0.Module = {
	[var_0_0.FightScene] = 60,
	[var_0_0.Story] = 60
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._moduleKey2FpsDict = {}
end

function var_0_0.set(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.Module[arg_2_1]

	if var_2_0 then
		arg_2_0._moduleKey2FpsDict[arg_2_1] = var_2_0

		arg_2_0:_updateFps()
	else
		logError("key not in SpineFpsMgr.Module: " .. arg_2_1)
	end
end

function var_0_0.remove(arg_3_0, arg_3_1)
	if arg_3_0._moduleKey2FpsDict[arg_3_1] then
		arg_3_0._moduleKey2FpsDict[arg_3_1] = nil

		arg_3_0:_updateFps()
	end
end

function var_0_0._updateFps(arg_4_0)
	local var_4_0 = var_0_1

	for iter_4_0, iter_4_1 in pairs(arg_4_0._moduleKey2FpsDict) do
		if var_4_0 < iter_4_1 then
			var_4_0 = iter_4_1
		end
	end

	Spine.Unity.SkeletonAnimation.SetTargetFps(var_4_0)
	Spine.Unity.SkeletonGraphic.SetTargetFps(var_4_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
