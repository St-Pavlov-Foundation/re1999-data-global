module("modules.logic.dungeon.model.RoleStoryModel", package.seeall)

local var_0_0 = class("RoleStoryModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._newDict = {}
	arg_2_0._unlockingStory = {}
	arg_2_0.roleStoryFinishDict = nil
	arg_2_0._leftNum = 0
	arg_2_0._curActStoryId = 0
	arg_2_0._todayExchange = 0
	arg_2_0._isResident = false
	arg_2_0._weekProgress = 0
	arg_2_0._weekHasGet = false
	arg_2_0._lastLeftNum = 0
	arg_2_0.curStoryId = nil

	TaskDispatcher.cancelTask(arg_2_0.checkActivityTime, arg_2_0)
end

function var_0_0.onGetHeroStoryReply(arg_3_0, arg_3_1)
	local var_3_0 = #arg_3_1.storyInfos

	for iter_3_0 = 1, var_3_0 do
		arg_3_0:updateStoryInfo(arg_3_1.storyInfos[iter_3_0])
	end

	local var_3_1 = #arg_3_1.newStoryList

	for iter_3_1 = 1, var_3_1 do
		arg_3_0:setStoryNewTag(arg_3_1.newStoryList[iter_3_1], true)
	end

	local var_3_2 = #arg_3_1.times

	for iter_3_2 = 1, var_3_2 do
		arg_3_0:updateStoryTime(arg_3_1.times[iter_3_2])
	end

	arg_3_0._leftNum = arg_3_1.leftNum
	arg_3_0._lastLeftNum = arg_3_0._leftNum
	arg_3_0._todayExchange = arg_3_1.todayExchange
	arg_3_0._weekProgress = arg_3_1.weekProgress
	arg_3_0._weekHasGet = arg_3_1.weekHasGet

	RoleStoryListModel.instance:refreshList()
	TaskDispatcher.cancelTask(arg_3_0.checkActivityTime, arg_3_0)
	TaskDispatcher.runRepeat(arg_3_0.checkActivityTime, arg_3_0, 1)
end

function var_0_0.onUnlocHeroStoryReply(arg_4_0, arg_4_1)
	arg_4_0._unlockingStory[arg_4_1.info.storyId] = true

	arg_4_0:updateStoryInfo(arg_4_1.info)
	RoleStoryListModel.instance:refreshList()
end

function var_0_0.onGetHeroStoryBonusReply(arg_5_0, arg_5_1)
	arg_5_0:updateStoryInfo(arg_5_1.info)
	RoleStoryListModel.instance:refreshList()
end

function var_0_0.onHeroStoryUpdatePush(arg_6_0, arg_6_1)
	local var_6_0 = #arg_6_1.unlockInfos

	for iter_6_0 = 1, var_6_0 do
		arg_6_0:updateStoryInfo(arg_6_1.unlockInfos[iter_6_0])
	end

	RoleStoryListModel.instance:refreshList()
end

function var_0_0.updateStoryInfo(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0:getMoById(arg_7_1.storyId):updateInfo(arg_7_1)
	end
end

function var_0_0.updateStoryTime(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0:getMoById(arg_8_1.storyId):updateTime(arg_8_1)
	end
end

function var_0_0.setCurStoryId(arg_9_0, arg_9_1)
	arg_9_0.curStoryId = arg_9_1
end

function var_0_0.getCurStoryId(arg_10_0)
	return arg_10_0.curStoryId
end

function var_0_0.isNewStory(arg_11_0, arg_11_1)
	if arg_11_0._newDict[arg_11_1] then
		return true
	end

	return false
end

function var_0_0.setStoryNewTag(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0:isNewStory(arg_12_1) == arg_12_2 then
		return
	end

	arg_12_0._newDict[arg_12_1] = arg_12_2

	if not arg_12_2 then
		HeroStoryRpc.instance:sendUpdateHeroStoryStatusRequest(arg_12_1)
	end
end

function var_0_0.initFinishTweenDict(arg_13_0)
	if not arg_13_0.roleStoryFinishDict then
		arg_13_0.roleStoryFinishDict = {}

		local var_13_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RoleStoryFinishKey), "")
		local var_13_1 = string.splitToNumber(var_13_0, "#")

		for iter_13_0, iter_13_1 in ipairs(var_13_1) do
			arg_13_0.roleStoryFinishDict[iter_13_1] = true
		end
	end
end

function var_0_0.isFinishTweenUnplay(arg_14_0, arg_14_1)
	arg_14_0:initFinishTweenDict()

	local var_14_0 = arg_14_0.roleStoryFinishDict[arg_14_1]

	if not var_14_0 then
		arg_14_0:markFinishTween(arg_14_1)
	end

	return not var_14_0
end

function var_0_0.markFinishTween(arg_15_0, arg_15_1)
	arg_15_0:initFinishTweenDict()

	arg_15_0.roleStoryFinishDict[arg_15_1] = true

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_0.roleStoryFinishDict) do
		table.insert(var_15_0, iter_15_0)
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RoleStoryFinishKey), table.concat(var_15_0, "#"))
end

