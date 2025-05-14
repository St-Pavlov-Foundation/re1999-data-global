module("modules.logic.task.view.TaskNoviceView", package.seeall)

local var_0_0 = class("TaskNoviceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#go_right")
	arg_1_0._gotaskitemcontent = gohelper.findChild(arg_1_0.viewGO, "#go_right/viewport/#go_taskitemcontent")
	arg_1_0._gogrowitemcontent = gohelper.findChild(arg_1_0.viewGO, "#go_right/viewport/#go_taskitemcontent/#go_growitemcontent")
	arg_1_0._gogrowtip = gohelper.findChild(arg_1_0.viewGO, "#go_right/viewport/#go_taskitemcontent/#go_growitemcontent/#go_growtip")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_left/#simage_leftbg")
	arg_1_0._simageren = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_left/#simage_ren")
	arg_1_0._btnshowdetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/title/#btn_showdetail")
	arg_1_0._gotex = gohelper.findChild(arg_1_0.viewGO, "#go_left/title/ani/tex")
	arg_1_0._gotexzh = gohelper.findChild(arg_1_0.viewGO, "#go_left/title/ani/tex_zh")
	arg_1_0._goactlist = gohelper.findChild(arg_1_0.viewGO, "#go_left/act/actlistscroll/Viewport/#go_actlist")
	arg_1_0._goactitem = gohelper.findChild(arg_1_0.viewGO, "#go_left/act/actlistscroll/Viewport/#go_actlist/#go_actitem")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "#go_left/#txt_stagename")
	arg_1_0._goflag = gohelper.findChild(arg_1_0.viewGO, "#go_left/curprogresslist/#go_flag")
	arg_1_0._txtcurprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_left/#txt_stagename/#txt_curprogress")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_left/rewardscroll/Viewport/#go_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_left/rewardscroll/Viewport/#go_rewards/#go_rewarditem")
	arg_1_0._golingqumax = gohelper.findChild(arg_1_0.viewGO, "#go_left/#lingqumax")
	arg_1_0._gohasreceive = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_hasreceive")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshowdetail:AddClickListener(arg_2_0._btnshowDetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshowdetail:RemoveClickListener()
end

function var_0_0._btnshowDetailOnClick(arg_4_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, 302303, false, nil, false)
end

function var_0_0._onUpdateTaskList(arg_5_0)
	local var_5_0 = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice)
	local var_5_1 = 0

	for iter_5_0 = 1, #var_5_0 do
		if var_5_0[iter_5_0].config.minTypeId == TaskEnum.TaskMinType.GrowBack then
			var_5_1 = var_5_1 + 1
		end
	end

	local var_5_2 = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	TaskModel.instance:setNoviceTaskCurStage(var_5_2)
	TaskDispatcher.runDelay(arg_5_0._onCheckRefreshNovice, arg_5_0, 0.2)
end

function var_0_0._onCheckRefreshNovice(arg_6_0)
	if TaskModel.instance:couldGetTaskNoviceStageReward() then
		return
	end

	arg_6_0:_refreshNovice()
end

function var_0_0._onPlayActState(arg_7_0, arg_7_1)
	if arg_7_1.taskType ~= TaskEnum.TaskType.Novice then
		return
	end

	if arg_7_1.force then
		arg_7_0:_refreshNovice()

		return
	end

	if arg_7_1.growCount then
		gohelper.setActive(arg_7_0._gogrowitemcontent, arg_7_1.growCount > 1)
		gohelper.setActive(arg_7_0._gogrowtip, arg_7_1.growCount > 1)
	end

	TaskDispatcher.cancelTask(arg_7_0._flagPlayUpdate, arg_7_0)

	if arg_7_1.num < 1 then
		return
	end

	local var_7_0 = TaskModel.instance:getNoviceTaskCurStage()
	local var_7_1 = TaskModel.instance:getNoviceTaskCurSelectStage()
	local var_7_2 = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	if var_7_0 < var_7_2 then
		return
	end

	if var_7_2 < var_7_1 then
		TaskModel.instance:setNoviceTaskCurStage(var_7_2)
		TaskModel.instance:setNoviceTaskCurSelectStage(var_7_2)
		arg_7_0:_refreshStageInfo()
		arg_7_0:_refreshActItem()
		arg_7_0:_refreshProgressItem()
	end

	local var_7_3 = TaskModel.instance:getCurStageActDotGetNum()
	local var_7_4 = TaskModel.instance:getCurStageMaxActDot()
	local var_7_5 = 0

	if var_7_4 < var_7_3 + arg_7_1.num then
		var_7_5 = var_7_3 + arg_7_1.num - var_7_4
	else
		var_7_5 = arg_7_1.num
	end

	arg_7_0._totalAct = var_7_3 + var_7_5

	if var_7_5 > 0 then
		arg_7_0._flagPlayCount = 0

		TaskDispatcher.runRepeat(arg_7_0._flagPlayUpdate, arg_7_0, 0.06, var_7_5)
	end
