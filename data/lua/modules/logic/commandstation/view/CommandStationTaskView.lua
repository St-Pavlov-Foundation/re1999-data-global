module("modules.logic.commandstation.view.CommandStationTaskView", package.seeall)

local var_0_0 = class("CommandStationTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/simage_title")
	arg_1_0._imageReward = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_reward")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_arrowLeft")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_arrowRight")
	arg_1_0._txtRewardDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/Dec/txt_tips2")
	arg_1_0._btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Dec/txt_tips2/#btn_detail")
	arg_1_0._btnNormalTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Top/#btn_normalTask")
	arg_1_0._goNormalTaskRed = gohelper.findChild(arg_1_0.viewGO, "Right/Top/#btn_normalTask/#go_reddot")
	arg_1_0._goNormalTaskSelect = gohelper.findChild(arg_1_0.viewGO, "Right/Top/#btn_normalTask/select")
	arg_1_0._btnCatchTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Top/#btn_catchTask")
	arg_1_0._goCatchTaskRed = gohelper.findChild(arg_1_0.viewGO, "Right/Top/#btn_catchTask/#go_reddot")
	arg_1_0._goCatchTaskSelect = gohelper.findChild(arg_1_0.viewGO, "Right/Top/#btn_catchTask/select")
	arg_1_0._goTime = gohelper.findChild(arg_1_0.viewGO, "Right/Top/#go_time")
	arg_1_0._txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/Top/#go_time/#txt_time")
	arg_1_0._txtCanGet = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/Top/#txt_canget")
	arg_1_0._simagePaperItemIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/Progress/#simage_reward")
	arg_1_0._txtprogress = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/Progress/#txt_progress")
	arg_1_0._rewardItem = gohelper.findChild(arg_1_0.viewGO, "Right/Progress/#scroll_view/Viewport/Content/#go_rewarditem")
	arg_1_0._slider = gohelper.findChildImage(arg_1_0.viewGO, "Right/Progress/#scroll_view/Viewport/Content/progressbg/fill")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Right/Progress/#scroll_view/Viewport/Content")
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnNormalTask:AddClickListener(arg_2_0._swtichTaskShow, arg_2_0, 1)
	arg_2_0._btnCatchTask:AddClickListener(arg_2_0._swtichTaskShow, arg_2_0, 2)
	arg_2_0._btnLeft:AddClickListener(arg_2_0.changeBigBonusIndex, arg_2_0, -1)
	arg_2_0._btnRight:AddClickListener(arg_2_0.changeBigBonusIndex, arg_2_0, 1)
	arg_2_0._btnDetail:AddClickListener(arg_2_0.showItemTips, arg_2_0)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnTaskUpdate, arg_2_0.refreshTask, arg_2_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_2_0._onGetTaskBonus, arg_2_0)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnBonusUpdate, arg_2_0.refreshBonus, arg_2_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_2_0.refreshBonus, arg_2_0)
	arg_2_0:addEventCb(CommandStationController.instance, CommandStationEvent.OnGetCommandPostInfo, arg_2_0._onOnGetCommandPostInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnNormalTask:RemoveClickListener()
	arg_3_0._btnCatchTask:RemoveClickListener()
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
	arg_3_0._btnDetail:RemoveClickListener()
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnTaskUpdate, arg_3_0.refreshTask, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, arg_3_0._onGetTaskBonus, arg_3_0)
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnBonusUpdate, arg_3_0.refreshBonus, arg_3_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_3_0.refreshBonus, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_mission_open)
	RedDotController.instance:addMultiRedDot(arg_4_0._goNormalTaskRed, {
		{
			id = RedDotEnum.DotNode.CommandStationTaskNormal
		},
		{
			uid = -1,
			id = RedDotEnum.DotNode.CommandStationTaskNormal
		}
	})
	RedDotController.instance:addMultiRedDot(arg_4_0._goCatchTaskRed, {
		{
			id = RedDotEnum.DotNode.CommandStationTaskCatch
		},
		{
			uid = -1,
			id = RedDotEnum.DotNode.CommandStationTaskCatch
		}
	})

	CommandStationTaskListModel.instance.curSelectType = 1
	arg_4_0._bonusCos, arg_4_0._bonusCountList = CommandStationConfig.instance:getTotalTaskRewards()
	arg_4_0._bigBonusCos = {}

	local var_4_0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._bonusCos) do
		if iter_4_1.isBig == 1 then
			table.insert(arg_4_0._bigBonusCos, iter_4_1)

			local var_4_1 = tabletool.indexOf(CommandStationModel.instance.gainBonus, iter_4_1.id)

			if not var_4_0 and not var_4_1 then
				var_4_0 = #arg_4_0._bigBonusCos
			end
		end
	end

	local var_4_2 = ItemConfig.instance:getItemIconById(CommandStationConfig.instance:getPaperItemId())

	arg_4_0._simagePaperItemIcon:LoadImage(ResUrl.getPropItemIcon(var_4_2))

	var_4_0 = var_4_0 or #arg_4_0._bigBonusCos
	arg_4_0._curBigBonusIndex = var_4_0

	arg_4_0:refreshTask()
	arg_4_0:refreshBonus()
	arg_4_0:refreshBigBonus()

	if arg_4_0:haveCatchTask() then
		local var_4_3 = ServerTime.getWeekEndTimeStamp(true) - ServerTime.now()

		TaskDispatcher.runDelay(arg_4_0._onGetTaskBonus, arg_4_0, var_4_3)
	end

	TaskDispatcher.runRepeat(arg_4_0._refreshTime, arg_4_0, 1, -1)
	arg_4_0:_refreshTime()
	TaskDispatcher.runDelay(arg_4_0._autoScrollNoGetBonus, arg_4_0, 0)
