module("modules.logic.fight.system.work.FightWorkNotifyBindContract", package.seeall)

slot0 = class("FightWorkNotifyBindContract", FightEffectBase)

function slot0.onStart(slot0)
	FightModel.instance:setNotifyContractInfo(slot0._actEffectMO.targetId, FightStrUtil.instance:getSplitCache(slot0._actEffectMO.reserveStr, "#"))
	slot0:onDone(true)
end

return slot0
