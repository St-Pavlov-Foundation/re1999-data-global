module("modules.logic.room.view.record.RoomTradeTaskView", package.seeall)

local var_0_0 = class("RoomTradeTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnlog = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_log")
	arg_1_0._gologreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_log/#go_logreddot")
	arg_1_0._btnhandbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_handbook")
	arg_1_0._gohandbookreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_handbook/#go_handbookreddot")
	arg_1_0._simageidcard = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/playerInfo/#simage_idcard")
	arg_1_0._txtplayername = gohelper.findChildText(arg_1_0.viewGO, "root/playerInfo/#txt_playername")
	arg_1_0._txtplayerId = gohelper.findChildText(arg_1_0.viewGO, "root/playerInfo/#txt_playerId")
	arg_1_0._simageheroIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/playerInfo/#simage_heroIcon")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "root/playerInfo/#txt_level")
	arg_1_0._txtscale = gohelper.findChildText(arg_1_0.viewGO, "root/playerInfo/#txt_scale")
	arg_1_0._golevelUp = gohelper.findChild(arg_1_0.viewGO, "root/levelup/#go_levelUp")
	arg_1_0._scrolllevel = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/levelup/#go_levelUp/#scroll_level")
	arg_1_0._txtleveluptip = gohelper.findChildText(arg_1_0.viewGO, "root/levelup/#go_levelUp/#txt_levelup_tip")
	arg_1_0._btnlevelup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/levelup/#go_levelUp/#btn_levelup")
	arg_1_0._golevelupreddot = gohelper.findChild(arg_1_0.viewGO, "root/levelup/#go_levelUp/#btn_levelup/#go_levelupreddot")
	arg_1_0._gomax = gohelper.findChild(arg_1_0.viewGO, "root/levelup/#go_max")
	arg_1_0._txttasktitle = gohelper.findChildText(arg_1_0.viewGO, "root/task/title/txt_task_title")
	arg_1_0._btntaskleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/task/title/#btn_taskleft")
	arg_1_0._btntaskright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/task/title/#btn_taskright")
	arg_1_0._scrolltask = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/task/#scroll_task")
	arg_1_0._txtrewardtitle = gohelper.findChildText(arg_1_0.viewGO, "root/reward/#txt_reward_title")
	arg_1_0._btnrewardleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward/#txt_reward_title/#btn_rewardleft")
	arg_1_0._gorewardleftreddot = gohelper.findChild(arg_1_0.viewGO, "root/reward/#txt_reward_title/#btn_rewardleft/#go_leftreddot")
	arg_1_0._btnrewardright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward/#txt_reward_title/#btn_rewardright")
	arg_1_0._gorewardrightreddot = gohelper.findChild(arg_1_0.viewGO, "root/reward/#txt_reward_title/#btn_rewardright/#go_rightreddot")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/reward/#scroll_reward")
	arg_1_0._gotaskrewarditem = gohelper.findChild(arg_1_0.viewGO, "root/reward/#scroll_reward/Viewport/Content/#go_taskrewarditem")
	arg_1_0._btngetclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward/#scroll_reward/#btn_getclick")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "root/reward/progress/#txt_progress")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "root/reward/point/#go_point")
	arg_1_0._btnachievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_achievement")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlog:AddClickListener(arg_2_0._btnlogOnClick, arg_2_0)
	arg_2_0._btnhandbook:AddClickListener(arg_2_0._btnhandbookOnClick, arg_2_0)
	arg_2_0._btnlevelup:AddClickListener(arg_2_0._btnlevelupOnClick, arg_2_0)
	arg_2_0._btntaskleft:AddClickListener(arg_2_0._btntaskleftOnClick, arg_2_0)
	arg_2_0._btntaskright:AddClickListener(arg_2_0._btntaskrightOnClick, arg_2_0)
	arg_2_0._btnrewardleft:AddClickListener(arg_2_0._btnrewardleftOnClick, arg_2_0)
	arg_2_0._btnrewardright:AddClickListener(arg_2_0._btnrewardrightOnClick, arg_2_0)
	arg_2_0._btngetclick:AddClickListener(arg_2_0._btngetclickOnClick, arg_2_0)
	arg_2_0._btnachievement:AddClickListener(arg_2_0._btnachievementOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlog:RemoveClickListener()
	arg_3_0._btnhandbook:RemoveClickListener()
	arg_3_0._btnlevelup:RemoveClickListener()
	arg_3_0._btntaskleft:RemoveClickListener()
	arg_3_0._btntaskright:RemoveClickListener()
	arg_3_0._btnrewardleft:RemoveClickListener()
	arg_3_0._btnrewardright:RemoveClickListener()
	arg_3_0._btngetclick:RemoveClickListener()
	arg_3_0._btnachievement:RemoveClickListener()
end

function var_0_0._btnlogOnClick(arg_4_0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Task2Log,
		view = RoomRecordEnum.View.Log
	})
