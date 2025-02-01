module("modules.logic.fight.system.work.FightWorkFightCounter", package.seeall)

slot0 = class("FightWorkFightCounter", FightEffectBase)

function slot0.onStart(slot0)
	slot2 = FightHelper.getEntity(slot0._actEffectMO.targetId)

	if slot0._actEffectMO.effectNum == 13 and slot2 then
		FightFloatMgr.instance:float(slot2.id, FightEnum.FloatType.buff, GameUtil.getSubPlaceholderLuaLang(luaLang("fight_counter_float13"), {
			luaLang("multiple"),
			slot0._actEffectMO.configEffect
		}), 1)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
