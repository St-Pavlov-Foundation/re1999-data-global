-- chunkname: @modules/logic/scene/fight/comp/FightSceneWadingEffect.lua

module("modules.logic.scene.fight.comp.FightSceneWadingEffect", package.seeall)

local FightSceneWadingEffect = class("FightSceneWadingEffect", BaseSceneComp)

function FightSceneWadingEffect:onSceneStart(sceneId, levelId)
	self:_setLevelCO(levelId)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, self._releaseEntityEffect, self)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, self._releaseAllEntityEffect, self)
	FightController.instance:registerCallback(FightEvent.OnSwitchPlaneClearAsset, self._releaseAllEntityEffect, self)
	FightController.instance:registerCallback(FightEvent.BeforeChangeSubHero, self._releaseEntityEffect, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:registerCallback(FightEvent.SetEntityAlpha, self._onSetEntityAlpha, self)
end

function FightSceneWadingEffect:onScenePrepared(sceneId, levelId)
	self:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function FightSceneWadingEffect:onSceneClose()
	self:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, self._releaseEntityEffect, self)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, self._releaseAllEntityEffect, self)
	FightController.instance:unregisterCallback(FightEvent.OnSwitchPlaneClearAsset, self._releaseAllEntityEffect, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeChangeSubHero, self._releaseEntityEffect, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.SetEntityAlpha, self._onSetEntityAlpha, self)
	self:_releaseEffect()
end

function FightSceneWadingEffect:_onSpineLoaded(unitSpine)
	if not unitSpine or not self._effectUrl then
		return
	end

	self:_setSpineEffect(unitSpine)
end

function FightSceneWadingEffect:_onLevelLoaded(levelId)
	self:_releaseEffect()
	self:_setLevelCO(levelId)
	self:_setAllSpineEffect()
end

function FightSceneWadingEffect:_setLevelCO(levelId)
	local levelCO = lua_scene_level.configDict[levelId]
	local wadeEffect = levelCO.wadeEffect

	if not string.nilorempty(wadeEffect) then
		TaskDispatcher.runRepeat(self._onFrameUpdateEffectPos, self, 0.01)

		local arr = string.split(wadeEffect, "#")
		local side = arr[1]

		if side == "1" then
			self._side = FightEnum.EntitySide.EnemySide
		elseif side == "2" then
			self._side = FightEnum.EntitySide.MySide
		elseif side == "3" then
			self._side = nil
		end

		self._effectUrl = arr[2]
	end
end

function FightSceneWadingEffect:_setAllSpineEffect()
	if not self._effectUrl then
		return
	end

	local entityList

	if self._side then
		entityList = FightHelper.getSideEntitys(self._side, true)
	else
		entityList = {}

		for i, v in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
			table.insert(entityList, v)
		end

		for i, v in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)) do
			table.insert(entityList, v)
		end
	end

	for _, entity in ipairs(entityList) do
		if entity.spine then
			self:_setSpineEffect(entity.spine)
		end
	end
end

function FightSceneWadingEffect:_setSpineEffect(spine)
	local entity = spine.unitSpawn
	local entityId = entity.id
	local entity_mo = entity:getMO()

	if not entity_mo then
		return
	end

	local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

	if not skin_config or skin_config.isFly == 1 then
		return
	end

	if self._side and self._side ~= entity:getSide() then
		return
	end

	if not self._effects then
		self._effects = {}
		self._originPos = {}
		self._standPos = {}
		self._effects2 = {}
	end

	if self._effects[entityId] then
		return
	end

	local foot = entity:getHangPoint(ModuleEnum.SpineHangPoint.mountbody)

	if foot then
		local effectWrap = entity.effect:addHangEffect(self._effectUrl, ModuleEnum.SpineHangPointRoot)

		self._effects[entityId] = effectWrap

		self._effects[entityId]:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)

		local x, y, z = FightHelper.getEntityStandPos(entity_mo)
		local offsetX, offsetY, offsetZ = transformhelper.getLocalPos(foot.transform)

		self._originPos[entityId] = {
			x + offsetX,
			y + offsetY,
			z + offsetZ
		}
		self._standPos[entityId] = {
			x,
			y,
			z
		}
		effectWrap = entity.effect:addGlobalEffect(self._effectUrl .. "_effect")

		effectWrap:setLocalPos(offsetX + x, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)

		self._effects2[entityId] = effectWrap
	end
