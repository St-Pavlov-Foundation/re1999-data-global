module("modules.logic.tower.view.TowerTaskView", package.seeall)

slot0 = class("TowerTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._goFullBg2 = gohelper.findChild(slot0.viewGO, "#simage_FullBG2")
	slot0._goLeft = gohelper.findChild(slot0.viewGO, "Left")
	slot0._scrolltower = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_tower")
	slot0._gotowerContent = gohelper.findChild(slot0.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent")
	slot0._gotowerItem = gohelper.findChild(slot0.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent/#go_towerItem")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent/#go_timeTowerItem/normal/time/#txt_time")
	slot0._goRight = gohelper.findChild(slot0.viewGO, "Right")
	slot0._scrolltaskList = gohelper.findChildScrollRect(slot0.viewGO, "Right/#scroll_taskList")
	slot0._gotaskContent = gohelper.findChild(slot0.viewGO, "Right/#scroll_taskList/Viewport/#go_taskContent")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "Right/#go_tips")
	slot0._gotimeTowerScore = gohelper.findChild(slot0.viewGO, "Right/#go_tips/#go_timeTowerScore")
	slot0._txttimeTowerScore = gohelper.findChildText(slot0.viewGO, "Right/#go_tips/#go_timeTowerScore/#txt_timeTowerScore")
	slot0._txttimeTowerTime = gohelper.findChildText(slot0.viewGO, "Right/#go_tips/#go_timeTowerScore/layout/#txt_timeTowerTime")
	slot0._gobossTowerTips = gohelper.findChild(slot0.viewGO, "Right/#go_tips/#go_bossTowerTips")
	slot0._txtbossTowerTip = gohelper.findChildText(slot0.viewGO, "Right/#go_tips/#go_bossTowerTips/#txt_bossTowerTip")
	slot0._txtbossTowerTime = gohelper.findChildText(slot0.viewGO, "Right/#go_tips/#go_bossTowerTips/layout/#txt_bossTowerTime")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshTaskPos, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.InitTowerItemData, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshLeftUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshTaskPos, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.InitTowerItemData, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshLeftUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshUI, slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

slot0.TaskMaskTime = 0.65
slot0.TaskGetAnimTime = 0.567
slot0.EnterViewAnimBlock = "playEnterTowerTaskViewAnim"
slot0.MoreTaskPosY = 14
slot0.NormalTaskPosY = -75
slot0.NormalTaskCount = 4

function slot0.onTowerItemClick(slot0, slot1)
	if slot1.select then
		return
	end

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(slot1.data.type, slot1.data.towerId)
	slot0:refreshSelectState()
	slot0:refreshRemainTime()
	slot0:refreshTaskPos()
end

function slot0._editableInitView(slot0)
	slot0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0.viewContainer.scrollView)

	slot0._taskAnimRemoveItem:setMoveInterval(0)
	slot0._taskAnimRemoveItem:setMoveAnimationTime(uv0.TaskMaskTime - uv0.TaskGetAnimTime)

	slot0.towerItemTab = slot0:getUserDataTb_()
	slot0.removeIndexTab = {}

	gohelper.setActive(slot0._gotowerItem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_task_entry)
	TaskDispatcher.runDelay(slot0.endEnterAnimBlock, slot0, 0.8)
	UIBlockMgr.instance:startBlock(uv0.EnterViewAnimBlock)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:InitTowerItemData()
	slot0:refreshSelectState()
	slot0:refreshRemainTime()
	slot0:refreshTaskPos()
	slot0:refreshLeftUI()
	slot0:refreshReddot()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
end

function slot0.InitTowerItemData(slot0)
	slot3 = TowerTaskModel.instance.bossTaskList

	if slot0:buildTowerItemData(TowerTaskModel.instance.limitTimeTaskList, TowerEnum.TowerType.Limited) then
		table.insert({}, slot4)
	end

	for slot8, slot9 in ipairs(slot3) do
		if slot0:buildTowerItemData(slot9, TowerEnum.TowerType.Boss) then
			table.insert(slot1, slot10)
		end
	end

	slot0:createOrRefreshTowerItem(slot1)
end

function slot0.buildTowerItemData(slot0, slot1, slot2)
	slot3 = {}

	if not slot1 or tabletool.len(slot1) == 0 then
		return nil
	end

	slot3.taskList = slot1
	slot3.taskCount = #slot1
	slot3.finishCount = TowerTaskModel.instance:getTaskItemRewardCount(slot1)
	slot3.type = slot2

	if slot2 == TowerEnum.TowerType.Limited then
		slot3.timeConfig = TowerConfig.instance:getTowerLimitedCoByTaskGroupId(slot1[1].config.taskGroupId)
		slot3.towerId = slot3.timeConfig.season
	elseif slot2 == TowerEnum.TowerType.Boss then
		slot3.timeConfig = TowerConfig.instance:getTowerBossTimeCoByTaskGroupId(slot1[1].config.taskGroupId)
		slot3.towerId = slot3.timeConfig.towerId
	end

	slot3.towerOpenMo = TowerModel.instance:getTowerOpenInfo(slot2, slot3.towerId, TowerEnum.TowerStatus.Open)

	return slot3
end

function slot0.createOrRefreshTowerItem(slot0, slot1)
	slot0.towerItemList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.towerItemTab[slot6.type] then
			slot0.towerItemTab[slot6.type] = {}
		end

		if not slot0.towerItemTab[slot6.type][slot6.towerId] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.clone(slot0._gotowerItem, slot0._gotowerContent, string.format("tower%s_%s", slot6.type, slot6.towerId))
			slot7.goTimeTower = gohelper.findChild(slot7.go, "go_timeTowerItem")
			slot7.goBossTower = gohelper.findChild(slot7.go, "go_bossTowerItem")
			slot7.btnClick = gohelper.findChildButtonWithAudio(slot7.go, "btn_click")

			slot7.btnClick:AddClickListener(slot0.onTowerItemClick, slot0, slot7)

			slot7.timeTowerUI = slot0:findTowerItemUI(slot7.goTimeTower)
			slot7.bossTowerUI = slot0:findTowerItemUI(slot7.goBossTower)
			slot7.select = false
			slot7.data = slot6
			slot0.towerItemTab[slot6.type][slot6.towerId] = slot7
		end

		slot7.towerItemUI = slot6.type == TowerEnum.TowerType.Boss and slot7.bossTowerUI or slot7.timeTowerUI

		slot0:refreshTowerItem(slot7)
		table.insert(slot0.towerItemList, slot7)
	end

	for slot5 = #slot1 + 1, #slot0.towerItemList do
		gohelper.setActive(slot0.towerItemList[slot5].go, false)
	end
end

function slot0.refreshTowerItem(slot0, slot1)
	slot1.select = TowerTaskModel.instance.curSelectTowerType == slot1.data.type and TowerTaskModel.instance.curSelectToweId == slot1.data.towerId
	slot4 = slot1.data.type == TowerEnum.TowerType.Boss

	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.goTimeTower, not slot4)
	gohelper.setActive(slot1.goBossTower, slot4)
	gohelper.setActive(slot1.towerItemUI.normalGO, not slot1.select)
	gohelper.setActive(slot1.towerItemUI.selectGO, slot1.select)

	slot5 = slot4 and string.format("tower_taskbossicon_%s", slot1.data.towerId) or "tower_tasktimeicon_1"

	UISpriteSetMgr.instance:setTowerSprite(slot1.towerItemUI.imageNormalIcon, slot5, true)
	UISpriteSetMgr.instance:setTowerSprite(slot1.towerItemUI.imageSelectIcon, slot5, true)

	slot6 = TowerConfig.instance:getBossTowerConfig(slot1.data.towerId)
	slot1.towerItemUI.txtNormalName.text = slot4 and slot6.name or luaLang("towertask_timelimited_name")
	slot1.towerItemUI.txtSelectName.text = slot4 and slot6.name or luaLang("towertask_timelimited_name")
	slot1.towerItemUI.txtNameEn.text = slot4 and slot6.nameEn or luaLang("towertask_timelimited_nameEn")
	slot7 = {}

	for slot11, slot12 in ipairs(slot1.data.taskList) do
		table.insert(slot7, {
			finishCount = slot1.data.finishCount,
			taskMo = slot12
		})
	end

	gohelper.CreateObjList(slot0, slot0.taskProgressShow, slot7, slot1.towerItemUI.goNormalPointContent, slot1.towerItemUI.goNormalPointItem)
	gohelper.CreateObjList(slot0, slot0.taskProgressShow, slot7, slot1.towerItemUI.goSelectPointContent, slot1.towerItemUI.goSelectPointItem)
