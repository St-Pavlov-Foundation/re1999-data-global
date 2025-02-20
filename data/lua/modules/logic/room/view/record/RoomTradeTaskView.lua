module("modules.logic.room.view.record.RoomTradeTaskView", package.seeall)

slot0 = class("RoomTradeTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnlog = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_log")
	slot0._gologreddot = gohelper.findChild(slot0.viewGO, "root/#btn_log/#go_logreddot")
	slot0._btnhandbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_handbook")
	slot0._gohandbookreddot = gohelper.findChild(slot0.viewGO, "root/#btn_handbook/#go_handbookreddot")
	slot0._simageidcard = gohelper.findChildSingleImage(slot0.viewGO, "root/playerInfo/#simage_idcard")
	slot0._txtplayername = gohelper.findChildText(slot0.viewGO, "root/playerInfo/#txt_playername")
	slot0._txtplayerId = gohelper.findChildText(slot0.viewGO, "root/playerInfo/#txt_playerId")
	slot0._simageheroIcon = gohelper.findChildSingleImage(slot0.viewGO, "root/playerInfo/#simage_heroIcon")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "root/playerInfo/#txt_level")
	slot0._txtscale = gohelper.findChildText(slot0.viewGO, "root/playerInfo/#txt_scale")
	slot0._golevelUp = gohelper.findChild(slot0.viewGO, "root/levelup/#go_levelUp")
	slot0._scrolllevel = gohelper.findChildScrollRect(slot0.viewGO, "root/levelup/#go_levelUp/#scroll_level")
	slot0._txtleveluptip = gohelper.findChildText(slot0.viewGO, "root/levelup/#go_levelUp/#txt_levelup_tip")
	slot0._btnlevelup = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/levelup/#go_levelUp/#btn_levelup")
	slot0._golevelupreddot = gohelper.findChild(slot0.viewGO, "root/levelup/#go_levelUp/#btn_levelup/#go_levelupreddot")
	slot0._gomax = gohelper.findChild(slot0.viewGO, "root/levelup/#go_max")
	slot0._txttasktitle = gohelper.findChildText(slot0.viewGO, "root/task/title/txt_task_title")
	slot0._btntaskleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/task/title/#btn_taskleft")
	slot0._btntaskright = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/task/title/#btn_taskright")
	slot0._scrolltask = gohelper.findChildScrollRect(slot0.viewGO, "root/task/#scroll_task")
	slot0._txtrewardtitle = gohelper.findChildText(slot0.viewGO, "root/reward/#txt_reward_title")
	slot0._btnrewardleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward/#txt_reward_title/#btn_rewardleft")
	slot0._gorewardleftreddot = gohelper.findChild(slot0.viewGO, "root/reward/#txt_reward_title/#btn_rewardleft/#go_leftreddot")
	slot0._btnrewardright = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward/#txt_reward_title/#btn_rewardright")
	slot0._gorewardrightreddot = gohelper.findChild(slot0.viewGO, "root/reward/#txt_reward_title/#btn_rewardright/#go_rightreddot")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "root/reward/#scroll_reward")
	slot0._gotaskrewarditem = gohelper.findChild(slot0.viewGO, "root/reward/#scroll_reward/Viewport/Content/#go_taskrewarditem")
	slot0._btngetclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward/#scroll_reward/#btn_getclick")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "root/reward/progress/#txt_progress")
	slot0._gopoint = gohelper.findChild(slot0.viewGO, "root/reward/point/#go_point")
	slot0._btnachievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_achievement")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlog:AddClickListener(slot0._btnlogOnClick, slot0)
	slot0._btnhandbook:AddClickListener(slot0._btnhandbookOnClick, slot0)
	slot0._btnlevelup:AddClickListener(slot0._btnlevelupOnClick, slot0)
	slot0._btntaskleft:AddClickListener(slot0._btntaskleftOnClick, slot0)
	slot0._btntaskright:AddClickListener(slot0._btntaskrightOnClick, slot0)
	slot0._btnrewardleft:AddClickListener(slot0._btnrewardleftOnClick, slot0)
	slot0._btnrewardright:AddClickListener(slot0._btnrewardrightOnClick, slot0)
	slot0._btngetclick:AddClickListener(slot0._btngetclickOnClick, slot0)
	slot0._btnachievement:AddClickListener(slot0._btnachievementOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlog:RemoveClickListener()
	slot0._btnhandbook:RemoveClickListener()
	slot0._btnlevelup:RemoveClickListener()
	slot0._btntaskleft:RemoveClickListener()
	slot0._btntaskright:RemoveClickListener()
	slot0._btnrewardleft:RemoveClickListener()
	slot0._btnrewardright:RemoveClickListener()
	slot0._btngetclick:RemoveClickListener()
	slot0._btnachievement:RemoveClickListener()
end

function slot0._btnlogOnClick(slot0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Task2Log,
		view = RoomRecordEnum.View.Log
	})
