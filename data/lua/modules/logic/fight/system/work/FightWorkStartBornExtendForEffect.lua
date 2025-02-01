module("modules.logic.fight.system.work.FightWorkStartBornExtendForEffect", package.seeall)

slot0 = class("FightWorkStartBornExtendForEffect", FightWorkStartBornNormal)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	uv0.super.ctor(slot0, slot1, slot2)

	slot0._effect_name = slot3
	slot0._hangPoint = slot4
	slot0._time = slot5
end

function slot0._playEffect(slot0)
	slot0._effectWrap = slot0._entity.effect:addHangEffect(slot0._effect_name, slot0._hangPoint, nil, , {
		z = 0,
		x = 0,
		y = 0
	})

	slot0._effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot0._effectWrap)
	TaskDispatcher.runDelay(slot0._onEffectDone, slot0, slot0._time)
end

return slot0