end

function var_0_0._flagPlayUpdate(arg_8_0)
	local var_8_0 = TaskModel.instance:getCurStageActDotGetNum()
	local var_8_1 = TaskModel.instance:getCurStageMaxActDot()

	arg_8_0._flagPlayCount = arg_8_0._flagPlayCount + 1

	gohelper.setActive(arg_8_0._noviceFlags[arg_8_0._flagPlayCount + var_8_0].go, true)
	arg_8_0._noviceFlags[arg_8_0._flagPlayCount + var_8_0].ani:Play("play")

	if arg_8_0._flagPlayCount + var_8_0 >= arg_8_0._totalAct then
		TaskDispatcher.cancelTask(arg_8_0._flagPlayUpdate, arg_8_0)

		for iter_8_0 = var_8_0, arg_8_0._totalAct - 1 do
			UISpriteSetMgr.instance:setCommonSprite(arg_8_0._noviceFlags[iter_8_0 + 1].img, "logo_huoyuedu")
		end
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._noviceTaskAni = arg_9_0._goleft:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._noviceReceiveAni = arg_9_0._gohasreceive:GetComponent(typeof(UnityEngine.Animator))

	arg_9_0._simageleftbg:LoadImage(ResUrl.getTaskBg("bg_yusijia"))
	arg_9_0._simageren:LoadImage(ResUrl.getTaskBg("bg_yusijiaren"))

	arg_9_0._taskItems = {}
	arg_9_0._actItems = {}
	arg_9_0._pointItems = {}
	arg_9_0._extraRewardItems = {}
	arg_9_0._initActPos = transformhelper.getLocalPos(arg_9_0._goactlist.transform)

	arg_9_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_9_0._onUpdateTaskList, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.RefreshActState, arg_9_0._onPlayActState, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_9_0._onGetBonus, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, arg_9_0._onShowTaskFinished, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_9_0._onFinishTask, arg_9_0)
	arg_9_0:addEventCb(TaskController.instance, TaskEvent.OnRefreshActItem, arg_9_0._onRefreshRewardActItem, arg_9_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_9_0._onCloseViewFinish, arg_9_0)

	local var_9_0 = LangSettings.instance:getCurLangShortcut()
	local var_9_1 = false

	if var_9_0 == "zh" or var_9_0 == "tw" then
		var_9_1 = true
	end

	gohelper.setActive(arg_9_0._gotex, not var_9_1)
	gohelper.setActive(arg_9_0._gotexzh, var_9_1)
end