end

function slot0._btnhandbookOnClick(slot0)
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Task2HandBook,
		view = RoomRecordEnum.View.HandBook
	})
end

function slot0._btngetclickOnClick(slot0)
	if not slot0._selectTaskRewardIndex then
		return
	end

	slot1, slot2 = RoomTradeTaskModel.instance:isCanLevelBonus(slot0._selectTaskRewardIndex)

	if slot2 then
		return
	end

	if not slot1 then
		return
	end

	RoomRpc.instance:sendGetTradeSupportBonusRequest(slot0._selectTaskRewardIndex)
end

function slot0._btnlevelupOnClick(slot0)
	if RoomTradeTaskModel.instance:isCanLevelUp() then
		RoomRpc.instance:sendTradeLevelUpRequest()
	end
end

slot0.SwitchAnimTime = 0.16
slot0.SwitchAnimTime2 = 0.367

function slot0._btntaskleftOnClick(slot0)
	if slot0._isLongPress then
		return
	end

	slot0:_btntaskleftOnClickCallBack()
end

function slot0._btntaskleftOnClickCallBack(slot0)
	if slot0._isPlayingTaskSwitchAnim or slot0._curShowLevel <= 1 then
		return
	end

	slot0._isPlayingTaskSwitchAnim = true

	slot0._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(slot0._cutLastLevelTask, slot0, uv0.SwitchAnimTime)
end

function slot0._btntaskrightOnClick(slot0)
	if slot0._isLongPress then
		return
	end

	slot0:_btntasRighttOnClickCallBack()
end

function slot0._btntasRighttOnClickCallBack(slot0)
	if slot0._isPlayingTaskSwitchAnim or slot0:_getMaxLevel() <= slot0._curShowLevel then
		return
	end

	slot0._isPlayingTaskSwitchAnim = true

	slot0._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(slot0._cutNextLevelTask, slot0, uv0.SwitchAnimTime)
end

function slot0._btnrewardleftOnClick(slot0)
	if slot0._isPlayingRewardSwitchAnim or slot0._selectTaskRewardIndex <= 1 then
		return
	end

	slot0._isPlayingRewardSwitchAnim = true

	slot0._rewardAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(slot0._cutLastTaskReward, slot0, uv0.SwitchAnimTime)
end

function slot0._btnrewardrightOnClick(slot0)
	if slot0._isPlayingRewardSwitchAnim or slot0._rewardPointPage <= slot0._selectTaskRewardIndex then
		return
	end

	slot0._isPlayingRewardSwitchAnim = true

	slot0._rewardAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(slot0._cutNextTaskReward, slot0, uv0.SwitchAnimTime)
end

function slot0._btnachievementOnClick(slot0)
	if ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.RoomCritter) and slot1.achievementJumpId and JumpConfig.instance:getJumpConfig(tonumber(slot2)) then
		slot5 = string.split(slot3.param, "#")

		AchievementController.instance:openAchievementGroupPreView(tonumber(slot5[3]), slot5[4])
	end
end

function slot0._ontaskleftLongPress(slot0)
	if slot0._isPlayingTaskSwitchAnim then
		return
	end

	if slot0:_getNotFinishTaskLevel(true) and slot1 == slot0._curShowLevel then
		return
	end

	slot0._isLongPress = true

	slot0._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(slot0._btntaskleftOnClickCallBack, slot0, uv0.SwitchAnimTime2)
end

function slot0._ontaskrightLongPress(slot0)
	if slot0._isPlayingTaskSwitchAnim then
		return
	end

	if slot0:_getNotFinishTaskLevel(false) and slot1 == slot0._curShowLevel then
		return
	end

	slot0._isLongPress = true

	slot0._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(slot0._btntasRighttOnClickCallBack, slot0, uv0.SwitchAnimTime2)
end

function slot0._onClicktaskleftDownHandler(slot0)
	slot0._isLongPress = nil
end

function slot0._onClicktaskrightDownHandler(slot0)
	slot0._isLongPress = nil
