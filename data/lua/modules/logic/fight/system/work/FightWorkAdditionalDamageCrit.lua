-- chunkname: @modules/logic/fight/system/work/FightWorkAdditionalDamageCrit.lua

module("modules.logic.fight.system.work.FightWorkAdditionalDamageCrit", package.seeall)

local FightWorkAdditionalDamageCrit = class("FightWorkAdditionalDamageCrit", FightEffectBase)

function FightWorkAdditionalDamageCrit:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		local effectNum = self.actEffectData.effectNum

		if effectNum > 0 then
			local floatNum = entity:isMySide() and -effectNum or effectNum

			FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.crit_additional_damage, floatNum, nil, self.actEffectData.effectNum1 == 1)

			if entity.nameUI then
				entity.nameUI:addHp(-effectNum)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -effectNum)
		end
	end

	self:onDone(true)
end

return FightWorkAdditionalDamageCrit