end

function var_0_0._btnhandbookOnClick(arg_5_0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Task2HandBook,
		view = RoomRecordEnum.View.HandBook
	})
end

function var_0_0._btngetclickOnClick(arg_6_0)
	if not arg_6_0._selectTaskRewardIndex then
		return
	end

	local var_6_0, var_6_1 = RoomTradeTaskModel.instance:isCanLevelBonus(arg_6_0._selectTaskRewardIndex)

	if var_6_1 then
		return
	end

	if not var_6_0 then
		return
	end

	RoomRpc.instance:sendGetTradeSupportBonusRequest(arg_6_0._selectTaskRewardIndex)
end

function var_0_0._btnlevelupOnClick(arg_7_0)
	if RoomTradeTaskModel.instance:isCanLevelUp() then
		RoomRpc.instance:sendTradeLevelUpRequest()
	end
end

var_0_0.SwitchAnimTime = 0.16
var_0_0.SwitchAnimTime2 = 0.367

function var_0_0._btntaskleftOnClick(arg_8_0)
	if arg_8_0._isLongPress then
		return
	end

	arg_8_0:_btntaskleftOnClickCallBack()
end

function var_0_0._btntaskleftOnClickCallBack(arg_9_0)
	if arg_9_0._isPlayingTaskSwitchAnim or arg_9_0._curShowLevel <= 1 then
		return
	end

	arg_9_0._isPlayingTaskSwitchAnim = true

	arg_9_0._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(arg_9_0._cutLastLevelTask, arg_9_0, var_0_0.SwitchAnimTime)
end

function var_0_0._btntaskrightOnClick(arg_10_0)
	if arg_10_0._isLongPress then
		return
	end

	arg_10_0:_btntasRighttOnClickCallBack()
end

function var_0_0._btntasRighttOnClickCallBack(arg_11_0)
	if arg_11_0._isPlayingTaskSwitchAnim or arg_11_0._curShowLevel >= arg_11_0:_getMaxLevel() then
		return
	end

	arg_11_0._isPlayingTaskSwitchAnim = true

	arg_11_0._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(arg_11_0._cutNextLevelTask, arg_11_0, var_0_0.SwitchAnimTime)
end

function var_0_0._btnrewardleftOnClick(arg_12_0)
	if arg_12_0._isPlayingRewardSwitchAnim or arg_12_0._selectTaskRewardIndex <= 1 then
		return
	end

	arg_12_0._isPlayingRewardSwitchAnim = true

	arg_12_0._rewardAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(arg_12_0._cutLastTaskReward, arg_12_0, var_0_0.SwitchAnimTime)
end

function var_0_0._btnrewardrightOnClick(arg_13_0)
	if arg_13_0._isPlayingRewardSwitchAnim or arg_13_0._selectTaskRewardIndex >= arg_13_0._rewardPointPage then
		return
	end

	arg_13_0._isPlayingRewardSwitchAnim = true

	arg_13_0._rewardAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(arg_13_0._cutNextTaskReward, arg_13_0, var_0_0.SwitchAnimTime)
end