end

function slot0._getNotFinishTaskLevel(slot0, slot1)
	if slot1 then
		if slot0._curShowLevel <= 1 or not slot0._curShowLevel then
			return
		end

		for slot5 = slot0._curShowLevel - 1, 2 do
			if RoomTradeTaskListModel.instance:getFinishOrNotTaskIds(slot5, false) then
				return slot5
			end
		end
	else
		if slot0:_getCurLevel() <= slot0._curShowLevel or not slot0._curShowLevel then
			return
		end

		slot5 = slot0

		for slot5 = slot0._curShowLevel + 1, slot0._getCurLevel(slot5) do
			if RoomTradeTaskListModel.instance:getFinishOrNotTaskIds(slot5, false) then
				return slot5
			end
		end
	end
end

slot1 = 2
slot2 = 99999

function slot0._editableInitView(slot0)
	slot0._goReward = gohelper.findChild(slot0.viewGO, "root/reward")
	slot0._gotask = gohelper.findChild(slot0.viewGO, "root/task")

	gohelper.setActive(slot0._gotaskrewarditem, false)
	gohelper.setActive(slot0._gopoint, false)

	slot0._rewardAnimator = slot0._goReward:GetComponent(typeof(UnityEngine.Animator))
	slot0._taskAnimator = slot0._gotask:GetComponent(typeof(UnityEngine.Animator))
	slot0._btntaskleftlongPrees = SLFramework.UGUI.UILongPressListener.Get(slot0._btntaskleft.gameObject)

	slot0._btntaskleftlongPrees:SetLongPressTime({
		uv0,
		uv1
	})
	slot0._btntaskleftlongPrees:AddLongPressListener(slot0._ontaskleftLongPress, slot0)

	slot0._tasklefttouch = SLFramework.UGUI.UIClickListener.Get(slot0._btntaskleft.gameObject)

	slot0._tasklefttouch:AddClickDownListener(slot0._onClicktaskleftDownHandler, slot0)

	slot0._btntaskrightlongPrees = SLFramework.UGUI.UILongPressListener.Get(slot0._btntaskright.gameObject)

	slot0._btntaskrightlongPrees:SetLongPressTime({
		uv0,
		uv1
	})
	slot0._btntaskrightlongPrees:AddLongPressListener(slot0._ontaskrightLongPress, slot0)

	slot0._taskrighttouch = SLFramework.UGUI.UIClickListener.Get(slot0._btntaskright.gameObject)

	slot0._taskrighttouch:AddClickDownListener(slot0._onClicktaskrightDownHandler, slot0)

	slot0._taskContent = slot0._scrolltask.content.gameObject
end

function slot0.onUpdateParam(slot0)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskInfo, slot0._onGetTradeTaskInfo, slot0)
	slot0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnReadNewTradeTaskReply, slot0._onReadNewTradeTaskReply, slot0)
	slot0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, slot0._onTradeLevelUpReply, slot0)
	slot0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeSupportBonusReply, slot0._onGetTradeSupportBonusReply, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskInfo, slot0._onGetTradeTaskInfo, slot0)
	slot0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnReadNewTradeTaskReply, slot0._onReadNewTradeTaskReply, slot0)
	slot0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, slot0._onTradeLevelUpReply, slot0)
	slot0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnGetTradeSupportBonusReply, slot0._onGetTradeSupportBonusReply, slot0)

	if slot0._btntaskleftlongPrees then
		slot0._btntaskleftlongPrees:RemoveLongPressListener()

		slot0._btntaskleftlongPrees = nil
	end

	if slot0._btntaskrightlongPrees then
		slot0._btntaskrightlongPrees:RemoveLongPressListener()

		slot0._btntaskrightlongPrees = nil
	end

	if slot0._tasklefttouch then
		slot0._tasklefttouch:RemoveClickDownListener()

		slot0._tasklefttouch = nil
	end

	if slot0._taskrighttouch then
		slot0._taskrighttouch:RemoveClickDownListener()

		slot0._taskrighttouch = nil
	end
end

function slot0._onGetTradeTaskInfo(slot0)
	slot0._curShowLevel = nil

	slot0:_cutLevelTask(slot0:_getCurLevel())
	slot0:onRefresh()
end

function slot0._onReadNewTradeTaskReply(slot0)
	slot0:_refreshTaskReward()
end

