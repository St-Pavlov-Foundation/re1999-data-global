module("modules.logic.fight.view.cardeffect.FightCardChangeMagicEffect", package.seeall)

slot0 = class("FightCardChangeMagicEffect", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0:_playEffects()
end

function slot0._playEffects(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
