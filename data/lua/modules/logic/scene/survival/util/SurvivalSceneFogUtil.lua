module("modules.logic.scene.survival.util.SurvivalSceneFogUtil", package.seeall)

local var_0_0 = class("SurvivalSceneFogUtil")

function var_0_0.loadFog(arg_1_0, arg_1_1)
	if not arg_1_0._fogLoader then
		local var_1_0 = gohelper.create3d(arg_1_1, "Fog")

		arg_1_0._fogLoader = PrefabInstantiate.Create(var_1_0)
	end

	arg_1_0._fogLoader:dispose()
	arg_1_0._fogLoader:startLoad(SurvivalSceneFogComp.FogResPath, arg_1_0._onLoadFogEnd, arg_1_0)
end

function var_0_0.unLoadFog(arg_2_0)
	if arg_2_0._fogLoader then
		arg_2_0._fogLoader:dispose()

		arg_2_0._fogLoader = nil
	end
end

function var_0_0._onLoadFogEnd(arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._delayDestroyFog, arg_3_0, 0)
end

function var_0_0._delayDestroyFog(arg_4_0)
	arg_4_0._fogLoader:dispose()
end

var_0_0.instance = var_0_0.New()

return var_0_0