function slot0._onTradeLevelUpReply(slot0, slot1)
	slot0:onRefresh()
	slot0:_cutLevelTask(slot1)
	RoomTradeController.instance:openLevelUpTipView(slot1)
end

function slot0._onGetTradeSupportBonusReply(slot0)
	slot0:_refreshSelectTaskReward(slot0._selectTaskRewardIndex)
	slot0:_refreshTaskItemList(slot0._curShowLevel)
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0._rewardPointCount, slot0._rewardPointPage = RoomTradeTaskModel.instance:getTaskPointMaxCount()

	slot0:_onGetTradeTaskInfo()
	slot0:_setPlayerInfo()
	RedDotController.instance:addRedDot(slot0._golevelupreddot, RedDotEnum.DotNode.TradeTaskLevelUp)
	RedDotController.instance:addRedDot(slot0._gorewardleftreddot, RedDotEnum.DotNode.TradeTaskGetBonus)
	RedDotController.instance:addRedDot(slot0._gorewardrightreddot, RedDotEnum.DotNode.TradeTaskGetBonus)
	RedDotController.instance:addRedDot(slot0._gohandbookreddot, RedDotEnum.DotNode.CritterHandBook)
	RedDotController.instance:addRedDot(slot0._gologreddot, RedDotEnum.DotNode.CritterLog)
end

function slot0._getCanGetTaskPage(slot0)
	for slot4 = 1, slot0._rewardPointPage do
		slot5, slot6 = RoomTradeTaskModel.instance:isCanLevelBonus(slot4)

		if slot5 then
			if not slot6 then
				return slot4
			end
		else
			return slot4
		end
	end

	return 1
end

function slot0._isLeftCanGetBonus(slot0)
	if not slot0._selectTaskRewardIndex or slot0._selectTaskRewardIndex <= 1 then
		return
	end

	for slot4 = 1, slot0._selectTaskRewardIndex - 1 do
		slot5, slot6 = RoomTradeTaskModel.instance:isCanLevelBonus(slot4)

		if slot5 and not slot6 then
			return true
		end
	end

	return false
end

function slot0._isRightCanGetBonus(slot0)
	if not slot0._selectTaskRewardIndex or slot0._rewardPointPage <= slot0._selectTaskRewardIndex then
		return
	end

	for slot4 = slot0._selectTaskRewardIndex + 1, slot0._rewardPointPage do
		slot5, slot6 = RoomTradeTaskModel.instance:isCanLevelBonus(slot4)

		if slot5 and not slot6 then
			return true
		end
	end

	return false
end

function slot0.onRefresh(slot0)
	slot0:_refreshLevelReward()
	slot0:_refreshLevel()

	if not slot0._selectTaskRewardIndex then
		slot0._selectTaskRewardIndex = slot0:_getCanGetTaskPage()
	end

	slot0:_refreshSelectTaskReward(slot0._selectTaskRewardIndex)
	slot0:_refreshLevelUnlock()
	slot0:_newFinishTask()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageheroIcon:UnLoadImage()
	slot0._simageidcard:UnLoadImage()
	slot0:_removeEvents()
	TaskDispatcher.cancelTask(slot0._cutLastLevelTask, slot0)
	TaskDispatcher.cancelTask(slot0._cutNextLevelTask, slot0)
	TaskDispatcher.cancelTask(slot0._cutLastTaskReward, slot0)
	TaskDispatcher.cancelTask(slot0._cutNextTaskReward, slot0)
	TaskDispatcher.cancelTask(slot0._btntaskleftOnClickCallBack, slot0)
	TaskDispatcher.cancelTask(slot0._btntasRighttOnClickCallBack, slot0)
end

function slot0._setPlayerInfo(slot0)
	slot1 = PlayerModel.instance:getPlayinfo()

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageheroIcon)
	end

	slot0._liveHeadIcon:setLiveHead(slot1.portrait)

	slot0._txtplayername.text = slot1.name
	slot0._txtplayerId.text = "ID:" .. slot1.userId
end

function slot0._refreshLevel(slot0)
	slot1 = slot0:_getCurLevel()
	slot2 = ManufactureConfig.instance:getTradeLevelCfg(slot1)
	slot0._txtlevel.text = slot2.dimension
	slot0._txtscale.text = slot2.job

	slot0._simageidcard:LoadImage(ResUrl.getRoomCritterIcon(slot2.jobCard))
	gohelper.setActive(slot0._goReward, RoomTradeTaskModel.instance:getOpenSupportLevel() <= slot1)
end