function var_0_0._btnachievementOnClick(arg_14_0)
	local var_14_0 = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.RoomCritter)
	local var_14_1 = var_14_0 and var_14_0.achievementJumpId

	if var_14_1 then
		local var_14_2 = tonumber(var_14_1)
		local var_14_3 = JumpConfig.instance:getJumpConfig(var_14_2)

		if var_14_3 then
			local var_14_4 = var_14_3.param
			local var_14_5 = string.split(var_14_4, "#")

			AchievementController.instance:openAchievementGroupPreView(tonumber(var_14_5[3]), var_14_5[4])
		end
	end
end

function var_0_0._ontaskleftLongPress(arg_15_0)
	if arg_15_0._isPlayingTaskSwitchAnim then
		return
	end

	local var_15_0 = arg_15_0:_getNotFinishTaskLevel(true)

	if var_15_0 and var_15_0 == arg_15_0._curShowLevel then
		return
	end

	arg_15_0._isLongPress = true

	arg_15_0._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(arg_15_0._btntaskleftOnClickCallBack, arg_15_0, var_0_0.SwitchAnimTime2)
end

function var_0_0._ontaskrightLongPress(arg_16_0)
	if arg_16_0._isPlayingTaskSwitchAnim then
		return
	end

	local var_16_0 = arg_16_0:_getNotFinishTaskLevel(false)

	if var_16_0 and var_16_0 == arg_16_0._curShowLevel then
		return
	end

	arg_16_0._isLongPress = true

	arg_16_0._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(arg_16_0._btntasRighttOnClickCallBack, arg_16_0, var_0_0.SwitchAnimTime2)
end

function var_0_0._onClicktaskleftDownHandler(arg_17_0)
	arg_17_0._isLongPress = nil
end

function var_0_0._onClicktaskrightDownHandler(arg_18_0)
	arg_18_0._isLongPress = nil
end

function var_0_0._getNotFinishTaskLevel(arg_19_0, arg_19_1)
	if arg_19_1 then
		if arg_19_0._curShowLevel <= 1 or not arg_19_0._curShowLevel then
			return
		end

		for iter_19_0 = arg_19_0._curShowLevel - 1, 2 do
			if RoomTradeTaskListModel.instance:getFinishOrNotTaskIds(iter_19_0, false) then
				return iter_19_0
			end
		end
	else
		if arg_19_0._curShowLevel >= arg_19_0:_getCurLevel() or not arg_19_0._curShowLevel then
			return
		end

		for iter_19_1 = arg_19_0._curShowLevel + 1, arg_19_0:_getCurLevel() do
			if RoomTradeTaskListModel.instance:getFinishOrNotTaskIds(iter_19_1, false) then
				return iter_19_1
			end
		end
	end
end

local var_0_1 = 2
local var_0_2 = 99999

function var_0_0._editableInitView(arg_20_0)
	arg_20_0._goReward = gohelper.findChild(arg_20_0.viewGO, "root/reward")
	arg_20_0._gotask = gohelper.findChild(arg_20_0.viewGO, "root/task")

	gohelper.setActive(arg_20_0._gotaskrewarditem, false)
	gohelper.setActive(arg_20_0._gopoint, false)

	arg_20_0._rewardAnimator = arg_20_0._goReward:GetComponent(typeof(UnityEngine.Animator))
	arg_20_0._taskAnimator = arg_20_0._gotask:GetComponent(typeof(UnityEngine.Animator))
	arg_20_0._btntaskleftlongPrees = SLFramework.UGUI.UILongPressListener.Get(arg_20_0._btntaskleft.gameObject)

	arg_20_0._btntaskleftlongPrees:SetLongPressTime({
		var_0_1,
		var_0_2
	})
	arg_20_0._btntaskleftlongPrees:AddLongPressListener(arg_20_0._ontaskleftLongPress, arg_20_0)

	arg_20_0._tasklefttouch = SLFramework.UGUI.UIClickListener.Get(arg_20_0._btntaskleft.gameObject)

	arg_20_0._tasklefttouch:AddClickDownListener(arg_20_0._onClicktaskleftDownHandler, arg_20_0)

	arg_20_0._btntaskrightlongPrees = SLFramework.UGUI.UILongPressListener.Get(arg_20_0._btntaskright.gameObject)

	arg_20_0._btntaskrightlongPrees:SetLongPressTime({
		var_0_1,
		var_0_2
	})
	arg_20_0._btntaskrightlongPrees:AddLongPressListener(arg_20_0._ontaskrightLongPress, arg_20_0)

	arg_20_0._taskrighttouch = SLFramework.UGUI.UIClickListener.Get(arg_20_0._btntaskright.gameObject)

	arg_20_0._taskrighttouch:AddClickDownListener(arg_20_0._onClicktaskrightDownHandler, arg_20_0)

	arg_20_0._taskContent = arg_20_0._scrolltask.content.gameObject
