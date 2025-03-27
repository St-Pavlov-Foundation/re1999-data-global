module("modules.logic.fight.system.work.asfd.effectwork.FightWorkCreateEmitterEntity", package.seeall)

slot0 = class("FightWorkCreateEmitterEntity", FightEffectBase)

function slot0.onStart(slot0)
	if not (GameSceneMgr.instance:getCurScene() and slot1.entityMgr) then
		return slot0:onDone(true)
	end

	slot2:addASFDUnit()
	slot0:onDone(true)
end

return slot0