function slot0._getCurLevel(slot0)
	return ManufactureModel.instance:getTradeLevel() or 1
end

function slot0._cutLastLevelTask(slot0)
	slot0:_cutLevelTask(slot0._curShowLevel - 1)
end

function slot0._cutNextLevelTask(slot0)
	slot0:_cutLevelTask(slot0._curShowLevel + 1)
end

function slot0._cutLevelTask(slot0, slot1)
	slot0._isPlayingTaskSwitchAnim = false

	if slot0._curShowLevel == math.min(RoomTradeTaskModel.instance:getTaskMaxLevel(), slot1) then
		return
	end

	slot0._curShowLevel = slot1

	slot0:_refreshTaskItemList(slot1)

	slot0._txttasktitle.text = RoomTradeConfig.instance:getLevelCo(slot1).taskName

	gohelper.setActive(slot0._btntaskleft.gameObject, slot1 > 1)
	gohelper.setActive(slot0._btntaskright.gameObject, slot1 < slot0:_getMaxLevel())
end

function slot0._getMaxLevel(slot0)
	return math.min(slot0:_getCurLevel(), RoomTradeTaskModel.instance:getTaskMaxLevel())
end

function slot0._refreshTaskItemList(slot0, slot1)
	slot2 = RoomTradeTaskListModel.instance:setMoList(slot1)

	if not slot0._taskItems then
		slot0._taskItems = slot0:getUserDataTb_()
	end

	slot3 = 0

	if slot2 then
		for slot7, slot8 in ipairs(slot2) do
			slot9 = slot0:_getTaskItem(slot7)

			slot9:onUpdateMO(slot8)

			slot3 = slot9:getNextItemAnchorY(slot3)
		end

		for slot7, slot8 in ipairs(slot0._taskItems) do
			slot8:activeGo(slot7 <= #slot2)
		end
	end

	recthelper.setHeight(slot0._taskContent.transform, math.abs(slot3))
end

function slot0._getTaskItem(slot0, slot1)
	if not slot0._taskItems[slot1] then
		slot0._taskItems[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._taskContent, "task_item" .. tostring(slot1)), RoomTradeTaskItem)
	end

	return slot2
end

function slot0._refreshLevelReward(slot0)
	slot1 = slot0:_getCurLevel()
	slot3, slot4 = RoomTradeTaskModel.instance:getLevelTaskCount(slot1)
	slot0._txtleveluptip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("room_finish_tradetask"), {
		RoomTradeConfig.instance:getLevelCo(slot1).taskName,
		slot4 <= slot3 and "#000000" or "#b6341a",
		slot3,
		slot4
	})
end

function slot0._refreshLevelUnlock(slot0)
	slot1, slot2, slot3 = RoomTradeTaskModel.instance:isCanLevelUp()

	gohelper.setActive(slot0._golevelUp, not slot3)
	gohelper.setActive(slot0._gomax, slot3)

	if slot3 then
		return
	end

	ZProj.UGUIHelper.SetGrayscale(slot0._btnlevelup.gameObject, not slot1)

	slot4 = RoomTradeTaskModel.instance:getLevelUnlock(slot2 + 1)

	if not slot0._refreshLevelUnlockItem then
		slot0._refreshLevelUnlockItem = slot0:getUserDataTb_()
	end

	if slot4 then
		for slot8, slot9 in ipairs(slot4) do
			slot10 = slot0:_getLevelUnlockItem(slot8)

			slot10:onRefreshMo(slot9)
			gohelper.setActive(slot10.viewGO, true)
		end

		if slot0._refreshLevelUnlockItem then
			for slot8 = 1, #slot0._refreshLevelUnlockItem do
				gohelper.setActive(slot0._refreshLevelUnlockItem[slot8].viewGO, slot8 <= #slot4)
			end
		end
	end
end

function slot0._getLevelUnlockItem(slot0, slot1)
	if not slot0._refreshLevelUnlockItem[slot1] then
		slot0._refreshLevelUnlockItem[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._scrolllevel.content.gameObject), RoomTradeLevelUnlockItem)
	end

	return slot2
end

function slot0._refreshTaskReward(slot0)
	slot0._txtprogress.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("room_trade_reward_progress"), "#000000", RoomTradeTaskModel.instance:getTaskFinishPointCount(), RoomTradeConfig.instance:getSupportBonusById(slot0._selectTaskRewardIndex).needTask)

	if slot0._rewardPointItem then
		for slot10, slot11 in ipairs(slot0._rewardPointItem) do
			gohelper.setActive(slot11.go, slot10 <= slot0._rewardPointPage)
		end
	end
