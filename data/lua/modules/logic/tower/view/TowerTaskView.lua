module("modules.logic.tower.view.TowerTaskView", package.seeall)

local var_0_0 = class("TowerTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._goFullBg2 = gohelper.findChild(arg_1_0.viewGO, "#simage_FullBG2")
	arg_1_0._goLeft = gohelper.findChild(arg_1_0.viewGO, "Left")
	arg_1_0._scrolltower = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_tower")
	arg_1_0._gotowerContent = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent")
	arg_1_0._gotowerItem = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent/#go_towerItem")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent/#go_timeTowerItem/normal/time/#txt_time")
	arg_1_0._goRight = gohelper.findChild(arg_1_0.viewGO, "Right")
	arg_1_0._scrolltaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#scroll_taskList")
	arg_1_0._gotaskContent = gohelper.findChild(arg_1_0.viewGO, "Right/#scroll_taskList/Viewport/#go_taskContent")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_tips")
	arg_1_0._gotimeTowerScore = gohelper.findChild(arg_1_0.viewGO, "Right/#go_tips/#go_timeTowerScore")
	arg_1_0._txttimeTowerScore = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_tips/#go_timeTowerScore/#txt_timeTowerScore")
	arg_1_0._txttimeTowerTime = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_tips/#go_timeTowerScore/layout/#txt_timeTowerTime")
	arg_1_0._gobossTowerTips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_tips/#go_bossTowerTips")
	arg_1_0._txtbossTowerTip = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_tips/#go_bossTowerTips/#txt_bossTowerTip")
	arg_1_0._txtbossTowerTime = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_tips/#go_bossTowerTips/layout/#txt_bossTowerTime")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, arg_2_0._playGetRewardFinishAnim, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_2_0.refreshTaskPos, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_2_0.InitTowerItemData, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_2_0.refreshLeftUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, arg_3_0._playGetRewardFinishAnim, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_3_0.refreshTaskPos, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_3_0.InitTowerItemData, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_3_0.refreshLeftUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.refreshUI, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshRemainTime, arg_3_0)
end

var_0_0.TaskMaskTime = 0.65
var_0_0.TaskGetAnimTime = 0.567
var_0_0.EnterViewAnimBlock = "playEnterTowerTaskViewAnim"
var_0_0.MoreTaskPosY = 14
var_0_0.NormalTaskPosY = -75
var_0_0.NormalTaskCount = 4

function var_0_0.onTowerItemClick(arg_4_0, arg_4_1)
	if arg_4_1.select then
		return
	end

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(arg_4_1.data.type, arg_4_1.data.towerId)
	arg_4_0:refreshSelectState()
	arg_4_0:refreshRemainTime()
	arg_4_0:refreshTaskPos()
	arg_4_0:refreshReddot()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_5_0.viewContainer.scrollView)

	arg_5_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_5_0._taskAnimRemoveItem:setMoveAnimationTime(var_0_0.TaskMaskTime - var_0_0.TaskGetAnimTime)

	arg_5_0.towerItemTab = arg_5_0:getUserDataTb_()
	arg_5_0.removeIndexTab = {}

	gohelper.setActive(arg_5_0._gotowerItem, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_task_entry)
	TaskDispatcher.runDelay(arg_7_0.endEnterAnimBlock, arg_7_0, 0.8)
	UIBlockMgr.instance:startBlock(var_0_0.EnterViewAnimBlock)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:InitTowerItemData()
	arg_8_0:refreshSelectState()
	arg_8_0:refreshRemainTime()
	arg_8_0:refreshTaskPos()
	arg_8_0:refreshLeftUI()
	arg_8_0:refreshReddot()
	TaskDispatcher.cancelTask(arg_8_0.refreshRemainTime, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0.refreshRemainTime, arg_8_0, 1)
end

