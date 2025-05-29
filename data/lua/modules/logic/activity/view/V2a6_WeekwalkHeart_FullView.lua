module("modules.logic.activity.view.V2a6_WeekwalkHeart_FullView", package.seeall)

local var_0_0 = class("V2a6_WeekwalkHeart_FullView", Activity189BaseView)

var_0_0.SignInState = {
	CanGet = 1,
	HasGet = 2,
	NotFinish = 0
}
var_0_0.ReadTaskId = 530008

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/Top/#txt_LimitTime")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#btn_goto")
	arg_1_0._rewardItemList = {}
	arg_1_0._tipItemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, arg_2_0._onFinishReadTask, arg_2_0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, arg_2_0._onGetReward, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._refresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngoto:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, arg_3_0._onFinishReadTask, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, arg_3_0._onGetReward, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._refresh, arg_3_0)
end

function var_0_0._btngotoOnClick(arg_4_0)
	GameFacade.jump(JumpEnum.JumpView.WeekWalk)
	arg_4_0:_trySendReadTask()
end

function var_0_0._onFinishReadTask(arg_5_0)
	arg_5_0:_updateRewardState()
end

function var_0_0._onGetReward(arg_6_0, arg_6_1)
	arg_6_0._taskId = arg_6_1
end

function var_0_0._onCloseViewFinish(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.CommonPropView then
		arg_7_0:_updateRewardState()
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:_initReward()
	arg_8_0:_initTipList()
end

function var_0_0._initReward(arg_9_0)
	local var_9_0 = Activity189Config.instance:getAllTaskList(arg_9_0:actId())

	for iter_9_0 = 1, 3 do
		local var_9_1 = arg_9_0:getUserDataTb_()

		var_9_1.co = var_9_0[iter_9_0]
		var_9_1.go = gohelper.findChild(arg_9_0.viewGO, "Root/Right/rightbg/taskitem" .. iter_9_0)
		var_9_1.txttask = gohelper.findChildText(var_9_1.go, "#txt_task")
		var_9_1.goreward = gohelper.findChild(var_9_1.go, "#go_rewarditem")
		var_9_1.gorewardicon = gohelper.findChild(var_9_1.goreward, "go_icon")
		var_9_1.gocanget = gohelper.findChild(var_9_1.goreward, "go_canget")
		var_9_1.goreceive = gohelper.findChild(var_9_1.goreward, "go_receive")
		var_9_1.gohasget = gohelper.findChild(var_9_1.goreward, "go_receive/go_hasget")
		var_9_1.btnclick = gohelper.findChildButton(var_9_1.goreward, "btnclick")
		var_9_1.animget = var_9_1.gohasget:GetComponent(typeof(UnityEngine.Animator))

		if var_9_1.co then
			local var_9_2 = string.splitToNumber(var_9_1.co.bonus, "#")
			local var_9_3 = var_9_2[1]
			local var_9_4 = var_9_2[2]
			local var_9_5 = var_9_2[3]

			var_9_1.txttask.text = var_9_1.co.desc
			var_9_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_9_1.gorewardicon)

			var_9_1.itemIcon:setMOValue(var_9_3, var_9_4, var_9_5, nil, true)

			if iter_9_0 ~= 2 then
				var_9_1.itemIcon:setItemIconScale(0.8)
			end

			var_9_1.itemIcon:setCountFontSize(36)

			local function var_9_6()
				TaskRpc.instance:sendFinishTaskRequest(var_9_1.co.id)
			end

			var_9_1.btnclick:AddClickListener(var_9_6, arg_9_0, var_9_1)
		end

		table.insert(arg_9_0._rewardItemList, var_9_1)
	end
end

function var_0_0._initTipList(arg_11_0)
	for iter_11_0 = 1, 3 do
		local var_11_0 = arg_11_0:getUserDataTb_()

		var_11_0.go = gohelper.findChild(arg_11_0.viewGO, "Root/Left/tips" .. iter_11_0 .. "/root")

		arg_11_0:_initTipItem(var_11_0)
	end

	local var_11_1 = arg_11_0:getUserDataTb_()

	var_11_1.go = gohelper.findChild(arg_11_0.viewGO, "Root/Right/rightbg/title")

	arg_11_0:_initTipItem(var_11_1)
end

