-- chunkname: @modules/logic/fight/system/work/FightWorkOriginDamage.lua

module("modules.logic.fight.system.work.FightWorkOriginDamage", package.seeall)

local FightWorkOriginDamage = class("FightWorkOriginDamage", FightEffectBase)

function FightWorkOriginDamage:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		local effectNum = self.actEffectData.effectNum

		if effectNum > 0 then
			local floatNum = entity:isMySide() and -effectNum or effectNum

			FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.damage_origin, floatNum, nil, self.actEffectData.effectNum1 == 1)

			if entity.nameUI then
				entity.nameUI:addHp(-effectNum)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -effectNum)
		end
	end

	self:onDone(true)
end

return FightWorkOriginDamage
