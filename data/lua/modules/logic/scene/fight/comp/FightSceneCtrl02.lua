-- chunkname: @modules/logic/scene/fight/comp/FightSceneCtrl02.lua

module("modules.logic.scene.fight.comp.FightSceneCtrl02", package.seeall)

local FightSceneCtrl02 = class("FightSceneCtrl02", BaseSceneComp)

function FightSceneCtrl02:onInit()
	self:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function FightSceneCtrl02:_onLevelLoaded(levelId)
	self._sceneCtrl02Comp = nil

	local sceneContainerGO = self:getCurScene():getSceneContainerGO()
	local compList = sceneContainerGO:GetComponentsInChildren(typeof(ZProj.SceneCtrl02))

	if compList.Length > 0 then
		self._sceneCtrl02Comp = compList[0]
		self._deadIdDict = {}

		FightController.instance:registerCallback(FightEvent.BeforePlayUniqueSkill, self._beforePlayUniqueSkill, self)
		FightController.instance:registerCallback(FightEvent.AfterPlayUniqueSkill, self._afterPlayUniqueSkill, self)
		FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, self._beforeDeadEffect, self)
		FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, self._onSpineMaterialChange, self)
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
		FightController.instance:registerCallback(FightEvent.BeforeEntityDestroy, self._beforeEntityDestroy, self)
		FightController.instance:registerCallback(FightEvent.PushEndFight, self._onEndFight, self)
		self:_setAllSpineMat()
	else
		FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, self._beforePlayUniqueSkill, self)
		FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, self._afterPlayUniqueSkill, self)
		FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, self._beforeDeadEffect, self)
		FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, self._onSpineMaterialChange, self)
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
		FightController.instance:unregisterCallback(FightEvent.BeforeEntityDestroy, self._beforeEntityDestroy, self)
		FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onEndFight, self)
	end
end

function FightSceneCtrl02:_setAllSpineMat()
	if self._sceneCtrl02Comp then
		local entityList = FightHelper.getAllEntitysContainUnitNpc()

		for _, entity in ipairs(entityList) do
			if entity.spineRenderer then
				local material = entity.spineRenderer:getReplaceMat()

				self._sceneCtrl02Comp:SetSpineMat(tostring(entity.id), material)
			end
		end
	end
end

function FightSceneCtrl02:_onSpineLoaded(unitSpine)
	if self._sceneCtrl02Comp then
		local entity = unitSpine.unitSpawn
		local entityId = entity.id

		if entity.spineRenderer then
			local material = entity.spineRenderer:getReplaceMat()

			self._sceneCtrl02Comp:SetSpineMat(tostring(entityId), material)
		end
	end
end

function FightSceneCtrl02:_beforeEntityDestroy(entity)
	if self._sceneCtrl02Comp and entity and entity.spineRenderer then
		self._sceneCtrl02Comp:SetSpineMat(tostring(entity.id), nil)
	end
end

function FightSceneCtrl02:_onSpineMaterialChange(entityId, material)
	if self._sceneCtrl02Comp and not self._deadIdDict[entityId] then
		self._sceneCtrl02Comp:SetSpineMat(tostring(entityId), material)
	end
end

function FightSceneCtrl02:_beforeDeadEffect(entityId)
	self._deadIdDict[entityId] = true

	self._sceneCtrl02Comp:SetSpineMat(tostring(entityId), nil)
end

function FightSceneCtrl02:_beforePlayUniqueSkill(entityId)
	if self._sceneCtrl02Comp then
		self._sceneCtrl02Comp.enabled = false
	end
end

function FightSceneCtrl02:_afterPlayUniqueSkill(entityId)
	if self._sceneCtrl02Comp then
		self._sceneCtrl02Comp.enabled = true
	end
end

function FightSceneCtrl02:_onEndFight()
	if self._sceneCtrl02Comp then
		self._sceneCtrl02Comp.enabled = false
	end
end

function FightSceneCtrl02:onSceneClose()
	self._sceneCtrl02Comp = nil

	FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, self._beforePlayUniqueSkill, self)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, self._afterPlayUniqueSkill, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, self._beforeDeadEffect, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, self._onSpineMaterialChange, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeEntityDestroy, self._beforeEntityDestroy, self)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onEndFight, self)
end

return FightSceneCtrl02
