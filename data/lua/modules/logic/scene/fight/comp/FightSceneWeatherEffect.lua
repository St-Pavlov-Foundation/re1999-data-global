module("modules.logic.scene.fight.comp.FightSceneWeatherEffect", package.seeall)

local var_0_0 = class("FightSceneWeatherEffect", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:_setLevelCO(arg_1_2)
	FightController.instance:registerCallback(FightEvent.SetEntityWeatherEffectVisible, arg_1_0._setEntityWeatherEffectVisible, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_1_0._onSpineLoaded, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_1_0._releaseAllEntityEffect, arg_1_0)
	FightController.instance:registerCallback(FightEvent.SetEntityAlpha, arg_1_0._onSetEntityAlpha, arg_1_0)
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)
end

function var_0_0.onSceneClose(arg_3_0)
	UrpCustom.PPEffectMask.hasRain = false

	FightController.instance:unregisterCallback(FightEvent.SetEntityWeatherEffectVisible, arg_3_0._setEntityWeatherEffectVisible, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_3_0._onSpineLoaded, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_3_0._releaseAllEntityEffect, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.SetEntityAlpha, arg_3_0._onSetEntityAlpha, arg_3_0)
	arg_3_0:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)
	arg_3_0:_releaseWeatherEffect()
end

function var_0_0._onSpineLoaded(arg_4_0, arg_4_1)
	if not arg_4_1 or not arg_4_0._weatherEffect_url then
		return
	end

	arg_4_0:_setSpineWeatherEffect(arg_4_1)
end

function var_0_0._onLevelLoaded(arg_5_0, arg_5_1)
	arg_5_0:_releaseWeatherEffect()
	arg_5_0:_setLevelCO(arg_5_1)
	arg_5_0:_setAllSpineWeatherEffect()
end

function var_0_0._setLevelCO(arg_6_0, arg_6_1)
	local var_6_0 = lua_scene_level.configDict[arg_6_1].weatherEffect

	if var_6_0 ~= 0 then
		if var_6_0 == 1 then
			arg_6_0._weatherEffect_url = "roleeffects/roleeffect_rain_write"
			UrpCustom.PPEffectMask.hasRain = true
		elseif var_6_0 == 2 then
			arg_6_0._weatherEffect_url = "roleeffects/roleeffect_rain_black"
			UrpCustom.PPEffectMask.hasRain = true
		else
			UrpCustom.PPEffectMask.hasRain = false

			logError("错误的天气类型:", var_6_0)
		end
	else
		UrpCustom.PPEffectMask.hasRain = false
	end
end

function var_0_0._setAllSpineWeatherEffect(arg_7_0)
	if not arg_7_0._weatherEffect_url then
		return
	end

	local var_7_0 = FightHelper.getAllEntitysContainUnitNpc()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.spine then
			arg_7_0:_setSpineWeatherEffect(iter_7_1.spine)
		end
	end
end

function var_0_0._setSpineWeatherEffect(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.unitSpawn

	if var_8_0.ingoreRainEffect then
		return
	end

	local var_8_1 = var_8_0.id

	if not var_8_0.effect or arg_8_1._spineGo:GetComponent(typeof(UnityEngine.Renderer)) == nil then
		return
	end

	if not arg_8_0.weather_effect then
		arg_8_0.weather_effect = {}
		arg_8_0.cache_entity = {}
	end

	if arg_8_0.cache_entity[var_8_1] then
		arg_8_0:_releaseOneWeatherEffect(arg_8_0.cache_entity[var_8_1])
	end

	arg_8_0.cache_entity[var_8_1] = var_8_0
	arg_8_0.weather_effect[var_8_1] = arg_8_0.weather_effect[var_8_1] or var_8_0.effect:addHangEffect(arg_8_0._weatherEffect_url)

	gohelper.addChild(arg_8_1:getSpineGO(), arg_8_0.weather_effect[var_8_1].containerGO)
	arg_8_0.weather_effect[var_8_1]:setLocalPos(0, 0, 0)
	arg_8_0.weather_effect[var_8_1]:setActive(false)
	arg_8_0.weather_effect[var_8_1]:setActive(true)
end

function var_0_0._onSetEntityAlpha(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = FightHelper.getEntity(arg_9_1)

	if var_9_0 then
		arg_9_0:_setEntityWeatherEffectVisible(var_9_0, arg_9_2)
	end
end

function var_0_0._setEntityWeatherEffectVisible(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.weather_effect and arg_10_0.weather_effect[arg_10_1.id] then
		gohelper.setActive(arg_10_0.weather_effect[arg_10_1.id].containerGO, arg_10_2 or false)
	end
end

function var_0_0._releaseOneWeatherEffect(arg_11_0, arg_11_1)
	if arg_11_1 and arg_11_1.effect then
		arg_11_1.effect:removeEffect(arg_11_0.weather_effect[arg_11_1.id])
	end

	if arg_11_0.weather_effect and arg_11_0.weather_effect[arg_11_1.id] then
		arg_11_0.weather_effect[arg_11_1.id] = nil
		arg_11_0.cache_entity[arg_11_1.id] = nil
	end
end

function var_0_0._releaseAllEntityEffect(arg_12_0)
	if arg_12_0.weather_effect then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.weather_effect) do
			arg_12_0:_releaseOneWeatherEffect(arg_12_0.cache_entity[iter_12_0])
		end
	end
end

function var_0_0._releaseWeatherEffect(arg_13_0)
	arg_13_0:_releaseAllEntityEffect()

	arg_13_0.weather_effect = nil
	arg_13_0._weatherEffect_url = nil
	arg_13_0.cache_entity = nil
end

return var_0_0