end

function var_0_0.onUpdateParam(arg_21_0)
	return
end

function var_0_0._addEvents(arg_22_0)
	arg_22_0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskInfo, arg_22_0._onGetTradeTaskInfo, arg_22_0)
	arg_22_0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnReadNewTradeTaskReply, arg_22_0._onReadNewTradeTaskReply, arg_22_0)
	arg_22_0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, arg_22_0._onTradeLevelUpReply, arg_22_0)
	arg_22_0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeSupportBonusReply, arg_22_0._onGetTradeSupportBonusReply, arg_22_0)
end

function var_0_0._removeEvents(arg_23_0)
	arg_23_0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskInfo, arg_23_0._onGetTradeTaskInfo, arg_23_0)
	arg_23_0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnReadNewTradeTaskReply, arg_23_0._onReadNewTradeTaskReply, arg_23_0)
	arg_23_0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, arg_23_0._onTradeLevelUpReply, arg_23_0)
	arg_23_0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeSupportBonusReply, arg_23_0._onGetTradeSupportBonusReply, arg_23_0)

	if arg_23_0._btntaskleftlongPrees then
		arg_23_0._btntaskleftlongPrees:RemoveLongPressListener()

		arg_23_0._btntaskleftlongPrees = nil
	end

	if arg_23_0._btntaskrightlongPrees then
		arg_23_0._btntaskrightlongPrees:RemoveLongPressListener()

		arg_23_0._btntaskrightlongPrees = nil
	end

	if arg_23_0._tasklefttouch then
		arg_23_0._tasklefttouch:RemoveClickDownListener()

		arg_23_0._tasklefttouch = nil
	end

	if arg_23_0._taskrighttouch then
		arg_23_0._taskrighttouch:RemoveClickDownListener()

		arg_23_0._taskrighttouch = nil
	end
end

function var_0_0._onGetTradeTaskInfo(arg_24_0)
	arg_24_0._curShowLevel = nil

	local var_24_0 = arg_24_0:_getCurLevel()

	arg_24_0:_cutLevelTask(var_24_0)
	arg_24_0:onRefresh()
end

function var_0_0._onReadNewTradeTaskReply(arg_25_0)
	arg_25_0:_refreshTaskReward()
end

function var_0_0._onTradeLevelUpReply(arg_26_0, arg_26_1)
	arg_26_0:onRefresh()
	arg_26_0:_cutLevelTask(arg_26_1)
	RoomTradeController.instance:openLevelUpTipView(arg_26_1)
end

function var_0_0._onGetTradeSupportBonusReply(arg_27_0)
	arg_27_0:_refreshSelectTaskReward(arg_27_0._selectTaskRewardIndex)
	arg_27_0:_refreshTaskItemList(arg_27_0._curShowLevel)
end

function var_0_0.onOpen(arg_28_0)
	arg_28_0:_addEvents()

	arg_28_0._rewardPointCount, arg_28_0._rewardPointPage = RoomTradeTaskModel.instance:getTaskPointMaxCount()

	arg_28_0:_onGetTradeTaskInfo()
	arg_28_0:_setPlayerInfo()
	RedDotController.instance:addRedDot(arg_28_0._golevelupreddot, RedDotEnum.DotNode.TradeTaskLevelUp)
	RedDotController.instance:addRedDot(arg_28_0._gorewardleftreddot, RedDotEnum.DotNode.TradeTaskGetBonus)
	RedDotController.instance:addRedDot(arg_28_0._gorewardrightreddot, RedDotEnum.DotNode.TradeTaskGetBonus)
	RedDotController.instance:addRedDot(arg_28_0._gohandbookreddot, RedDotEnum.DotNode.CritterHandBook)
	RedDotController.instance:addRedDot(arg_28_0._gologreddot, RedDotEnum.DotNode.CritterLog)