end

function slot0.findTowerItemUI(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.normalGO = gohelper.findChild(slot1, "normal")
	slot2.selectGO = gohelper.findChild(slot1, "select")
	slot2.imageNormalIcon = gohelper.findChildImage(slot2.normalGO, "image_icon")
	slot2.imageSelectIcon = gohelper.findChildImage(slot2.selectGO, "image_icon")
	slot2.txtNormalName = gohelper.findChildText(slot2.normalGO, "txt_name")
	slot2.txtSelectName = gohelper.findChildText(slot2.selectGO, "txt_name")
	slot2.goNormalPointContent = gohelper.findChild(slot2.normalGO, "go_pointContent")
	slot2.goSelectPointContent = gohelper.findChild(slot2.selectGO, "go_pointContent")
	slot2.goNormalPointItem = gohelper.findChild(slot2.goNormalPointContent, "go_pointItem")
	slot2.goSelectPointItem = gohelper.findChild(slot2.goSelectPointContent, "go_pointItem")
	slot2.goNormalReddot = gohelper.findChild(slot2.normalGO, "go_reddot")
	slot2.goSelectReddot = gohelper.findChild(slot2.selectGO, "go_reddot")
	slot2.txtTime = gohelper.findChildText(slot2.normalGO, "time/txt_time")
	slot2.txtNameEn = gohelper.findChildText(slot2.selectGO, "txt_en")

	return slot2
end

function slot0.taskProgressShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_light"), slot3 <= slot2.finishCount)
end

function slot0.refreshSelectState(slot0)
	slot2 = TowerTaskModel.instance.curSelectToweId
	slot6 = TowerTaskModel.instance.curSelectTowerType

	TowerTaskModel.instance:refreshList(slot6)

	for slot6, slot7 in ipairs(slot0.towerItemList) do
		slot7.select = slot1 == slot7.data.type and slot2 == slot7.data.towerId

		gohelper.setActive(slot7.towerItemUI.normalGO, not slot7.select)
		gohelper.setActive(slot7.towerItemUI.selectGO, slot7.select)
	end

	gohelper.setActive(slot0._gobossTowerTips, slot1 == TowerEnum.TowerType.Boss)
	gohelper.setActive(slot0._gotimeTowerScore, slot1 == TowerEnum.TowerType.Limited)

	slot3 = TowerModel.instance:getTowerInfoById(slot1, slot2)

	if slot1 == TowerEnum.TowerType.Boss then
		slot0._txtbossTowerTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertask_passlayer"), {
			slot3 and slot3.passLayerId or 0,
			#TowerConfig.instance:getBossTowerEpisodeCoList(slot2)
		})
	elseif slot1 == TowerEnum.TowerType.Limited then
		slot0._txttimeTowerScore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertask_currenthighscore"), {
			TowerTimeLimitLevelModel.instance:getTotalScore(true)
		})
	end