function var_0_0.InitTowerItemData(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = TowerTaskModel.instance.limitTimeTaskList
	local var_9_2 = {}
	local var_9_3 = {}

	for iter_9_0 in pairs(TowerTaskModel.instance.bossTaskList) do
		table.insert(var_9_3, iter_9_0)
	end

	table.sort(var_9_3)

	for iter_9_1, iter_9_2 in ipairs(var_9_3) do
		table.insert(var_9_2, TowerTaskModel.instance.bossTaskList[iter_9_2])
	end

	local var_9_4 = arg_9_0:buildTowerItemData(var_9_1, TowerEnum.TowerType.Limited)

	if var_9_4 then
		table.insert(var_9_0, var_9_4)
	end

	for iter_9_3, iter_9_4 in ipairs(var_9_2) do
		local var_9_5 = arg_9_0:buildTowerItemData(iter_9_4, TowerEnum.TowerType.Boss)

		if var_9_5 then
			table.insert(var_9_0, var_9_5)
		end
	end

	arg_9_0:createOrRefreshTowerItem(var_9_0)
end

function var_0_0.buildTowerItemData(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	if not arg_10_1 or tabletool.len(arg_10_1) == 0 then
		return nil
	end

	var_10_0.taskList = arg_10_1
	var_10_0.taskCount = #arg_10_1
	var_10_0.finishCount = TowerTaskModel.instance:getTaskItemRewardCount(arg_10_1)
	var_10_0.type = arg_10_2

	if arg_10_2 == TowerEnum.TowerType.Limited then
		var_10_0.timeConfig = TowerConfig.instance:getTowerLimitedCoByTaskGroupId(arg_10_1[1].config.taskGroupId)
		var_10_0.towerId = var_10_0.timeConfig.season
	elseif arg_10_2 == TowerEnum.TowerType.Boss then
		var_10_0.timeConfig = TowerConfig.instance:getTowerBossTimeCoByTaskGroupId(arg_10_1[1].config.taskGroupId)
		var_10_0.towerId = var_10_0.timeConfig.towerId
	end

	var_10_0.towerOpenMo = TowerModel.instance:getTowerOpenInfo(arg_10_2, var_10_0.towerId, TowerEnum.TowerStatus.Open)

	return var_10_0
end

function var_0_0.createOrRefreshTowerItem(arg_11_0, arg_11_1)
	arg_11_0.towerItemList = arg_11_0:getUserDataTb_()

	local var_11_0 = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if not arg_11_0.towerItemTab[iter_11_1.type] then
			arg_11_0.towerItemTab[iter_11_1.type] = {}
		end

		if tabletool.len(arg_11_0.towerItemTab[iter_11_1.type]) > 0 then
			for iter_11_2, iter_11_3 in pairs(arg_11_0.towerItemTab[iter_11_1.type]) do
				local var_11_1 = iter_11_3.data
				local var_11_2 = false

				for iter_11_4, iter_11_5 in pairs(arg_11_1) do
					if iter_11_5.towerId == var_11_1.towerId and iter_11_5.type == var_11_1.type then
						var_11_2 = true
					end
				end

				if not var_11_2 then
					iter_11_3.btnClick:RemoveClickListener()
					gohelper.destroy(iter_11_3.go)

					arg_11_0.towerItemTab[iter_11_1.type][var_11_1.towerId] = nil
					var_11_0 = true
				end
			end

			if var_11_0 then
				TowerController.instance:selectDefaultTowerTask()
			end
		end

		local var_11_3 = arg_11_0.towerItemTab[iter_11_1.type][iter_11_1.towerId]

		if not var_11_3 then
			var_11_3 = arg_11_0:getUserDataTb_()
			var_11_3.go = gohelper.clone(arg_11_0._gotowerItem, arg_11_0._gotowerContent, string.format("tower%s_%s", iter_11_1.type, iter_11_1.towerId))
			var_11_3.goTimeTower = gohelper.findChild(var_11_3.go, "go_timeTowerItem")
			var_11_3.goBossTower = gohelper.findChild(var_11_3.go, "go_bossTowerItem")
			var_11_3.btnClick = gohelper.findChildButtonWithAudio(var_11_3.go, "btn_click")

			var_11_3.btnClick:AddClickListener(arg_11_0.onTowerItemClick, arg_11_0, var_11_3)

			var_11_3.timeTowerUI = arg_11_0:findTowerItemUI(var_11_3.goTimeTower)
			var_11_3.bossTowerUI = arg_11_0:findTowerItemUI(var_11_3.goBossTower)
			var_11_3.select = false
			var_11_3.data = iter_11_1
			arg_11_0.towerItemTab[iter_11_1.type][iter_11_1.towerId] = var_11_3

			gohelper.setAsLastSibling(var_11_3.go)
		end

		var_11_3.towerItemUI = iter_11_1.type == TowerEnum.TowerType.Boss and var_11_3.bossTowerUI or var_11_3.timeTowerUI

		arg_11_0:refreshTowerItem(var_11_3)
		table.insert(arg_11_0.towerItemList, var_11_3)
	end

	for iter_11_6, iter_11_7 in pairs(arg_11_0.towerItemList) do
		if iter_11_7.data.type == TowerEnum.TowerType.Limited then
			gohelper.setAsFirstSibling(iter_11_7.go)

			break
		end
	end

	for iter_11_8 = #arg_11_1 + 1, #arg_11_0.towerItemList do
		gohelper.setActive(arg_11_0.towerItemList[iter_11_8].go, false)
	end
end

function var_0_0.refreshTowerItem(arg_12_0, arg_12_1)
	local var_12_0 = TowerTaskModel.instance.curSelectTowerType
	local var_12_1 = TowerTaskModel.instance.curSelectToweId

	arg_12_1.select = var_12_0 == arg_12_1.data.type and var_12_1 == arg_12_1.data.towerId

	local var_12_2 = arg_12_1.data.type == TowerEnum.TowerType.Boss

	gohelper.setActive(arg_12_1.go, true)
	gohelper.setActive(arg_12_1.goTimeTower, not var_12_2)
	gohelper.setActive(arg_12_1.goBossTower, var_12_2)
	gohelper.setActive(arg_12_1.towerItemUI.normalGO, not arg_12_1.select)
	gohelper.setActive(arg_12_1.towerItemUI.selectGO, arg_12_1.select)
	gohelper.setActive(arg_12_1.towerItemUI.goNormalIconMask, var_12_2)
	gohelper.setActive(arg_12_1.towerItemUI.goSelectIconMask, var_12_2)
	gohelper.setActive(arg_12_1.towerItemUI.imageNormalIcon, not var_12_2)
	gohelper.setActive(arg_12_1.towerItemUI.imageSelectIcon, not var_12_2)

	if var_12_2 then
		local var_12_3 = TowerConfig.instance:getBossTowerConfig(arg_12_1.data.towerId)
		local var_12_4 = TowerConfig.instance:getAssistBossConfig(var_12_3.bossId)
		local var_12_5 = FightConfig.instance:getSkinCO(var_12_4.skinId)

		arg_12_1.towerItemUI.simageNormalIcon:LoadImage(ResUrl.monsterHeadIcon(var_12_5 and var_12_5.headIcon))
		arg_12_1.towerItemUI.simageSelectIcon:LoadImage(ResUrl.monsterHeadIcon(var_12_5 and var_12_5.headIcon))
	else
		UISpriteSetMgr.instance:setTowerSprite(arg_12_1.towerItemUI.imageNormalIcon, "tower_tasktimeicon_1")
		UISpriteSetMgr.instance:setTowerSprite(arg_12_1.towerItemUI.imageSelectIcon, "tower_tasktimeicon_1")
	end

	local var_12_6 = TowerConfig.instance:getBossTowerConfig(arg_12_1.data.towerId)

	arg_12_1.towerItemUI.txtNormalName.text = var_12_2 and var_12_6.name or luaLang("towertask_timelimited_name")
	arg_12_1.towerItemUI.txtSelectName.text = var_12_2 and var_12_6.name or luaLang("towertask_timelimited_name")
	arg_12_1.towerItemUI.txtNameEn.text = var_12_2 and var_12_6.nameEn or luaLang("towertask_timelimited_nameEn")

	local var_12_7 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.data.taskList) do
		local var_12_8 = {
			finishCount = arg_12_1.data.finishCount,
			taskMo = iter_12_1
		}

		table.insert(var_12_7, var_12_8)
	end

	gohelper.CreateObjList(arg_12_0, arg_12_0.taskProgressShow, var_12_7, arg_12_1.towerItemUI.goNormalPointContent, arg_12_1.towerItemUI.goNormalPointItem)
	gohelper.CreateObjList(arg_12_0, arg_12_0.taskProgressShow, var_12_7, arg_12_1.towerItemUI.goSelectPointContent, arg_12_1.towerItemUI.goSelectPointItem)
end

function var_0_0.findTowerItemUI(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.normalGO = gohelper.findChild(arg_13_1, "normal")
	var_13_0.selectGO = gohelper.findChild(arg_13_1, "select")
	var_13_0.imageNormalIcon = gohelper.findChildImage(var_13_0.normalGO, "image_icon")
	var_13_0.imageSelectIcon = gohelper.findChildImage(var_13_0.selectGO, "image_icon")
	var_13_0.goNormalIconMask = gohelper.findChild(var_13_0.normalGO, "Mask")
	var_13_0.goSelectIconMask = gohelper.findChild(var_13_0.selectGO, "Mask")
	var_13_0.simageNormalIcon = gohelper.findChildSingleImage(var_13_0.normalGO, "Mask/image_bossIcon")
	var_13_0.simageSelectIcon = gohelper.findChildSingleImage(var_13_0.selectGO, "Mask/image_bossIcon")
	var_13_0.txtNormalName = gohelper.findChildText(var_13_0.normalGO, "txt_name")
	var_13_0.txtSelectName = gohelper.findChildText(var_13_0.selectGO, "txt_name")
	var_13_0.goNormalPointContent = gohelper.findChild(var_13_0.normalGO, "go_pointContent")
	var_13_0.goSelectPointContent = gohelper.findChild(var_13_0.selectGO, "go_pointContent")
	var_13_0.goNormalPointItem = gohelper.findChild(var_13_0.goNormalPointContent, "go_pointItem")
	var_13_0.goSelectPointItem = gohelper.findChild(var_13_0.goSelectPointContent, "go_pointItem")
	var_13_0.goNormalReddot = gohelper.findChild(var_13_0.normalGO, "go_reddot")
	var_13_0.goSelectReddot = gohelper.findChild(var_13_0.selectGO, "go_reddot")
	var_13_0.txtTime = gohelper.findChildText(var_13_0.normalGO, "time/txt_time")
	var_13_0.txtNameEn = gohelper.findChildText(var_13_0.selectGO, "txt_en")

	return var_13_0
end

function var_0_0.taskProgressShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.findChild(arg_14_1, "go_light")
	local var_14_1 = arg_14_2.finishCount

	gohelper.setActive(var_14_0, arg_14_3 <= var_14_1)
end

function var_0_0.refreshSelectState(arg_15_0)
	local var_15_0 = TowerTaskModel.instance.curSelectTowerType
	local var_15_1 = TowerTaskModel.instance.curSelectToweId

	TowerTaskModel.instance:refreshList(var_15_0)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.towerItemList) do
		iter_15_1.select = var_15_0 == iter_15_1.data.type and var_15_1 == iter_15_1.data.towerId

		gohelper.setActive(iter_15_1.towerItemUI.normalGO, not iter_15_1.select)
		gohelper.setActive(iter_15_1.towerItemUI.selectGO, iter_15_1.select)
	end

	gohelper.setActive(arg_15_0._gobossTowerTips, var_15_0 == TowerEnum.TowerType.Boss)
	gohelper.setActive(arg_15_0._gotimeTowerScore, var_15_0 == TowerEnum.TowerType.Limited)

	local var_15_2 = TowerModel.instance:getTowerInfoById(var_15_0, var_15_1)

	if var_15_0 == TowerEnum.TowerType.Boss then
		local var_15_3 = TowerConfig.instance:getBossTowerConfig(var_15_1)
		local var_15_4 = TowerAssistBossModel.instance:getById(var_15_3.bossId)
		local var_15_5 = var_15_4 and var_15_4.level or 0
		local var_15_6 = TowerConfig.instance:getAssistBossMaxLev(var_15_3.bossId)

		arg_15_0._txtbossTowerTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerbossepisodepasscount"), var_15_5, var_15_6)
	elseif var_15_0 == TowerEnum.TowerType.Limited then
		local var_15_7 = TowerTimeLimitLevelModel.instance:getHistoryHighScore()

		arg_15_0._txttimeTowerScore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertask_currenthighscore"), {
			var_15_7
		})
	end
