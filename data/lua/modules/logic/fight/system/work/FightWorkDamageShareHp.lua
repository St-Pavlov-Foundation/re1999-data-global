-- chunkname: @modules/logic/fight/system/work/FightWorkDamageShareHp.lua

module("modules.logic.fight.system.work.FightWorkDamageShareHp", package.seeall)

local FightWorkDamageShareHp = class("FightWorkDamageShareHp", FightEffectBase)

function FightWorkDamageShareHp:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		local effectNum = self.actEffectData.effectNum

		if effectNum > 0 then
			local floatNum = entity:isMySide() and -effectNum or effectNum

			if entity.nameUI then
				entity.nameUI:addHp(-effectNum)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -effectNum)
		end
	end

	self:onDone(true)
end

function FightWorkDamageShareHp:clearWork()
	return
end

return FightWorkDamageShareHp
