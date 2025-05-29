module("modules.logic.activity.view.V2a6_WeekwalkHeart_PanelView", package.seeall)

local var_0_0 = class("V2a6_WeekwalkHeart_PanelView", Activity189BaseView)

var_0_0.SigninId = 530007
var_0_0.ConstItemId = 1261301

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Left/reward/btn_reward")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/rightbg/reward/btn")
	arg_1_0._goreceive = gohelper.findChild(arg_1_0.viewGO, "Root/Left/go_receive")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "Root/Left/go_receive/go_hasget")
	arg_1_0._animGet = arg_1_0._gohasget:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "Root/Left/go_canget")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/Top/#txt_LimitTime")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Top/#btn_close")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#btn_goto")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btngotoOnClick(arg_5_0)
	ActivityModel.instance:setTargetActivityCategoryId(arg_5_0:actId())
	ActivityController.instance:openActivityBeginnerView()
end

function var_0_0._btnrewardOnClick(arg_6_0)
	if arg_6_0.rewardMo.hasFinished and not (arg_6_0.rewardMo.finishCount > 0) then
		TaskRpc.instance:sendFinishTaskRequest(var_0_0.SigninId)
	end
end

function var_0_0._btnrightOnClick(arg_7_0)
	MaterialTipController.instance:showMaterialInfo(arg_7_0._itemCo[1], arg_7_0._itemCo[2])
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:_initTip()
end

function var_0_0._initTip(arg_9_0)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = gohelper.findChild(arg_9_0.viewGO, "Root/Left")
	var_9_0.isLike = false
	var_9_0.isUnLike = false
	var_9_0.golike = gohelper.findChild(var_9_0.go, "like")
	var_9_0.txtlike = gohelper.findChildText(var_9_0.golike, "num")
	var_9_0.likenum = math.random(50, 99)
	var_9_0.txtlike.text = var_9_0.likenum
	var_9_0.govxlike = gohelper.findChild(var_9_0.golike, "vx_like")
	var_9_0.golikeSelect = gohelper.findChild(var_9_0.golike, "go_selected")
	var_9_0.btnlikeclick = gohelper.findChildButton(var_9_0.golike, "#btn_click")

	local function var_9_1()
		if not var_9_0.isUnLike then
			if var_9_0.isLike then
				var_9_0.likenum = var_9_0.likenum - 1
			else
				var_9_0.likenum = var_9_0.likenum + 1
			end

			var_9_0.isLike = not var_9_0.isLike
		end

		gohelper.setActive(var_9_0.govxlike, var_9_0.isLike)
		gohelper.setActive(var_9_0.golikeSelect, var_9_0.isLike)

		var_9_0.txtlike.text = var_9_0.likenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end

	var_9_0.btnlikeclick:AddClickListener(var_9_1, arg_9_0, var_9_0)

	var_9_0.gounlike = gohelper.findChild(var_9_0.go, "unlike")
	var_9_0.txtunlike = gohelper.findChildText(var_9_0.gounlike, "num")
	var_9_0.unlikenum = math.random(50, 99)
	var_9_0.txtunlike.text = var_9_0.unlikenum
	var_9_0.govxunlike = gohelper.findChild(var_9_0.gounlike, "vx_unlike")
	var_9_0.gounlikeSelect = gohelper.findChild(var_9_0.gounlike, "go_selected")
	var_9_0.btnunlikeclick = gohelper.findChildButton(var_9_0.gounlike, "#btn_click")

	local function var_9_2()
		if not var_9_0.isLike then
			if var_9_0.isUnLike then
				var_9_0.unlikenum = var_9_0.unlikenum - 1
			else
				var_9_0.unlikenum = var_9_0.unlikenum + 1
			end

			var_9_0.isUnLike = not var_9_0.isUnLike
		end

		gohelper.setActive(var_9_0.govxunlike, var_9_0.isUnLike)
		gohelper.setActive(var_9_0.gounlikeSelect, var_9_0.isUnLike)

		var_9_0.txtunlike.text = var_9_0.unlikenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end

	var_9_0.btnunlikeclick:AddClickListener(var_9_2, arg_9_0, var_9_0)
	gohelper.setActive(var_9_0.govxlike, var_9_0.isLike)
	gohelper.setActive(var_9_0.golikeSelect, var_9_0.isLike)
	gohelper.setActive(var_9_0.govxunlike, var_9_0.isUnLike)
	gohelper.setActive(var_9_0.gounlikeSelect, var_9_0.isUnLike)

	arg_9_0._rewardItem = var_9_0
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0._onCloseViewFinish(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.CommonPropView then
		arg_13_0:_refresh()
		arg_13_0._animGet:Play("open")
	end
end

function var_0_0._refresh(arg_14_0)
	arg_14_0._txtLimitTime.text = arg_14_0:getRemainTimeStr()

	local var_14_0 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, arg_14_0:actId())

	if var_14_0 and #var_14_0 > 0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if iter_14_1.id == var_0_0.SigninId then
				arg_14_0.rewardMo = iter_14_1

				break
			end
		end
	end

	if arg_14_0.rewardMo.finishCount > 0 then
		gohelper.setActive(arg_14_0._gocanget, false)
		gohelper.setActive(arg_14_0._goreceive, true)
		gohelper.setActive(arg_14_0._btnreward.gameObject, false)
	elseif arg_14_0.rewardMo.hasFinished then
		gohelper.setActive(arg_14_0._gocanget, true)
		gohelper.setActive(arg_14_0._goreceive, false)
		gohelper.setActive(arg_14_0._btnreward.gameObject, true)
	else
		gohelper.setActive(arg_14_0._gocanget, false)
		gohelper.setActive(arg_14_0._goreceive, false)
		gohelper.setActive(arg_14_0._btnreward.gameObject, false)
	end
end

function var_0_0.onOpen(arg_15_0)
	local var_15_0 = Activity189Config.instance:getConstCoById(var_0_0.ConstItemId)

	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_04)

	arg_15_0._itemCo = string.split(var_15_0.numValue, "#")

	arg_15_0:_refresh()
end

function var_0_0.onClose(arg_16_0)
	arg_16_0._rewardItem.btnlikeclick:RemoveClickListener()
	arg_16_0._rewardItem.btnunlikeclick:RemoveClickListener()
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
