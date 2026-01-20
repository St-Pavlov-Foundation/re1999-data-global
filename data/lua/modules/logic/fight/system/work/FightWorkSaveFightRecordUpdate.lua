-- chunkname: @modules/logic/fight/system/work/FightWorkSaveFightRecordUpdate.lua

module("modules.logic.fight.system.work.FightWorkSaveFightRecordUpdate", package.seeall)

local FightWorkSaveFightRecordUpdate = class("FightWorkSaveFightRecordUpdate", FightEffectBase)

function FightWorkSaveFightRecordUpdate:beforePlayEffectData()
	local entityId = self.actEffectData.entity and self.actEffectData.entity.uid
	local entity = entityId and FightHelper.getEntity(entityId)
	local entityMo = entity and entity:getMO()

	self.beforeHp = entityMo and entityMo.currentHp or 0
end

function FightWorkSaveFightRecordUpdate:onStart()
	local entityId = self.actEffectData.entity and self.actEffectData.entity.uid
	local entity = entityId and FightHelper.getEntity(entityId)

	if not entity then
		return
	end

	if entity.nameUI then
		entity.nameUI:resetHp()
	end

	local entityMo = entity and entity:getMO()
	local curHp = entityMo and entityMo.currentHp or 0

	FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, curHp - self.beforeHp)

	return self:onDone(true)
end

return FightWorkSaveFightRecordUpdate
