module("modules.logic.mainsceneswitch.model.MainSceneSwitchModel", package.seeall)

local var_0_0 = class("MainSceneSwitchModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._sceneId = nil
	arg_2_0._sceneConfig = nil
end

function var_0_0.initSceneId(arg_3_0)
	if arg_3_0._sceneId then
		return
	end

	local var_3_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainSceneSkin)
	local var_3_1 = tonumber(var_3_0) or 0

	arg_3_0:updateSceneIdByItemId(var_3_1)

	if arg_3_0._sceneId then
		MainSceneSwitchController.closeSceneReddot(arg_3_0._sceneId)
	end
end

function var_0_0.updateSceneIdByItemId(arg_4_0, arg_4_1)
	local var_4_0 = MainSceneSwitchConfig.instance:getConfigByItemId(arg_4_1)
	local var_4_1 = var_4_0 and var_4_0.id or MainSceneSwitchConfig.instance:getDefaultSceneId()

	arg_4_0:setCurSceneId(var_4_1)
end

function var_0_0.getCurSceneId(arg_5_0)
	return arg_5_0._sceneId
end

function var_0_0.setCurSceneId(arg_6_0, arg_6_1)
	arg_6_0._sceneId = arg_6_1
	arg_6_0._sceneConfig = lua_scene_switch.configDict[arg_6_0._sceneId]

	if not arg_6_0._sceneConfig then
		arg_6_0._sceneId = MainSceneSwitchConfig.instance:getDefaultSceneId()
		arg_6_0._sceneConfig = lua_scene_switch.configDict[arg_6_0._sceneId]
	end
end

function var_0_0.getCurSceneResName(arg_7_0)
	return arg_7_0._sceneConfig and arg_7_0._sceneConfig.resName
end

function var_0_0.getSceneStatus(arg_8_0)
	local var_8_0 = lua_scene_switch.configDict[arg_8_0]

	if not var_8_0 then
		return MainSceneSwitchEnum.SceneStutas.Lock
	end

	if var_8_0.defaultUnlock == 1 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	if ItemModel.instance:getItemCount(var_8_0.itemId) > 0 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	if var_0_0.canJump(var_8_0.itemId) then
		return MainSceneSwitchEnum.SceneStutas.LockCanGet
	end

	return MainSceneSwitchEnum.SceneStutas.Lock
end

function var_0_0.canJump(arg_9_0)
	local var_9_0 = MainSceneSwitchConfig.instance:getItemSource(arg_9_0)

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1, var_9_2 = var_0_0._getCantJump(iter_9_1)

		if not var_9_1 then
			return true
		end
	end

	return false
end

function var_0_0._getCantJump(arg_10_0)
	local var_10_0 = JumpController.instance:isJumpOpen(arg_10_0.sourceId)
	local var_10_1
	local var_10_2
	local var_10_3 = JumpConfig.instance:getJumpConfig(arg_10_0.sourceId)

	if not var_10_0 then
		var_10_1, var_10_2 = OpenHelper.getToastIdAndParam(var_10_3.openId)
	else
		var_10_1, var_10_2 = JumpController.instance:cantJump(var_10_3.param)
	end

	return var_10_1, var_10_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