end

function var_0_0._getCanGetTaskPage(arg_29_0)
	for iter_29_0 = 1, arg_29_0._rewardPointPage do
		local var_29_0, var_29_1 = RoomTradeTaskModel.instance:isCanLevelBonus(iter_29_0)

		if var_29_0 then
			if not var_29_1 then
				return iter_29_0
			end
		else
			return iter_29_0
		end
	end

	return 1
end

function var_0_0._isLeftCanGetBonus(arg_30_0)
	if not arg_30_0._selectTaskRewardIndex or arg_30_0._selectTaskRewardIndex <= 1 then
		return
	end

	for iter_30_0 = 1, arg_30_0._selectTaskRewardIndex - 1 do
		local var_30_0, var_30_1 = RoomTradeTaskModel.instance:isCanLevelBonus(iter_30_0)

		if var_30_0 and not var_30_1 then
			return true
		end
	end

	return false
end

function var_0_0._isRightCanGetBonus(arg_31_0)
	if not arg_31_0._selectTaskRewardIndex or arg_31_0._selectTaskRewardIndex >= arg_31_0._rewardPointPage then
		return
	end

	for iter_31_0 = arg_31_0._selectTaskRewardIndex + 1, arg_31_0._rewardPointPage do
		local var_31_0, var_31_1 = RoomTradeTaskModel.instance:isCanLevelBonus(iter_31_0)

		if var_31_0 and not var_31_1 then
			return true
		end
	end

	return false
end

function var_0_0.onRefresh(arg_32_0)
	arg_32_0:_refreshLevelReward()
	arg_32_0:_refreshLevel()

	if not arg_32_0._selectTaskRewardIndex then
		arg_32_0._selectTaskRewardIndex = arg_32_0:_getCanGetTaskPage()
	end

	arg_32_0:_refreshSelectTaskReward(arg_32_0._selectTaskRewardIndex)
	arg_32_0:_refreshLevelUnlock()
	arg_32_0:_newFinishTask()
end

function var_0_0.onClose(arg_33_0)
	return
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simageheroIcon:UnLoadImage()
	arg_34_0._simageidcard:UnLoadImage()
	arg_34_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_34_0._cutLastLevelTask, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._cutNextLevelTask, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._cutLastTaskReward, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._cutNextTaskReward, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._btntaskleftOnClickCallBack, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._btntasRighttOnClickCallBack, arg_34_0)
end

function var_0_0._setPlayerInfo(arg_35_0)
	local var_35_0 = PlayerModel.instance:getPlayinfo()

	if not arg_35_0._liveHeadIcon then
		arg_35_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_35_0._simageheroIcon)
	end

	arg_35_0._liveHeadIcon:setLiveHead(var_35_0.portrait)

	arg_35_0._txtplayername.text = var_35_0.name
	arg_35_0._txtplayerId.text = "ID:" .. var_35_0.userId
end

function var_0_0._refreshLevel(arg_36_0)
	local var_36_0 = arg_36_0:_getCurLevel()
	local var_36_1 = ManufactureConfig.instance:getTradeLevelCfg(var_36_0)

	arg_36_0._txtlevel.text = var_36_1.dimension
	arg_36_0._txtscale.text = var_36_1.job

	local var_36_2 = ResUrl.getRoomCritterIcon(var_36_1.jobCard)

	arg_36_0._simageidcard:LoadImage(var_36_2)

	local var_36_3 = RoomTradeTaskModel.instance:getOpenSupportLevel()

	gohelper.setActive(arg_36_0._goReward, var_36_3 <= var_36_0)
end

function var_0_0._getCurLevel(arg_37_0)
	return ManufactureModel.instance:getTradeLevel() or 1
end

function var_0_0._cutLastLevelTask(arg_38_0)
	arg_38_0:_cutLevelTask(arg_38_0._curShowLevel - 1)
