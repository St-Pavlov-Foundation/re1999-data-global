module("modules.logic.fight.system.work.specialdelay.FightWorkSpecialDelayModelId3070", package.seeall)

slot0 = class("FightWorkSpecialDelayModelId3070", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._parentClass = slot1
	slot0._fightStepMO = slot2

	slot0:onStart()
end

slot1 = 0.4
slot2 = 0.45

function slot0.onStart(slot0)
	if slot0._fightStepMO.actType == FightEnum.ActType.SKILL and FightHelper.getEntity(slot0._fightStepMO.fromId) and slot1:getMO() then
		for slot8, slot9 in ipairs(slot0._fightStepMO.actEffectMOs) do
			if slot9.effectType == FightEnum.EffectType.BUFFADD and slot9.buff and lua_skill_buff.configDict[slot9.buff.buffId] and FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[slot10.typeId] then
				slot3 = 0 + 1
				slot4 = nil or tonumber(string.split(lua_skill_bufftype.configDict[slot10.typeId].includeTypes, "#")[2])
			end
		end

		if slot3 > 0 then
			TaskDispatcher.runDelay(slot0._delay, slot0, uv0 + uv1 * math.min(slot3, slot4) / FightModel.instance:getSpeed())

			return
		end
	end

	slot0:_delay()
end

function slot0._delay(slot0)
	slot0._parentClass:_delayDone()
end

function slot0.releaseSelf(slot0)
	TaskDispatcher.cancelTask(slot0._delay, slot0)
	slot0:__onDispose()
end

return slot0
