module("modules.logic.dungeon.model.RoleStoryModel", package.seeall)

slot0 = class("RoleStoryModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._newDict = {}
	slot0._unlockingStory = {}
	slot0.roleStoryFinishDict = nil
	slot0._leftNum = 0
	slot0._curActStoryId = 0
	slot0._todayExchange = 0
	slot0._isResident = false
	slot0._weekProgress = 0
	slot0._weekHasGet = false
	slot0._lastLeftNum = 0
	slot0.curStoryId = nil

	TaskDispatcher.cancelTask(slot0.checkActivityTime, slot0)
end

function slot0.onGetHeroStoryReply(slot0, slot1)
	for slot6 = 1, #slot1.storyInfos do
		slot0:updateStoryInfo(slot1.storyInfos[slot6])
	end

	for slot6 = 1, #slot1.newStoryList do
		slot0:setStoryNewTag(slot1.newStoryList[slot6], true)
	end

	for slot6 = 1, #slot1.times do
		slot0:updateStoryTime(slot1.times[slot6])
	end

	slot0._leftNum = slot1.leftNum
	slot0._lastLeftNum = slot0._leftNum
	slot0._todayExchange = slot1.todayExchange
	slot0._weekProgress = slot1.weekProgress
	slot0._weekHasGet = slot1.weekHasGet

	RoleStoryListModel.instance:refreshList()
	TaskDispatcher.cancelTask(slot0.checkActivityTime, slot0)
	TaskDispatcher.runRepeat(slot0.checkActivityTime, slot0, 1)
end

function slot0.onUnlocHeroStoryReply(slot0, slot1)
	slot0._unlockingStory[slot1.info.storyId] = true

	slot0:updateStoryInfo(slot1.info)
	RoleStoryListModel.instance:refreshList()
end

function slot0.onGetHeroStoryBonusReply(slot0, slot1)
	slot0:updateStoryInfo(slot1.info)
	RoleStoryListModel.instance:refreshList()
end

function slot0.onHeroStoryUpdatePush(slot0, slot1)
	for slot6 = 1, #slot1.unlockInfos do
		slot0:updateStoryInfo(slot1.unlockInfos[slot6])
	end

	RoleStoryListModel.instance:refreshList()
end

function slot0.updateStoryInfo(slot0, slot1)
	if slot1 then
		slot0:getMoById(slot1.storyId):updateInfo(slot1)
	end
end

function slot0.updateStoryTime(slot0, slot1)
	if slot1 then
		slot0:getMoById(slot1.storyId):updateTime(slot1)
	end
end

function slot0.setCurStoryId(slot0, slot1)
	slot0.curStoryId = slot1
end

function slot0.getCurStoryId(slot0)
	return slot0.curStoryId
end

function slot0.isNewStory(slot0, slot1)
	if slot0._newDict[slot1] then
		return true
	end

	return false
end

function slot0.setStoryNewTag(slot0, slot1, slot2)
	if slot0:isNewStory(slot1) == slot2 then
		return
	end

	slot0._newDict[slot1] = slot2

	if not slot2 then
		HeroStoryRpc.instance:sendUpdateHeroStoryStatusRequest(slot1)
	end
end

function slot0.initFinishTweenDict(slot0)
	if not slot0.roleStoryFinishDict then
		slot0.roleStoryFinishDict = {}

		for slot6, slot7 in ipairs(string.splitToNumber(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RoleStoryFinishKey), ""), "#")) do
			slot0.roleStoryFinishDict[slot7] = true
		end
	end
end

function slot0.isFinishTweenUnplay(slot0, slot1)
	slot0:initFinishTweenDict()

	if not slot0.roleStoryFinishDict[slot1] then
		slot0:markFinishTween(slot1)
	end

	return not slot2
end

function slot0.markFinishTween(slot0, slot1)
	slot0:initFinishTweenDict()

	slot0.roleStoryFinishDict[slot1] = true
	slot2 = {}

	for slot6, slot7 in pairs(slot0.roleStoryFinishDict) do
		table.insert(slot2, slot6)
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RoleStoryFinishKey), table.concat(slot2, "#"))
end

function slot0.isUnlockingStory(slot0, slot1)
	if slot0._unlockingStory[slot1] then
		slot0._unlockingStory[slot1] = nil
	end

	return slot2
end

function slot0.onUpdateHeroStoryStatusReply(slot0, slot1)
end

function slot0.onExchangeTicketReply(slot0, slot1)
	slot0.lastExchangeTime = Time.time
	slot0._leftNum = slot1.leftNum
	slot0._lastLeftNum = slot0._leftNum
	slot0._todayExchange = slot1.todayExchange
end

function slot0.getLeftNum(slot0)
	return slot0._leftNum, slot0._lastLeftNum
end