end

local proName = "_RolePos"

function FightSceneWadingEffect:_onFrameUpdateEffectPos()
	if self._effects then
		for entityId, effectWrap in pairs(self._effects) do
			local entity = FightHelper.getEntity(entityId)

			if entity then
				local standPos = self._standPos[entityId]
				local curPosX, curPosY, curPosz = transformhelper.getLocalPos(entity.go.transform)

				if curPosX ~= standPos[1] or curPosY ~= standPos[2] or curPosz ~= standPos[3] then
					local effectGO = effectWrap.effectGO
					local render = gohelper.findChildComponent(effectGO, "root/wave", typeof(UnityEngine.MeshRenderer))

					if render and render.material then
						local entity = FightHelper.getEntity(entityId)
						local foot = entity:getHangPoint(ModuleEnum.SpineHangPoint.mountbody)
						local footX, footY, footZ = transformhelper.getPos(foot.transform)
						local originPos = self._originPos[entityId]
						local offsetX = footX - originPos[1]
						local offsetY = footY - originPos[2]
						local offsetZ = footZ - originPos[3]
						local posStr = string.format("%f,%f,%f,0", offsetX, offsetY, offsetZ)

						MaterialUtil.setPropValue(render.material, proName, "Vector4", MaterialUtil.getPropValueFromStr("Vector4", posStr))

						if footX < 0 and offsetY < 1 then
							self._effects2[entityId]:setLocalPos(footX, 0, footZ)
						end
					end
				end
			end
		end
	end
end

local directCharacterHitEffectType = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}

function FightSceneWadingEffect:_onSkillPlayStart(entity, skillId, stepData)
	local showEffect2Entity = {
		[stepData.fromId] = true,
		[stepData.toId] = true
	}

	for _, actEffectMO in ipairs(stepData.actEffect) do
		if directCharacterHitEffectType[actEffectMO.effectType] then
			showEffect2Entity[actEffectMO.targetId] = true
		end
	end

	if self._effects2 then
		for entityId, effectWrap in pairs(self._effects2) do
			if not showEffect2Entity[entityId] then
				effectWrap:setActive(false, "FightSceneWadingEffect")
			end
		end
	end
end

function FightSceneWadingEffect:_onSkillPlayFinish()
	if self._effects2 then
		for entityId, effectWrap in pairs(self._effects2) do
			effectWrap:setActive(true, "FightSceneWadingEffect")
		end
	end
end

function FightSceneWadingEffect:_onSetEntityAlpha(entityId, state)
	local effectWrap = self._effects2 and self._effects2[entityId]

	if effectWrap and effectWrap.containerGO then
		effectWrap:setActive(state, "_onSetEntityAlpha")
	end
end

function FightSceneWadingEffect:_releaseEntityEffect(entityId)
	local effectWrap = self._effects and self._effects[entityId]

	if effectWrap then
		local entity = FightHelper.getEntity(entityId)

		if entity and entity.effect then
			entity.effect:removeEffect(effectWrap)
			entity.effect:removeEffect(self._effects2[entityId])
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(entityId, effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(entityId, self._effects2[entityId])

		self._effects[entityId] = nil
		self._effects2[entityId] = nil
	end
end

function FightSceneWadingEffect:_releaseAllEntityEffect()
	if self._effects then
		for k, v in pairs(self._effects) do
			self:_releaseEntityEffect(k)
		end
	end
end

function FightSceneWadingEffect:_releaseEffect()
	TaskDispatcher.cancelTask(self._onFrameUpdateEffectPos, self)
	self:_releaseAllEntityEffect()

	self._effects = nil
	self._originPos = nil
	self._standPos = nil
	self._effectUrl = nil
end

return FightSceneWadingEffect