end

function var_0_0.refreshRemainTime(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.towerItemList) do
		local var_16_0 = iter_16_1.data.towerOpenMo
		local var_16_1 = var_16_0 and var_16_0.nextTime / 1000 - ServerTime.now() or 0

		gohelper.setActive(iter_16_1.towerItemUI.txtTime.gameObject, var_16_1 > 0)

		local var_16_2, var_16_3 = TimeUtil.secondToRoughTime2(var_16_1)

		iter_16_1.towerItemUI.txtTime.text = var_16_1 > 0 and string.format("%s%s", var_16_2, var_16_3) or ""
	end

	local var_16_4 = TowerTaskModel.instance.curSelectTowerType
	local var_16_5 = TowerTaskModel.instance.curSelectToweId
	local var_16_6 = TowerModel.instance:getTowerOpenInfo(var_16_4, var_16_5, TowerEnum.TowerStatus.Open)
	local var_16_7 = var_16_6 and var_16_6.nextTime / 1000 - ServerTime.now() or 0
	local var_16_8, var_16_9 = TimeUtil.secondToRoughTime2(var_16_7)

	if var_16_4 == TowerEnum.TowerType.Boss then
		arg_16_0._txtbossTowerTime.text = var_16_7 > 0 and string.format("%s%s", var_16_8, var_16_9) or ""

		gohelper.setActive(arg_16_0._txtbossTowerTime.gameObject, var_16_7 > 0)
	else
		arg_16_0._txttimeTowerTime.text = var_16_7 > 0 and string.format("%s%s", var_16_8, var_16_9) or ""

		gohelper.setActive(arg_16_0._txttimeTowerTime.gameObject, var_16_7 > 0)
	end
