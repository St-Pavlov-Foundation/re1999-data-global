module("modules.logic.fight.system.work.FightWorkEffectImmunity", package.seeall)

slot0 = class("FightWorkEffectImmunity", BaseWork)

function slot0.onStart(slot0)
	FightFloatMgr.instance:float(slot0._actEffectMO.targetId, FightEnum.FloatType.buff, luaLang("fight_buff_reject"), FightEnum.BuffFloatEffectType.Good)
	slot0:onDone(true)
end

return slot0
