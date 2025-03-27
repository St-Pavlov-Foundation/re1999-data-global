module("modules.logic.achievement.controller.AchievementStateController", package.seeall)

slot0 = class("AchievementStateController", BaseController)

function slot0.addConstEvents(slot0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, slot0._onCheckFuncUnlock, slot0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, slot0._onNewFuncOpen, slot0)
end

function slot0.reInit(slot0)
	slot0:release()
end

function slot0._onCheckFuncUnlock(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		return
	end

	AchievementConfig.instance:initWaitAchievements()
	slot0:checkReadyAchievmeentOnline()
end

function slot0._onNewFuncOpen(slot0, slot1)
	if tabletool.indexOf(slot1, OpenEnum.UnlockFunc.Achievement) then
		AchievementConfig.instance:initWaitAchievements()
		slot0:checkReadyAchievmeentOnline()
	end
end

function slot0.checkReadyAchievmeentOnline(slot0)
	slot2 = AchievementConfig.instance:getWaitOfflineAchievementList()

	if AchievementConfig.instance:getWaitOnlineAchievementList() and #slot1 > 0 then
		slot0._onlinePriorityQueue = PriorityQueue.New(function (slot0, slot1)
			return slot0.startTime < slot1.startTime
		end)

		for slot6, slot7 in pairs(slot1) do
			slot0._onlinePriorityQueue:add(slot7)
		end

		slot0:startTickAchievementOnline()
	end

	if slot2 and #slot2 > 0 then
		slot0._offlinePriorityQueue = PriorityQueue.New(function (slot0, slot1)
			return slot0.endTime < slot1.endTime
		end)

		for slot6, slot7 in ipairs(slot2) do
			slot0._offlinePriorityQueue:add(slot7)
		end

		slot0:startTickAchievementOffline()
	end
end

function slot0.startTickAchievementOnline(slot0)
	TaskDispatcher.cancelTask(slot0.onAchievementOnline, slot0)
	TaskDispatcher.runDelay(slot0.onAchievementOnline, slot0, slot0:getAchievementStartLeftSeconds(slot0._onlinePriorityQueue:getFirst()))
end

function slot0.onAchievementOnline(slot0)
	AchievementConfig.instance:onAchievementArriveOnlineTime(slot0._onlinePriorityQueue:getFirst().id)
	AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievementState)
	slot0._onlinePriorityQueue:getFirstAndRemove()

	if slot0._onlinePriorityQueue:getSize() > 0 then
		slot0:startTickAchievementOnline()
	else
		slot0._onlinePriorityQueue = nil
	end
end

function slot0.startTickAchievementOffline(slot0)
	slot1 = slot0._offlinePriorityQueue:getFirst()
	slot2 = slot0:getAchievementEndLeftSeconds(slot1)

	logNormal(string.format("成就{%s}准备下架,倒计时:{%s}秒", slot1.id, slot2))
	TaskDispatcher.cancelTask(slot0.onAchievementOffline, slot0)
	TaskDispatcher.runDelay(slot0.onAchievementOffline, slot0, slot2)
end

function slot0.onAchievementOffline(slot0)
	slot1 = slot0._offlinePriorityQueue:getFirst()

	AchievementConfig.instance:onAchievementArriveOfflineTime(slot1.id)
	AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievementState)
	slot0._offlinePriorityQueue:getFirstAndRemove()
	logNormal(string.format("成就{%s}下架", slot1.id))

	if slot0._offlinePriorityQueue:getSize() > 0 then
		slot0:startTickAchievementOnline()
	else
		slot0._offlinePriorityQueue = nil
	end
end

function slot0.getAchievementStartLeftSeconds(slot0, slot1)
	return TimeUtil.stringToTimestamp(slot1.startTime) - ServerTime.now()
end

function slot0.getAchievementEndLeftSeconds(slot0, slot1)
	return TimeUtil.stringToTimestamp(slot1.endTime) - ServerTime.now()
end

function slot0.release(slot0)
	TaskDispatcher.cancelTask(slot0.onAchievementOnline, slot0)
	TaskDispatcher.cancelTask(slot0.onAchievementOffline, slot0)

	slot0._offlinePriorityQueue = nil
	slot0._onlinePriorityQueue = nil
end

slot0.instance = slot0.New()

return slot0
