module("modules.logic.turnback.view.TurnbackCategoryItem", package.seeall)

local var_0_0 = class("TurnbackCategoryItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "beselected")
	arg_1_0._gounselect = gohelper.findChild(arg_1_1, "noselected")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_1, "beselected/activitynamecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_1, "beselected/activitynamecn/activitynameen")
	arg_1_0._txtunselectnamecn = gohelper.findChildText(arg_1_1, "noselected/noactivitynamecn")
	arg_1_0._txtunselectnameen = gohelper.findChildText(arg_1_1, "noselected/noactivitynamecn/noactivitynameen")
	arg_1_0._goreddot = gohelper.findChild(arg_1_1, "#go_reddot")
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0.go)
	arg_1_0._anim = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	arg_1_0._openAnimTime = 0.43

	arg_1_0:playEnterAnim()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._itemClick:RemoveClickListener()
end

function var_0_0._onItemClick(arg_4_0)
	if arg_4_0._selected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
	arg_4_0:_setLoginReddOtData(arg_4_0._mo.id)
	TurnbackModel.instance:setTargetCategoryId(arg_4_0._mo.id)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)
	arg_4_0:_refreshItem()
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:_refreshItem()

	if Time.realtimeSinceStartup - TurnbackBeginnerCategoryListModel.instance.openViewTime > arg_5_0._openAnimTime then
		arg_5_0._anim:Play(UIAnimationName.Idle, 0, 1)
	end
end

function var_0_0._refreshItem(arg_6_0)
	arg_6_0._selected = arg_6_0._mo.id == TurnbackModel.instance:getTargetCategoryId(arg_6_0.curTurnbackId)

	local var_6_0 = TurnbackConfig.instance:getTurnbackSubModuleCo(arg_6_0._mo.id)

	RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_0.reddotId, nil, arg_6_0._checkCustomShowRedDotData, arg_6_0)

	arg_6_0._txtnamecn.text = var_6_0.name
	arg_6_0._txtnameen.text = var_6_0.nameEn
	arg_6_0._txtunselectnamecn.text = var_6_0.name
	arg_6_0._txtunselectnameen.text = var_6_0.nameEn

	gohelper.setActive(arg_6_0._goselect, arg_6_0._selected)
	gohelper.setActive(arg_6_0._gounselect, not arg_6_0._selected)
end

function var_0_0._checkCustomShowRedDotData(arg_7_0, arg_7_1)
	TurnbackController.instance:_checkCustomShowRedDotData(arg_7_1, arg_7_0._mo.id)
end

function var_0_0._setLoginReddOtData(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.curTurnbackId .. "_" .. arg_8_1

	TimeUtil.setDayFirstLoginRed(var_8_0)
end

function var_0_0.playEnterAnim(arg_9_0)
	local var_9_0 = Mathf.Clamp01((Time.realtimeSinceStartup - TurnbackBeginnerCategoryListModel.instance.openViewTime) / arg_9_0._openAnimTime)

	arg_9_0._anim:Play(UIAnimationName.Open, 0, var_9_0)
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0