end

function var_0_0._autoScrollNoGetBonus(arg_5_0)
	local var_5_0 = 0

	for iter_5_0 = 1, #arg_5_0._bonusCos do
		if not tabletool.indexOf(CommandStationModel.instance.gainBonus, arg_5_0._bonusCos[iter_5_0].id) then
			break
		end

		var_5_0 = var_5_0 + arg_5_0._bonusCountList[iter_5_0] * 100 + 70
	end

	local var_5_1 = recthelper.getWidth(arg_5_0._goContent.transform.parent)
	local var_5_2 = recthelper.getWidth(arg_5_0._goContent.transform)
	local var_5_3 = Mathf.Clamp(var_5_0, 0, var_5_2 - var_5_1)

	recthelper.setAnchorX(arg_5_0._goContent.transform, -var_5_3)
end

function var_0_0.haveCatchTask(arg_6_0)
	return #CommandStationTaskListModel.instance.allCatchTaskMos > 0 and CommandStationModel.instance.catchNum > 0
end

function var_0_0.refreshTask(arg_7_0)
	CommandStationTaskListModel.instance:init()

	local var_7_0 = arg_7_0:haveCatchTask()

	gohelper.setActive(arg_7_0._btnCatchTask, var_7_0)

	local var_7_1 = CommandStationTaskListModel.instance.curSelectType == CommandStationEnum.TaskType.Catch

	arg_7_0:setTaskNewRed(var_7_1 and RedDotEnum.DotNode.CommandStationTaskCatch or RedDotEnum.DotNode.CommandStationTaskNormal, var_7_1 and PlayerPrefsKey.CommandStationTaskCatchOnce or PlayerPrefsKey.CommandStationTaskNormalOnce)
	gohelper.setActive(arg_7_0._goNormalTaskSelect, not var_7_1)
	gohelper.setActive(arg_7_0._goCatchTaskSelect, var_7_1)
	gohelper.setActive(arg_7_0._txtCanGet, var_7_1)

	if not var_7_0 and var_7_1 then
		arg_7_0:_swtichTaskShow(1)

		return
	end
end

function var_0_0.setTaskNewRed(arg_8_0, arg_8_1, arg_8_2)
	if not RedDotModel.instance:isDotShow(arg_8_1, -1) then
		return
	end

	local var_8_0 = CommandStationConfig.instance:getCurVersionId()

	GameUtil.playerPrefsSetNumberByUserId(arg_8_2 .. var_8_0, 0)
	RedDotRpc.instance:clientAddRedDotGroupList({
		{
			uid = -1,
			value = 0,
			id = arg_8_1
		}
	}, false)
end

function var_0_0._refreshTime(arg_9_0)
	local var_9_0 = 0
	local var_9_1 = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.VersionEndDt)

	if var_9_1 then
		var_9_0 = TimeUtil.stringToTimestamp(var_9_1.value2) + ServerTime.clientToServerOffset() - ServerTime.now()
	end

	local var_9_2 = math.max(0, var_9_0)

	arg_9_0._txtTime.text = TimeUtil.SecondToActivityTimeFormat(var_9_2)
end

function var_0_0._onOnGetCommandPostInfo(arg_10_0)
	arg_10_0:refreshBonus()
end

