-- chunkname: @modules/logic/fight/system/work/FightWorkAdditionalDamage.lua

module("modules.logic.fight.system.work.FightWorkAdditionalDamage", package.seeall)

local FightWorkAdditionalDamage = class("FightWorkAdditionalDamage", FightEffectBase)

function FightWorkAdditionalDamage:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		local effectNum = self.actEffectData.effectNum

		if effectNum > 0 then
			local floatNum = entity:isMySide() and -effectNum or effectNum

			FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.additional_damage, floatNum, nil, self.actEffectData.effectNum1 == 1)

			if entity.nameUI then
				entity.nameUI:addHp(-effectNum)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -effectNum)
		end
	end

	self:onDone(true)
end

return FightWorkAdditionalDamage