function slot0.setLastLeftNum(slot0, slot1)
	slot0._lastLeftNum = slot1
end

function slot0.getMoById(slot0, slot1)
	if not slot0:getById(slot1) then
		slot2 = RoleStoryMO.New()

		slot2:init(slot1)
		slot0:addAtLast(slot2)
	end

	return slot2
end

function slot0.getCurActStoryId(slot0)
	return slot0._curActStoryId
end

function slot0.checkActStoryOpen(slot0)
	return slot0._curActStoryId and slot0._curActStoryId > 0
end

function slot0.isInResident(slot0, slot1)
	if not slot1 then
		return slot0._isResident
	end

	if not slot0:getById(slot1) then
		return slot0._isResident
	end

	return slot2:isResidentTime()
end

function slot0.checkActivityTime(slot0)
	slot1 = slot0:getCurActStoryId()
	slot2 = 0
	slot3 = slot0._isResident
	slot4 = false

	if slot0:getList() then
		for slot9, slot10 in ipairs(slot5) do
			if slot10:isActTime() then
				slot2 = slot10.id
			end

			if slot10:isResidentTime() then
				slot4 = true
			end
		end
	end

	if slot2 ~= slot1 then
		slot0._curActStoryId = slot2

		if slot2 == 0 and ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchMainView) then
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
		end

		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ActStoryChange)
	end

	if slot4 ~= slot3 then
		slot0._isResident = slot4

		if not slot4 then
			-- Nothing
		end

		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ResidentStoryChange)
	end

	if slot0:getById(slot0._curActStoryId) and slot6:hasNewDispatchFinish() then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.RoleStoryDispatch
		})
	end
end

function slot0.onGetScoreBonusReply(slot0, slot1)
	if slot0:getById(slot0:getCurActStoryId()) then
		slot3:addScoreBonus(slot1.getScoreBonus)
	end
end

function slot0.onHeroStoryScorePush(slot0, slot1)
	if slot0:getById(slot1.storyId) then
		slot2:updateScore(slot1)
	end
end

function slot0.checkTodayCanExchange(slot0)
	return slot0._todayExchange < CommonConfig.instance:getConstNum(ConstEnum.RoleStoryDayChangeNum)
end

function slot0.getRewardState(slot0, slot1, slot2, slot3)
	if not slot0:getById(slot1) then
		return 0
	end

	if slot4:isBonusHasGet(slot2) then
		return 2
	end

	if slot3 <= slot4:getScore() then
		return 1
	end

	return 0
end

function slot0.onGetChallengeBonusReply(slot0)
	if slot0:getById(slot0:getCurActStoryId()) then
		slot2.getChallengeReward = true
	end
end

function slot0.onHeroStoryTicketPush(slot0, slot1)
	slot0._leftNum = slot1.leftNum
	slot0._todayExchange = slot1.todayExchange
end

function slot0.onHeroStoryWeekTaskPush(slot0, slot1)
	slot0._weekProgress = slot1.weekProgress
	slot0._weekHasGet = slot1.weekHasGet
end

function slot0.getWeekProgress(slot0)
	return slot0._weekProgress
end

function slot0.getWeekHasGet(slot0)
	return slot0._weekHasGet
end

function slot0.onHeroStoryWeekTaskGetReply(slot0)
	slot0._weekHasGet = true
end

function slot0.onHeroStoryDispatchReply(slot0, slot1)
	if slot0:getById(slot1.storyId) then
		slot2:updateDispatchTime(slot1)
	end
end

function slot0.onHeroStoryDispatchResetReply(slot0, slot1)
	if slot0:getById(slot1.storyId) then
		slot2:resetDispatch(slot1)
	end
end

function slot0.onHeroStoryDispatchCompleteReply(slot0, slot1)
	if slot0:getById(slot1.storyId) then
		slot2:completeDispatch(slot1)
	end
end

function slot0.isShowReplayStoryBtn(slot0)
	if not slot0:getCurStoryId() or slot1 == 0 or slot1 == slot0:getCurActStoryId() then
		return false
	end

	return RoleStoryConfig.instance:getDispatchList(slot1, RoleStoryEnum.DispatchType.Story) and #slot2 > 0
end

function slot0.isHeroDispatching(slot0, slot1, slot2)
	return slot0:getById(slot2) and slot3:isHeroDispatching(slot1)
end

function slot0.canPlayDungeonUnlockAnim(slot0, slot1)
	return PlayerPrefsHelper.getNumber(string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDungeonUnlockAnim, slot1), 0) == 0
end

function slot0.setPlayDungeonUnlockAnimFlag(slot0, slot1)
	PlayerPrefsHelper.setNumber(string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDungeonUnlockAnim, slot1), 1)
end

slot0.instance = slot0.New()

return slot0