function var_0_0._onRefreshRewardActItem(arg_10_0, arg_10_1)
	local var_10_0 = TaskModel.instance:getNoviceTaskCurSelectStage()
	local var_10_1 = TaskModel.instance:getNoviceTaskCurStage()
	local var_10_2 = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	if var_10_2 < var_10_0 then
		arg_10_0:_refreshStageInfo()
		arg_10_0:_refreshActItem()
		arg_10_0:_refreshProgressItem()
		TaskModel.instance:setNoviceTaskCurStage(var_10_2)

		if arg_10_1 and not arg_10_1.isFinishClick then
			TaskDispatcher.runDelay(arg_10_0._setNoviceTaskItem, arg_10_0, 0.5)

			return
		end
	end

	if not arg_10_1 or not arg_10_1.isActClick then
		if not TaskModel.instance:couldGetTaskNoviceStageReward() then
			TaskModel.instance:setNoviceTaskCurSelectStage(var_10_2)
			TaskModel.instance:setNoviceTaskCurStage(var_10_2)
		end

		arg_10_0:_refreshStageInfo()
		arg_10_0:_refreshActItem()
		arg_10_0:_refreshProgressItem()
		TaskModel.instance:setNoviceTaskCurSelectStage(var_10_2)
		TaskModel.instance:setNoviceTaskCurStage(var_10_2)

		if TaskModel.instance:couldGetTaskNoviceStageReward() then
			return
		end

		TaskDispatcher.runDelay(arg_10_0._setNoviceTaskItem, arg_10_0, 0.5)

		return
	end

	arg_10_0:_refreshStageInfo()
	arg_10_0:_refreshActItem()
	arg_10_0:_refreshProgressItem()
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0:_refreshNovice()
end

function var_0_0.onOpen(arg_12_0)
	TaskModel.instance:setHasTaskNoviceStageReward(false)

	local var_12_0 = TaskModel.instance:getRefreshCount()
	local var_12_1 = TaskView.getInitTaskType()

	if var_12_0 == 0 and var_12_1 ~= TaskEnum.TaskType.Novice then
		return
	end

	local var_12_2 = TaskModel.instance:getNoviceTaskCurStage()

	TaskModel.instance:setNoviceTaskCurSelectStage(var_12_2)

	if #arg_12_0._taskItems < 1 then
		arg_12_0:_refreshNovice()
	end
end

function var_0_0._onShowTaskFinished(arg_13_0, arg_13_1)
	if arg_13_1 == TaskEnum.TaskType.Novice then
		return
	end

	arg_13_0:_refreshNovice()
end

function var_0_0._onFinishTask(arg_14_0, arg_14_1)
	if not TaskConfig.instance:gettaskNoviceConfig(arg_14_1) then
		return
	end

	local var_14_0 = {}

	var_14_0.isFinishClick = true

	TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem, var_14_0)
end

function var_0_0._onCloseViewFinish(arg_15_0, arg_15_1)
	if arg_15_1 == ViewName.CommonPropView or arg_15_1 == ViewName.CharacterSkinGainView then
		local var_15_0 = PopupController.instance:getPopupCount()

		if TaskModel.instance:couldGetTaskNoviceStageReward() and var_15_0 == 0 then
			TaskDispatcher.runDelay(arg_15_0._onWaitShowGetStageReward, arg_15_0, 0.1)
		end
	end
end

function var_0_0._onWaitShowGetStageReward(arg_16_0)
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return
	end

	gohelper.setActive(arg_16_0._golingqumax, true)
	UIBlockMgr.instance:startBlock("taskstageani")
	TaskDispatcher.runDelay(arg_16_0._showStageReward, arg_16_0, 1.3)
end

function var_0_0._showStageReward(arg_17_0)
	UIBlockMgr.instance:endBlock("taskstageani")
	gohelper.setActive(arg_17_0._golingqumax, false)

	local var_17_0 = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	TaskModel.instance:setNoviceTaskCurSelectStage(var_17_0)

	local var_17_1 = {}
	local var_17_2 = var_17_0 == TaskModel.instance:getMaxStage(TaskEnum.TaskType.Novice)

	var_17_2 = var_17_2 and TaskModel.instance:getStageActDotGetNum(var_17_0) >= TaskModel.instance:getStageMaxActDot(var_17_0)

	local var_17_3 = var_17_2 and var_17_0 or var_17_0 - 1
	local var_17_4 = TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, var_17_3)
	local var_17_5 = string.split(var_17_4.bonus, "|")
	local var_17_6

	for iter_17_0, iter_17_1 in ipairs(var_17_5) do
		local var_17_7 = string.splitToNumber(iter_17_1, "#")

		if var_17_7[1] == MaterialEnum.MaterialType.PowerPotion then
			local var_17_8 = ItemPowerModel.instance:getLatestPowerChange()

			for iter_17_2, iter_17_3 in pairs(var_17_8) do
				if tonumber(iter_17_3.itemid) == tonumber(iter_17_1.materilId) then
					local var_17_9 = iter_17_3.uid
				end
			end
		end

		local var_17_10 = MaterialDataMO.New()

		var_17_10:initValue(var_17_7[1], var_17_7[2], var_17_7[3])

		if var_17_7[1] ~= MaterialEnum.MaterialType.Faith then
			table.insert(var_17_1, var_17_10)
		end
	end

	TaskModel.instance:setHasTaskNoviceStageReward(false)
	TaskDispatcher.runDelay(arg_17_0._onCheckRefreshNovice, arg_17_0, 0.2)

	local var_17_11 = TaskModel.instance:getTaskNoviceStageParam()

	if var_17_11 then
		TaskController.instance:getRewardByLine(MaterialEnum.GetApproach.NoviceStageReward, ViewName.CharacterSkinGainView, var_17_11)
		TaskModel.instance:setTaskNoviceStageHeroParam()
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_17_1)
end

