module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesDivisionEntity", package.seeall)

slot0 = class("PinballMarblesDivisionEntity", PinballMarblesEntity)
slot1 = {
	Done = 2,
	Hit = 1,
	None = 0
}

function slot0.initByCo(slot0)
	uv0.super.initByCo(slot0)

	slot0._statu = uv1.None
	slot0._canHitNum = 0
end

function slot0.onHitEnter(slot0, slot1, slot2, slot3, slot4)
	uv0.super.onHitEnter(slot0, slot1, slot2, slot3, slot4)

	if not PinballEntityMgr.instance:getEntity(slot1) or not slot5:isResType() then
		return
	end

	if slot0._statu == uv1.None then
		slot0._statu = uv1.Hit
	end

	if slot0._canHitNum > 0 then
		slot0._canHitNum = slot0._canHitNum - 1

		if slot0._canHitNum == 0 then
			slot0:markDead()
		end
	end
end

function slot0.onHitExit(slot0, slot1)
	uv0.super.onHitExit(slot0, slot1)

	if slot0._statu == uv1.Hit then
		slot0._statu = uv1.Done

		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio17)

		for slot5 = 1, slot0.effectNum - 1 do
			slot6 = math.random(0, 360)
			slot7, slot8 = PinballHelper.rotateAngle(slot0.width * 2.1, 0, slot6)
			slot9 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.MarblesDivision)
			slot9._statu = uv1.Done
			slot9.x = slot0.x + slot7
			slot9.y = slot0.y + slot8
			slot9.vx, slot9.vy = PinballHelper.rotateAngle(slot0.vx, slot0.vy, slot6)
			slot9._canHitNum = slot0.effectNum2

			slot9:tick(0)
			slot9:playAnim("clone")
		end
	end
end

return slot0
