module("modules.logic.scene.common.CommonSceneCtrlComp", package.seeall)

local var_0_0 = class("CommonSceneCtrlComp", BaseSceneComp)

var_0_0.CtrlComp = {
	DynamicShadow = SceneLuaCompSpineDynamicShadow
}

function var_0_0.onInit(arg_1_0)
	arg_1_0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_1_0._onLevelLoaded, arg_1_0)
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.onSceneClose(arg_3_0)
	return
end

function var_0_0._onLevelLoaded(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getCurScene().level
	local var_4_1 = var_4_0 and var_4_0:getSceneGo()
	local var_4_2 = arg_4_1 and lua_scene_level.configDict[arg_4_1]
	local var_4_3 = var_4_2 and lua_scene_ctrl.configDict[var_4_2.resName]

	if var_4_3 and not gohelper.isNil(var_4_1) then
		for iter_4_0, iter_4_1 in pairs(var_4_3) do
			local var_4_4 = var_0_0.CtrlComp[iter_4_1.ctrlName]

			if var_4_4 then
				local var_4_5 = {
					iter_4_1.param1,
					iter_4_1.param2,
					iter_4_1.param3,
					iter_4_1.param4
				}

				MonoHelper.addLuaComOnceToGo(var_4_1, var_4_4, var_4_5)
			else
				logError("ctrlComp not exist: " .. iter_4_1.ctrlName)
			end
		end
	end
end

return var_0_0
