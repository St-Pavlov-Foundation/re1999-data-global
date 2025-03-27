module("modules.logic.fight.system.work.FightWorkCallMonsterToSub", package.seeall)

slot0 = class("FightWorkCallMonsterToSub", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.AddSubEntity)
	slot0:onDone(true)
end

return slot0
