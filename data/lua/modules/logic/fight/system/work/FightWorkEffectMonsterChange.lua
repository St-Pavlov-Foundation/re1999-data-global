-- chunkname: @modules/logic/fight/system/work/FightWorkEffectMonsterChange.lua

module("modules.logic.fight.system.work.FightWorkEffectMonsterChange", package.seeall)

local FightWorkEffectMonsterChange = class("FightWorkEffectMonsterChange", FightEffectBase)

function FightWorkEffectMonsterChange:beforePlayEffectData()
	self._entityId = self.actEffectData.entity.id
	self._oldEntityMO = FightDataHelper.entityMgr:getOldEntityMO(self._entityId)
end

function FightWorkEffectMonsterChange:onStart()
	self._newEntityMO = FightDataHelper.entityMgr:getById(self._entityId)

	if not self._newEntityMO then
		self:onDone(true)

		return
	end

	local oldEntity = FightHelper.getEntity(self.actEffectData.targetId)

	if not oldEntity then
		self:_buildNewEntity()
		self:onDone(true)

		return
	end

	self._newEntityMO.custom_refreshNameUIOp = true

	local flowDone = self:com_registWorkDoneFlowSequence()

	flowDone:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.MonsterChangeBefore, self._oldEntityMO.modelId))

	local bossEvolutionConfig = lua_fight_boss_evolution_client.configDict[self._oldEntityMO.skin]

	if bossEvolutionConfig then
		oldEntity.beforeMonsterChangeSkin = self._oldEntityMO.skin

		local flow = FightWorkFlowSequence.New()

		work = FightWorkBuildSpine.New(self._newEntityMO)

		FightHelper.buildMonsterA2B(oldEntity, self._oldEntityMO, flow, work)
		flow:registWork(FightWorkDelayTimer, 0.01)
		flowDone:addWork(flow)
	else
		flowDone:registWork(FightWorkFunction, self._removeOldEntity, self, oldEntity)
		flowDone:registWork(FightWorkBuildSpine, self._newEntityMO)
	end

	flowDone:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.MonsterChangeAfter, self._newEntityMO.modelId))
	flowDone:registWork(FightWorkFunction, self._dispatchChangeEvent, self)
	flowDone:start()
end

function FightWorkEffectMonsterChange:_removeOldEntity(oldEntity)
	local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

	entityMgr:removeUnit(oldEntity:getTag(), oldEntity.id)
end

function FightWorkEffectMonsterChange:_buildNewEntity()
	local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	local oldEntity = FightHelper.getEntity(self._newEntityMO.id)

	if oldEntity then
		entityMgr:removeUnit(oldEntity:getTag(), oldEntity.id)
	end

	local newEntity = entityMgr:buildSpine(self._newEntityMO)
	local buffComp = newEntity and newEntity.buff

	if buffComp then
		xpcall(buffComp.dealStartBuff, __G__TRACKBACK__, buffComp)
	end
end

function FightWorkEffectMonsterChange:_dispatchChangeEvent()
	self:com_sendFightEvent(FightEvent.OnMonsterChange, self._oldEntityMO, self._newEntityMO)
end

function FightWorkEffectMonsterChange:clearWork()
	return
end

return FightWorkEffectMonsterChange
