module("modules.logic.achievement.controller.AchievementJumpController", package.seeall)

slot0 = class("AchievementJumpController", BaseController)

function slot0.jumpToAchievement(slot0, slot1)
	slot5 = false

	if slot0:getJumpHandleFunc(slot0:tryParaseParamsToNumber(slot1) and slot2[2]) then
		slot5 = slot4(unpack(slot2))
	else
		logError(string.format("cannot find JumpHandleFunction, jumpType = %s", slot3))
	end

	return slot5
end

function slot0.tryParaseParamsToNumber(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if tonumber(slot7) then
				table.insert(slot2, slot8)
			else
				table.insert(slot2, slot7)
			end
		end
	end

	return slot2
end

function slot0.getJumpHandleFunc(slot0, slot1)
	return uv0.instance["jumpHandleFunc_" .. tostring(slot1)]
end

function slot0.jumpHandleFunc_1(slot0, slot1, slot2)
	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Single, slot2, true)
end

function slot0.jumpHandleFunc_2(slot0, slot1, slot2)
	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Group, slot2)
end

function slot0.jumpHandleFunc_3(slot0, slot1, slot2)
	AchievementController.instance:openAchievementMainView(slot2)
end

function slot0.jumpHandleFunc_4(slot0, slot1, slot2, slot3)
	AchievementController.instance:openAchievementGroupPreView(slot2, slot3)
end

slot0.instance = slot0.New()

return slot0