function var_0_0._onGetBonus(arg_18_0)
	TaskDispatcher.runDelay(arg_18_0._onCheckRefreshNovice, arg_18_0, 0.1)
end

function var_0_0._refreshNovice(arg_19_0)
	local var_19_0 = TaskModel.instance:getRefreshCount() < 2

	arg_19_0._noviceTaskAni.enabled = var_19_0

	arg_19_0:_refreshStageInfo(var_19_0)
	arg_19_0:_refreshActItem(var_19_0)
	arg_19_0:_refreshProgressItem(var_19_0)
	arg_19_0:_setNoviceTaskItem(var_19_0)
end

function var_0_0._refreshStageInfo(arg_20_0, arg_20_1)
	local var_20_0 = TaskModel.instance:getNoviceTaskCurSelectStage()
	local var_20_1 = TaskModel.instance:getStageMaxActDot(var_20_0)
	local var_20_2 = TaskModel.instance:getNoviceTaskMaxUnlockStage()
	local var_20_3 = TaskModel.instance:getStageActDotGetNum(var_20_0)
	local var_20_4 = TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, var_20_0)
	local var_20_5 = TaskModel.instance:couldGetTaskNoviceStageReward()
	local var_20_6 = var_20_0 < var_20_2 and true or var_20_1 <= var_20_3

	var_20_6 = not var_20_5 and var_20_6

	if var_20_6 then
		gohelper.setActive(arg_20_0._gohasreceive, true)

		if arg_20_1 then
			arg_20_0._noviceReceiveAni:Play(UIAnimationName.Open)
		else
			arg_20_0._noviceReceiveAni:Play(UIAnimationName.Idle)
		end
	else
		gohelper.setActive(arg_20_0._gohasreceive, false)
	end

	arg_20_0._txtstagename.text = var_20_4.desc
	arg_20_0._extraRewardItems = arg_20_0._extraRewardItems or {}

	local var_20_7 = string.split(var_20_4.bonus, "|")

	for iter_20_0 = 1, #var_20_7 do
		local var_20_8 = arg_20_0._extraRewardItems[iter_20_0]

		if not var_20_8 then
			var_20_8 = {
				parentGo = gohelper.cloneInPlace(arg_20_0._gorewarditem)
			}
			var_20_8.itemGo = gohelper.findChild(var_20_8.parentGo, "rewarditem")
			var_20_8.canvasGroup = var_20_8.itemGo:GetComponent(typeof(UnityEngine.CanvasGroup))
			var_20_8.itemIcon = IconMgr.instance:getCommonItemIcon(var_20_8.itemGo)

			table.insert(arg_20_0._extraRewardItems, var_20_8)
		end

		gohelper.setActive(var_20_8.parentGo, true)

		local var_20_9 = string.splitToNumber(var_20_7[iter_20_0], "#")

		var_20_8.itemIcon:setMOValue(var_20_9[1], var_20_9[2], var_20_9[3], nil, true)
		var_20_8.itemIcon:isShowCount(var_20_9[1] ~= MaterialEnum.MaterialType.Hero)
		var_20_8.itemIcon:setCountFontSize(45)
		var_20_8.itemIcon:showStackableNum2()
		var_20_8.itemIcon:hideEquipLvAndCount()

		var_20_8.canvasGroup.alpha = var_20_6 and 0.7 or 1

		var_20_8.itemIcon:setItemColor(var_20_6 and "#3F3F3F" or nil)
	end

	for iter_20_1 = #var_20_7 + 1, #arg_20_0._extraRewardItems do
		local var_20_10 = arg_20_0._extraRewardItems[iter_20_1]

		gohelper.setActive(var_20_10.parentGo, false)
	end
