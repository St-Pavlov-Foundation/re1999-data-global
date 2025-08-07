module("modules.logic.mainuiswitch.model.MainUISwitchModel", package.seeall)

local var_0_0 = class("MainUISwitchModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curUseUI = nil
end

function var_0_0.initMainUI(arg_3_0)
	local var_3_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainUISkin)
	local var_3_1 = tonumber(var_3_0) or 0
	local var_3_2 = MainUISwitchConfig.instance:getUISwitchCoByItemId(var_3_1)

	arg_3_0._curUseUI = var_3_2 and var_3_2.id or arg_3_0:_getUseUIDefaultId()
end

function var_0_0.setCurUseUI(arg_4_0, arg_4_1)
	arg_4_0._curUseUI = arg_4_1
end

function var_0_0.getCurUseUI(arg_5_0)
	return arg_5_0._curUseUI or arg_5_0:_getUseUIDefaultId()
end

function var_0_0._getUseUIDefaultId(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(lua_scene_ui.configList) do
		if iter_6_1.defaultUnlock == 1 then
			return iter_6_1.id
		end
	end
end

function var_0_0.getUIStatus(arg_7_0)
	local var_7_0 = lua_scene_ui.configDict[arg_7_0]

	if not var_7_0 then
		return MainSceneSwitchEnum.SceneStutas.Lock
	end

	if var_7_0.defaultUnlock == 1 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	if ItemModel.instance:getItemCount(var_7_0.itemId) > 0 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	if var_0_0.canJump(var_7_0.itemId) then
		return MainSceneSwitchEnum.SceneStutas.LockCanGet
	end

	return MainSceneSwitchEnum.SceneStutas.Lock
end

function var_0_0.canJump(arg_8_0)
	local var_8_0 = MainUISwitchConfig.instance:getItemSource(arg_8_0)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1, var_8_2 = MainSceneSwitchModel._getCantJump(iter_8_1)

		if not var_8_1 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
