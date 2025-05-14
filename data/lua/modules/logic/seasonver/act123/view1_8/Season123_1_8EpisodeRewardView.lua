module("modules.logic.seasonver.act123.view1_8.Season123_1_8EpisodeRewardView", package.seeall)

local var_0_0 = class("Season123_1_8EpisodeRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goRwards = gohelper.findChild(arg_1_0.viewGO, "#go_rewards")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rewards/#btn_close")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rewards/#scroll_rewardview")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content")
	arg_1_0._gofillbg = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_fillbg")
	arg_1_0._gofill = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_fillbg/#go_fill")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_rewardContent")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_rewardContent/#go_rewarditem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Season123Controller.instance, Season123Event.OpenEpisodeRewardView, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Season123Controller.instance, Season123Event.OpenEpisodeRewardView, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:resetView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._rewardItems = arg_5_0:getUserDataTb_()
	arg_5_0._goContentHLayout = arg_5_0._goContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.actId = arg_6_0.viewParam.actId
	arg_6_0.stage = arg_6_0.viewParam.stage
	arg_6_0.targetNumList = {}
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) or {}

	Season123EpisodeRewardModel.instance:init(arg_7_0.actId, var_7_0)
	gohelper.setActive(arg_7_0._goRwards, true)
	Season123EpisodeRewardModel.instance:setTaskInfoList(arg_7_0.stage)

	arg_7_0.itemList = Season123EpisodeRewardModel.instance:getList()

	arg_7_0:initTargetNumList()

	local var_7_1 = Season123Model.instance:getActInfo(arg_7_0.actId):getStageMO(arg_7_0.stage)

	arg_7_0.stageMinRound = var_7_1.minRound
	arg_7_0.stageIsPass = var_7_1.isPass
	arg_7_0.defaultProgress = arg_7_0.targetNumList[1] + 5
	arg_7_0.curProgress = (arg_7_0.stageMinRound == 0 or not arg_7_0.stageIsPass) and arg_7_0.defaultProgress or arg_7_0.stageMinRound

	arg_7_0:createAndRefreshRewardItem()
	arg_7_0:refreshProgressBar()
	arg_7_0:refreshScrollPos()
end

function var_0_0.createAndRefreshRewardItem(arg_8_0)
	gohelper.CreateObjList(arg_8_0, arg_8_0.rewardItemShow, arg_8_0.itemList, arg_8_0._gorewardContent, arg_8_0._gorewardItem)
end

function var_0_0.rewardItemShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_1.name = "rewardItem" .. arg_9_3

	local var_9_0 = gohelper.findChildTextMesh(arg_9_1, "txt_score")
	local var_9_1 = gohelper.findChild(arg_9_1, "darkpoint")
	local var_9_2 = gohelper.findChild(arg_9_1, "lightpoint")
	local var_9_3 = gohelper.findChild(arg_9_1, "layout")
	local var_9_4 = gohelper.findChild(arg_9_1, "layout/go_reward")

	gohelper.setActive(var_9_4, false)

	local var_9_5 = string.split(arg_9_2.config.listenerParam, "#")

	var_9_0.text = var_9_5[2]

	local var_9_6 = tonumber(var_9_5[2])

	SLFramework.UGUI.GuiHelper.SetColor(var_9_0, var_9_6 >= arg_9_0.curProgress and "#E27F45" or "#9F9F9F")
	gohelper.setActive(var_9_1, var_9_6 < arg_9_0.curProgress)
	gohelper.setActive(var_9_2, var_9_6 >= arg_9_0.curProgress)

	local var_9_7 = arg_9_0._rewardItems[arg_9_3]
	local var_9_8 = GameUtil.splitString2(arg_9_2.config.bonus, true, "|", "#")

	if not var_9_7 then
		var_9_7 = {}

		for iter_9_0, iter_9_1 in ipairs(var_9_8) do
			local var_9_9 = {
				itemGO = gohelper.cloneInPlace(var_9_4, "item" .. tostring(arg_9_3))
			}

			var_9_9.goItemPos = gohelper.findChild(var_9_9.itemGO, "go_itempos")
			var_9_9.icon = IconMgr.instance:getCommonPropItemIcon(var_9_9.goItemPos)
			var_9_9.goHasGet = gohelper.findChild(var_9_9.itemGO, "go_hasget")
			var_9_9.goCanGet = gohelper.findChild(var_9_9.itemGO, "go_canget")
			var_9_9.btnCanGet = gohelper.findChildButtonWithAudio(var_9_9.itemGO, "go_canget")

			var_9_9.btnCanGet:AddClickListener(arg_9_0.onItemGetClick, arg_9_0)
			gohelper.setActive(var_9_9.itemGO, true)
			var_9_9.icon:setMOValue(iter_9_1[1], iter_9_1[2], iter_9_1[3])
			var_9_9.icon:setHideLvAndBreakFlag(true)
			var_9_9.icon:hideEquipLvAndBreak(true)
			var_9_9.icon:setCountFontSize(51)

			var_9_7[iter_9_0] = var_9_9
		end
	end

	arg_9_0._rewardItems[arg_9_3] = var_9_7

	for iter_9_2, iter_9_3 in pairs(var_9_7) do
		gohelper.setActive(iter_9_3.goHasGet, arg_9_2.finishCount >= arg_9_2.config.maxFinishCount)
		gohelper.setActive(iter_9_3.goCanGet, arg_9_2.progress >= arg_9_2.config.maxProgress and arg_9_2.hasFinished)
	end
