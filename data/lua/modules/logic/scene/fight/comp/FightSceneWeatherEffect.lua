-- chunkname: @modules/logic/scene/fight/comp/FightSceneWeatherEffect.lua

module("modules.logic.scene.fight.comp.FightSceneWeatherEffect", package.seeall)

local FightSceneWeatherEffect = class("FightSceneWeatherEffect", BaseSceneComp)

function FightSceneWeatherEffect:onSceneStart(sceneId, levelId)
	self:_setLevelCO(levelId)
	FightController.instance:registerCallback(FightEvent.SetEntityWeatherEffectVisible, self._setEntityWeatherEffectVisible, self)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, self._releaseAllEntityEffect, self)
	FightController.instance:registerCallback(FightEvent.OnSwitchPlaneClearAsset, self._releaseAllEntityEffect, self)
	FightController.instance:registerCallback(FightEvent.SetEntityAlpha, self._onSetEntityAlpha, self)
end

function FightSceneWeatherEffect:onScenePrepared(sceneId, levelId)
	self:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function FightSceneWeatherEffect:onSceneClose()
	UrpCustom.PPEffectMask.hasRain = false

	FightController.instance:unregisterCallback(FightEvent.SetEntityWeatherEffectVisible, self._setEntityWeatherEffectVisible, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, self._releaseAllEntityEffect, self)
	FightController.instance:unregisterCallback(FightEvent.OnSwitchPlaneClearAsset, self._releaseAllEntityEffect, self)
	FightController.instance:unregisterCallback(FightEvent.SetEntityAlpha, self._onSetEntityAlpha, self)
	self:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
	self:_releaseWeatherEffect()
end

function FightSceneWeatherEffect:_onSpineLoaded(unitSpine)
	if not unitSpine or not self._weatherEffect_url then
		return
	end

	self:_setSpineWeatherEffect(unitSpine)
end

function FightSceneWeatherEffect:_onLevelLoaded(levelId)
	self:_releaseWeatherEffect()
	self:_setLevelCO(levelId)
	self:_setAllSpineWeatherEffect()
end

function FightSceneWeatherEffect:_setLevelCO(levelId)
	local levelCO = lua_scene_level.configDict[levelId]
	local weatherEffect = levelCO.weatherEffect

	if weatherEffect ~= 0 then
		if weatherEffect == 1 then
			self._weatherEffect_url = "roleeffects/roleeffect_rain_write"
			UrpCustom.PPEffectMask.hasRain = true
		elseif weatherEffect == 2 then
			self._weatherEffect_url = "roleeffects/roleeffect_rain_black"
			UrpCustom.PPEffectMask.hasRain = true
		else
			UrpCustom.PPEffectMask.hasRain = false

			logError("错误的天气类型:", weatherEffect)
		end
	else
		UrpCustom.PPEffectMask.hasRain = false
	end
end

function FightSceneWeatherEffect:_setAllSpineWeatherEffect()
	if not self._weatherEffect_url then
		return
	end

	local entityList = FightHelper.getAllEntitysContainUnitNpc()

	for _, entity in ipairs(entityList) do
		if entity.spine then
			self:_setSpineWeatherEffect(entity.spine)
		end
	end
end

function FightSceneWeatherEffect:_setSpineWeatherEffect(spine)
	local target_entity = spine.unitSpawn

	if target_entity.ingoreRainEffect then
		return
	end

	local entity_id = target_entity.id

	if not target_entity.effect or spine._spineGo:GetComponent(typeof(UnityEngine.Renderer)) == nil then
		return
	end

	if not self.weather_effect then
		self.weather_effect = {}
		self.cache_entity = {}
	end

	if self.cache_entity[entity_id] then
		self:_releaseOneWeatherEffect(self.cache_entity[entity_id])
	end

	self.cache_entity[entity_id] = target_entity
	self.weather_effect[entity_id] = self.weather_effect[entity_id] or target_entity.effect:addHangEffect(self._weatherEffect_url)

	gohelper.addChild(spine:getSpineGO(), self.weather_effect[entity_id].containerGO)
	self.weather_effect[entity_id]:setLocalPos(0, 0, 0)
	self.weather_effect[entity_id]:setActive(false)
	self.weather_effect[entity_id]:setActive(true)
end

function FightSceneWeatherEffect:_onSetEntityAlpha(entityId, state)
	local entity = FightHelper.getEntity(entityId)

	if entity then
		self:_setEntityWeatherEffectVisible(entity, state)
	end
end

function FightSceneWeatherEffect:_setEntityWeatherEffectVisible(entity, state)
	if self.weather_effect and self.weather_effect[entity.id] then
		gohelper.setActive(self.weather_effect[entity.id].containerGO, state or false)
	end
end

function FightSceneWeatherEffect:_releaseOneWeatherEffect(entity)
	if entity and entity.effect then
		entity.effect:removeEffect(self.weather_effect[entity.id])
	end

	if self.weather_effect and self.weather_effect[entity.id] then
		self.weather_effect[entity.id] = nil
		self.cache_entity[entity.id] = nil
	end
end

function FightSceneWeatherEffect:_releaseAllEntityEffect()
	if self.weather_effect then
		for k, v in pairs(self.weather_effect) do
			self:_releaseOneWeatherEffect(self.cache_entity[k])
		end
	end
end

function FightSceneWeatherEffect:_releaseWeatherEffect()
	self:_releaseAllEntityEffect()

	self.weather_effect = nil
	self._weatherEffect_url = nil
	self.cache_entity = nil
end

return FightSceneWeatherEffect
