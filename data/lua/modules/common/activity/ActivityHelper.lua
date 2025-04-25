module("modules.common.activity.ActivityHelper", package.seeall)

slot0 = class("ActivityHelper")

function slot0.getActivityStatus(slot0, slot1)
	if not ActivityModel.instance:getActivityInfo()[slot0] then
		if not slot1 then
			logError(string.format("not found ActivityId : %s activity", slot0))
		end

		return ActivityEnum.ActivityStatus.None
	end

	if not slot2:isOpen() then
		return ActivityEnum.ActivityStatus.NotOpen
	end

	if slot2:isExpired() then
		return ActivityEnum.ActivityStatus.Expired
	end

	if slot2.config and slot2.config.openId and slot3 ~= 0 and not OpenModel.instance:isFunctionUnlock(slot3) then
		return ActivityEnum.ActivityStatus.NotUnlock
	end

	if not slot2:isOnline() then
		return ActivityEnum.ActivityStatus.NotOnLine
	end

	return ActivityEnum.ActivityStatus.Normal
end

function slot0.getActivityStatusAndToast(slot0, slot1)
	if not ActivityModel.instance:getActivityInfo()[slot0] then
		if not slot1 then
			logError(string.format("not found ActivityId : %s activity", slot0))
		end

		return ActivityEnum.ActivityStatus.None
	end

	if not slot2:isOpen() then
		return ActivityEnum.ActivityStatus.NotOpen, ToastEnum.ActivityNotOpen
	end

	if slot2:isExpired() then
		return ActivityEnum.ActivityStatus.Expired, ToastEnum.ActivityEnd
	end

	if slot2.config and slot2.config.openId and slot3 ~= 0 and not OpenModel.instance:isFunctionUnlock(slot3) then
		slot4, slot5 = OpenHelper.getToastIdAndParam(slot3)

		return ActivityEnum.ActivityStatus.NotUnlock, slot4, slot5
	end

	if not slot2:isOnline() then
		return ActivityEnum.ActivityStatus.NotOnLine, ToastEnum.ActivityEnd
	end

	return ActivityEnum.ActivityStatus.Normal
end

function slot0.getActivityRemainTimeStr(slot0, slot1)
	if ActivityModel.instance:getRemainTimeSec(slot0) then
		if slot2 >= 0 then
			return TimeUtil.SecondToActivityTimeFormat(slot2, slot1)
		else
			return luaLang("turnback_end")
		end
	end

	return ""
end

slot1, slot2 = nil

function slot0.initActivityVersion()
	if not uv0 then
		uv0 = {}
		uv1 = {}
		slot0 = 1

		for slot4 = 1, math.huge do
			for slot8 = slot0, math.huge do
				slot9 = string.format("VersionActivity%d_%dEnum", slot4, slot8)

				if slot4 == 1 and slot8 == 1 then
					slot9 = "VersionActivityEnum"
				end

				if slot8 == 0 and not _G[slot9] then
					return
				elseif not slot10 then
					break
				end

				if isDebugBuild then
					logNormal("自动加载" .. slot9)
				end

				if slot10.ActivityId then
					for slot15, slot16 in pairs(slot10.ActivityId) do
						uv0[slot16] = string.format("%d_%d", slot4, slot8)
					end
				end

				if slot10.JumpNeedCloseView then
					for slot14, slot15 in pairs(slot10.JumpNeedCloseView()) do
						uv1[slot15] = true
					end
				end
			end

			slot0 = 0
		end
	end
end

function slot0.getActivityVersion(slot0)
	uv0.initActivityVersion()

	return uv1[slot0] or ""
end

function slot0.getJumpNeedCloseViewDict()
	uv0.initActivityVersion()

	return uv1
end

function slot0.activateClass(slot0, slot1, slot2)
	slot2 = slot2 or 0

	for slot6 = slot1 or 1, math.huge do
		for slot10 = slot2, math.huge do
			if not _G[string.format(slot0, slot6, slot10)] then
				slot13 = slot10

				while slot10 < 10 do
					if _G[string.format(slot0, slot6, slot10 + 1)] then
						break
					end
				end

				if slot13 == 0 and not slot12 then
					return
				end

				if slot10 >= 10 then
					break
				end
			end

			if slot10 == 0 and not slot12 then
				return
			elseif not slot12 then
				break
			end

			if isDebugBuild then
				logNormal("自动加载" .. slot11)
			end
		end

		slot2 = 0
	end
end

return slot0
