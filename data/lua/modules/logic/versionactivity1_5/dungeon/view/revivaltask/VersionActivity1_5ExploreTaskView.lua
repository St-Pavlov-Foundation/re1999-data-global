module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5ExploreTaskView", package.seeall)

local var_0_0 = class("VersionActivity1_5ExploreTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goexploretask = gohelper.findChild(arg_1_0.viewGO, "#go_exploretask")
	arg_1_0._scrollMap = gohelper.findChildScrollRect(arg_1_0._goexploretask, "#go_map/Scroll View")
	arg_1_0._gomapcontent = gohelper.findChild(arg_1_0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent")
	arg_1_0._simagemap1 = gohelper.findChildSingleImage(arg_1_0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/#simage_map1")
	arg_1_0._simagemap2 = gohelper.findChildSingleImage(arg_1_0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/#simage_map2")
	arg_1_0._gomapitem = gohelper.findChild(arg_1_0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/Layout/#go_mapitem")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0._goexploretask, "LeftDown/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0._goexploretask, "LeftDown/#txt_total")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0._goexploretask, "LeftDown/#go_rewarditem")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0._goexploretask, "LeftDown/#go_hasget")
	arg_1_0._gogainreward = gohelper.findChild(arg_1_0._goexploretask, "LeftDown/#go_gainReward")
	arg_1_0._sliderprogress = gohelper.findChildSlider(arg_1_0._goexploretask, "LeftDown/#slider_progress")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.initReward(arg_4_0)
	arg_4_0.icon = IconMgr.instance:getCommonPropItemIcon(arg_4_0._gorewarditem)

	local var_4_0, var_4_1, var_4_2 = VersionActivity1_5DungeonConfig.instance:getExploreReward()

	arg_4_0.icon:setMOValue(var_4_0, var_4_1, var_4_2)
	arg_4_0.icon:setScale(0.6, 0.6, 0.6)
end

function var_0_0.initLineNodes(arg_5_0)
	local var_5_0 = gohelper.findChild(arg_5_0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/Line")

	arg_5_0.lineImageList = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, var_5_0.transform.childCount do
		local var_5_1 = gohelper.findChildImage(var_5_0, "line" .. iter_5_0)

		if not var_5_1 then
			logError("not found line go, line number : " .. iter_5_0)
		end

		table.insert(arg_5_0.lineImageList, var_5_1)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.animator = arg_6_0._goexploretask:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(arg_6_0._gomapitem, false)

	arg_6_0.taskItemList = {}
	arg_6_0.needRefreshTimeTaskItemList = {}

	for iter_6_0, iter_6_1 in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		arg_6_0:createTaskItem(iter_6_1)
	end

	arg_6_0:setPosition()

	arg_6_0.totalCount = #arg_6_0.taskItemList
	arg_6_0.rewardClick = gohelper.getClickWithDefaultAudio(arg_6_0._gogainreward, arg_6_0)

	arg_6_0.rewardClick:AddClickListener(arg_6_0.onClickReward, arg_6_0)
	arg_6_0:initReward()
	arg_6_0:initLineNodes()
	arg_6_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange, arg_6_0.onSelectHeroTabChange, arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedExploreReward, arg_6_0.onGainedExploreReward, arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.HideExploreTip, arg_6_0.onHideExploreTip, arg_6_0)
end

function var_0_0.createTaskItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getUserDataTb_()

	var_7_0.go = gohelper.cloneInPlace(arg_7_0._gomapitem, arg_7_1.id)
	var_7_0.animator = var_7_0.go:GetComponent(gohelper.Type_Animator)
	var_7_0.rectTr = var_7_0.go:GetComponent(typeof(UnityEngine.RectTransform))
	var_7_0.goFight = gohelper.findChild(var_7_0.go, "btn/fight")
	var_7_0.goDispatch = gohelper.findChild(var_7_0.go, "btn/dispatch")
	var_7_0.goFightImage = var_7_0.goFight:GetComponent(gohelper.Type_Image)
	var_7_0.goDispatchImage = var_7_0.goDispatch:GetComponent(gohelper.Type_Image)
	var_7_0.goFinish = gohelper.findChild(var_7_0.go, "btn/finish")
	var_7_0.goReward = gohelper.findChild(var_7_0.go, "btn/finish/reward")
	var_7_0.click = gohelper.findChildClickWithDefaultAudio(var_7_0.go, "btn/clickarea")

	var_7_0.click:AddClickListener(arg_7_0.onClickTaskItem, arg_7_0, var_7_0)

	var_7_0.goTips = gohelper.findChild(var_7_0.go, "layout/tips")
	var_7_0.goLockTips = gohelper.findChild(var_7_0.go, "layout/tips/lockedtips")
	var_7_0.txtLockTips = gohelper.findChildText(var_7_0.go, "layout/tips/lockedtips/#txt_locked")
	var_7_0.goTimeTips = gohelper.findChild(var_7_0.go, "layout/tips/timetips")
	var_7_0.txtTimeTips = gohelper.findChildText(var_7_0.go, "layout/tips/timetips/#txt_time")
	var_7_0.goProgressPoint = gohelper.findChild(var_7_0.go, "layout/progresspoint")
	var_7_0.goProgressPointItem = gohelper.findChild(var_7_0.go, "layout/progresspoint/staritem")
	var_7_0.taskCo = arg_7_1
	var_7_0.pointDict = {}

	local var_7_1 = string.splitToNumber(arg_7_1.pos, "#")

	recthelper.setAnchor(var_7_0.rectTr, var_7_1[1], var_7_1[2])
	gohelper.setActive(var_7_0.go, true)
	gohelper.setActive(var_7_0.goProgressPointItem, false)
	table.insert(arg_7_0.taskItemList, var_7_0)
end

function var_0_0.onClickTaskItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.taskCo

	if VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(var_8_0) == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock then
		GameFacade.showToastString(var_8_0.unlockToastDesc)

		return
	end

	arg_8_1.animator:Play("open", 0, 0)
	arg_8_0.viewContainer.exploreTipView:showTip(arg_8_1, arg_8_2)
end

function var_0_0.onHideExploreTip(arg_9_0, arg_9_1)
	arg_9_1.animator:Play("close", 0, 0)
end

function var_0_0.onClickReward(arg_10_0)
	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskGainedTotalReward() then
		return
	end

	if arg_10_0.finishCount < arg_10_0.totalCount then
		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct139GainExploreRewardRequest()
end

function var_0_0.onSelectHeroTabChange(arg_11_0)
	local var_11_0 = VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() == VersionActivity1_5DungeonEnum.ExploreTaskId

	gohelper.setActive(arg_11_0._goexploretask, var_11_0)

	if not var_11_0 then
		arg_11_0:recordPosition()

		return
	end

	arg_11_0.animator:Play("open", 0, 0)
	arg_11_0:setPosition()
	arg_11_0:refreshUI()
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0.finishCount = arg_12_0:getFinishCount()

	arg_12_0:refreshMap()
	arg_12_0:refreshLeftDown()
end

function var_0_0.getFinishCount(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		if arg_13_0:checkExploreTaskFinish(iter_13_1) then
			var_13_0 = var_13_0 + 1
		end
	end

	return var_13_0
end

function var_0_0.checkExploreTaskFinish(arg_14_0, arg_14_1)
	if #arg_14_1.elementList == 0 then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(iter_14_1) then
			return false
		end
	end

	return true
end

function var_0_0.refreshMap(arg_15_0)
	arg_15_0:refreshLines()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.taskItemList) do
		arg_15_0:refreshItem(iter_15_1)
	end

	if #arg_15_0.needRefreshTimeTaskItemList > 0 then
		TaskDispatcher.runRepeat(arg_15_0.everySecondCall, arg_15_0, 1)
	end
end

function var_0_0.refreshLines(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		arg_16_0:refreshLineByTaskCo(iter_16_1)
	end
end

function var_0_0.refreshLineByTaskCo(arg_17_0, arg_17_1)
	if arg_17_1.type ~= VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch then
		return
	end

	local var_17_0 = arg_17_1.elementList[1]
	local var_17_1 = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(var_17_0)
	local var_17_2 = var_17_1 and var_17_1:isFinish()
	local var_17_3 = string.splitToNumber(arg_17_1.unlockLineNumbers, "#")

	for iter_17_0, iter_17_1 in ipairs(var_17_3) do
		local var_17_4 = arg_17_0.lineImageList[iter_17_1]

		if var_17_4 then
			ZProj.UGUIHelper.SetColorAlpha(var_17_4, var_17_2 and 1 or 0.6)
		else
			logError("not found line image : " .. iter_17_1)
		end
	end
end

function var_0_0.refreshItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.taskCo
	local var_18_1 = VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(var_18_0)

	arg_18_0:refreshTaskItemImage(arg_18_1)
	arg_18_0:refreshLockTip(arg_18_1, var_18_1)
	arg_18_0:refreshTimeTip(arg_18_1, var_18_1)
	arg_18_0:refreshStar(arg_18_1, var_18_1)
end

function var_0_0.refreshTaskItemImage(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.taskCo
	local var_19_1 = VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskUnlock(var_19_0)
	local var_19_2 = var_19_0.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Fight
	local var_19_3 = var_19_0.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch
	local var_19_4 = var_19_1 and 1 or 0.55

	ZProj.UGUIHelper.SetColorAlpha(arg_19_1.goFightImage, var_19_4)
	ZProj.UGUIHelper.SetColorAlpha(arg_19_1.goDispatchImage, var_19_4)

	if not var_19_1 then
		gohelper.setActive(arg_19_1.goFight, var_19_2)
		gohelper.setActive(arg_19_1.goDispatch, var_19_3)
		gohelper.setActive(arg_19_1.goFinish, false)
		gohelper.setActive(arg_19_1.goReward, false)

		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskRunning(var_19_0) then
		gohelper.setActive(arg_19_1.goFight, false)
		gohelper.setActive(arg_19_1.goDispatch, true)
		gohelper.setActive(arg_19_1.goFinish, false)
		gohelper.setActive(arg_19_1.goReward, false)

		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskGainedReward(var_19_0) then
		gohelper.setActive(arg_19_1.goFight, false)
		gohelper.setActive(arg_19_1.goDispatch, false)
		gohelper.setActive(arg_19_1.goFinish, true)
		gohelper.setActive(arg_19_1.goReward, false)

		return
	end

	for iter_19_0, iter_19_1 in ipairs(var_19_0.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(iter_19_1) then
			if var_19_3 and iter_19_0 == 1 then
				local var_19_5 = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(iter_19_1)

				if var_19_5 and var_19_5:isFinish() then
					gohelper.setActive(arg_19_1.goFight, false)
					gohelper.setActive(arg_19_1.goFinish, true)
					gohelper.setActive(arg_19_1.goDispatch, true)
					gohelper.setActive(arg_19_1.goReward, true)
				else
					gohelper.setActive(arg_19_1.goFight, false)
					gohelper.setActive(arg_19_1.goFinish, false)
					gohelper.setActive(arg_19_1.goReward, false)
					gohelper.setActive(arg_19_1.goDispatch, true)
				end

				return
			else
				local var_19_6 = lua_chapter_map_element.configDict[iter_19_1]

				if var_19_6.type == DungeonEnum.ElementType.Fight then
					local var_19_7 = tonumber(var_19_6.param)

					if DungeonModel.instance:hasPassLevel(var_19_7) then
						gohelper.setActive(arg_19_1.goFight, true)
						gohelper.setActive(arg_19_1.goFinish, true)
						gohelper.setActive(arg_19_1.goReward, true)
						gohelper.setActive(arg_19_1.goDispatch, false)
					else
						gohelper.setActive(arg_19_1.goFight, true)
						gohelper.setActive(arg_19_1.goFinish, false)
						gohelper.setActive(arg_19_1.goReward, false)
						gohelper.setActive(arg_19_1.goDispatch, false)
					end
				else
					local var_19_8 = false

					if var_19_6.type == DungeonEnum.ElementType.EnterDialogue then
						local var_19_9 = tonumber(var_19_6.param)

						var_19_8 = DialogueModel.instance:isFinishDialogue(var_19_9)
					end

					if var_19_8 then
						gohelper.setActive(arg_19_1.goFight, false)
						gohelper.setActive(arg_19_1.goFinish, true)
						gohelper.setActive(arg_19_1.goDispatch, true)
						gohelper.setActive(arg_19_1.goReward, true)
					else
						gohelper.setActive(arg_19_1.goFight, false)
						gohelper.setActive(arg_19_1.goFinish, false)
						gohelper.setActive(arg_19_1.goReward, false)
						gohelper.setActive(arg_19_1.goDispatch, true)
					end
				end
			end
		end
	end
end

function var_0_0.refreshLockTip(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1.taskCo

	if string.nilorempty(var_20_0.unlockDesc) then
		gohelper.setActive(arg_20_1.goLockTips, false)

		return
	end

	arg_20_2 = arg_20_2 or VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(var_20_0)

	local var_20_1 = arg_20_2 == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock

	if var_20_1 then
		if var_20_0.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishElementAndEpisode then
			local var_20_2 = string.splitToNumber(var_20_0.unlockParam, "#")
			local var_20_3 = var_20_2[1]
			local var_20_4 = var_20_2[2]

			var_20_1 = DungeonMapModel.instance:elementIsFinished(var_20_3) and not DungeonModel.instance:hasPassLevel(var_20_4)
		elseif var_20_0.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishEpisodeAndAnyOneElement then
			local var_20_5 = string.split(var_20_0.unlockParam, "#")
			local var_20_6 = string.splitToNumber(var_20_5[2], "|")
			local var_20_7 = var_20_5[1]

			var_20_1 = VersionActivity1_5RevivalTaskModel.instance:_checkFinishAnyOneElement(var_20_6) and not DungeonModel.instance:hasPassLevel(var_20_7)
		else
			var_20_1 = false
		end
	end

	gohelper.setActive(arg_20_1.goLockTips, var_20_1)

	if var_20_1 then
		arg_20_1.txtLockTips.text = var_20_0.unlockDesc
	end
end

function var_0_0.refreshTimeTip(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1.taskCo

	arg_21_2 = arg_21_2 or VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(var_21_0)

	local var_21_1 = arg_21_2 == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Running

	gohelper.setActive(arg_21_1.goTimeTips, var_21_1)

	if var_21_1 then
		local var_21_2 = var_21_0.elementList[1]
		local var_21_3 = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(var_21_2)

		if var_21_3 then
			arg_21_1.txtTimeTips.text = var_21_3:getRemainTimeStr()

			table.insert(arg_21_0.needRefreshTimeTaskItemList, arg_21_1)
		else
			gohelper.setActive(arg_21_1.goTimeTips, false)
			logError("没拿到对应的派遣信息, elementId : " .. tostring(var_21_2))
		end
	end
end

function var_0_0.refreshStar(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1.taskCo
	local var_22_1 = var_22_0.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch

	gohelper.setActive(arg_22_1.goProgressPoint, var_22_1)

	if not var_22_1 then
		return
	end

	arg_22_2 = arg_22_2 or VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(var_22_0)

	if arg_22_2 == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock then
		gohelper.setActive(arg_22_1.goProgressPoint, false)

		return
	end

	gohelper.setActive(arg_22_1.goProgressPoint, true)

	local var_22_2 = var_22_0.elementList
	local var_22_3 = var_22_2[1]
	local var_22_4 = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(var_22_3)
	local var_22_5 = arg_22_0:getPointItem(arg_22_1, var_22_3)

	if not var_22_4 then
		gohelper.setActive(var_22_5.goRunning, false)
		gohelper.setActive(var_22_5.goFinish, false)
	elseif var_22_4:isRunning() then
		gohelper.setActive(var_22_5.goRunning, true)
		gohelper.setActive(var_22_5.goFinish, false)
	elseif var_22_4:isFinish() then
		gohelper.setActive(var_22_5.goRunning, false)
		gohelper.setActive(var_22_5.goFinish, true)
	end

	for iter_22_0 = 2, #var_22_2 do
		local var_22_6 = var_22_2[iter_22_0]
		local var_22_7 = arg_22_0:getPointItem(arg_22_1, var_22_6)

		if DungeonMapModel.instance:elementIsFinished(var_22_6) then
			gohelper.setActive(var_22_7.goRunning, false)
			gohelper.setActive(var_22_7.goFinish, true)
		else
			gohelper.setActive(var_22_7.goRunning, false)
			gohelper.setActive(var_22_7.goFinish, false)
		end
	end
end

function var_0_0.getPointItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1.pointDict[arg_23_2]

	if var_23_0 then
		return var_23_0
	end

	local var_23_1 = arg_23_0:getUserDataTb_()

	var_23_1.go = gohelper.cloneInPlace(arg_23_1.goProgressPointItem, arg_23_2)

	gohelper.setActive(var_23_1.go, true)

	var_23_1.goRunning = gohelper.findChild(var_23_1.go, "running")
	var_23_1.goFinish = gohelper.findChild(var_23_1.go, "finish")
	arg_23_1.pointDict[arg_23_2] = var_23_1

	return var_23_1
end

function var_0_0.refreshLeftDown(arg_24_0)
	arg_24_0:refreshSlider()
	arg_24_0:refreshReward()
end

function var_0_0.refreshSlider(arg_25_0)
	arg_25_0._txtnum.text = arg_25_0.finishCount
	arg_25_0._txttotal.text = arg_25_0.totalCount

	arg_25_0._sliderprogress:SetValue(arg_25_0.finishCount / arg_25_0.totalCount)
end

function var_0_0.refreshReward(arg_26_0)
	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskGainedTotalReward() then
		gohelper.setActive(arg_26_0._gohasget, true)
		gohelper.setActive(arg_26_0._gogainreward, false)

		return
	end

	gohelper.setActive(arg_26_0._gohasget, false)
	gohelper.setActive(arg_26_0._gogainreward, arg_26_0.finishCount >= arg_26_0.totalCount)
end

function var_0_0.onGainedExploreReward(arg_27_0)
	arg_27_0:refreshReward()
end

function var_0_0.everySecondCall(arg_28_0)
	for iter_28_0 = #arg_28_0.needRefreshTimeTaskItemList, 1, -1 do
		local var_28_0 = arg_28_0.needRefreshTimeTaskItemList[iter_28_0]
		local var_28_1 = var_28_0.taskCo.elementList[1]
		local var_28_2 = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(var_28_1)

		if var_28_2 then
			if var_28_2:isFinish() then
				table.remove(arg_28_0.needRefreshTimeTaskItemList, iter_28_0)
				arg_28_0:refreshItem(var_28_0)
				arg_28_0:refreshLineByTaskCo(var_28_0.taskCo)
			else
				var_28_0.txtTimeTips.text = var_28_2:getRemainTimeStr()
			end
		else
			table.remove(arg_28_0.needRefreshTimeTaskItemList, iter_28_0)
			arg_28_0:refreshItem(var_28_0)
		end
	end

	if #arg_28_0.needRefreshTimeTaskItemList == 0 then
		TaskDispatcher.cancelTask(arg_28_0.everySecondCall, arg_28_0)
	end
end

function var_0_0.setPosition(arg_29_0)
	if not arg_29_0.lastRecordPos then
		local var_29_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskHorizontalPos)

		arg_29_0.lastRecordPos = PlayerPrefsHelper.getNumber(var_29_0, 0)
	end

	arg_29_0._scrollMap.horizontalNormalizedPosition = arg_29_0.lastRecordPos
end

function var_0_0.recordPosition(arg_30_0)
	arg_30_0.lastRecordPos = arg_30_0._scrollMap.horizontalNormalizedPosition

	local var_30_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskHorizontalPos)

	PlayerPrefsHelper.setNumber(var_30_0, arg_30_0.lastRecordPos)
end

function var_0_0.onClose(arg_31_0)
	arg_31_0:recordPosition()
end

function var_0_0.onDestroyView(arg_32_0)
	arg_32_0.rewardClick:RemoveClickListener()

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.taskItemList) do
		iter_32_1.click:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_32_0.everySecondCall, arg_32_0)
end

return var_0_0
