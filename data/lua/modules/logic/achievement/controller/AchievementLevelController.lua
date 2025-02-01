module("modules.logic.achievement.controller.AchievementLevelController", package.seeall)

slot0 = class("AchievementLevelController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2)
	AchievementLevelModel.instance:initData(slot1, slot2)
	uv0.instance:cleanAchievementIsNew(slot1)
end

function slot0.onCloseView(slot0)
end

function slot0.selectTask(slot0, slot1)
	AchievementLevelModel.instance:setSelectTask(slot1)
	slot0:dispatchEvent(AchievementEvent.LevelViewUpdated)
end

function slot0.scrollTask(slot0, slot1)
	if AchievementLevelModel.instance:scrollTask(slot1) then
		slot0:cleanAchievementIsNew(AchievementLevelModel.instance:getAchievement())
		slot0:dispatchEvent(AchievementEvent.LevelViewUpdated)
	end
end

function slot0.cleanAchievementIsNew(slot0, slot1)
	if AchievementModel.instance:getAchievementTaskCoList(slot1) then
		slot3 = {}

		for slot7, slot8 in ipairs(slot2) do
			if AchievementModel.instance:getById(slot8.id) and slot9.isNew then
				table.insert(slot3, slot8.id)
			end
		end

		if #slot3 > 0 then
			AchievementRpc.instance:sendReadNewAchievementRequest(slot3)
		end
	end
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