end

function slot0._cutLastTaskReward(slot0)
	slot0:_refreshSelectTaskReward(slot0._selectTaskRewardIndex - 1)
end

function slot0._cutNextTaskReward(slot0)
	slot0:_refreshSelectTaskReward(slot0._selectTaskRewardIndex + 1)
end

function slot0._refreshSelectTaskReward(slot0, slot1)
	slot0._isPlayingRewardSwitchAnim = false

	if not slot0._taskRewards then
		slot0._taskRewards = RoomTradeTaskModel.instance:getAllTaskRewards()
	end

	if not slot0._taskRewardItemList then
		slot0._taskRewardItemList = slot0:getUserDataTb_()
	end

	slot0._selectTaskRewardIndex = slot1

	slot0:_refreshTaskReward()

	slot3, slot4 = RoomTradeTaskModel.instance:isCanLevelBonus(slot1)

	gohelper.setActive(slot0._btngetclick.gameObject, not slot4 and slot3)

	for slot8, slot9 in ipairs(slot0._taskRewards[slot1]) do
		slot13, slot14 = slot0:_getRewardItem(slot8)

		if slot13 then
			if slot13.item then
				slot15:setMOValue(slot9[1], slot9[2], slot9[3], nil, true)

				if slot14 then
					slot15:setCountFontSize(40)
					slot15:showStackableNum2()
					slot15:isShowEffect(true)
				end
			end

			gohelper.setActive(slot13.goGot, slot4)
			gohelper.setActive(slot13.goCanGet, slot3)
		end
	end

	for slot8 = 1, #slot0._taskRewardItemList do
		gohelper.setActive(slot0._taskRewardItemList[slot8].go, slot8 <= #slot2)
	end

	if not slot0._leftDark then
		slot0._leftDark = gohelper.findChild(slot0._btnrewardleft.gameObject, "dark")
	end

	if not slot0._rightDark then
		slot0._rightDark = gohelper.findChild(slot0._btnrewardright.gameObject, "dark")
	end

	gohelper.setActive(slot0._leftDark, slot1 <= 1)
	gohelper.setActive(slot0._rightDark, slot0._rewardPointPage <= slot1)

	for slot8 = 1, slot0._rewardPointPage do
		gohelper.setActive(slot0:_getRewardPointItem(slot8).normal, slot8 ~= slot1)
		gohelper.setActive(slot9.select, slot8 == slot1)
	end

	for slot8 = 1, #slot0._rewardPointItem do
		gohelper.setActive(slot0._rewardPointItem[slot8].go, slot8 <= slot0._rewardPointPage)
	end

	gohelper.setActive(slot0._gorewardleftreddot, slot0:_isLeftCanGetBonus())
	gohelper.setActive(slot0._gorewardrightreddot, slot0:_isRightCanGetBonus())
end

function slot0._getRewardItem(slot0, slot1)
	if not slot0._taskRewardItemList then
		slot0._taskRewardItemList = slot0:getUserDataTb_()
	end

	if not slot0._taskRewardItemList[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._gotaskrewarditem)
		slot5 = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot3, "item"))
		slot2 = {
			item = slot5,
			go = slot3,
			goGot = gohelper.findChild(slot3, "#goHasGet"),
			goCanGet = gohelper.findChild(slot3, "#goCanGet")
		}

		transformhelper.setLocalScale(slot5.go.transform, 0.62, 0.62, 1)

		slot0._taskRewardItemList[slot1] = slot2

		return slot2, true
	end

	return slot2, false
end

function slot0._getRewardPointItem(slot0, slot1)
	if not slot0._rewardPointItem then
		slot0._rewardPointItem = slot0:getUserDataTb_()
	end

	if not slot0._rewardPointItem[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._gopoint, "point_" .. slot1)
		slot0._rewardPointItem[slot1] = {
			go = slot3,
			normal = gohelper.findChild(slot3, "normal"),
			select = gohelper.findChild(slot3, "select")
		}
	end

	return slot2
end

function slot0._newFinishTask(slot0)
	if LuaUtil.tableNotEmpty(RoomTradeTaskListModel.instance:getNewFinishTaskIds(slot0._curShowLevel)) then
		RoomRpc.instance:sendReadNewTradeTaskRequest(slot1)
	end
end

return slot0
