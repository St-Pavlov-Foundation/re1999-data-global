-- chunkname: @modules/logic/fight/system/work/asfd/effectwork/FightWorkEmitterRemove.lua

module("modules.logic.fight.system.work.asfd.effectwork.FightWorkEmitterRemove", package.seeall)

local FightWorkEmitterRemove = class("FightWorkEmitterRemove", FightEffectBase)

function FightWorkEmitterRemove:beforePlayEffectData()
	local side = self.actEffectData.effectNum

	self.emitterMo = FightDataHelper.entityMgr:getASFDEntityMo(side)
end

function FightWorkEmitterRemove:onStart()
	if not self.emitterMo then
		return self:onDone(true)
	end

	local curScene = GameSceneMgr.instance:getCurScene()
	local sceneMgr = curScene and curScene.entityMgr

	if not sceneMgr then
		return self:onDone(true)
	end

	local entity = FightHelper.getEntity(self.emitterMo.id)

	if entity then
		sceneMgr:removeUnit(entity:getTag(), entity.id)
	end

	self:onDone(true)
end

return FightWorkEmitterRemove
