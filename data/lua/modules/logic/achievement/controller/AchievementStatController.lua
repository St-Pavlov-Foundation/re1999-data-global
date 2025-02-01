module("modules.logic.achievement.controller.AchievementStatController", package.seeall)

slot0 = class("AchievementStatController", BaseController)

function slot0.onInit(slot0)
	slot0.startTime = nil
	slot0.entrance = nil
end

function slot0.reInit(slot0)
	slot0.startTime = nil
	slot0.entrance = nil
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenViewCallBack, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseViewCallBack, slot0)
end

function slot0.onOpenViewCallBack(slot0, slot1, slot2)
	slot0:onOpenTragetView(slot1, slot2)

	if slot1 == ViewName.AchievementMainView then
		slot0:onEnterAchievementMainView()
	end
end

function slot0.onCloseViewCallBack(slot0, slot1)
	if slot1 == ViewName.AchievementMainView then
		slot0:onExitAchievementMainView()
	end
end

function slot0.onExitAchievementMainView(slot0)
	if not slot0.startTime then
		return
	end

	StatController.instance:track(StatEnum.EventName.ExitAchievementMainView, {
		[StatEnum.EventProperties.Time] = Mathf.Ceil(Time.realtimeSinceStartup - slot0.startTime) or 0,
		[StatEnum.EventProperties.CollectAchievmentsName] = slot0:getCollectAchievementList(),
		[StatEnum.EventProperties.Entrance] = tostring(slot0.entrance or "")
	})

	slot0.startTime = nil
end

function slot0.onSaveDisplayAchievementsSucc(slot0)
	slot2, slot3 = AchievementUtils.decodeShowStr(PlayerModel.instance:getShowAchievement())

	StatController.instance:track(StatEnum.EventName.SaveDisplayAchievementSucc, {
		[StatEnum.EventProperties.DisplaySingleAchievementName] = slot0:getAchievementNameListByTaskId(slot2),
		[StatEnum.EventProperties.DisplayGroupAchievementName] = slot0:getGroupNameListByTaskId(slot3)
	})
end

function slot0.getAchievementNameListByTaskId(slot0, slot1)
	slot2 = {}
	slot3 = {}

	if slot1 and #slot1 > 0 then
		for slot7, slot8 in ipairs(slot1) do
			if AchievementConfig.instance:getTask(slot8) and not slot3[slot9.achievementId] then
				table.insert(slot2, AchievementConfig.instance:getAchievement(slot9.achievementId) and slot10.name or "")

				slot3[slot9.achievementId] = true
			end
		end
	end

	return slot2
end

function slot0.getGroupNameListByTaskId(slot0, slot1)
	slot2 = {}
	slot3 = {}

	if slot1 and #slot1 > 0 then
		for slot7, slot8 in ipairs(slot1) do
			if AchievementConfig.instance:getTask(slot8) and AchievementConfig.instance:getGroup(AchievementConfig.instance:getAchievement(slot9.achievementId) and slot10.groupId) and not slot3[slot11] then
				table.insert(slot2, slot12 and slot12.name or "")

				slot3[slot11] = true
			end
		end
	end

	return slot2
end

function slot0.getCollectAchievementList(slot0)
	slot1 = {}
	slot2 = {}

	if AchievementModel.instance:getList() then
		for slot7, slot8 in ipairs(slot3) do
			if slot8.hasFinished and not slot2[slot8.cfg.achievementId] then
				slot2[slot8.cfg.achievementId] = true

				table.insert(slot1, AchievementConfig.instance:getAchievement(slot8.cfg.achievementId).name)
			end
		end
	end

	return slot1
end

function slot0.onOpenAchievementGroupPreView(slot0, slot1)
	if ViewMgr.instance:getContainer(slot1) and slot2.viewParam and slot2.viewParam.activityId and slot3 ~= 0 and ActivityConfig.instance:getActivityCo(slot3) then
		return string.format("Activity_%s", slot4.name)
	end
end

function slot0.setAchievementEntrance(slot0, slot1)
	return slot1
end

function slot0.checkBuildEntranceOpenHandleFuncDict(slot0)
	if not slot0._entranceOpenHandleFuncDict then
		slot0._entranceOpenHandleFuncDict = {
			[ViewName.MainView] = uv0.setAchievementEntrance,
			[ViewName.PlayerView] = uv0.setAchievementEntrance,
			[ViewName.AchievementGroupPreView] = uv0.onOpenAchievementGroupPreView
		}
	end
end

function slot0.onOpenTragetView(slot0, slot1, slot2)
	slot0:checkBuildEntranceOpenHandleFuncDict()

	if slot1 and slot0._entranceOpenHandleFuncDict[slot1] then
		return slot0._entranceOpenHandleFuncDict[slot1](slot0, slot1, slot2) or ""
	end
end

function slot0.onEnterAchievementMainView(slot0)
	slot0.startTime = Time.realtimeSinceStartup

	if ViewMgr.instance:getOpenViewNameList() then
		for slot5 = #slot1, 1, -1 do
			if slot0._entranceOpenHandleFuncDict[slot1[slot5]] then
				slot0.entrance = slot7(slot0, slot6)

				break
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
