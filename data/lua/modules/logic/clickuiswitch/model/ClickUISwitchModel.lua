module("modules.logic.clickuiswitch.model.ClickUISwitchModel", package.seeall)

local var_0_0 = class("ClickUISwitchModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initConfig(arg_3_0)
	arg_3_0:_defaultUseId()
end

function var_0_0.initClickUI(arg_4_0)
	local var_4_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ClickUISkin)

	if var_4_0 then
		arg_4_0._curUseUI = tonumber(var_4_0) or arg_4_0:_getUseUIDefaultId()
	else
		arg_4_0:_defaultUseId()
	end
end

function var_0_0._defaultUseId(arg_5_0)
	arg_5_0._curUseUI = GameUtil.playerPrefsGetNumberByUserId(ClickUISwitchEnum.SaveClickUIPrefKey, arg_5_0:_getUseUIDefaultId())
end

function var_0_0.setCurUseUI(arg_6_0, arg_6_1)
	arg_6_0._curUseUI = arg_6_1

	GameUtil.playerPrefsSetNumberByUserId(ClickUISwitchEnum.SaveClickUIPrefKey, arg_6_1)
end

function var_0_0.getCurUseUI(arg_7_0)
	return arg_7_0._curUseUI or arg_7_0:_getUseUIDefaultId()
end

function var_0_0.getCurUseUICo(arg_8_0)
	return arg_8_0:getClickUICoById(arg_8_0:getCurUseUI())
end

function var_0_0.getClickUICoById(arg_9_0, arg_9_1)
	return lua_scene_click.configDict[arg_9_1]
end

function var_0_0._getUseUIDefaultId(arg_10_0)
	if not lua_scene_click.configList then
		return ClickUISwitchEnum.SkinParams[ClickUISwitchEnum.Skin.Normal].id
	end

	for iter_10_0, iter_10_1 in ipairs(lua_scene_click.configList) do
		if iter_10_1.defaultUnlock == 1 then
			return iter_10_1.id
		end
	end
end

function var_0_0.getUIStatus(arg_11_0)
	local var_11_0 = lua_scene_click.configDict[arg_11_0]

	if not var_11_0 then
		return MainSceneSwitchEnum.SceneStutas.Lock
	end

	if var_11_0.defaultUnlock == 1 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	if ItemModel.instance:getItemCount(var_11_0.itemId) > 0 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	if var_0_0.canJump(var_11_0.itemId) then
		return MainSceneSwitchEnum.SceneStutas.LockCanGet
	end

	return MainSceneSwitchEnum.SceneStutas.Lock
end

function var_0_0.canJump(arg_12_0)
	local var_12_0 = ClickUISwitchConfig.instance:getItemSource(arg_12_0)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1, var_12_2 = MainSceneSwitchModel._getCantJump(iter_12_1)

		if not var_12_1 then
			return true
		end
	end

	return false
end

function var_0_0.hasReddot(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(lua_scene_click.configList) do
		if iter_13_1.defaultUnlock ~= 1 and var_0_0.getUIStatus(iter_13_1.id) == MainSceneSwitchEnum.SceneStutas.Unlock then
			local var_13_0 = ClickUISwitchEnum.SaveClickUIPrefKey .. iter_13_1.id

			if GameUtil.playerPrefsGetNumberByUserId(var_13_0, 0) == 0 then
				return true
			end
		end
	end
end

function var_0_0.cancelReddot(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(lua_scene_click.configList) do
		if iter_14_1.defaultUnlock ~= 1 and var_0_0.getUIStatus(iter_14_1.id) == MainSceneSwitchEnum.SceneStutas.Unlock then
			local var_14_0 = ClickUISwitchEnum.SaveClickUIPrefKey .. iter_14_1.id

			GameUtil.playerPrefsSetNumberByUserId(var_14_0, 1)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
