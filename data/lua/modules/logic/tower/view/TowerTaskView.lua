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
	arg_1_0._goactReward = gohelper.findChild(arg_1_0.viewGO, "Right/#go_actReward")
	arg_1_0._simageRewardIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_actReward/#simage_rewardicon")
	arg_1_0._btnShowRewardInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_actReward/#btn_showRewardInfo")
	arg_1_0._txtRewardCount = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_actReward/#txt_rewardCount")
	arg_1_0._txtactReward = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_actReward/#txt_actReward")
	arg_1_0._goactPointContent = gohelper.findChild(arg_1_0.viewGO, "Right/#go_actReward/#go_actPointContent")
	arg_1_0._goactPointItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_actReward/#go_actPointContent/#go_actPointItem")
	arg_1_0._btnactNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_actReward/#btn_actNormal")
	arg_1_0._btnCanget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_actReward/#btn_actCanget")
	arg_1_0._goactHasget = gohelper.findChild(arg_1_0.viewGO, "Right/#go_actReward/#go_actHasget")
	arg_1_0._animActReward = arg_1_0._goactReward:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, arg_2_0._playGetRewardFinishAnim, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_2_0.refreshTaskPos, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_2_0.InitTowerItemData, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_2_0.refreshLeftUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_2_0.refreshActReward, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, arg_2_0.refreshActReward, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.refreshUI, arg_2_0)
	arg_2_0._btnCanget:AddClickListener(arg_2_0._btnActCangetOnClick, arg_2_0)
	arg_2_0._btnactNormal:AddClickListener(arg_2_0._btnActNormalOnClick, arg_2_0)
	arg_2_0._btnShowRewardInfo:AddClickListener(arg_2_0._btnShowRewardInfoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, arg_3_0._playGetRewardFinishAnim, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_3_0.refreshTaskPos, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_3_0.InitTowerItemData, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_3_0.refreshLeftUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, arg_3_0.refreshActReward, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, arg_3_0.refreshActReward, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.refreshUI, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshRemainTime, arg_3_0)
	arg_3_0._btnCanget:RemoveClickListener()
	arg_3_0._btnactNormal:RemoveClickListener()
	arg_3_0._btnShowRewardInfo:RemoveClickListener()
end

var_0_0.TaskMaskTime = 0.65
var_0_0.TaskGetAnimTime = 0.567
var_0_0.EnterViewAnimBlock = "playEnterTowerTaskViewAnim"
var_0_0.MoreTaskPosY = 14
var_0_0.NormalTaskPosY = 14
var_0_0.NormalTaskCount = 4
var_0_0.NormalTaskScrollHeight = 1044
var_0_0.ActTaskScrollHeight = 860

function var_0_0.onTowerItemClick(arg_4_0, arg_4_1)
	if arg_4_1.select then
		return
	end

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(arg_4_1.data.type, arg_4_1.data.towerId)
	arg_4_0:refreshSelectState()
	arg_4_0:refreshRemainTime()
	arg_4_0:refreshTaskPos()
	arg_4_0:refreshReddot()
	arg_4_0:refreshActReward()
end

function var_0_0._btnActCangetOnClick(arg_5_0)
	local var_5_0 = arg_5_0.actRewardTaskMO.config.id

	TaskRpc.instance:sendFinishTaskRequest(var_5_0)
	arg_5_0._animActReward:Play(UIAnimationName.Finish, 0, 0)
end

function var_0_0._btnActNormalOnClick(arg_6_0)
	if not arg_6_0.actRewardTaskMO then
		return
	end

	GameFacade.showToast(ToastEnum.TowerTaskActRewardNormalClick, arg_6_0.actRewardTaskMO.config.desc)
end

function var_0_0._btnShowRewardInfoOnClick(arg_7_0)
	local var_7_0 = string.split(arg_7_0.actRewardTaskMO.config.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(var_7_0[1], var_7_0[2])
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_8_0.viewContainer.scrollView)

	arg_8_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_8_0._taskAnimRemoveItem:setMoveAnimationTime(var_0_0.TaskMaskTime - var_0_0.TaskGetAnimTime)

	arg_8_0.towerItemTab = arg_8_0:getUserDataTb_()
	arg_8_0.removeIndexTab = {}

	gohelper.setActive(arg_8_0._gotowerItem, false)

	arg_8_0.showActRewardEnter = true
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_task_entry)
	TaskDispatcher.runDelay(arg_10_0.endEnterAnimBlock, arg_10_0, 0.8)
	UIBlockMgr.instance:startBlock(var_0_0.EnterViewAnimBlock)
	arg_10_0:selectDefaultTaskCategory()
	arg_10_0:refreshUI()
	arg_10_0:saveLimitedActTaskNew()

	arg_10_0.showActRewardEnter = false
