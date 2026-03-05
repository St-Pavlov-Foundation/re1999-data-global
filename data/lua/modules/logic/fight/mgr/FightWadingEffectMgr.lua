-- chunkname: @modules/logic/fight/mgr/FightWadingEffectMgr.lua

module("modules.logic.fight.mgr.FightWadingEffectMgr", package.seeall)

local FightWadingEffectMgr = class("FightWadingEffectMgr", FightBaseClass)
local pairs = pairs
local FightHelper = FightHelper
local transformhelper = transformhelper
local gohelper = gohelper
local typeof = typeof
local MeshRenderer = UnityEngine.MeshRenderer
local mountbody = ModuleEnum.SpineHangPoint.mountbody
local string = string
local MaterialUtil = MaterialUtil

function FightWadingEffectMgr:onConstructor()
	self:com_registFightEvent(FightEvent.OnSpineLoaded, self.onSpineLoaded)
	self:com_registFightEvent(FightEvent.BeforeDeadEffect, self.releaseEntityEffect)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self.releaseAllEntityEffect)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self.releaseAllEntityEffect)
	self:com_registFightEvent(FightEvent.BeforeChangeSubHero, self.releaseEntityEffect)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.SetEntityAlpha, self.onSetEntityAlpha)

	local curScene = GameSceneMgr.instance:getCurScene()

	self:com_registEvent(curScene.level, CommonSceneLevelComp.OnLevelLoaded, self.onLevelLoaded)
end

function FightWadingEffectMgr:onSpineLoaded(unitSpine)
	if not unitSpine or not self.effectUrl then
		return
	end

	self:setSpineEffect(unitSpine)
end

function FightWadingEffectMgr:onLevelLoaded(levelId)
	self:releaseEffect()
	self:setLevelCO(levelId)
	self:setAllSpineEffect()
end

function FightWadingEffectMgr:setLevelCO(levelId)
	local levelCO = lua_scene_level.configDict[levelId]
	local wadeEffect = levelCO.wadeEffect

	if not string.nilorempty(wadeEffect) then
		self:com_registUpdate(self.onUpdate)

		local arr = string.split(wadeEffect, "#")
		local side = arr[1]

		if side == "1" then
			self.side = FightEnum.EntitySide.EnemySide
		elseif side == "2" then
			self.side = FightEnum.EntitySide.MySide
		elseif side == "3" then
			self.side = nil
		end

		self.effectUrl = arr[2]
	end
end

function FightWadingEffectMgr:setAllSpineEffect()
	if not self.effectUrl then
		return
	end

	local entityList

	if self.side then
		entityList = FightHelper.getSideEntitys(self.side, true)
	else
		entityList = {}

		for i, v in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
			table.insert(entityList, v)
		end

		for i, v in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)) do
			table.insert(entityList, v)
		end
	end

	for i, entity in ipairs(entityList) do
		if entity.spine then
			self:setSpineEffect(entity.spine)
		end
	end
end

function FightWadingEffectMgr:setSpineEffect(spine)
	local entity = spine.unitSpawn
	local entityId = entity.id
	local entitymo = entity:getMO()

	if not entitymo then
		return
	end

	local skinconfig = FightConfig.instance:getSkinCO(entitymo.skin)

	if not skinconfig or skinconfig.isFly == 1 then
		return
	end

	if self.side and self.side ~= entity:getSide() then
		return
	end

	if not self.effects then
		self.effects = {}
		self.originPos = {}
		self.standPos = {}
		self.effects2 = {}
	end

	if self.effects[entityId] then
		return
	end

	local foot = entity:getHangPoint(mountbody)

	if foot then
		local effectWrap = entity.effect:addHangEffect(self.effectUrl, ModuleEnum.SpineHangPointRoot)

		self.effects[entityId] = effectWrap

		self.effects[entityId]:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)

		local x, y, z = FightHelper.getEntityStandPos(entitymo)
		local offsetX, offsetY, offsetZ = transformhelper.getLocalPos(foot.transform)

		self.originPos[entityId] = {
			x + offsetX,
			y + offsetY,
			z + offsetZ
		}
		self.standPos[entityId] = {
			x,
			y,
			z
		}
		effectWrap = entity.effect:addGlobalEffect(self.effectUrl .. "_effect")

		effectWrap:setLocalPos(offsetX + x, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)

		self.effects2[entityId] = effectWrap
	end