function var_0_0.isUnlockingStory(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._unlockingStory[arg_16_1]

	if var_16_0 then
		arg_16_0._unlockingStory[arg_16_1] = nil
	end

	return var_16_0
end

function var_0_0.onUpdateHeroStoryStatusReply(arg_17_0, arg_17_1)
	return
end

function var_0_0.onExchangeTicketReply(arg_18_0, arg_18_1)
	arg_18_0.lastExchangeTime = Time.time
	arg_18_0._leftNum = arg_18_1.leftNum
	arg_18_0._lastLeftNum = arg_18_0._leftNum
	arg_18_0._todayExchange = arg_18_1.todayExchange
end

function var_0_0.getLeftNum(arg_19_0)
	return arg_19_0._leftNum, arg_19_0._lastLeftNum
end

function var_0_0.setLastLeftNum(arg_20_0, arg_20_1)
	arg_20_0._lastLeftNum = arg_20_1
end

function var_0_0.getMoById(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getById(arg_21_1)

	if not var_21_0 then
		var_21_0 = RoleStoryMO.New()

		var_21_0:init(arg_21_1)
		arg_21_0:addAtLast(var_21_0)
	end

	return var_21_0
end

function var_0_0.getCurActStoryId(arg_22_0)
	return arg_22_0._curActStoryId
end

function var_0_0.checkActStoryOpen(arg_23_0)
	return arg_23_0._curActStoryId and arg_23_0._curActStoryId > 0
end

function var_0_0.isInResident(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return arg_24_0._isResident
	end

	local var_24_0 = arg_24_0:getById(arg_24_1)

	if not var_24_0 then
		return arg_24_0._isResident
	end

	return var_24_0:isResidentTime()
end

function var_0_0.checkActivityTime(arg_25_0)
	local var_25_0 = arg_25_0:getCurActStoryId()
	local var_25_1 = 0
	local var_25_2 = arg_25_0._isResident
	local var_25_3 = false
	local var_25_4 = arg_25_0:getList()

	if var_25_4 then
		for iter_25_0, iter_25_1 in ipairs(var_25_4) do
			if iter_25_1:isActTime() then
				var_25_1 = iter_25_1.id
			end

			if iter_25_1:isResidentTime() then
				var_25_3 = true
			end
		end
	end

	if var_25_1 ~= var_25_0 then
		arg_25_0._curActStoryId = var_25_1

		if var_25_1 == 0 and ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchMainView) then
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
		end

		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ActStoryChange)
	end

	if var_25_3 ~= var_25_2 then
		arg_25_0._isResident = var_25_3

		if not var_25_3 then
			-- block empty
		end

		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ResidentStoryChange)
	end

	local var_25_5 = arg_25_0:getById(arg_25_0._curActStoryId)

	if var_25_5 and var_25_5:hasNewDispatchFinish() then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.RoleStoryDispatch
		})
	end
end