end

function var_0_0.selectDefaultTaskCategory(arg_11_0)
	local var_11_0 = arg_11_0.viewParam.towerType
	local var_11_1 = arg_11_0.viewParam.towerId

	if not var_11_0 or not var_11_1 then
		if #TowerTaskModel.instance.actTaskList > 0 then
			local var_11_2 = TowerTaskModel.instance.actTaskList[1].config.activityId
			local var_11_3 = ActivityModel.instance:getActivityInfo()[var_11_2]

			if var_11_3:isOpen() and not var_11_3:isExpired() then
				var_11_0 = TowerEnum.ActTaskType
				var_11_1 = var_11_2
			end
		else
			local var_11_4 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

			var_11_1, var_11_0 = var_11_4 and var_11_4.towerId or 1, TowerEnum.TowerType.Limited
		end
	end

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(var_11_0, var_11_1)

	arg_11_0.viewParam.towerType = nil
	arg_11_0.viewParam.towerId = nil
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:InitTowerItemData()
	arg_12_0:refreshSelectState()
	arg_12_0:refreshRemainTime()
	arg_12_0:refreshTaskPos()
	arg_12_0:refreshLeftUI()
	arg_12_0:refreshReddot()
	arg_12_0:refreshActReward()
	TaskDispatcher.cancelTask(arg_12_0.refreshRemainTime, arg_12_0)
	TaskDispatcher.runRepeat(arg_12_0.refreshRemainTime, arg_12_0, 1)
end

function var_0_0.saveLimitedActTaskNew(arg_13_0)
	local var_13_0 = TowerTaskModel.instance.actTaskList

	if #var_13_0 > 0 then
		TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewLimitedActTask, var_13_0[1].config.activityId)
	end
end