function var_0_0.refreshBonus(arg_11_0)
	local var_11_0 = CommandStationConfig.instance:getCurPaperCount()
	local var_11_1 = CommandStationConfig.instance:getCurTotalPaperCount()

	arg_11_0._txtCanGet.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("commandstation_paper_canget"), CommandStationModel.instance.catchNum)
	arg_11_0._txtprogress.text = string.format("<#DE9A2F>%d</color>/%d", var_11_0, var_11_1)

	local var_11_2 = 0
	local var_11_3 = 0
	local var_11_4 = false

	for iter_11_0 = 1, #arg_11_0._bonusCos do
		local var_11_5 = arg_11_0._bonusCos[iter_11_0]
		local var_11_6 = arg_11_0._bonusCos[iter_11_0 - 1]
		local var_11_7 = var_11_6 and var_11_6.pointNum or 0
		local var_11_8 = ((arg_11_0._bonusCountList[iter_11_0 - 1] and arg_11_0._bonusCountList[iter_11_0 - 1] * 100 + 70 or 0) + (arg_11_0._bonusCountList[iter_11_0] * 100 + 70)) / 2

		if var_11_0 >= var_11_5.pointNum then
			var_11_2 = var_11_2 + var_11_8
		elseif not var_11_4 then
			var_11_2 = var_11_2 + var_11_8 * (var_11_0 - var_11_7) / (var_11_5.pointNum - var_11_7)
			var_11_4 = true
		end

		var_11_3 = var_11_3 + var_11_8
	end

	arg_11_0._slider.fillAmount = var_11_2 / var_11_3

	CommandStationBonusListModel.instance:setData(arg_11_0._bonusCos, arg_11_0._bonusCountList)
end

function var_0_0._titleLoadCallback(arg_12_0)
	gohelper.findChildImage(arg_12_0.viewGO, "Left/simage_title"):SetNativeSize()
end

function var_0_0.refreshBigBonus(arg_13_0)
	local var_13_0 = arg_13_0._bigBonusCos[arg_13_0._curBigBonusIndex]

	if not var_13_0 then
		return
	end

	gohelper.setActive(arg_13_0._btnLeft, arg_13_0._curBigBonusIndex > 1)
	gohelper.setActive(arg_13_0._btnRight, arg_13_0._curBigBonusIndex < #arg_13_0._bigBonusCos)
	arg_13_0._imageTitle:LoadImage(string.format("singlebg_lang/txt_commandstation_singlebg/commandstation_task_title%s.png", arg_13_0._curBigBonusIndex), arg_13_0._titleLoadCallback, arg_13_0)
	arg_13_0._imageReward:LoadImage(string.format("singlebg/commandstation/task/commandstation_task_reward%s.png", arg_13_0._curBigBonusIndex))

	local var_13_1 = {}
	local var_13_2 = GameUtil.splitString2(var_13_0.bonus, true)

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		local var_13_3 = ItemConfig:getItemConfig(iter_13_1[1], iter_13_1[2])

		if var_13_3 then
			table.insert(var_13_1, var_13_3.name)
		end
	end

	arg_13_0._txtRewardDesc.text = table.concat(var_13_1, luaLang("commandstation_itemname_and"))
end

function var_0_0.changeBigBonusIndex(arg_14_0, arg_14_1)
	arg_14_0._curBigBonusIndex = Mathf.Clamp(arg_14_1 + arg_14_0._curBigBonusIndex, 1, #arg_14_0._bigBonusCos)

	if arg_14_1 > 0 then
		arg_14_0._anim:Play("switch_right", 0, 0)
	elseif arg_14_1 < 0 then
		arg_14_0._anim:Play("switch_left", 0, 0)
	end

	TaskDispatcher.runDelay(arg_14_0.refreshBigBonus, arg_14_0, 0.167)
	UIBlockHelper.instance:startBlock("CommandStationTaskView_switch", 0.167)
end

function var_0_0.showItemTips(arg_15_0)
	local var_15_0 = arg_15_0._bigBonusCos[arg_15_0._curBigBonusIndex]

	if not var_15_0 then
		return
	end

	local var_15_1 = GameUtil.splitString2(var_15_0.bonus, true)

	MaterialTipController.instance:showMaterialInfo(var_15_1[1][1], var_15_1[1][2])
end

function var_0_0._sendGetAllBonus(arg_16_0)
	CommandStationRpc.instance:sendCommandPostBonusAllRequest()
end

function var_0_0._swtichTaskShow(arg_17_0, arg_17_1)
	if arg_17_1 == CommandStationTaskListModel.instance.curSelectType then
		return
	end

	CommandStationTaskListModel.instance.curSelectType = arg_17_1

	arg_17_0:refreshTask()
	arg_17_0:_refreshTime()
end

function var_0_0._onGetTaskBonus(arg_18_0)
	CommandStationRpc.instance:sendGetCommandPostInfoRequest()
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.refreshBigBonus, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._refreshTime, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._onGetTaskBonus, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._autoScrollNoGetBonus, arg_19_0)
end

return var_0_0
