module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesEntity", package.seeall)

slot0 = class("PinballMarblesEntity", PinballColliderEntity)

function slot0.onInit(slot0)
	slot0.ay = PinballConst.Const5
	slot0.shape = PinballEnum.Shape.Circle
	slot0.speedScale = 1
	slot0.path = "v2a4_tutushizi_ball_0"
	slot0.decx = PinballConst.Const14
	slot0.decy = PinballConst.Const14
	slot0._isTemp = false
	slot0._hitDict = {}
end

function slot0.initByCo(slot0)
	slot0.co = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot0.unitType]
	slot0.path = slot0.co.icon
	slot0.lv = PinballModel.instance:getMarblesLvCache(slot0.unitType)
	slot1 = string.splitToNumber(slot0.co.radius, "#") or {}
	slot0.scale = (slot1[slot0.lv] or slot1[#slot1] or 1000) / 1000 * PinballConst.Const7
	slot0.width = PinballConst.Const6 * slot0.scale
	slot0.height = PinballConst.Const6 * slot0.scale
	slot2 = string.splitToNumber(slot0.co.elasticity, "#") or {}
	slot3 = (slot2[slot0.lv] or slot2[#slot2] or 1000) / 1000
	slot0.baseForceX = slot3
	slot0.baseForceY = slot3
	slot0.speedScale = slot0.co.velocity / 1000
	slot4 = string.splitToNumber(slot0.co.detectTime, "#") or {}
	slot0.hitNum = slot4[slot0.lv] or slot4[#slot4] or 1
	slot5 = string.splitToNumber(slot0.co.effectTime, "#") or {}
	slot0.effectNum = slot5[slot0.lv] or slot5[#slot5] or 1
	slot6 = string.splitToNumber(slot0.co.effectTime2, "#") or {}
	slot0.effectNum2 = slot6[slot0.lv] or slot6[#slot6] or 1
end

function slot0.fixedPos(slot0)
	if slot0.y < PinballConst.Const2 and slot0.vy < 0 then
		slot0:markDead()
	end

	if PinballConst.Const1 < slot0.y and slot0.vy > 0 then
		slot0.vy = -slot0.vy
	end

	if PinballConst.Const3 < slot0.x + slot0.width and slot0.vx > 0 then
		slot0.vx = -slot0.vx
		slot1 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

		slot1:setDelayDispose(2)

		slot1.x = slot0.x + slot0.width
		slot1.y = slot0.y

		slot1:tick(0)
		slot1:playAnim("hit")

		if slot0.unitType == PinballEnum.UnitType.MarblesElasticity then
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio18)
		else
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio13)
		end
	end

	if slot0.x - slot0.width < PinballConst.Const4 and slot0.vx < 0 then
		slot0.vx = -slot0.vx
		slot1 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

		slot1:setDelayDispose(2)

		slot1.x = slot0.x - slot0.width
		slot1.y = slot0.y

		slot1:tick(0)
		slot1:playAnim("hit")

		if slot0.unitType == PinballEnum.UnitType.MarblesElasticity then
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio18)
		else
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio13)
		end
	end
end

function slot0.onTick(slot0, slot1)
	if slot0._isTemp then
		return
	end

	slot0.vx = Mathf.Clamp(slot0.vx, PinballConst.Const8, PinballConst.Const9)
	slot0.vy = Mathf.Clamp(slot0.vy, PinballConst.Const10, PinballConst.Const11)

	if math.abs(slot0.vx) < PinballConst.Const12 and math.abs(slot0.vy) < PinballConst.Const12 then
		if not slot0.stopDt then
			slot0.stopDt = 0
		else
			slot0.stopDt = slot0.stopDt + slot1
		end

		if PinballConst.Const13 < slot0.stopDt then
			slot0:markDead()
		end
	else
		slot0.stopDt = nil
	end
end

function slot0.canHit(slot0)
	return not slot0._isTemp
end

function slot0.isCheckHit(slot0)
	return not slot0._isTemp
end

function slot0.setTemp(slot0)
	slot0._isTemp = true
	slot0.ay = 0
end

function slot0.getHitResCount(slot0)
	return 1
end

function slot0.onHitEnter(slot0, slot1, slot2, slot3, slot4)
	if not PinballEntityMgr.instance:getEntity(slot1) then
		return
	end

	if slot5:isResType() then
		slot5:doHit(slot0:getHitResCount())
	end

	if slot5.unitType == PinballEnum.UnitType.TriggerElasticity then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio14)
	elseif slot0.unitType == PinballEnum.UnitType.MarblesElasticity then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio18)
	else
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio13)
	end

	if not slot5:isBounce() then
		return
	end

	slot0.vx = slot0.vx * slot0.baseForceX * slot5.baseForceX
	slot0.vy = slot0.vy * slot0.baseForceY * slot5.baseForceY
	slot6 = 0

	if next(slot0._hitDict) then
		if PinballEntityMgr.instance:getEntity(slot7):isOtherType() and not slot5:isOtherType() then
			return
		end

		for slot14, slot15 in pairs(slot0._hitDict) do
			slot9 = slot2 - slot0.x + slot15.x
			slot10 = slot3 - slot0.y + slot15.y
		end

		slot6 = math.deg(math.atan2(slot10, slot9))
	else
		slot6 = math.deg(math.atan2(slot0.y - slot3, slot0.x - slot2)) * 2 - (180 + math.deg(math.atan2(slot0.vy, slot0.vx))) % 360 + math.random(0, 20) - 10
	end

	slot0.vx, slot0.vy = PinballHelper.rotateAngle(math.sqrt(slot0.vx * slot0.vx + slot0.vy * slot0.vy), 0, slot6)
	slot9 = math.max(slot0.width - math.sqrt((slot2 - slot0.x)^2 + (slot3 - slot0.y)^2), 0.1)
	slot0._hitDict[slot1] = {
		x = slot2 - slot0.x,
		y = slot3 - slot0.y
	}
	slot0.ay = 0
end

function slot0.onHitExit(slot0, slot1)
	slot0._hitDict[slot1] = nil

	if not next(slot0._hitDict) then
		slot0.ay = PinballConst.Const5
	end
end

return slot0