function var_0_0.InitTowerItemData(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = TowerTaskModel.instance.limitTimeTaskList
	local var_14_2 = TowerTaskModel.instance.actTaskList
	local var_14_3 = {}
	local var_14_4 = {}

	for iter_14_0 in pairs(TowerTaskModel.instance.bossTaskList) do
		table.insert(var_14_4, iter_14_0)
	end

	table.sort(var_14_4)

	for iter_14_1, iter_14_2 in ipairs(var_14_4) do
		table.insert(var_14_3, TowerTaskModel.instance.bossTaskList[iter_14_2])
	end

	local var_14_5 = arg_14_0:buildTowerItemData(var_14_1, TowerEnum.TowerType.Limited)

	if var_14_5 then
		table.insert(var_14_0, var_14_5)
	end

	for iter_14_3, iter_14_4 in ipairs(var_14_3) do
		local var_14_6 = arg_14_0:buildTowerItemData(iter_14_4, TowerEnum.TowerType.Boss)

		if var_14_6 then
			table.insert(var_14_0, var_14_6)
		end
	end

	local var_14_7 = arg_14_0:buildTowerItemData(var_14_2, TowerEnum.ActTaskType)

	if var_14_7 then
		table.insert(var_14_0, var_14_7)
	end

	arg_14_0:createOrRefreshTowerItem(var_14_0)
end

function var_0_0.buildTowerItemData(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	if not arg_15_1 or tabletool.len(arg_15_1) == 0 then
		return nil
	end

	var_15_0.taskList = arg_15_1
	var_15_0.taskCount = #arg_15_1
	var_15_0.finishCount = TowerTaskModel.instance:getTaskItemRewardCount(arg_15_1)
	var_15_0.type = arg_15_2

	if arg_15_2 == TowerEnum.TowerType.Limited then
		var_15_0.timeConfig = TowerConfig.instance:getTowerLimitedCoByTaskGroupId(arg_15_1[1].config.taskGroupId)
		var_15_0.towerId = var_15_0.timeConfig.season
	elseif arg_15_2 == TowerEnum.TowerType.Boss then
		var_15_0.timeConfig = TowerConfig.instance:getTowerBossTimeCoByTaskGroupId(arg_15_1[1].config.taskGroupId)
		var_15_0.towerId = var_15_0.timeConfig.towerId
	elseif arg_15_2 == TowerEnum.ActTaskType then
		var_15_0.towerId = arg_15_1[1].config.activityId
		var_15_0.timeConfig = arg_15_1[1].config
	end

	var_15_0.towerOpenMo = TowerModel.instance:getTowerOpenInfo(arg_15_2, var_15_0.towerId, TowerEnum.TowerStatus.Open)

	return var_15_0
end

function var_0_0.createOrRefreshTowerItem(arg_16_0, arg_16_1)
	arg_16_0.towerItemList = arg_16_0:getUserDataTb_()

	local var_16_0 = false

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if not arg_16_0.towerItemTab[iter_16_1.type] then
			arg_16_0.towerItemTab[iter_16_1.type] = {}
		end

		if tabletool.len(arg_16_0.towerItemTab[iter_16_1.type]) > 0 then
			for iter_16_2, iter_16_3 in pairs(arg_16_0.towerItemTab[iter_16_1.type]) do
				local var_16_1 = iter_16_3.data
				local var_16_2 = false

				for iter_16_4, iter_16_5 in pairs(arg_16_1) do
					if iter_16_5.towerId == var_16_1.towerId and iter_16_5.type == var_16_1.type then
						var_16_2 = true
					end
				end

				if not var_16_2 then
					iter_16_3.btnClick:RemoveClickListener()
					gohelper.destroy(iter_16_3.go)

					arg_16_0.towerItemTab[iter_16_1.type][var_16_1.towerId] = nil
					var_16_0 = true
				end
			end

			if var_16_0 then
				arg_16_0:selectDefaultTaskCategory()
			end
		end

		local var_16_3 = arg_16_0.towerItemTab[iter_16_1.type][iter_16_1.towerId]

		if not var_16_3 then
			var_16_3 = arg_16_0:getUserDataTb_()
			var_16_3.go = gohelper.clone(arg_16_0._gotowerItem, arg_16_0._gotowerContent, string.format("tower%s_%s", iter_16_1.type, iter_16_1.towerId))
			var_16_3.goTimeTower = gohelper.findChild(var_16_3.go, "go_timeTowerItem")
			var_16_3.goBossTower = gohelper.findChild(var_16_3.go, "go_bossTowerItem")
			var_16_3.goActTower = gohelper.findChild(var_16_3.go, "go_actTowerItem")
			var_16_3.btnClick = gohelper.findChildButtonWithAudio(var_16_3.go, "btn_click")

			var_16_3.btnClick:AddClickListener(arg_16_0.onTowerItemClick, arg_16_0, var_16_3)

			var_16_3.timeTowerUI = arg_16_0:findTowerItemUI(var_16_3.goTimeTower)
			var_16_3.bossTowerUI = arg_16_0:findTowerItemUI(var_16_3.goBossTower)
			var_16_3.actTowerUI = arg_16_0:findTowerItemUI(var_16_3.goActTower)
			var_16_3.select = false
			var_16_3.data = iter_16_1
			arg_16_0.towerItemTab[iter_16_1.type][iter_16_1.towerId] = var_16_3

			gohelper.setAsLastSibling(var_16_3.go)
		end

		if iter_16_1.type == TowerEnum.TowerType.Boss then
			var_16_3.towerItemUI = var_16_3.bossTowerUI
		elseif iter_16_1.type == TowerEnum.ActTaskType then
			var_16_3.towerItemUI = var_16_3.actTowerUI
		else
			var_16_3.towerItemUI = var_16_3.timeTowerUI
		end

		arg_16_0:refreshTowerItem(var_16_3)
		table.insert(arg_16_0.towerItemList, var_16_3)
	end

	for iter_16_6, iter_16_7 in pairs(arg_16_0.towerItemList) do
		if iter_16_7.data.type == TowerEnum.TowerType.Limited then
			gohelper.setAsFirstSibling(iter_16_7.go)

			break
		end
	end

	for iter_16_8, iter_16_9 in pairs(arg_16_0.towerItemList) do
		if iter_16_9.data.type == TowerEnum.ActTaskType then
			gohelper.setAsFirstSibling(iter_16_9.go)

			break
		end
	end

	for iter_16_10 = #arg_16_1 + 1, #arg_16_0.towerItemList do
		gohelper.setActive(arg_16_0.towerItemList[iter_16_10].go, false)
	end
end

function var_0_0.refreshTowerItem(arg_17_0, arg_17_1)
	local var_17_0 = TowerTaskModel.instance.curSelectTowerType
	local var_17_1 = TowerTaskModel.instance.curSelectToweId

	arg_17_1.select = var_17_0 == arg_17_1.data.type and var_17_1 == arg_17_1.data.towerId

	local var_17_2 = arg_17_1.data.type == TowerEnum.TowerType.Boss
	local var_17_3 = arg_17_1.data.type == TowerEnum.ActTaskType

	gohelper.setActive(arg_17_1.go, true)
	gohelper.setActive(arg_17_1.goTimeTower, not var_17_2 and not var_17_3)
	gohelper.setActive(arg_17_1.goBossTower, var_17_2)
	gohelper.setActive(arg_17_1.goActTower, var_17_3)
	gohelper.setActive(arg_17_1.towerItemUI.normalGO, not arg_17_1.select)
	gohelper.setActive(arg_17_1.towerItemUI.selectGO, arg_17_1.select)
	gohelper.setActive(arg_17_1.towerItemUI.goNormalIconMask, var_17_2)
	gohelper.setActive(arg_17_1.towerItemUI.goSelectIconMask, var_17_2)
	gohelper.setActive(arg_17_1.towerItemUI.imageNormalIcon, not var_17_2)
	gohelper.setActive(arg_17_1.towerItemUI.imageSelectIcon, not var_17_2)

	if var_17_2 then
		local var_17_4 = TowerConfig.instance:getBossTowerConfig(arg_17_1.data.towerId)
		local var_17_5 = TowerConfig.instance:getAssistBossConfig(var_17_4.bossId)
		local var_17_6 = FightConfig.instance:getSkinCO(var_17_5.skinId)

		arg_17_1.towerItemUI.simageNormalIcon:LoadImage(ResUrl.monsterHeadIcon(var_17_6 and var_17_6.headIcon))
		arg_17_1.towerItemUI.simageSelectIcon:LoadImage(ResUrl.monsterHeadIcon(var_17_6 and var_17_6.headIcon))
	else
		UISpriteSetMgr.instance:setTowerSprite(arg_17_1.towerItemUI.imageNormalIcon, var_17_3 and "tower_tasktimeicon_2" or "tower_tasktimeicon_1")
		UISpriteSetMgr.instance:setTowerSprite(arg_17_1.towerItemUI.imageSelectIcon, var_17_3 and "tower_tasktimeicon_2" or "tower_tasktimeicon_1")
	end

	local var_17_7 = TowerConfig.instance:getBossTowerConfig(arg_17_1.data.towerId)

	arg_17_1.towerItemUI.txtNormalName.text = var_17_2 and var_17_7.name or var_17_3 and luaLang("towertask_act_name") or luaLang("towertask_timelimited_name")
	arg_17_1.towerItemUI.txtSelectName.text = var_17_2 and var_17_7.name or var_17_3 and luaLang("towertask_act_name") or luaLang("towertask_timelimited_name")
	arg_17_1.towerItemUI.txtNameEn.text = var_17_2 and var_17_7.nameEn or var_17_3 and luaLang("towertask_act_nameEn") or luaLang("towertask_timelimited_nameEn")
	arg_17_1.towerItemUI.txtNormalTaskNum.text = string.format("%s/%s", arg_17_1.data.finishCount, #arg_17_1.data.taskList)
	arg_17_1.towerItemUI.txtSelectTaskNum.text = string.format("%s/%s", arg_17_1.data.finishCount, #arg_17_1.data.taskList)
end

function var_0_0.findTowerItemUI(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getUserDataTb_()

	var_18_0.normalGO = gohelper.findChild(arg_18_1, "normal")
	var_18_0.selectGO = gohelper.findChild(arg_18_1, "select")
	var_18_0.imageNormalIcon = gohelper.findChildImage(var_18_0.normalGO, "image_icon")
	var_18_0.imageSelectIcon = gohelper.findChildImage(var_18_0.selectGO, "image_icon")
	var_18_0.goNormalIconMask = gohelper.findChild(var_18_0.normalGO, "Mask")
	var_18_0.goSelectIconMask = gohelper.findChild(var_18_0.selectGO, "Mask")
	var_18_0.simageNormalIcon = gohelper.findChildSingleImage(var_18_0.normalGO, "Mask/image_bossIcon")
	var_18_0.simageSelectIcon = gohelper.findChildSingleImage(var_18_0.selectGO, "Mask/image_bossIcon")
	var_18_0.txtNormalName = gohelper.findChildText(var_18_0.normalGO, "txt_name")
	var_18_0.txtSelectName = gohelper.findChildText(var_18_0.selectGO, "txt_name")
	var_18_0.txtNormalTaskNum = gohelper.findChildText(var_18_0.normalGO, "txt_taskNum")
	var_18_0.txtSelectTaskNum = gohelper.findChildText(var_18_0.selectGO, "txt_taskNum")
	var_18_0.goNormalReddot = gohelper.findChild(var_18_0.normalGO, "go_reddot")
	var_18_0.goSelectReddot = gohelper.findChild(var_18_0.selectGO, "go_reddot")
	var_18_0.txtTime = gohelper.findChildText(var_18_0.normalGO, "time/txt_time")
	var_18_0.goSelectTime = gohelper.findChild(var_18_0.selectGO, "time")
	var_18_0.txtSelectTime = gohelper.findChildText(var_18_0.selectGO, "time/txt_time")
	var_18_0.txtNameEn = gohelper.findChildText(var_18_0.selectGO, "txt_en")

	return var_18_0
end

function var_0_0.taskProgressShow(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = gohelper.findChild(arg_19_1, "go_light")
	local var_19_1 = arg_19_2.finishCount

	gohelper.setActive(var_19_0, arg_19_3 <= var_19_1)
end

function var_0_0.refreshSelectState(arg_20_0)
	local var_20_0 = TowerTaskModel.instance.curSelectTowerType
	local var_20_1 = TowerTaskModel.instance.curSelectToweId

	TowerTaskModel.instance:refreshList(var_20_0)

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.towerItemList) do
		iter_20_1.select = var_20_0 == iter_20_1.data.type and var_20_1 == iter_20_1.data.towerId

		gohelper.setActive(iter_20_1.towerItemUI.normalGO, not iter_20_1.select)
		gohelper.setActive(iter_20_1.towerItemUI.selectGO, iter_20_1.select)
	end

	gohelper.setActive(arg_20_0._gobossTowerTips, var_20_0 == TowerEnum.TowerType.Boss)
	gohelper.setActive(arg_20_0._gotimeTowerScore, var_20_0 == TowerEnum.TowerType.Limited)

	local var_20_2 = TowerModel.instance:getTowerInfoById(var_20_0, var_20_1)

	if var_20_0 == TowerEnum.TowerType.Boss then
		local var_20_3 = TowerConfig.instance:getBossTowerConfig(var_20_1)
		local var_20_4 = TowerAssistBossModel.instance:getById(var_20_3.bossId)
		local var_20_5 = var_20_4 and var_20_4.level or 0
		local var_20_6 = TowerConfig.instance:getAssistBossMaxLev(var_20_3.bossId)

		arg_20_0._txtbossTowerTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerbossepisodepasscount"), var_20_5, var_20_6)
	elseif var_20_0 == TowerEnum.TowerType.Limited then
		local var_20_7 = TowerTimeLimitLevelModel.instance:getHistoryHighScore()
		local var_20_8 = TowerConfig.instance:getScoreToStarConfig(var_20_7)

		arg_20_0._txttimeTowerScore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertask_currenthighscore_level"), {
			var_20_8
		})
	end
end

function var_0_0.refreshRemainTime(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.towerItemList) do
		local var_21_0 = iter_21_1.data.towerOpenMo
		local var_21_1 = var_21_0 and var_21_0.taskEndTime / 1000 - ServerTime.now() or 0
		local var_21_2, var_21_3 = TimeUtil.secondToRoughTime2(var_21_1, true)

		gohelper.setActive(iter_21_1.towerItemUI.goSelectTime, iter_21_1.data.type == TowerEnum.ActTaskType)

		if iter_21_1.data.type == TowerEnum.ActTaskType then
			local var_21_4 = iter_21_1.data.timeConfig.activityId
			local var_21_5 = ActivityModel.instance:getActivityInfo()[var_21_4]

			if var_21_5 and var_21_5:isOpen() and not var_21_5:isExpired() then
				local var_21_6 = var_21_5:getRealEndTimeStamp() - ServerTime.now()
				local var_21_7 = TimeUtil.SecondToActivityTimeFormat(var_21_6, true)

				iter_21_1.towerItemUI.txtTime.text = var_21_6 > 0 and var_21_7 or ""
				iter_21_1.towerItemUI.txtSelectTime.text = var_21_6 > 0 and var_21_7 or ""

				gohelper.setActive(iter_21_1.towerItemUI.txtTime.gameObject, var_21_6 > 0)
			else
				iter_21_1.towerItemUI.txtTime.text = ""
				iter_21_1.towerItemUI.txtSelectTime.text = ""

				gohelper.setActive(iter_21_1.towerItemUI.txtTime.gameObject, false)
			end
		else
			iter_21_1.towerItemUI.txtTime.text = var_21_1 > 0 and string.format("%s%s", var_21_2, var_21_3) or ""
			iter_21_1.towerItemUI.txtSelectTime.text = var_21_1 > 0 and string.format("%s%s", var_21_2, var_21_3) or ""

			gohelper.setActive(iter_21_1.towerItemUI.txtTime.gameObject, var_21_1 > 0)
		end
	end

	local var_21_8 = TowerTaskModel.instance.curSelectTowerType
	local var_21_9 = TowerTaskModel.instance.curSelectToweId
	local var_21_10 = TowerModel.instance:getTowerOpenInfo(var_21_8, var_21_9, TowerEnum.TowerStatus.Open)
	local var_21_11 = var_21_10 and var_21_10.taskEndTime / 1000 - ServerTime.now() or 0
	local var_21_12, var_21_13 = TimeUtil.secondToRoughTime2(var_21_11, true)

	if var_21_8 == TowerEnum.TowerType.Boss then
		arg_21_0._txtbossTowerTime.text = var_21_11 > 0 and string.format("%s%s", var_21_12, var_21_13) or ""

		gohelper.setActive(arg_21_0._txtbossTowerTime.gameObject, var_21_11 > 0)
	elseif var_21_8 == TowerEnum.TowerType.Limited then
		arg_21_0._txttimeTowerTime.text = var_21_11 > 0 and string.format("%s%s", var_21_12, var_21_13) or ""

		gohelper.setActive(arg_21_0._txttimeTowerTime.gameObject, var_21_11 > 0)
	end
end

function var_0_0.refreshTaskPos(arg_22_0)
	arg_22_0._scrolltaskList.verticalNormalizedPosition = 1

	local var_22_0 = TowerTaskModel.instance:getCount()

	recthelper.setAnchorY(arg_22_0._goRight.transform, var_22_0 > var_0_0.NormalTaskCount and var_0_0.MoreTaskPosY or var_0_0.NormalTaskPosY)

	local var_22_1 = TowerTaskModel.instance.curSelectTowerType == TowerEnum.ActTaskType

	recthelper.setHeight(arg_22_0._scrolltaskList.gameObject.transform, var_22_1 and var_0_0.ActTaskScrollHeight or var_0_0.NormalTaskScrollHeight)
end

function var_0_0.refreshLeftUI(arg_23_0)
	local var_23_0 = TowerTaskModel.instance:checkHasBossTask()

	gohelper.setActive(arg_23_0._simageFullBG.gameObject, var_23_0)
	gohelper.setActive(arg_23_0._goLeft, var_23_0)
	gohelper.setActive(arg_23_0._goFullBg2, not var_23_0)
end

function var_0_0.refreshReddot(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.towerItemTab) do
		for iter_24_2, iter_24_3 in pairs(iter_24_1) do
			local var_24_0 = TowerTaskModel.instance:canShowReddot(iter_24_0, iter_24_2)

			gohelper.setActive(iter_24_3.timeTowerUI.goNormalReddot, var_24_0 and iter_24_0 == TowerEnum.TowerType.Limited)
			gohelper.setActive(iter_24_3.timeTowerUI.goSelectReddot, var_24_0 and iter_24_0 == TowerEnum.TowerType.Limited)
			gohelper.setActive(iter_24_3.bossTowerUI.goNormalReddot, var_24_0 and iter_24_0 == TowerEnum.TowerType.Boss)
			gohelper.setActive(iter_24_3.bossTowerUI.goSelectReddot, var_24_0 and iter_24_0 == TowerEnum.TowerType.Boss)
			gohelper.setActive(iter_24_3.actTowerUI.goNormalReddot, var_24_0 and iter_24_0 == TowerEnum.ActTaskType)
			gohelper.setActive(iter_24_3.actTowerUI.goSelectReddot, var_24_0 and iter_24_0 == TowerEnum.ActTaskType)
		end
	end
end

function var_0_0.refreshActReward(arg_25_0)
	local var_25_0 = TowerTaskModel.instance.curSelectTowerType == TowerEnum.ActTaskType

	arg_25_0.actRewardTaskMO = TowerTaskModel.instance:getActRewardTask()

	gohelper.setActive(arg_25_0._goactReward, var_25_0 and arg_25_0.actRewardTaskMO)

	if not var_25_0 or not arg_25_0.actRewardTaskMO then
		return
	end

	if arg_25_0.showActRewardEnter then
		arg_25_0._animActReward:Play(UIAnimationName.Open, 0, 0)
	else
		arg_25_0._animActReward:Play(UIAnimationName.Idle, 0, 0)
	end

	arg_25_0._txtactReward.text = arg_25_0.actRewardTaskMO.config.desc

	local var_25_1 = string.split(arg_25_0.actRewardTaskMO.config.bonus, "#")
	local var_25_2, var_25_3 = ItemModel.instance:getItemConfigAndIcon(var_25_1[1], var_25_1[2])

	arg_25_0._simageRewardIcon:LoadImage(var_25_3)

	arg_25_0._txtRewardCount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), var_25_1[3])

	local var_25_4 = {}

	for iter_25_0 = 1, arg_25_0.actRewardTaskMO.config.maxProgress do
		table.insert(var_25_4, iter_25_0 <= arg_25_0.actRewardTaskMO.progress and 1 or 0)
	end

	gohelper.setActive(arg_25_0._btnactNormal.gameObject, not TowerTaskModel.instance:isTaskFinished(arg_25_0.actRewardTaskMO) and not arg_25_0.actRewardTaskMO.hasFinished)
	gohelper.setActive(arg_25_0._btnCanget.gameObject, arg_25_0.actRewardTaskMO.hasFinished)
	gohelper.setActive(arg_25_0._goactHasget, TowerTaskModel.instance:isTaskFinished(arg_25_0.actRewardTaskMO) and not arg_25_0.actRewardTaskMO.hasFinished)
	gohelper.CreateObjList(arg_25_0, arg_25_0.taskRewardProgressShow, var_25_4, arg_25_0._goactPointContent, arg_25_0._goactPointItem)
end

function var_0_0.taskRewardProgressShow(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = gohelper.findChild(arg_26_1, "go_light")

	gohelper.setActive(var_26_0, arg_26_2 == 1)
end

function var_0_0._playGetRewardFinishAnim(arg_27_0, arg_27_1)
	if arg_27_1 then
		arg_27_0.removeIndexTab = {
			arg_27_1
		}
	end

	TaskDispatcher.runDelay(arg_27_0.delayPlayFinishAnim, arg_27_0, var_0_0.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_28_0)
	arg_28_0._taskAnimRemoveItem:removeByIndexs(arg_28_0.removeIndexTab)
end

function var_0_0.endEnterAnimBlock(arg_29_0)
	UIBlockMgr.instance:endBlock(var_0_0.EnterViewAnimBlock)
end

function var_0_0.onClose(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0.towerItemList) do
		iter_30_1.btnClick:RemoveClickListener()
		iter_30_1.bossTowerUI.simageNormalIcon:UnLoadImage()
		iter_30_1.bossTowerUI.simageSelectIcon:UnLoadImage()
	end

	UIBlockMgr.instance:endBlock(var_0_0.EnterViewAnimBlock)
	TaskDispatcher.cancelTask(arg_30_0.endEnterAnimBlock, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.delayPlayFinishAnim, arg_30_0)
	arg_30_0._simageRewardIcon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_31_0)
	return
end

return var_0_0
