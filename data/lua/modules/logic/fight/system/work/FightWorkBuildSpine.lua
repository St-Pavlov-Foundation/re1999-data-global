-- chunkname: @modules/logic/fight/system/work/FightWorkBuildSpine.lua

module("modules.logic.fight.system.work.FightWorkBuildSpine", package.seeall)

local FightWorkBuildSpine = class("FightWorkBuildSpine", FightWorkItem)

function FightWorkBuildSpine:onConstructor(entityMo)
	self.entityMo = entityMo
	self.entityId = self.entityMo.id
end

function FightWorkBuildSpine:onStart()
	local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	local oldEntity = FightHelper.getEntity(self.entityId)

	if oldEntity then
		entityMgr:removeUnit(oldEntity:getTag(), oldEntity.id)
	end

	self.newEntity = entityMgr:buildSpine(self.entityMo)

	local spine = self.newEntity.spine
	local spineGo = spine and spine:getSpineGO()

	if not gohelper.isNil(spineGo) then
		return self:onSpineLoaded(spine)
	end

	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self.onSpineLoaded, self)
end

function FightWorkBuildSpine:onSpineLoaded(unitSpine)
	local entity = unitSpine and unitSpine.unitSpawn

	if entity ~= self.newEntity then
		return
	end

	local buffComp = entity and entity.buff

	if buffComp then
		xpcall(buffComp.dealStartBuff, __G__TRACKBACK__, buffComp)
	end

	return self:onDone(true)
end

function FightWorkBuildSpine:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self.onSpineLoaded, self)
end

return FightWorkBuildSpine
