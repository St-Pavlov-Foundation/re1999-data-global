module("modules.logic.versionactivity2_4.pinball.controller.PinballHelper", package.seeall)

slot0 = class("PinballHelper")

function slot0.getHitInfo(slot0, slot1)
	if slot0.shape == PinballEnum.Shape.Rect and slot1.shape == PinballEnum.Shape.Rect then
		return uv0.getHitRectRect(slot0, slot1)
	elseif slot0.shape == PinballEnum.Shape.Circle and slot1.shape == PinballEnum.Shape.Circle then
		return uv0.getHitCirCleCirCle(slot0, slot1)
	elseif slot0.shape == PinballEnum.Shape.Rect and slot1.shape == PinballEnum.Shape.Circle then
		return uv0.getHitRectCircle(slot0, slot1)
	elseif slot0.shape == PinballEnum.Shape.Circle and slot1.shape == PinballEnum.Shape.Rect then
		slot2, slot3, slot4 = uv0.getHitRectCircle(slot1, slot0)

		return slot2, slot3, slot4 and -slot4
	end
end

slot1 = {
	width = 0,
	height = 0,
	angle = 0,
	y = 0,
	x = 0
}
slot2 = {
	width = 0,
	height = 0,
	angle = 0,
	y = 0,
	x = 0
}
slot3 = Vector2()

function slot0.getHitRectCircle(slot0, slot1)
	if slot0.angle ~= 0 then
		uv0.x = slot1.x - slot0.x
		uv0.y = slot1.y - slot0.y
		uv1.x = slot0.x + uv0.x * math.cos(-slot0.angle * Mathf.Deg2Rad) - uv0.y * math.sin(-slot0.angle * Mathf.Deg2Rad)
		uv1.y = slot0.y + uv0.x * math.sin(-slot0.angle * Mathf.Deg2Rad) + uv0.y * math.cos(-slot0.angle * Mathf.Deg2Rad)
		uv1.width = slot1.width
		uv1.height = slot1.height
		uv2.x = slot0.x
		uv2.y = slot0.y
		uv2.width = slot0.width
		uv2.height = slot0.height
		slot2, slot3 = uv3.getHitRectCircle(uv2, uv1)

		if slot2 then
			uv0.x = slot2 - slot0.x
			uv0.y = slot3 - slot0.y
			slot2 = slot0.x + uv0.x * math.cos(slot0.angle * Mathf.Deg2Rad) - uv0.y * math.sin(slot0.angle * Mathf.Deg2Rad)
			slot3 = slot0.y + uv0.x * math.sin(slot0.angle * Mathf.Deg2Rad) + uv0.y * math.cos(slot0.angle * Mathf.Deg2Rad)
		end

		return slot2, slot3, PinballEnum.Dir.None
	end

	slot3 = math.abs(slot0.y - slot1.y)

	if math.abs(slot0.x - slot1.x) > slot0.width + slot1.width or slot3 > slot0.height + slot1.width then
		return
	end

	slot4, slot5, slot6 = nil

	if slot2 <= slot0.width and slot3 <= slot0.height then
		if slot0.width - slot2 > slot0.height - slot3 then
			slot4 = slot1.x
			slot5 = slot0.y < slot1.y and slot0.y + slot0.height or slot0.y - slot0.height
			slot6 = slot0.y < slot1.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
		else
			slot4 = slot0.x < slot1.x and slot0.x + slot0.width or slot0.x - slot0.width
			slot5 = slot1.y
			slot6 = slot1.x < slot0.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
		end
	elseif slot2 <= slot0.width then
		slot4 = slot1.x
		slot5 = slot0.y < slot1.y and slot0.y + slot0.height or slot0.y - slot0.height
		slot6 = slot0.y < slot1.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
	elseif slot3 <= slot0.height then
		slot4 = slot0.x < slot1.x and slot0.x + slot0.width or slot0.x - slot0.width
		slot5 = slot1.y
		slot6 = slot1.x < slot0.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
	else
		for slot10 = -1, 1, 2 do
			for slot14 = -1, 1, 2 do
				if (slot0.x + slot10 * slot0.width - slot1.x)^2 + (slot0.y + slot14 * slot0.height - slot1.y)^2 <= slot1.width^2 then
					slot4 = slot15
					slot5 = slot16
					slot6 = slot0.y < slot1.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down

					break
				end
			end

			if slot4 then
				break
			end
		end
	end

	return slot4, slot5, slot6
end

function slot0.rotateAngle(slot0, slot1, slot2)
	return slot0 * math.cos(slot2 * Mathf.Deg2Rad) - slot1 * math.sin(slot2 * Mathf.Deg2Rad), slot0 * math.sin(slot2 * Mathf.Deg2Rad) + slot1 * math.cos(slot2 * Mathf.Deg2Rad)
end

function slot0.getHitRectRect(slot0, slot1)
	if math.abs(slot0.x - slot1.x) > slot0.width + slot1.width or math.abs(slot0.y - slot1.y) > slot0.height + slot1.height then
		return
	end

	slot4, slot5, slot6 = nil
	slot4 = (slot1.x + slot0.x) / 2
	slot5 = (slot1.y + slot0.y) / 2

	if slot2 <= slot0.width then
		slot6 = slot0.y < slot1.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
	elseif slot3 <= slot0.height then
		slot6 = slot1.x < slot0.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
	end

	return slot4, slot5, slot6
end

function slot0.getHitCirCleCirCle(slot0, slot1)
	slot3 = math.abs(slot0.y - slot1.y)

	if math.abs(slot0.x - slot1.x) > slot0.width + slot1.width or slot3 > slot0.height + slot1.height then
		return
	end

	if slot2^2 + slot3^2 > (slot0.width + slot1.width)^2 then
		return
	end

	slot5, slot6, slot7 = nil

	return (slot1.x + slot0.x) / 2, (slot1.y + slot0.y) / 2, slot3 < slot2 and (slot1.x < slot0.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right) or slot0.y < slot1.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
end

function slot0.isResType(slot0)
	return slot0 == PinballEnum.UnitType.ResSmallFood or slot0 == PinballEnum.UnitType.ResFood or slot0 == PinballEnum.UnitType.ResMine or slot0 == PinballEnum.UnitType.ResStone or slot0 == PinballEnum.UnitType.ResWood
end

function slot0.isMarblesType(slot0)
	return slot0 == PinballEnum.UnitType.MarblesNormal or slot0 == PinballEnum.UnitType.MarblesDivision or slot0 == PinballEnum.UnitType.MarblesElasticity or slot0 == PinballEnum.UnitType.MarblesExplosion or slot0 == PinballEnum.UnitType.MarblesGlass
end

function slot0.isOtherType(slot0)
	return not uv0.isResType(slot0) and not uv0.isMarblesType(slot0)
end

function slot0.getLimitTimeStr()
	if not ActivityModel.instance:getActMO(VersionActivity2_4Enum.ActivityId.Pinball) then
		return ""
	end

	if slot0:getRealEndTimeStamp() - ServerTime.now() > 0 then
		return TimeUtil.SecondToActivityTimeFormat(slot1)
	end

	return ""
end

function slot0.isBanOper()
	return GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.PinballBanOper)
end

return slot0
