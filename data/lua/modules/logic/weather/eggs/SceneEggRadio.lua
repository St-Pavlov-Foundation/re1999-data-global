module("modules.logic.weather.eggs.SceneEggRadio", package.seeall)

local var_0_0 = class("SceneEggRadio", SceneBaseEgg)

function var_0_0._onInit(arg_1_0)
	arg_1_0._heroOrSkinId = tonumber(arg_1_0._eggConfig.actionParams)
	arg_1_0._isMainScene = arg_1_0._context and arg_1_0._context.isMainScene

	if arg_1_0._isMainScene then
		CharacterController.instance:registerCallback(CharacterEvent.ChangeMainHero, arg_1_0._onChangeMainHero, arg_1_0)
		CharacterController.instance:registerCallback(CharacterEvent.RandomMainHero, arg_1_0._onRandomMainHero, arg_1_0)
	end

	arg_1_0:_onChangeMainHero()
end

function var_0_0._onChangeMainHero(arg_2_0)
	if not arg_2_0._isMainScene then
		arg_2_0:setGoListVisible(true)

		return
	end

	local var_2_0, var_2_1 = CharacterSwitchListModel.instance:getMainHero()

	arg_2_0:setGoListVisible(arg_2_0._heroOrSkinId ~= var_2_0 and arg_2_0._heroOrSkinId ~= var_2_1)
end

function var_0_0._onRandomMainHero(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0._isMainScene then
		arg_3_0:setGoListVisible(true)

		return
	end

	arg_3_0:setGoListVisible(arg_3_0._heroOrSkinId ~= arg_3_1 and arg_3_0._heroOrSkinId ~= arg_3_2)
end

function var_0_0._onSceneClose(arg_4_0)
	if arg_4_0._isMainScene then
		CharacterController.instance:unregisterCallback(CharacterEvent.ChangeMainHero, arg_4_0._onChangeMainHero, arg_4_0)
		CharacterController.instance:unregisterCallback(CharacterEvent.RandomMainHero, arg_4_0._onRandomMainHero, arg_4_0)
	end
end

return var_0_0