function var_0_0.onGetScoreBonusReply(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getCurActStoryId()
	local var_26_1 = arg_26_0:getById(var_26_0)

	if var_26_1 then
		var_26_1:addScoreBonus(arg_26_1.getScoreBonus)
	end
end

function var_0_0.onHeroStoryScorePush(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getById(arg_27_1.storyId)

	if var_27_0 then
		var_27_0:updateScore(arg_27_1)
	end
end

function var_0_0.checkTodayCanExchange(arg_28_0)
	return CommonConfig.instance:getConstNum(ConstEnum.RoleStoryDayChangeNum) > arg_28_0._todayExchange
end

function var_0_0.getRewardState(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0:getById(arg_29_1)

	if not var_29_0 then
		return 0
	end

	if var_29_0:isBonusHasGet(arg_29_2) then
		return 2
	end

	if arg_29_3 <= var_29_0:getScore() then
		return 1
	end

	return 0
end

function var_0_0.onGetChallengeBonusReply(arg_30_0)
	local var_30_0 = arg_30_0:getCurActStoryId()
	local var_30_1 = arg_30_0:getById(var_30_0)

	if var_30_1 then
		var_30_1.getChallengeReward = true
	end
end

function var_0_0.onHeroStoryTicketPush(arg_31_0, arg_31_1)
	arg_31_0._leftNum = arg_31_1.leftNum
	arg_31_0._todayExchange = arg_31_1.todayExchange
end

function var_0_0.onHeroStoryWeekTaskPush(arg_32_0, arg_32_1)
	arg_32_0._weekProgress = arg_32_1.weekProgress
	arg_32_0._weekHasGet = arg_32_1.weekHasGet
end

function var_0_0.getWeekProgress(arg_33_0)
	return arg_33_0._weekProgress
end

function var_0_0.getWeekHasGet(arg_34_0)
	return arg_34_0._weekHasGet
end

function var_0_0.onHeroStoryWeekTaskGetReply(arg_35_0)
	arg_35_0._weekHasGet = true
end

function var_0_0.onHeroStoryDispatchReply(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getById(arg_36_1.storyId)

	if var_36_0 then
		var_36_0:updateDispatchTime(arg_36_1)
	end
end

function var_0_0.onHeroStoryDispatchResetReply(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getById(arg_37_1.storyId)

	if var_37_0 then
		var_37_0:resetDispatch(arg_37_1)
	end
end

function var_0_0.onHeroStoryDispatchCompleteReply(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getById(arg_38_1.storyId)

	if var_38_0 then
		var_38_0:completeDispatch(arg_38_1)
	end
end

function var_0_0.isShowReplayStoryBtn(arg_39_0)
	local var_39_0 = arg_39_0:getCurStoryId()

	if not var_39_0 or var_39_0 == 0 or var_39_0 == arg_39_0:getCurActStoryId() then
		return false
	end

	local var_39_1 = RoleStoryConfig.instance:getDispatchList(var_39_0, RoleStoryEnum.DispatchType.Story)

	return var_39_1 and #var_39_1 > 0
end

function var_0_0.isHeroDispatching(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:getById(arg_40_2)

	return var_40_0 and var_40_0:isHeroDispatching(arg_40_1)
end

function var_0_0.canPlayDungeonUnlockAnim(arg_41_0, arg_41_1)
	local var_41_0 = string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDungeonUnlockAnim, arg_41_1)

	return PlayerPrefsHelper.getNumber(var_41_0, 0) == 0
end

function var_0_0.setPlayDungeonUnlockAnimFlag(arg_42_0, arg_42_1)
	local var_42_0 = string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDungeonUnlockAnim, arg_42_1)

	PlayerPrefsHelper.setNumber(var_42_0, 1)
end

function var_0_0.isCGUnlock(arg_43_0, arg_43_1)
	local var_43_0 = RoleStoryConfig.instance:getStoryById(arg_43_1)
	local var_43_1 = var_43_0.cgUnlockEpisodeId
	local var_43_2 = var_43_0.cgUnlockStoryId

	if var_43_1 == 0 and var_43_2 == 0 then
		return true
	end

	if var_43_1 ~= 0 then
		return DungeonModel.instance:hasPassLevel(var_43_1)
	end

	return NecrologistStoryModel.instance:getGameMO(arg_43_1):isStoryFinish(var_43_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