end

local proName = "RolePos"

function FightWadingEffectMgr:onUpdate()
	if self.effects then
		for entityId, effectWrap in pairs(self.effects) do
			local entity = FightHelper.getEntity(entityId)

			if entity then
				local standPos = self.standPos[entityId]
				local curPosX, curPosY, curPosz = transformhelper.getLocalPos(entity.go.transform)

				if curPosX ~= standPos[1] or curPosY ~= standPos[2] or curPosz ~= standPos[3] then
					local effectGO = effectWrap.effectGO
					local render = gohelper.findChildComponent(effectGO, "root/wave", typeof(MeshRenderer))

					if render and render.material then
						local entity = FightHelper.getEntity(entityId)
						local foot = entity:getHangPoint(mountbody)
						local footX, footY, footZ = transformhelper.getPos(foot.transform)
						local originPos = self.originPos[entityId]
						local offsetX = footX - originPos[1]
						local offsetY = footY - originPos[2]
						local offsetZ = footZ - originPos[3]
						local posStr = string.format("%f,%f,%f,0", offsetX, offsetY, offsetZ)

						MaterialUtil.setPropValue(render.material, proName, "Vector4", MaterialUtil.getPropValueFromStr("Vector4", posStr))

						if footX < 0 and offsetY < 1 then
							self.effects2[entityId]:setLocalPos(footX, 0, footZ)
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

function FightWadingEffectMgr:onSkillPlayStart(entity, skillId, stepData)
	local showEffect2Entity = {
		[stepData.fromId] = true,
		[stepData.toId] = true
	}

	for i, actEffectMO in ipairs(stepData.actEffect) do
		if directCharacterHitEffectType[actEffectMO.effectType] then
			showEffect2Entity[actEffectMO.targetId] = true
		end
	end

	if self.effects2 then
		for entityId, effectWrap in pairs(self.effects2) do
			if not showEffect2Entity[entityId] then
				effectWrap:setActive(false, "FightWadingEffectMgr")
			end
		end
	end
end

function FightWadingEffectMgr:onSkillPlayFinish()
	if self.effects2 then
		for entityId, effectWrap in pairs(self.effects2) do
			effectWrap:setActive(true, "FightWadingEffectMgr")
		end
	end
end

function FightWadingEffectMgr:onSetEntityAlpha(entityId, state)
	if self.effects2 and self.effects2[entityId] then
		self.effects2[entityId]:setActive(state, "onSetEntityAlpha")
	end
end

function FightWadingEffectMgr:releaseEntityEffect(entityId)
	local effectWrap = self.effects and self.effects[entityId]

	if effectWrap then
		local entity = FightHelper.getEntity(entityId)

		if entity and entity.effect then
			entity.effect:removeEffect(effectWrap)
			entity.effect:removeEffect(self.effects2[entityId])
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(entityId, effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(entityId, self.effects2[entityId])

		self.effects[entityId] = nil
		self.effects2[entityId] = nil
	end
end

function FightWadingEffectMgr:releaseAllEntityEffect()
	if self.effects then
		for k, v in pairs(self.effects) do
			self:releaseEntityEffect(k)
		end
	end
end

function FightWadingEffectMgr:releaseEffect()
	self:releaseAllEntityEffect()

	self.effects = nil
	self.originPos = nil
	self.standPos = nil
	self.effectUrl = nil
end

function FightWadingEffectMgr:onDestructor()
	self:releaseEffect()
end

return FightWadingEffectMgr