end

function var_0_0.refreshTaskPos(arg_17_0)
	local var_17_0 = TowerTaskModel.instance:getCount()

	recthelper.setAnchorY(arg_17_0._goRight.transform, var_17_0 > var_0_0.NormalTaskCount and var_0_0.MoreTaskPosY or var_0_0.NormalTaskPosY)
end

function var_0_0.refreshLeftUI(arg_18_0)
	local var_18_0 = TowerTaskModel.instance:checkHasBossTask()

	gohelper.setActive(arg_18_0._simageFullBG.gameObject, var_18_0)
	gohelper.setActive(arg_18_0._goLeft, var_18_0)
	gohelper.setActive(arg_18_0._goFullBg2, not var_18_0)
end

function var_0_0.refreshReddot(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.towerItemTab) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			local var_19_0 = TowerTaskModel.instance:canShowReddot(iter_19_0, iter_19_2)

			gohelper.setActive(iter_19_3.timeTowerUI.goNormalReddot, var_19_0 and iter_19_0 == TowerEnum.TowerType.Limited)
			gohelper.setActive(iter_19_3.timeTowerUI.goSelectReddot, var_19_0 and iter_19_0 == TowerEnum.TowerType.Limited)
			gohelper.setActive(iter_19_3.bossTowerUI.goNormalReddot, var_19_0 and iter_19_0 == TowerEnum.TowerType.Boss)
			gohelper.setActive(iter_19_3.bossTowerUI.goSelectReddot, var_19_0 and iter_19_0 == TowerEnum.TowerType.Boss)
		end
	end
end

function var_0_0._playGetRewardFinishAnim(arg_20_0, arg_20_1)
	if arg_20_1 then
		arg_20_0.removeIndexTab = {
			arg_20_1
		}
	end

	TaskDispatcher.runDelay(arg_20_0.delayPlayFinishAnim, arg_20_0, var_0_0.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_21_0)
	arg_21_0._taskAnimRemoveItem:removeByIndexs(arg_21_0.removeIndexTab)
end

function var_0_0.endEnterAnimBlock(arg_22_0)
	UIBlockMgr.instance:endBlock(var_0_0.EnterViewAnimBlock)
end

function var_0_0.onClose(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.towerItemList) do
		iter_23_1.btnClick:RemoveClickListener()
		iter_23_1.bossTowerUI.simageNormalIcon:UnLoadImage()
		iter_23_1.bossTowerUI.simageSelectIcon:UnLoadImage()
	end

	UIBlockMgr.instance:endBlock(var_0_0.EnterViewAnimBlock)
	TaskDispatcher.cancelTask(arg_23_0.endEnterAnimBlock, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.delayPlayFinishAnim, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
