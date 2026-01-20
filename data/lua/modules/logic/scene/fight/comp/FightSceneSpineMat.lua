-- chunkname: @modules/logic/scene/fight/comp/FightSceneSpineMat.lua

module("modules.logic.scene.fight.comp.FightSceneSpineMat", package.seeall)

local FightSceneSpineMat = class("FightSceneSpineMat", BaseSceneComp)

function FightSceneSpineMat:onSceneStart(sceneId, levelId)
	self:_setLevelCO(levelId)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
end

function FightSceneSpineMat:onScenePrepared(sceneId, levelId)
	self:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
	self:_setAllSpineColor()
end

function FightSceneSpineMat:onSceneClose()
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	self:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)

	self._spineColor = nil
end

function FightSceneSpineMat:_onSpineLoaded(unitSpine)
	if self._spineColor and unitSpine then
		local mat = unitSpine.unitSpawn.spineRenderer:getReplaceMat()

		MaterialUtil.setMainColor(mat, self._spineColor)
	end
end

function FightSceneSpineMat:_onLevelLoaded(levelId)
	self:_setLevelCO(levelId)
	self:_setAllSpineColor()
end

function FightSceneSpineMat:_setLevelCO(levelId)
	self._spineColor = nil

	local levelCO = lua_scene_level.configDict[levelId]

	if levelCO.spineR ~= 0 or levelCO.spineG ~= 0 or levelCO.spineB ~= 0 then
		self._spineColor = Color.New(levelCO.spineR, levelCO.spineG, levelCO.spineB, 1)
	end
end

function FightSceneSpineMat:_setAllSpineColor()
	if not self._spineColor then
		return
	end

	local entityList = FightHelper.getAllEntitysContainUnitNpc()

	for _, entity in ipairs(entityList) do
		if entity.spineRenderer and entity.spineRenderer:hasSkeletonAnim() then
			local mat = entity.spineRenderer:getReplaceMat()

			MaterialUtil.setMainColor(mat, self._spineColor)
		end
	end
end

return FightSceneSpineMat
