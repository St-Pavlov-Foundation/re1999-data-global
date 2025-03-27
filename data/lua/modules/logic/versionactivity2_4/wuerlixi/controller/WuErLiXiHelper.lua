module("modules.logic.versionactivity2_4.wuerlixi.controller.WuErLiXiHelper", package.seeall)

slot0 = class("WuErLiXiHelper")

function slot0.getUnitSpriteName(slot0, slot1)
	if slot0 == WuErLiXiEnum.UnitType.SignalEnd or slot0 == WuErLiXiEnum.UnitType.Obstacle or slot0 == WuErLiXiEnum.UnitType.Key then
		return string.format("v2a4_wuerlixi_unit_icon%s_%s", slot0, slot1 and 2 or 1)
	end

	return string.format("v2a4_wuerlixi_unit_icon%s", slot0)
end

function slot0.getLimitTimeStr()
	if not ActivityModel.instance:getActMO(VersionActivity2_4Enum.ActivityId.WuErLiXi) then
		return ""
	end

	if slot0:getRealEndTimeStamp() - ServerTime.now() > 0 then
		return TimeUtil.SecondToActivityTimeFormat(slot1)
	end

	return ""
end

function slot0.getOppositeDir(slot0)
	return math.abs((2 + slot0) % 4)
end

function slot0.getNextDir(slot0)
	return (slot0 + 1) % 4
end

function slot0.getPreDir(slot0)
	return (4 + slot0 - 1) % 4
end

return slot0