end

function var_0_0._refreshActItem(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._actItems) do
		iter_21_1:destroy()
	end

	arg_21_0._actItems = {}

	local var_21_0 = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Novice)
	local var_21_1

	for iter_21_2 = 1, var_21_0 do
		local var_21_2 = gohelper.cloneInPlace(arg_21_0._goactitem)
		local var_21_3 = TaskNoviceActItem.New()

		var_21_3:init(var_21_2, iter_21_2)
		table.insert(arg_21_0._actItems, var_21_3)
	end

	if arg_21_0._actTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._actTweenId)
	end

	TaskDispatcher.runDelay(arg_21_0._showActItems, arg_21_0, 0.1)
end

function var_0_0._showActItems(arg_22_0)
	local var_22_0 = TaskModel.instance:getNoviceTaskCurSelectStage()
	local var_22_1 = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Novice)
	local var_22_2 = 0

	if var_22_0 >= var_22_1 - 1 then
		local var_22_3 = recthelper.getWidth(arg_22_0._actItems[1].go.transform)
		local var_22_4 = arg_22_0._goactlist:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
		local var_22_5 = var_22_4.spacing
		local var_22_6 = gohelper.findChild(arg_22_0.viewGO, "#go_left/act/actlistscroll")
		local var_22_7 = recthelper.getWidth(var_22_6.transform)

		var_22_2 = transformhelper.getLocalPos(arg_22_0._actItems[var_22_1 - 3].go.transform) - transformhelper.getLocalPos(arg_22_0._actItems[1].go.transform) + (4 * var_22_3 + 3 * var_22_4.spacing + var_22_4.padding.left - var_22_7)
	elseif var_22_0 > 1 then
		var_22_2 = transformhelper.getLocalPos(arg_22_0._actItems[var_22_0 - 1].go.transform) - transformhelper.getLocalPos(arg_22_0._actItems[1].go.transform)
	end

	if arg_22_0._hasEnterNovice then
		arg_22_0._actTweenId = ZProj.TweenHelper.DOLocalMoveX(arg_22_0._goactlist.transform, arg_22_0._initActPos - var_22_2, 0.5)
	else
		arg_22_0._hasEnterNovice = true

		transformhelper.setLocalPosXY(arg_22_0._goactlist.transform, arg_22_0._initActPos - var_22_2, 0)
	end
end

