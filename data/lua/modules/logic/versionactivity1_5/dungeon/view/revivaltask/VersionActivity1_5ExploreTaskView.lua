module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5ExploreTaskView", package.seeall)

slot0 = class("VersionActivity1_5ExploreTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._goexploretask = gohelper.findChild(slot0.viewGO, "#go_exploretask")
	slot0._scrollMap = gohelper.findChildScrollRect(slot0._goexploretask, "#go_map/Scroll View")
	slot0._gomapcontent = gohelper.findChild(slot0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent")
	slot0._simagemap1 = gohelper.findChildSingleImage(slot0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/#simage_map1")
	slot0._simagemap2 = gohelper.findChildSingleImage(slot0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/#simage_map2")
	slot0._gomapitem = gohelper.findChild(slot0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/Layout/#go_mapitem")
	slot0._txtnum = gohelper.findChildText(slot0._goexploretask, "LeftDown/#txt_num")
	slot0._txttotal = gohelper.findChildText(slot0._goexploretask, "LeftDown/#txt_total")
	slot0._gorewarditem = gohelper.findChild(slot0._goexploretask, "LeftDown/#go_rewarditem")
	slot0._gohasget = gohelper.findChild(slot0._goexploretask, "LeftDown/#go_hasget")
	slot0._gogainreward = gohelper.findChild(slot0._goexploretask, "LeftDown/#go_gainReward")
	slot0._sliderprogress = gohelper.findChildSlider(slot0._goexploretask, "LeftDown/#slider_progress")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.initReward(slot0)
	slot0.icon = IconMgr.instance:getCommonPropItemIcon(slot0._gorewarditem)
	slot1, slot2, slot3 = VersionActivity1_5DungeonConfig.instance:getExploreReward()

	slot0.icon:setMOValue(slot1, slot2, slot3)
	slot0.icon:setScale(0.6, 0.6, 0.6)
end

function slot0.initLineNodes(slot0)
	slot0.lineImageList = slot0:getUserDataTb_()

	for slot5 = 1, gohelper.findChild(slot0._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/Line").transform.childCount do
		if not gohelper.findChildImage(slot1, "line" .. slot5) then
			logError("not found line go, line number : " .. slot5)
		end

		table.insert(slot0.lineImageList, slot6)
	end
end

function slot0._editableInitView(slot0)
	slot0.animator = slot0._goexploretask:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(slot0._gomapitem, false)

	slot0.taskItemList = {}
	slot0.needRefreshTimeTaskItemList = {}

	for slot4, slot5 in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		slot0:createTaskItem(slot5)
	end

	slot0:setPosition()

	slot0.totalCount = #slot0.taskItemList
	slot0.rewardClick = gohelper.getClickWithDefaultAudio(slot0._gogainreward, slot0)

	slot0.rewardClick:AddClickListener(slot0.onClickReward, slot0)
	slot0:initReward()
	slot0:initLineNodes()
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange, slot0.onSelectHeroTabChange, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedExploreReward, slot0.onGainedExploreReward, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.HideExploreTip, slot0.onHideExploreTip, slot0)
end

function slot0.createTaskItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gomapitem, slot1.id)
	slot2.animator = slot2.go:GetComponent(gohelper.Type_Animator)
	slot2.rectTr = slot2.go:GetComponent(typeof(UnityEngine.RectTransform))
	slot2.goFight = gohelper.findChild(slot2.go, "btn/fight")
	slot2.goDispatch = gohelper.findChild(slot2.go, "btn/dispatch")
	slot2.goFightImage = slot2.goFight:GetComponent(gohelper.Type_Image)
	slot2.goDispatchImage = slot2.goDispatch:GetComponent(gohelper.Type_Image)
	slot2.goFinish = gohelper.findChild(slot2.go, "btn/finish")
	slot2.goReward = gohelper.findChild(slot2.go, "btn/finish/reward")
	slot2.click = gohelper.findChildClickWithDefaultAudio(slot2.go, "btn/clickarea")

	slot2.click:AddClickListener(slot0.onClickTaskItem, slot0, slot2)

	slot2.goTips = gohelper.findChild(slot2.go, "layout/tips")
	slot2.goLockTips = gohelper.findChild(slot2.go, "layout/tips/lockedtips")
	slot2.txtLockTips = gohelper.findChildText(slot2.go, "layout/tips/lockedtips/#txt_locked")
	slot2.goTimeTips = gohelper.findChild(slot2.go, "layout/tips/timetips")
	slot2.txtTimeTips = gohelper.findChildText(slot2.go, "layout/tips/timetips/#txt_time")
	slot2.goProgressPoint = gohelper.findChild(slot2.go, "layout/progresspoint")
	slot2.goProgressPointItem = gohelper.findChild(slot2.go, "layout/progresspoint/staritem")
	slot2.taskCo = slot1
	slot2.pointDict = {}
	slot3 = string.splitToNumber(slot1.pos, "#")

	recthelper.setAnchor(slot2.rectTr, slot3[1], slot3[2])
	gohelper.setActive(slot2.go, true)
	gohelper.setActive(slot2.goProgressPointItem, false)
	table.insert(slot0.taskItemList, slot2)
end

function slot0.onClickTaskItem(slot0, slot1, slot2)
	if VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(slot1.taskCo) == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock then
		GameFacade.showToastString(slot3.unlockToastDesc)

		return
	end

	slot1.animator:Play("open", 0, 0)
	slot0.viewContainer.exploreTipView:showTip(slot1, slot2)
end

function slot0.onHideExploreTip(slot0, slot1)
	slot1.animator:Play("close", 0, 0)
end

function slot0.onClickReward(slot0)
	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskGainedTotalReward() then
		return
	end

	if slot0.finishCount < slot0.totalCount then
		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct139GainExploreRewardRequest()
end

function slot0.onSelectHeroTabChange(slot0)
	slot1 = VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() == VersionActivity1_5DungeonEnum.ExploreTaskId

	gohelper.setActive(slot0._goexploretask, slot1)

	if not slot1 then
		slot0:recordPosition()

		return
	end

	slot0.animator:Play("open", 0, 0)
	slot0:setPosition()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.finishCount = slot0:getFinishCount()

	slot0:refreshMap()
	slot0:refreshLeftDown()
end

function slot0.getFinishCount(slot0)
	for slot5, slot6 in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		if slot0:checkExploreTaskFinish(slot6) then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.checkExploreTaskFinish(slot0, slot1)
	if #slot1.elementList == 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(slot6) then
			return false
		end
	end

	return true
end

function slot0.refreshMap(slot0)
	slot0:refreshLines()

	for slot4, slot5 in ipairs(slot0.taskItemList) do
		slot0:refreshItem(slot5)
	end

	if #slot0.needRefreshTimeTaskItemList > 0 then
		TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
	end
end

function slot0.refreshLines(slot0)
	for slot4, slot5 in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		slot0:refreshLineByTaskCo(slot5)
	end
end

function slot0.refreshLineByTaskCo(slot0, slot1)
	if slot1.type ~= VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch then
		return
	end

	for slot9, slot10 in ipairs(string.splitToNumber(slot1.unlockLineNumbers, "#")) do
		if slot0.lineImageList[slot10] then
			ZProj.UGUIHelper.SetColorAlpha(slot11, VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(slot1.elementList[1]) and slot3:isFinish() and 1 or 0.6)
		else
			logError("not found line image : " .. slot10)
		end
	end
end

function slot0.refreshItem(slot0, slot1)
	slot3 = VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(slot1.taskCo)

	slot0:refreshTaskItemImage(slot1)
	slot0:refreshLockTip(slot1, slot3)
	slot0:refreshTimeTip(slot1, slot3)
	slot0:refreshStar(slot1, slot3)
end

function slot0.refreshTaskItemImage(slot0, slot1)
	slot2 = slot1.taskCo
	slot3 = VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskUnlock(slot2)
	slot6 = slot3 and 1 or 0.55

	ZProj.UGUIHelper.SetColorAlpha(slot1.goFightImage, slot6)
	ZProj.UGUIHelper.SetColorAlpha(slot1.goDispatchImage, slot6)

	if not slot3 then
		gohelper.setActive(slot1.goFight, slot2.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Fight)
		gohelper.setActive(slot1.goDispatch, slot2.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch)
		gohelper.setActive(slot1.goFinish, false)
		gohelper.setActive(slot1.goReward, false)

		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskRunning(slot2) then
		gohelper.setActive(slot1.goFight, false)
		gohelper.setActive(slot1.goDispatch, true)
		gohelper.setActive(slot1.goFinish, false)
		gohelper.setActive(slot1.goReward, false)

		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskGainedReward(slot2) then
		gohelper.setActive(slot1.goFight, false)
		gohelper.setActive(slot1.goDispatch, false)
		gohelper.setActive(slot1.goFinish, true)
		gohelper.setActive(slot1.goReward, false)

		return
	end

	for slot10, slot11 in ipairs(slot2.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(slot11) then
			if slot5 and slot10 == 1 then
				if VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(slot11) and slot12:isFinish() then
					gohelper.setActive(slot1.goFight, false)
					gohelper.setActive(slot1.goFinish, true)
					gohelper.setActive(slot1.goDispatch, true)
					gohelper.setActive(slot1.goReward, true)
				else
					gohelper.setActive(slot1.goFight, false)
					gohelper.setActive(slot1.goFinish, false)
					gohelper.setActive(slot1.goReward, false)
					gohelper.setActive(slot1.goDispatch, true)
				end

				return
			elseif lua_chapter_map_element.configDict[slot11].type == DungeonEnum.ElementType.Fight then
				if DungeonModel.instance:hasPassLevel(tonumber(slot12.param)) then
					gohelper.setActive(slot1.goFight, true)
					gohelper.setActive(slot1.goFinish, true)
					gohelper.setActive(slot1.goReward, true)
					gohelper.setActive(slot1.goDispatch, false)
				else
					gohelper.setActive(slot1.goFight, true)
					gohelper.setActive(slot1.goFinish, false)
					gohelper.setActive(slot1.goReward, false)
					gohelper.setActive(slot1.goDispatch, false)
				end
			else
				slot13 = false

				if slot12.type == DungeonEnum.ElementType.EnterDialogue then
					slot13 = DialogueModel.instance:isFinishDialogue(tonumber(slot12.param))
				end

				if slot13 then
					gohelper.setActive(slot1.goFight, false)
					gohelper.setActive(slot1.goFinish, true)
					gohelper.setActive(slot1.goDispatch, true)
					gohelper.setActive(slot1.goReward, true)
				else
					gohelper.setActive(slot1.goFight, false)
					gohelper.setActive(slot1.goFinish, false)
					gohelper.setActive(slot1.goReward, false)
					gohelper.setActive(slot1.goDispatch, true)
				end
			end
		end
	end
end

function slot0.refreshLockTip(slot0, slot1, slot2)
	if string.nilorempty(slot1.taskCo.unlockDesc) then
		gohelper.setActive(slot1.goLockTips, false)

		return
	end

	slot4 = (slot2 or VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(slot3)) == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock and (slot3.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishElementAndEpisode and DungeonMapModel.instance:elementIsFinished(slot5[1]) and not DungeonModel.instance:hasPassLevel(slot5[2]) or slot3.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishEpisodeAndAnyOneElement and VersionActivity1_5RevivalTaskModel.instance:_checkFinishAnyOneElement(string.splitToNumber(slot5[2], "|")) and not DungeonModel.instance:hasPassLevel(slot5[1]) or false)

	gohelper.setActive(slot1.goLockTips, slot4)

	if slot4 then
		slot1.txtLockTips.text = slot3.unlockDesc
	end
end

function slot0.refreshTimeTip(slot0, slot1, slot2)
	slot4 = (slot2 or VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(slot1.taskCo)) == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Running

	gohelper.setActive(slot1.goTimeTips, slot4)

	if slot4 then
		if VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(slot3.elementList[1]) then
			slot1.txtTimeTips.text = slot6:getRemainTimeStr()

			table.insert(slot0.needRefreshTimeTaskItemList, slot1)
		else
			gohelper.setActive(slot1.goTimeTips, false)
			logError("没拿到对应的派遣信息, elementId : " .. tostring(slot5))
		end
	end
end

function slot0.refreshStar(slot0, slot1, slot2)
	slot4 = slot1.taskCo.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch

	gohelper.setActive(slot1.goProgressPoint, slot4)

	if not slot4 then
		return
	end

	if (slot2 or VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(slot3)) == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock then
		gohelper.setActive(slot1.goProgressPoint, false)

		return
	end

	gohelper.setActive(slot1.goProgressPoint, true)

	slot6 = slot3.elementList[1]
	slot8 = slot0:getPointItem(slot1, slot6)

	if not VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(slot6) then
		gohelper.setActive(slot8.goRunning, false)
		gohelper.setActive(slot8.goFinish, false)
	elseif slot7:isRunning() then
		gohelper.setActive(slot8.goRunning, true)
		gohelper.setActive(slot8.goFinish, false)
	elseif slot7:isFinish() then
		gohelper.setActive(slot8.goRunning, false)
		gohelper.setActive(slot8.goFinish, true)
	end

	for slot12 = 2, #slot5 do
		slot6 = slot5[slot12]
		slot8 = slot0:getPointItem(slot1, slot6)

		if DungeonMapModel.instance:elementIsFinished(slot6) then
			gohelper.setActive(slot8.goRunning, false)
			gohelper.setActive(slot8.goFinish, true)
		else
			gohelper.setActive(slot8.goRunning, false)
			gohelper.setActive(slot8.goFinish, false)
		end
	end
end

function slot0.getPointItem(slot0, slot1, slot2)
	if slot1.pointDict[slot2] then
		return slot3
	end

	slot3 = slot0:getUserDataTb_()
	slot3.go = gohelper.cloneInPlace(slot1.goProgressPointItem, slot2)

	gohelper.setActive(slot3.go, true)

	slot3.goRunning = gohelper.findChild(slot3.go, "running")
	slot3.goFinish = gohelper.findChild(slot3.go, "finish")
	slot1.pointDict[slot2] = slot3

	return slot3
end

function slot0.refreshLeftDown(slot0)
	slot0:refreshSlider()
	slot0:refreshReward()
end

function slot0.refreshSlider(slot0)
	slot0._txtnum.text = slot0.finishCount
	slot0._txttotal.text = slot0.totalCount

	slot0._sliderprogress:SetValue(slot0.finishCount / slot0.totalCount)
end

function slot0.refreshReward(slot0)
	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskGainedTotalReward() then
		gohelper.setActive(slot0._gohasget, true)
		gohelper.setActive(slot0._gogainreward, false)

		return
	end

	gohelper.setActive(slot0._gohasget, false)
	gohelper.setActive(slot0._gogainreward, slot0.totalCount <= slot0.finishCount)
end

function slot0.onGainedExploreReward(slot0)
	slot0:refreshReward()
end

function slot0.everySecondCall(slot0)
	for slot4 = #slot0.needRefreshTimeTaskItemList, 1, -1 do
		if VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(slot0.needRefreshTimeTaskItemList[slot4].taskCo.elementList[1]) then
			if slot8:isFinish() then
				table.remove(slot0.needRefreshTimeTaskItemList, slot4)
				slot0:refreshItem(slot5)
				slot0:refreshLineByTaskCo(slot5.taskCo)
			else
				slot5.txtTimeTips.text = slot8:getRemainTimeStr()
			end
		else
			table.remove(slot0.needRefreshTimeTaskItemList, slot4)
			slot0:refreshItem(slot5)
		end
	end

	if #slot0.needRefreshTimeTaskItemList == 0 then
		TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
	end
end

function slot0.setPosition(slot0)
	if not slot0.lastRecordPos then
		slot0.lastRecordPos = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskHorizontalPos), 0)
	end

	slot0._scrollMap.horizontalNormalizedPosition = slot0.lastRecordPos
end

function slot0.recordPosition(slot0)
	slot0.lastRecordPos = slot0._scrollMap.horizontalNormalizedPosition

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskHorizontalPos), slot0.lastRecordPos)
end

function slot0.onClose(slot0)
	slot0:recordPosition()
end

function slot0.onDestroyView(slot0)
	slot0.rewardClick:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0.taskItemList) do
		slot5.click:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

return slot0