end

function slot0.refreshRemainTime(slot0)
	for slot4, slot5 in ipairs(slot0.towerItemList) do
		slot7 = slot5.data.towerOpenMo and slot6.nextTime / 1000 - ServerTime.now() or 0

		gohelper.setActive(slot5.towerItemUI.txtTime.gameObject, slot7 > 0)

		slot8, slot9 = TimeUtil.secondToRoughTime2(slot7)
		slot5.towerItemUI.txtTime.text = slot7 > 0 and string.format("%s%s", slot8, slot9) or ""
	end

	slot5, slot6 = TimeUtil.secondToRoughTime2(TowerModel.instance:getTowerOpenInfo(TowerTaskModel.instance.curSelectTowerType, TowerTaskModel.instance.curSelectToweId, TowerEnum.TowerStatus.Open) and slot3.nextTime / 1000 - ServerTime.now() or 0)

	if slot1 == TowerEnum.TowerType.Boss then
		slot0._txtbossTowerTime.text = slot4 > 0 and string.format("%s%s", slot5, slot6) or ""

		gohelper.setActive(slot0._txtbossTowerTime.gameObject, slot4 > 0)
	else
		slot0._txttimeTowerTime.text = slot4 > 0 and string.format("%s%s", slot5, slot6) or ""

		gohelper.setActive(slot0._txttimeTowerTime.gameObject, slot4 > 0)
	end
end

function slot0.refreshTaskPos(slot0)
	recthelper.setAnchorY(slot0._goRight.transform, uv0.NormalTaskCount < TowerTaskModel.instance:getCount() and uv0.MoreTaskPosY or uv0.NormalTaskPosY)
end

function slot0.refreshLeftUI(slot0)
	slot1 = TowerTaskModel.instance:checkHasBossTask()

	gohelper.setActive(slot0._simageFullBG.gameObject, slot1)
	gohelper.setActive(slot0._goLeft, slot1)
	gohelper.setActive(slot0._goFullBg2, not slot1)
end

function slot0.refreshReddot(slot0)
	for slot4, slot5 in pairs(slot0.towerItemTab) do
		for slot9, slot10 in pairs(slot5) do
			gohelper.setActive(slot10.timeTowerUI.goNormalReddot, TowerTaskModel.instance:canShowReddot(slot4, slot9) and slot4 == TowerEnum.TowerType.Limited)
			gohelper.setActive(slot10.timeTowerUI.goSelectReddot, slot11 and slot4 == TowerEnum.TowerType.Limited)
			gohelper.setActive(slot10.bossTowerUI.goNormalReddot, slot11 and slot4 == TowerEnum.TowerType.Boss)
			gohelper.setActive(slot10.bossTowerUI.goSelectReddot, slot11 and slot4 == TowerEnum.TowerType.Boss)
		end
	end
end

function slot0._playGetRewardFinishAnim(slot0, slot1)
	if slot1 then
		slot0.removeIndexTab = {
			slot1
		}
	end

	TaskDispatcher.runDelay(slot0.delayPlayFinishAnim, slot0, uv0.TaskGetAnimTime)
end

function slot0.delayPlayFinishAnim(slot0)
	slot0._taskAnimRemoveItem:removeByIndexs(slot0.removeIndexTab)
end

function slot0.endEnterAnimBlock(slot0)
	UIBlockMgr.instance:endBlock(uv0.EnterViewAnimBlock)
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0.towerItemList) do
		slot5.btnClick:RemoveClickListener()
	end

	UIBlockMgr.instance:endBlock(uv0.EnterViewAnimBlock)
	TaskDispatcher.cancelTask(slot0.endEnterAnimBlock, slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayFinishAnim, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
