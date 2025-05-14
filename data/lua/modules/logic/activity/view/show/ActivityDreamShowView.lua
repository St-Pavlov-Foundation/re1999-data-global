module("modules.logic.activity.view.show.ActivityDreamShowView", package.seeall)

local var_0_0 = class("ActivityDreamShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_icon")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/time/#txt_time")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_desc")
	arg_1_0._txttask = gohelper.findChildText(arg_1_0.viewGO, "reward/rewardItem/#txt_task")
	arg_1_0._gorewardTask = gohelper.findChild(arg_1_0.viewGO, "reward/rewardItem/rewarditem")
	arg_1_0._simagerewardicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "reward/rewardItem/rewarditem/#simage_rewardicon")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "reward/rewardItem/rewarditem/#go_canget")
	arg_1_0._btnrewardicon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "reward/rewardItem/rewarditem/#btn_rewardIcon")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.viewGO, "reward/rewardItem/rewarditem/#go_finished")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrewardicon:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0.refreshTask, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0.onViewOpenedFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrewardicon:RemoveClickListener()
	arg_3_0._btnjump:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0.onViewOpenedFinish, arg_3_0)
end

var_0_0.ShowCount = 1
var_0_0.taskConfigId = 160002
var_0_0.unlimitDay = 42

function var_0_0._btncangetOnClick(arg_4_0)
	if arg_4_0._taskMo.hasFinished then
		TaskRpc.instance:sendFinishTaskRequest(arg_4_0._taskMo.id)
	else
		MaterialTipController.instance:showMaterialInfo(tonumber(arg_4_0._rewardCo[1]), tonumber(arg_4_0._rewardCo[2]))
	end
end

function var_0_0._btnjumpOnClick(arg_5_0)
	local var_5_0 = arg_5_0._config.jumpId

	if var_5_0 ~= 0 then
		local var_5_1 = JumpConfig.instance:getJumpConfig(var_5_0)

		if JumpController.instance:isJumpOpen(var_5_0) and JumpController.instance:canJumpNew(var_5_1.param) then
			GameFacade.jump(var_5_0, nil, arg_5_0)
		else
			GameFacade.showToast(ToastEnum.DreamShow)
		end
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_dream_bg"))
	arg_6_0._simageicon:LoadImage(ResUrl.getActivityBg("show/img_dream_lihui"))

	arg_6_0._rewardItems = arg_6_0:getUserDataTb_()

	gohelper.setActive(arg_6_0._gorewarditem, false)
	gohelper.setActive(arg_6_0._gorewardTask, false)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.parent

	gohelper.addChild(var_8_0, arg_8_0.viewGO)

	arg_8_0._actId = arg_8_0.viewParam.actId

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityShow
	})
	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0._config = ActivityConfig.instance:getActivityShowTaskList(arg_9_0._actId, 1)
	arg_9_0._txtdesc.text = arg_9_0._config.actDesc

	local var_9_0, var_9_1 = ActivityModel.instance:getRemainTime(arg_9_0._actId)

	arg_9_0._txttime.text = var_9_0 > var_0_0.unlimitDay and luaLang("activityshow_unlimittime") or string.format(luaLang("activityshow_remaintime"), var_9_0, var_9_1)

	local var_9_2 = string.split(arg_9_0._config.showBonus, "|")

	for iter_9_0 = 1, #var_9_2 do
		if not arg_9_0._rewardItems[iter_9_0] then
			local var_9_3 = arg_9_0:getUserDataTb_()

			var_9_3.go = gohelper.clone(arg_9_0._gorewarditem, arg_9_0._gorewardContent, "rewarditem" .. iter_9_0)
			var_9_3.item = IconMgr.instance:getCommonPropItemIcon(var_9_3.go)

			table.insert(arg_9_0._rewardItems, var_9_3)
		end

		gohelper.setActive(arg_9_0._rewardItems[iter_9_0].go, true)

		local var_9_4 = string.splitToNumber(var_9_2[iter_9_0], "#")

		arg_9_0._rewardItems[iter_9_0].item:setMOValue(var_9_4[1], var_9_4[2], var_9_4[3])
		arg_9_0._rewardItems[iter_9_0].item:isShowCount(var_9_4[4] == var_0_0.ShowCount)
		arg_9_0._rewardItems[iter_9_0].item:setCountFontSize(56)
		arg_9_0._rewardItems[iter_9_0].item:setHideLvAndBreakFlag(true)
		arg_9_0._rewardItems[iter_9_0].item:hideEquipLvAndBreak(true)
	end

	for iter_9_1 = #var_9_2 + 1, #arg_9_0._rewardItems do
		gohelper.setActive(arg_9_0._rewardItems[iter_9_1].go, false)
	end

	arg_9_0:refreshTask()
end

function var_0_0.refreshTask(arg_10_0)
	gohelper.setActive(arg_10_0._gorewardTask, true)

	local var_10_0 = TaskConfig.instance:getTaskActivityShowConfig(var_0_0.taskConfigId)

	arg_10_0._txttask.text = var_10_0.desc
	arg_10_0._rewardCo = string.splitToNumber(var_10_0.bonus, "#")

	local var_10_1, var_10_2 = ItemModel.instance:getItemConfigAndIcon(arg_10_0._rewardCo[1], arg_10_0._rewardCo[2], true)

	arg_10_0._simagerewardicon:LoadImage(var_10_2)

	arg_10_0._taskMo = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, var_10_0.activityId)[1]

	if arg_10_0._taskMo.finishCount >= arg_10_0._taskMo.config.maxFinishCount then
		gohelper.setActive(arg_10_0._gofinished, true)
		gohelper.setActive(arg_10_0._gocanget, false)
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._simagerewardicon.gameObject:GetComponent(gohelper.Type_Image), "#666666")
	elseif arg_10_0._taskMo.hasFinished then
		gohelper.setActive(arg_10_0._gofinished, false)
		gohelper.setActive(arg_10_0._gocanget, true)
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._simagerewardicon.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	else
		gohelper.setActive(arg_10_0._gofinished, false)
		gohelper.setActive(arg_10_0._gocanget, false)
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._simagerewardicon.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	end
end

function var_0_0.onViewOpenedFinish(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.DungeonView then
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView, true)
	end
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._closeAllView, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagebg:UnLoadImage()
	arg_13_0._simageicon:UnLoadImage()
end

return var_0_0
