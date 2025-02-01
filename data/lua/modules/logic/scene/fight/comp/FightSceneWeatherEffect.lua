module("modules.logic.scene.fight.comp.FightSceneWeatherEffect", package.seeall)

slot0 = class("FightSceneWeatherEffect", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0:_setLevelCO(slot2)
	FightController.instance:registerCallback(FightEvent.SetEntityWeatherEffectVisible, slot0._setEntityWeatherEffectVisible, slot0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._releaseAllEntityEffect, slot0)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0.onSceneClose(slot0)
	UrpCustom.PPEffectMask.hasRain = false

	FightController.instance:unregisterCallback(FightEvent.SetEntityWeatherEffectVisible, slot0._setEntityWeatherEffectVisible, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._releaseAllEntityEffect, slot0)
	slot0:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	slot0:_releaseWeatherEffect()
end

function slot0._onSpineLoaded(slot0, slot1)
	if not slot1 or not slot0._weatherEffect_url then
		return
	end

	slot0:_setSpineWeatherEffect(slot1)
end

function slot0._onLevelLoaded(slot0, slot1)
	slot0:_releaseWeatherEffect()
	slot0:_setLevelCO(slot1)
	slot0:_setAllSpineWeatherEffect()
end

function slot0._setLevelCO(slot0, slot1)
	if lua_scene_level.configDict[slot1].weatherEffect ~= 0 then
		if slot3 == 1 then
			slot0._weatherEffect_url = "roleeffects/roleeffect_rain_write"
			UrpCustom.PPEffectMask.hasRain = true
		elseif slot3 == 2 then
			slot0._weatherEffect_url = "roleeffects/roleeffect_rain_black"
			UrpCustom.PPEffectMask.hasRain = true
		else
			UrpCustom.PPEffectMask.hasRain = false

			logError("错误的天气类型:", slot3)
		end
	else
		UrpCustom.PPEffectMask.hasRain = false
	end
end

function slot0._setAllSpineWeatherEffect(slot0)
	if not slot0._weatherEffect_url then
		return
	end

	for slot5, slot6 in ipairs(FightHelper.getAllEntitysContainUnitNpc()) do
		if slot6.spine then
			slot0:_setSpineWeatherEffect(slot6.spine)
		end
	end
end

function slot0._setSpineWeatherEffect(slot0, slot1)
	slot2 = slot1.unitSpawn
	slot3 = slot2.id

	if not slot2.effect or slot1._spineGo:GetComponent(typeof(UnityEngine.Renderer)) == nil then
		return
	end

	if not slot0.weather_effect then
		slot0.weather_effect = {}
		slot0.cache_entity = {}
	end

	if slot0.cache_entity[slot3] then
		slot0:_releaseOneWeatherEffect(slot0.cache_entity[slot3])
	end

	slot0.cache_entity[slot3] = slot2
	slot0.weather_effect[slot3] = slot0.weather_effect[slot3] or slot2.effect:addHangEffect(slot0._weatherEffect_url)

	gohelper.addChild(slot1:getSpineGO(), slot0.weather_effect[slot3].containerGO)
	slot0.weather_effect[slot3]:setLocalPos(0, 0, 0)
	slot0.weather_effect[slot3]:setActive(false)
	slot0.weather_effect[slot3]:setActive(true)
end

function slot0._setEntityWeatherEffectVisible(slot0, slot1, slot2)
	if slot0.weather_effect and slot0.weather_effect[slot1.id] then
		gohelper.setActive(slot0.weather_effect[slot1.id].containerGO, slot2 or false)
	end
end

function slot0._releaseOneWeatherEffect(slot0, slot1)
	if slot1 and slot1.effect then
		slot1.effect:removeEffect(slot0.weather_effect[slot1.id])
	end

	if slot0.weather_effect and slot0.weather_effect[slot1.id] then
		slot0.weather_effect[slot1.id] = nil
		slot0.cache_entity[slot1.id] = nil
	end
end

function slot0._releaseAllEntityEffect(slot0)
	if slot0.weather_effect then
		for slot4, slot5 in pairs(slot0.weather_effect) do
			slot0:_releaseOneWeatherEffect(slot0.cache_entity[slot4])
		end
	end
end

function slot0._releaseWeatherEffect(slot0)
	slot0:_releaseAllEntityEffect()

	slot0.weather_effect = nil
	slot0._weatherEffect_url = nil
	slot0.cache_entity = nil
end

return slot0