function var_0_0._initTipItem(arg_12_0, arg_12_1)
	arg_12_1.isLike = false
	arg_12_1.isUnLike = false
	arg_12_1.golike = gohelper.findChild(arg_12_1.go, "like")
	arg_12_1.txtlike = gohelper.findChildText(arg_12_1.golike, "num")
	arg_12_1.likenum = math.random(50, 99)
	arg_12_1.txtlike.text = arg_12_1.likenum
	arg_12_1.govxlike = gohelper.findChild(arg_12_1.golike, "vx_like")
	arg_12_1.golikeSelect = gohelper.findChild(arg_12_1.golike, "go_selected")
	arg_12_1.btnlikeclick = gohelper.findChildButton(arg_12_1.golike, "#btn_click")

	local function var_12_0()
		if not arg_12_1.isUnLike then
			if arg_12_1.isLike then
				arg_12_1.likenum = arg_12_1.likenum - 1
			else
				arg_12_1.likenum = arg_12_1.likenum + 1
			end

			arg_12_1.isLike = not arg_12_1.isLike
		end

		gohelper.setActive(arg_12_1.govxlike, arg_12_1.isLike)
		gohelper.setActive(arg_12_1.golikeSelect, arg_12_1.isLike)

		arg_12_1.txtlike.text = arg_12_1.likenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end

	arg_12_1.btnlikeclick:AddClickListener(var_12_0, arg_12_0, arg_12_1)

	arg_12_1.gounlike = gohelper.findChild(arg_12_1.go, "unlike")
	arg_12_1.txtunlike = gohelper.findChildText(arg_12_1.gounlike, "num")
	arg_12_1.unlikenum = math.random(50, 99)
	arg_12_1.txtunlike.text = arg_12_1.unlikenum
	arg_12_1.govxunlike = gohelper.findChild(arg_12_1.gounlike, "vx_unlike")
	arg_12_1.gounlikeSelect = gohelper.findChild(arg_12_1.gounlike, "go_selected")
	arg_12_1.btnunlikeclick = gohelper.findChildButton(arg_12_1.gounlike, "#btn_click")

	local function var_12_1()
		if not arg_12_1.isLike then
			if arg_12_1.isUnLike then
				arg_12_1.unlikenum = arg_12_1.unlikenum - 1
			else
				arg_12_1.unlikenum = arg_12_1.unlikenum + 1
			end

			arg_12_1.isUnLike = not arg_12_1.isUnLike
		end

		gohelper.setActive(arg_12_1.govxunlike, arg_12_1.isUnLike)
		gohelper.setActive(arg_12_1.gounlikeSelect, arg_12_1.isUnLike)

		arg_12_1.txtunlike.text = arg_12_1.unlikenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end

	arg_12_1.btnunlikeclick:AddClickListener(var_12_1, arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_1.govxlike, arg_12_1.isLike)
	gohelper.setActive(arg_12_1.golikeSelect, arg_12_1.isLike)
	gohelper.setActive(arg_12_1.govxunlike, arg_12_1.isUnLike)
	gohelper.setActive(arg_12_1.gounlikeSelect, arg_12_1.isUnLike)
	table.insert(arg_12_0._tipItemList, arg_12_1)
end

function var_0_0._refresh(arg_15_0)
	arg_15_0:_updateRewardState()
end

function var_0_0._updateRewardState(arg_16_0)
	local var_16_0 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, arg_16_0:actId())

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		for iter_16_2, iter_16_3 in ipairs(arg_16_0._rewardItemList) do
			if iter_16_3.co.id == iter_16_1.id then
				iter_16_3.mo = iter_16_1

				if iter_16_1.finishCount > 0 then
					gohelper.setActive(iter_16_3.gocanget, false)
					gohelper.setActive(iter_16_3.goreceive, true)

					if arg_16_0._taskId == iter_16_1.id then
						iter_16_3.animget:Play("go_hasget_in")

						arg_16_0._taskId = nil
					end

					gohelper.setActive(iter_16_3.btnclick.gameObject, false)
				elseif iter_16_1.hasFinished then
					gohelper.setActive(iter_16_3.gocanget, true)
					gohelper.setActive(iter_16_3.goreceive, false)
					gohelper.setActive(iter_16_3.btnclick.gameObject, true)
				else
					gohelper.setActive(iter_16_3.goreceive, false)
					gohelper.setActive(iter_16_3.gocanget, false)
					gohelper.setActive(iter_16_3.btnclick.gameObject, false)
				end
			end
		end
	end
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0.onOpen(arg_18_0)
	local var_18_0 = arg_18_0.viewParam.parent

	gohelper.addChild(var_18_0, arg_18_0.viewGO)

	arg_18_0._txtLimitTime.text = arg_18_0:getRemainTimeStr()

	AudioMgr.instance:trigger(AudioEnum.AudioEnum2_6.WeekwalkHeart.play_ui_wenming_popup)
	Activity189Controller.instance:sendGetTaskInfoRequest(arg_18_0._refresh, arg_18_0)
end

function var_0_0._trySendReadTask(arg_19_0)
	local var_19_0 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, arg_19_0:actId())

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1.id == var_0_0.ReadTaskId and not iter_19_1.hasFinished and not (iter_19_1.finishCount > 0) then
			TaskRpc.instance:sendFinishReadTaskRequest(var_0_0.ReadTaskId)
		end
	end
end

function var_0_0.onClose(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._rewardItemList) do
		iter_20_1.btnclick:RemoveClickListener()
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0._tipItemList) do
		iter_20_3.btnlikeclick:RemoveClickListener()
		iter_20_3.btnunlikeclick:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_20_0._cb, arg_20_0)
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