end

function var_0_0._cutNextLevelTask(arg_39_0)
	arg_39_0:_cutLevelTask(arg_39_0._curShowLevel + 1)
end

function var_0_0._cutLevelTask(arg_40_0, arg_40_1)
	arg_40_0._isPlayingTaskSwitchAnim = false
	arg_40_1 = math.min(RoomTradeTaskModel.instance:getTaskMaxLevel(), arg_40_1)

	if arg_40_0._curShowLevel == arg_40_1 then
		return
	end

	arg_40_0._curShowLevel = arg_40_1

	arg_40_0:_refreshTaskItemList(arg_40_1)

	local var_40_0 = RoomTradeConfig.instance:getLevelCo(arg_40_1)

	arg_40_0._txttasktitle.text = var_40_0.taskName

	gohelper.setActive(arg_40_0._btntaskleft.gameObject, arg_40_1 > 1)
	gohelper.setActive(arg_40_0._btntaskright.gameObject, arg_40_1 < arg_40_0:_getMaxLevel())
end

function var_0_0._getMaxLevel(arg_41_0)
	return math.min(arg_41_0:_getCurLevel(), RoomTradeTaskModel.instance:getTaskMaxLevel())
end

function var_0_0._refreshTaskItemList(arg_42_0, arg_42_1)
	local var_42_0 = RoomTradeTaskListModel.instance:setMoList(arg_42_1)

	if not arg_42_0._taskItems then
		arg_42_0._taskItems = arg_42_0:getUserDataTb_()
	end

	local var_42_1 = 0

	if var_42_0 then
		for iter_42_0, iter_42_1 in ipairs(var_42_0) do
			local var_42_2 = arg_42_0:_getTaskItem(iter_42_0)

			var_42_2:onUpdateMO(iter_42_1)

			var_42_1 = var_42_2:getNextItemAnchorY(var_42_1)
		end

		for iter_42_2, iter_42_3 in ipairs(arg_42_0._taskItems) do
			iter_42_3:activeGo(iter_42_2 <= #var_42_0)
		end
	end

	recthelper.setHeight(arg_42_0._taskContent.transform, math.abs(var_42_1))
end

function var_0_0._getTaskItem(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0._taskItems[arg_43_1]

	if not var_43_0 then
		local var_43_1 = arg_43_0.viewContainer:getSetting().otherRes[1]
		local var_43_2 = arg_43_0:getResInst(var_43_1, arg_43_0._taskContent, "task_item" .. tostring(arg_43_1))

		var_43_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_43_2, RoomTradeTaskItem)
		arg_43_0._taskItems[arg_43_1] = var_43_0
	end

	return var_43_0
end

function var_0_0._refreshLevelReward(arg_44_0)
	local var_44_0 = arg_44_0:_getCurLevel()
	local var_44_1 = RoomTradeConfig.instance:getLevelCo(var_44_0)
	local var_44_2, var_44_3 = RoomTradeTaskModel.instance:getLevelTaskCount(var_44_0)
	local var_44_4 = var_44_1.taskName
	local var_44_5 = var_44_3 <= var_44_2 and "#000000" or "#b6341a"
	local var_44_6 = luaLang("room_finish_tradetask")
	local var_44_7 = {
		var_44_4,
		var_44_5,
		var_44_2,
		var_44_3
	}

	arg_44_0._txtleveluptip.text = GameUtil.getSubPlaceholderLuaLang(var_44_6, var_44_7)
end

function var_0_0._refreshLevelUnlock(arg_45_0)
	local var_45_0, var_45_1, var_45_2 = RoomTradeTaskModel.instance:isCanLevelUp()

	gohelper.setActive(arg_45_0._golevelUp, not var_45_2)
	gohelper.setActive(arg_45_0._gomax, var_45_2)

	if var_45_2 then
		return
	end

	ZProj.UGUIHelper.SetGrayscale(arg_45_0._btnlevelup.gameObject, not var_45_0)

	local var_45_3 = RoomTradeTaskModel.instance:getLevelUnlock(var_45_1 + 1)

	if not arg_45_0._refreshLevelUnlockItem then
		arg_45_0._refreshLevelUnlockItem = arg_45_0:getUserDataTb_()
	end

	if var_45_3 then
		for iter_45_0, iter_45_1 in ipairs(var_45_3) do
			local var_45_4 = arg_45_0:_getLevelUnlockItem(iter_45_0)

			var_45_4:onRefreshMo(iter_45_1)
			gohelper.setActive(var_45_4.viewGO, true)
		end

		if arg_45_0._refreshLevelUnlockItem then
			for iter_45_2 = 1, #arg_45_0._refreshLevelUnlockItem do
				gohelper.setActive(arg_45_0._refreshLevelUnlockItem[iter_45_2].viewGO, iter_45_2 <= #var_45_3)
			end
		end
	end
end

function var_0_0._getLevelUnlockItem(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0._refreshLevelUnlockItem[arg_46_1]

	if not var_46_0 then
		local var_46_1 = arg_46_0._scrolllevel.content.gameObject
		local var_46_2 = arg_46_0.viewContainer:getSetting().otherRes[2]
		local var_46_3 = arg_46_0:getResInst(var_46_2, var_46_1)

		var_46_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_46_3, RoomTradeLevelUnlockItem)
		arg_46_0._refreshLevelUnlockItem[arg_46_1] = var_46_0
	end

	return var_46_0
end

function var_0_0._refreshTaskReward(arg_47_0)
	local var_47_0 = RoomTradeTaskModel.instance:getTaskFinishPointCount()
	local var_47_1 = luaLang("room_trade_reward_progress")
	local var_47_2 = "#000000"
	local var_47_3 = RoomTradeConfig.instance:getSupportBonusById(arg_47_0._selectTaskRewardIndex).needTask
	local var_47_4 = GameUtil.getSubPlaceholderLuaLangThreeParam(var_47_1, var_47_2, var_47_0, var_47_3)

	arg_47_0._txtprogress.text = var_47_4

	if arg_47_0._rewardPointItem then
		for iter_47_0, iter_47_1 in ipairs(arg_47_0._rewardPointItem) do
			gohelper.setActive(iter_47_1.go, iter_47_0 <= arg_47_0._rewardPointPage)
		end
	end
end

function var_0_0._cutLastTaskReward(arg_48_0)
	arg_48_0:_refreshSelectTaskReward(arg_48_0._selectTaskRewardIndex - 1)
end

function var_0_0._cutNextTaskReward(arg_49_0)
	arg_49_0:_refreshSelectTaskReward(arg_49_0._selectTaskRewardIndex + 1)
end

function var_0_0._refreshSelectTaskReward(arg_50_0, arg_50_1)
	arg_50_0._isPlayingRewardSwitchAnim = false

	if not arg_50_0._taskRewards then
		arg_50_0._taskRewards = RoomTradeTaskModel.instance:getAllTaskRewards()
	end

	if not arg_50_0._taskRewardItemList then
		arg_50_0._taskRewardItemList = arg_50_0:getUserDataTb_()
	end

	arg_50_0._selectTaskRewardIndex = arg_50_1

	arg_50_0:_refreshTaskReward()

	local var_50_0 = arg_50_0._taskRewards[arg_50_1]
	local var_50_1, var_50_2 = RoomTradeTaskModel.instance:isCanLevelBonus(arg_50_1)

	var_50_1 = not var_50_2 and var_50_1

	gohelper.setActive(arg_50_0._btngetclick.gameObject, var_50_1)

	for iter_50_0, iter_50_1 in ipairs(var_50_0) do
		local var_50_3 = iter_50_1[1]
		local var_50_4 = iter_50_1[2]
		local var_50_5 = iter_50_1[3]
		local var_50_6, var_50_7 = arg_50_0:_getRewardItem(iter_50_0)

		if var_50_6 then
			local var_50_8 = var_50_6.item

			if var_50_8 then
				var_50_8:setMOValue(var_50_3, var_50_4, var_50_5, nil, true)

				if var_50_7 then
					var_50_8:setCountFontSize(40)
					var_50_8:showStackableNum2()
					var_50_8:isShowEffect(true)
				end
			end

			gohelper.setActive(var_50_6.goGot, var_50_2)
			gohelper.setActive(var_50_6.goCanGet, var_50_1)
		end
	end

	for iter_50_2 = 1, #arg_50_0._taskRewardItemList do
		gohelper.setActive(arg_50_0._taskRewardItemList[iter_50_2].go, iter_50_2 <= #var_50_0)
	end

	if not arg_50_0._leftDark then
		arg_50_0._leftDark = gohelper.findChild(arg_50_0._btnrewardleft.gameObject, "dark")
	end

	if not arg_50_0._rightDark then
		arg_50_0._rightDark = gohelper.findChild(arg_50_0._btnrewardright.gameObject, "dark")
	end

	gohelper.setActive(arg_50_0._leftDark, arg_50_1 <= 1)
	gohelper.setActive(arg_50_0._rightDark, arg_50_1 >= arg_50_0._rewardPointPage)

	for iter_50_3 = 1, arg_50_0._rewardPointPage do
		local var_50_9 = arg_50_0:_getRewardPointItem(iter_50_3)

		gohelper.setActive(var_50_9.normal, iter_50_3 ~= arg_50_1)
		gohelper.setActive(var_50_9.select, iter_50_3 == arg_50_1)
	end

	for iter_50_4 = 1, #arg_50_0._rewardPointItem do
		gohelper.setActive(arg_50_0._rewardPointItem[iter_50_4].go, iter_50_4 <= arg_50_0._rewardPointPage)
	end

	gohelper.setActive(arg_50_0._gorewardleftreddot, arg_50_0:_isLeftCanGetBonus())
	gohelper.setActive(arg_50_0._gorewardrightreddot, arg_50_0:_isRightCanGetBonus())
end

function var_0_0._getRewardItem(arg_51_0, arg_51_1)
	if not arg_51_0._taskRewardItemList then
		arg_51_0._taskRewardItemList = arg_51_0:getUserDataTb_()
	end

	local var_51_0 = arg_51_0._taskRewardItemList[arg_51_1]

	if not var_51_0 then
		local var_51_1 = gohelper.cloneInPlace(arg_51_0._gotaskrewarditem)
		local var_51_2 = gohelper.findChild(var_51_1, "item")
		local var_51_3 = IconMgr.instance:getCommonPropItemIcon(var_51_2)

		var_51_0 = {
			item = var_51_3,
			go = var_51_1,
			goGot = gohelper.findChild(var_51_1, "#goHasGet"),
			goCanGet = gohelper.findChild(var_51_1, "#goCanGet")
		}

		transformhelper.setLocalScale(var_51_3.go.transform, 0.62, 0.62, 1)

		arg_51_0._taskRewardItemList[arg_51_1] = var_51_0

		return var_51_0, true
	end

	return var_51_0, false
end

function var_0_0._getRewardPointItem(arg_52_0, arg_52_1)
	if not arg_52_0._rewardPointItem then
		arg_52_0._rewardPointItem = arg_52_0:getUserDataTb_()
	end

	local var_52_0 = arg_52_0._rewardPointItem[arg_52_1]

	if not var_52_0 then
		local var_52_1 = gohelper.cloneInPlace(arg_52_0._gopoint, "point_" .. arg_52_1)
		local var_52_2 = gohelper.findChild(var_52_1, "normal")
		local var_52_3 = gohelper.findChild(var_52_1, "select")

		var_52_0 = {
			go = var_52_1,
			normal = var_52_2,
			select = var_52_3
		}
		arg_52_0._rewardPointItem[arg_52_1] = var_52_0
	end

	return var_52_0
end

function var_0_0._newFinishTask(arg_53_0)
	local var_53_0 = RoomTradeTaskListModel.instance:getNewFinishTaskIds(arg_53_0._curShowLevel)

	if LuaUtil.tableNotEmpty(var_53_0) then
		RoomRpc.instance:sendReadNewTradeTaskRequest(var_53_0)
	end
end

return var_0_0
