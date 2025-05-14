module("modules.logic.explore.view.ExploreRewardView", package.seeall)

local var_0_0 = class("ExploreRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._btnbox = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_box")
	arg_1_0._txtprogress0 = gohelper.findChildTextMesh(arg_1_0.viewGO, "#btn_box/#txt_progress")
	arg_1_0._txtprogress1 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Top/title1/#txt_progress")
	arg_1_0._txtprogress2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Top/title2/#txt_progress")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbox:AddClickListener(arg_2_0.openBoxView, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.TaskUpdate, arg_2_0._onUpdateTaskList, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbox:RemoveClickListener()
	ExploreController.instance:unregisterCallback(ExploreEvent.TaskUpdate, arg_3_0._onUpdateTaskList, arg_3_0)
end

function var_0_0.openBoxView(arg_4_0)
	ViewMgr.instance:openView(ViewName.ExploreBonusRewardView, arg_4_0.viewParam)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	local var_6_0 = arg_6_0.viewParam
	local var_6_1, var_6_2, var_6_3, var_6_4, var_6_5, var_6_6 = ExploreSimpleModel.instance:getChapterCoinCount(var_6_0.id)
	local var_6_7

	var_6_7 = var_6_1 == var_6_4

	local var_6_8

	var_6_8 = var_6_2 == var_6_5

	local var_6_9

	var_6_9 = var_6_3 == var_6_6
	arg_6_0._txtprogress0.text = string.format("%d/%d", var_6_1, var_6_4)
	arg_6_0._txtprogress1.text = string.format("%d/%d", var_6_3, var_6_6)
	arg_6_0._txtprogress2.text = string.format("%d/%d", var_6_2, var_6_5)

	local var_6_10 = {}

	for iter_6_0 = 1, 2 do
		local var_6_11 = ExploreTaskModel.instance:getTaskList(3 - iter_6_0)
		local var_6_12 = ExploreConfig.instance:getTaskList(var_6_0.id, iter_6_0)

		for iter_6_1, iter_6_2 in pairs(var_6_12) do
			local var_6_13 = TaskModel.instance:getTaskById(iter_6_2.id)

			if var_6_13 and var_6_13.progress >= iter_6_2.maxProgress and var_6_13.finishCount == 0 then
				table.insert(var_6_10, iter_6_2.id)
			end
		end

		var_6_11:setList(var_6_12)
	end

	if #var_6_10 > 0 then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Explore, nil, var_6_10)
	end
end

function var_0_0._onUpdateTaskList(arg_7_0)
	return
end

function var_0_0._setitem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildImage(arg_8_1, "bottom/image_progresssilder")
	local var_8_1 = gohelper.findChildTextMesh(arg_8_1, "bottom/txt_point")
	local var_8_2 = gohelper.findChildImage(arg_8_1, "bottom/bg")
	local var_8_3 = gohelper.findChild(arg_8_1, "icons")
	local var_8_4 = gohelper.findChildButtonWithAudio(arg_8_1, "btn_click")
	local var_8_5 = GameUtil.splitString2(arg_8_2.bonus, true)

	var_8_1.text = arg_8_2.maxProgress

	local var_8_6 = TaskModel.instance:getTaskById(arg_8_2.id)
	local var_8_7 = var_8_6 and var_8_6.progress or 0
	local var_8_8 = var_8_6 and var_8_6.finishCount > 0 or false
	local var_8_9 = 1
	local var_8_10 = var_8_7 >= arg_8_2.maxProgress

	if var_8_10 then
		if arg_8_3 == #arg_8_0._taskList then
			var_8_9 = 1
		else
			local var_8_11 = TaskModel.instance:getTaskById(arg_8_0._taskList[arg_8_3 + 1].id)

			var_8_7 = var_8_11 and var_8_11.progress or var_8_7
			var_8_9 = Mathf.Clamp((var_8_7 - arg_8_2.maxProgress) / (arg_8_0._taskList[arg_8_3 + 1].maxProgress - arg_8_2.maxProgress), 0, 0.5) + 0.5
		end
	elseif arg_8_3 == 1 then
		var_8_9 = var_8_7 / arg_8_2.maxProgress * 0.5
	else
		var_8_9 = Mathf.Clamp((var_8_7 - arg_8_0._taskList[arg_8_3 - 1].maxProgress) / (arg_8_2.maxProgress - arg_8_0._taskList[arg_8_3 - 1].maxProgress), 0.5, 1) - 0.5
	end

	var_8_0.fillAmount = var_8_9

	ZProj.UGUIHelper.SetColorAlpha(var_8_2, var_8_10 and 1 or 0.15)
	SLFramework.UGUI.GuiHelper.SetColor(var_8_1, var_8_10 and "#000000" or "#d2c197")
	arg_8_0:addClickCb(var_8_4, arg_8_0._getReward, arg_8_0, arg_8_2)
	gohelper.setActive(var_8_4, not var_8_8 and var_8_10)

	arg_8_0._isGet = var_8_8

	gohelper.CreateObjList(arg_8_0, arg_8_0._setRewardItem, var_8_5, var_8_3, arg_8_0._gorewarditemicon)
end

function var_0_0._setRewardItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = gohelper.findChild(arg_9_1, "go_icon")
	local var_9_1 = gohelper.findChild(arg_9_1, "go_receive")
	local var_9_2 = IconMgr.instance:getCommonPropItemIcon(var_9_0)

	var_9_2:setMOValue(arg_9_2[1], arg_9_2[2], arg_9_2[3], nil, true)
	var_9_2:setCountFontSize(46)
	var_9_2:SetCountBgHeight(31)
	gohelper.setActive(var_9_1, arg_9_0._isGet)
end

function var_0_0._getReward(arg_10_0, arg_10_1)
	TaskRpc.instance:sendFinishTaskRequest(arg_10_1.id)
end

return var_0_0
