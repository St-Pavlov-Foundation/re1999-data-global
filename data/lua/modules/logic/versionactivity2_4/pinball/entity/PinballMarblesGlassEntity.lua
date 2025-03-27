module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesGlassEntity", package.seeall)

slot0 = class("PinballMarblesGlassEntity", PinballMarblesEntity)

function slot0.onHitEnter(slot0, slot1, slot2, slot3, slot4)
	if not PinballEntityMgr.instance:getEntity(slot1) then
		return
	end

	if slot5:isResType() then
		if slot5.unitType == PinballEnum.UnitType.ResMine and slot0.hitNum < slot5.totalHitCount then
			uv0.super.onHitEnter(slot0, slot1, slot2, slot3, slot4)
		else
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio16)
			slot5:doHit(slot0.hitNum)
		end
	else
		uv0.super.onHitEnter(slot0, slot1, slot2, slot3, slot4)
	end
end

function slot0.getHitResCount(slot0)
	return slot0.hitNum
end

return slot0
