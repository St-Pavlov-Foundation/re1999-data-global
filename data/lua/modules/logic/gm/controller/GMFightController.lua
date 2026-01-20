-- chunkname: @modules/logic/gm/controller/GMFightController.lua

module("modules.logic.gm.controller.GMFightController", package.seeall)

local GMFightController = class("GMFightController", BaseController)

function GMFightController:ctor()
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, self._onExitScene, self)
end

function GMFightController:_onExitScene()
	self.buffTypeId = nil
end

function GMFightController:startStatBuffType(buffTypeId)
	self.buffTypeId = buffTypeId

	local fightScene = GameSceneMgr.instance:getCurScene()
	local entityMgr = fightScene.entityMgr
	local enemyDict = entityMgr:getTagUnitDict(SceneTag.UnitMonster)

	for _, entity in pairs(enemyDict) do
		self:addStatBuffTypeByEntity(entity)
	end

	local playerDict = entityMgr:getTagUnitDict(SceneTag.UnitPlayer)

	for _, entity in pairs(playerDict) do
		self:addStatBuffTypeByEntity(entity)
	end
end

function GMFightController:addStatBuffTypeByEntity(entity)
	local nameUi = entity.nameUI

	if nameUi then
		local containerGo = nameUi:getGO()
		local comp = MonoHelper.addLuaComOnceToGo(containerGo, FightGmNameUIComp, entity)

		comp:startStatBuffType(self.buffTypeId)
	end
end

function GMFightController:stopStatBuffType()
	self.buffTypeId = nil

	local fightScene = GameSceneMgr.instance:getCurScene()
	local entityMgr = fightScene.entityMgr
	local enemyDict = entityMgr:getTagUnitDict(SceneTag.UnitMonster)

	for _, entity in pairs(enemyDict) do
		self:stopStatBuffTypeByEntity(entity)
	end

	local playerDict = entityMgr:getTagUnitDict(SceneTag.UnitPlayer)

	for _, entity in pairs(playerDict) do
		self:stopStatBuffTypeByEntity(entity)
	end
end

function GMFightController:stopStatBuffTypeByEntity(entity)
	local nameUi = entity.nameUI

	if nameUi then
		local containerGo = nameUi:getGO()
		local comp = MonoHelper.getLuaComFromGo(containerGo, FightGmNameUIComp)

		if comp then
			comp:stopStatBuffType()
		end
	end
end

function GMFightController:statingBuffType()
	return self.buffTypeId ~= nil
end

GMFightController.instance = GMFightController.New()

return GMFightController
