module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesExplosionEntity", package.seeall)

slot0 = class("PinballMarblesExplosionEntity", PinballMarblesEntity)

function slot0.initByCo(slot0)
	uv0.super.initByCo(slot0)

	slot0._totalExplosion = slot0.effectNum
	slot0._range = slot0.width * slot0.effectNum2
	slot0._curExplosionNum = 0
end

function slot0.onHitExit(slot0, slot1)
	uv0.super.onHitExit(slot0, slot1)

	if not PinballEntityMgr.instance:getEntity(slot1) then
		return
	end

	if slot0._curExplosionNum < slot0._totalExplosion and slot2:isResType() then
		slot0:doExplosion()
	end
end

function slot0.doExplosion(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio15)

	slot1 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

	slot1:setDelayDispose(2)

	slot1.x = slot0.x
	slot1.y = slot0.y

	slot1:tick(0)
	slot1:setScale(slot0.effectNum2 * 0.4 * slot0.scale / 3)
	slot1:playAnim("explode")

	slot3 = slot0.width
	slot4 = slot0.height
	slot0.width = slot0._range
	slot0.height = slot0._range

	for slot8, slot9 in pairs(PinballEntityMgr.instance:getAllEntity()) do
		if slot9:isResType() and not slot9.isDead and PinballHelper.getHitInfo(slot0, slot9) then
			slot9:doHit(slot0.hitNum)
		end
	end

	slot0.height = slot4
	slot0.width = slot3
	slot0._curExplosionNum = slot0._curExplosionNum + 1
end

return slot0