function var_0_0._refreshProgressItem(arg_23_0, arg_23_1)
	if arg_23_0._noviceFlags then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._noviceFlags) do
			gohelper.destroy(iter_23_1.go)
		end
	end

	arg_23_0._noviceFlags = arg_23_0:getUserDataTb_()

	local var_23_0 = TaskModel.instance:getNoviceTaskCurStage()
	local var_23_1 = TaskModel.instance:getNoviceTaskCurSelectStage()
	local var_23_2 = TaskModel.instance:getNoviceTaskMaxUnlockStage()
	local var_23_3 = TaskModel.instance:getStageMaxActDot(var_23_1)
	local var_23_4 = TaskModel.instance:getStageActDotGetNum(var_23_1)
	local var_23_5 = var_23_1 < var_23_2 and var_23_3 or var_23_4

	if var_23_2 < var_23_1 then
		var_23_4 = TaskModel.instance:getStageActDotGetNum(var_23_1)
		var_23_3 = TaskModel.instance:getStageMaxActDot(var_23_1)
		var_23_5 = 0
	end

	for iter_23_2 = 1, var_23_3 do
		local var_23_6 = gohelper.cloneInPlace(arg_23_0._goflag)

		gohelper.setActive(var_23_6, not arg_23_1)

		local var_23_7 = {
			go = var_23_6
		}

		var_23_7.idle = gohelper.findChild(var_23_7.go, "idle")

		gohelper.setActive(var_23_7.idle, true)

		var_23_7.img = gohelper.findChildImage(var_23_7.go, "idle")

		local var_23_8 = var_23_1 < var_23_2 and true or iter_23_2 <= var_23_4

		if var_23_2 < var_23_1 then
			var_23_8 = false
		end

		local var_23_9 = var_23_8 and "logo_huoyuedu" or "logo_huoyuedu_dis"

		UISpriteSetMgr.instance:setCommonSprite(var_23_7.img, var_23_9)

		var_23_7.play = gohelper.findChild(var_23_7.go, "play")

		gohelper.setActive(var_23_7.play, false)

		var_23_7.ani = var_23_7.go:GetComponent(typeof(UnityEngine.Animator))

		var_23_7.ani:Play(UIAnimationName.Idle)
		table.insert(arg_23_0._noviceFlags, var_23_7)
	end

	arg_23_0._txtcurprogress.text = string.format("%s/%s", var_23_5, var_23_3)

	if arg_23_1 then
		arg_23_0._flagopenCount = 0

		TaskDispatcher.cancelTask(arg_23_0._flagOpenUpdate, arg_23_0)
		TaskDispatcher.runRepeat(arg_23_0._flagOpenUpdate, arg_23_0, 0.03, var_23_3)
	end
end

function var_0_0._flagOpenUpdate(arg_24_0)
	arg_24_0._flagopenCount = arg_24_0._flagopenCount + 1

	gohelper.setActive(arg_24_0._noviceFlags[arg_24_0._flagopenCount].go, true)
	arg_24_0._noviceFlags[arg_24_0._flagopenCount].ani:Play(UIAnimationName.Open)
end

function var_0_0._setNoviceTaskItem(arg_25_0, arg_25_1)
	if arg_25_0._taskItems then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._taskItems) do
			if iter_25_1.go then
				iter_25_1:destroy()
			end
		end

		arg_25_0._taskItems = {}
	end

	gohelper.setActive(arg_25_0._gogrowitemcontent, false)

	local var_25_0 = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice)

	if arg_25_1 then
		UIBlockMgr.instance:startBlock("taskani")

		arg_25_0._repeatCount = 0

		TaskDispatcher.runRepeat(arg_25_0.showByLine, arg_25_0, 0.04, #var_25_0)
	else
		for iter_25_2 = 1, #var_25_0 do
			local var_25_1 = arg_25_0:getItem(var_25_0[iter_25_2], iter_25_2, false)

			table.insert(arg_25_0._taskItems, var_25_1)
		end
	end
end

function var_0_0.showByLine(arg_26_0)
	arg_26_0._repeatCount = arg_26_0._repeatCount + 1

	local var_26_0 = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice)
	local var_26_1 = arg_26_0:getItem(var_26_0[arg_26_0._repeatCount], arg_26_0._repeatCount, true)

	table.insert(arg_26_0._taskItems, var_26_1)

	if arg_26_0._repeatCount >= #var_26_0 then
		UIBlockMgr.instance:endBlock("taskani")
		TaskDispatcher.cancelTask(arg_26_0.showByLine, arg_26_0)
		TaskDispatcher.runDelay(arg_26_0._onStartTaskFinished, arg_26_0, 0.5)
	end
end

function var_0_0._onStartTaskFinished(arg_27_0)
	local var_27_0 = TaskModel.instance:getRefreshCount()

	TaskModel.instance:setRefreshCount(var_27_0 + 1)
	TaskController.instance:dispatchEvent(TaskEvent.OnShowTaskFinished, TaskEnum.TaskType.Novice)
end