end

function var_0_0.onItemGetClick(arg_10_0)
	local var_10_0 = Season123EpisodeRewardModel.instance:getCurStageCanGetReward()

	if #var_10_0 ~= 0 then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season123, 0, var_10_0, nil, nil, 0)
	end
end

function var_0_0.refreshProgressBar(arg_11_0)
	local var_11_0 = arg_11_0._goContentHLayout.padding.left + 98
	local var_11_1 = arg_11_0._goContentHLayout.padding.right + 102 - 20
	local var_11_2 = 40
	local var_11_3 = 236
	local var_11_4 = arg_11_0.defaultProgress
	local var_11_5 = 0
	local var_11_6 = 0
	local var_11_7 = 0
	local var_11_8 = 0
	local var_11_9 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.targetNumList) do
		if iter_11_1 >= arg_11_0.curProgress then
			var_11_5 = iter_11_0
			var_11_6 = iter_11_1
			var_11_7 = iter_11_1
		elseif var_11_6 <= var_11_7 then
			var_11_7 = iter_11_1
		end
	end

	if var_11_7 ~= var_11_6 then
		var_11_8 = (arg_11_0.curProgress - var_11_6) / (var_11_7 - var_11_6)
	end

	if var_11_5 == 0 then
		if var_11_4 <= arg_11_0.curProgress then
			var_11_9 = var_11_0 / 2
		else
			var_11_9 = var_11_0 / 2 + (var_11_4 - arg_11_0.curProgress) / (var_11_0 / 2)
		end
	else
		var_11_9 = var_11_0 + var_11_5 * var_11_2 + (var_11_5 - 1) * var_11_3 + var_11_8 * var_11_3
	end

	local var_11_10 = #arg_11_0.targetNumList

	arg_11_0.totalWidth = math.max(1287, var_11_0 + (var_11_10 - 1) * var_11_3 + var_11_10 * var_11_2 + var_11_1)

	if var_11_5 == var_11_10 then
		var_11_9 = arg_11_0.totalWidth
	end

	recthelper.setWidth(arg_11_0._gofill.transform, var_11_9)
end

function var_0_0.initTargetNumList(arg_12_0)
	if #arg_12_0.targetNumList == 0 then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.itemList) do
			local var_12_0 = tonumber(string.split(iter_12_1.config.listenerParam, "#")[2])

			table.insert(arg_12_0.targetNumList, var_12_0)
		end
	end
end

function var_0_0.refreshScrollPos(arg_13_0)
	local var_13_0 = 240
	local var_13_1 = 36
	local var_13_2 = arg_13_0:getCurCanGetIndex()
	local var_13_3 = recthelper.getWidth(arg_13_0._scrollreward.transform)

	if var_13_2 == nil or var_13_2 <= 0 then
		arg_13_0._scrollreward.horizontalNormalizedPosition = 1
	else
		local var_13_4 = math.max(0, (var_13_2 - 0.5) * (var_13_0 + var_13_1))

		arg_13_0._scrollreward.horizontalNormalizedPosition = Mathf.Clamp01(var_13_4 / (arg_13_0.totalWidth + 20 - var_13_3))
	end
end

function var_0_0.getCurCanGetIndex(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.itemList) do
		if iter_14_1.progress >= iter_14_1.config.maxProgress and iter_14_1.hasFinished or iter_14_1.finishCount < iter_14_1.config.maxFinishCount then
			return iter_14_0 - 1
		end
	end

	return nil
end

function var_0_0.resetView(arg_15_0)
	gohelper.setActive(arg_15_0._goRwards, false)
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._rewardItems) do
		for iter_17_2, iter_17_3 in pairs(iter_17_1) do
			iter_17_3.btnCanGet:RemoveClickListener()
		end
	end
end

return var_0_0
