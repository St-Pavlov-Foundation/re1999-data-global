module("modules.logic.fight.entity.comp.buff.FightBuffRedOrBlueChangeTriggerBuff", package.seeall)

slot0 = class("FightBuffRedOrBlueChangeTriggerBuff")

function slot0.ctor(slot0)
end

function slot0.onBuffStart(slot0, slot1, slot2)
	FightDataHelper.LYDataMgr:setLYChangeTriggerBuff(slot2)
end

function slot0.clear(slot0)
	FightDataHelper.LYDataMgr:setLYChangeTriggerBuff(nil)
end

function slot0.onBuffEnd(slot0)
	slot0:clear()
end

function slot0.dispose(slot0)
	slot0:clear()
end

return slot0