function var_0_0.getItem(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = {}

	if arg_28_1.type == TaskEnum.TaskType.Novice and arg_28_1.config.chapter ~= 0 then
		local var_28_1 = arg_28_0.viewContainer:getSetting().otherRes[4]
		local var_28_2 = arg_28_0:getResInst(var_28_1, arg_28_0._gotaskitemcontent, "item" .. arg_28_2)

		var_28_0 = TaskListNoviceSpItem.New()

		gohelper.setSiblingBefore(var_28_2, arg_28_0._gogrowitemcontent)
		var_28_0:init(var_28_2, arg_28_2, arg_28_1, arg_28_3, arg_28_0._goright)
	elseif arg_28_1.config.minTypeId == TaskEnum.TaskMinType.GrowBack then
		gohelper.setActive(arg_28_0._gogrowitemcontent, true)
		gohelper.setActive(arg_28_0._gogrowtip, true)

		local var_28_3 = arg_28_0.viewContainer:getSetting().otherRes[3]
		local var_28_4 = arg_28_0:getResInst(var_28_3, arg_28_0._gogrowitemcontent, "item" .. arg_28_2)

		var_28_0 = TaskListNoviceGrowItem.New()

		var_28_0:init(var_28_4, arg_28_2, arg_28_1, arg_28_3, arg_28_0._goright)
	else
		local var_28_5 = arg_28_0.viewContainer:getSetting().otherRes[2]
		local var_28_6 = arg_28_0:getResInst(var_28_5, arg_28_0._gotaskitemcontent, "item" .. arg_28_2)

		var_28_0 = TaskListNoviceNormalItem.New()

		var_28_0:init(var_28_6, arg_28_2, arg_28_1, arg_28_3, arg_28_0._goright)
	end

	return var_28_0
end

function var_0_0.onClose(arg_29_0)
	return
end

function var_0_0.onDestroyView(arg_30_0)
	UIBlockMgr.instance:endBlock("taskstageani")
	TaskModel.instance:setNoviceTaskCurStage(0)

	if arg_30_0._extraRewardItems then
		for iter_30_0, iter_30_1 in pairs(arg_30_0._extraRewardItems) do
			gohelper.destroy(iter_30_1.itemIcon.go)
			gohelper.destroy(iter_30_1.parentGo)
			iter_30_1.itemIcon:onDestroy()
		end

		arg_30_0._extraRewardItems = nil
	end

	arg_30_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_30_0._onUpdateTaskList, arg_30_0)
	arg_30_0:removeEventCb(TaskController.instance, TaskEvent.RefreshActState, arg_30_0._onPlayActState, arg_30_0)
	arg_30_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_30_0._onGetBonus, arg_30_0)
	arg_30_0:removeEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, arg_30_0._onShowTaskFinished, arg_30_0)
	arg_30_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_30_0._onFinishTask, arg_30_0)
	arg_30_0:removeEventCb(TaskController.instance, TaskEvent.OnRefreshActItem, arg_30_0._onRefreshRewardActItem, arg_30_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_30_0._onCloseViewFinish, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._flagOpenUpdate, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._flagPlayUpdate, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._onCheckRefreshNovice, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._showStageReward, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._showActItems, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._setNoviceTaskItem, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._onWaitShowGetStageReward, arg_30_0)
	arg_30_0._simageleftbg:UnLoadImage()
	arg_30_0._simageren:UnLoadImage()

	if arg_30_0._actTweenId then
		ZProj.TweenHelper.KillById(arg_30_0._actTweenId)

		arg_30_0._actTweenId = nil
	end

	if arg_30_0._taskItems then
		for iter_30_2, iter_30_3 in ipairs(arg_30_0._taskItems) do
			if iter_30_3.go then
				iter_30_3:destroy()
			end
		end

		arg_30_0._taskItems = nil
	end

	if arg_30_0._actItems then
		for iter_30_4, iter_30_5 in pairs(arg_30_0._actItems) do
			iter_30_5:destroy()
		end

		arg_30_0._actItems = nil
	end

	if arg_30_0._pointItems then
		for iter_30_6, iter_30_7 in pairs(arg_30_0._pointItems) do
			iter_30_7:destroy()
		end

		arg_30_0._pointItems = nil
	end
end

return var_0_0
