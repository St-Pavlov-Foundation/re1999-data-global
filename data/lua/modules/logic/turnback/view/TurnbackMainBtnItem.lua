module("modules.logic.turnback.view.TurnbackMainBtnItem", package.seeall)

local var_0_0 = class("TurnbackMainBtnItem", ActCenterItemBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.turnbackId = arg_1_2
	arg_1_0._hasSetRefreshTime = false

	var_0_0.super.init(arg_1_0, gohelper.cloneInPlace(arg_1_1))
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	arg_2_0:_initReddotitem()
	arg_2_0:_refreshItem()
end

function var_0_0.onClick(arg_3_0)
	local var_3_0 = {
		turnbackId = arg_3_0.turnbackId
	}

	TurnbackController.instance:openTurnbackBeginnerView(var_3_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_activity_open)
end

function var_0_0._refreshItem(arg_4_0)
	local var_4_0 = ActivityModel.showActivityEffect()
	local var_4_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_4_2 = var_4_0 and var_4_1.mainViewActBtnPrefix .. "icon_4" or "icon_4"

	UISpriteSetMgr.instance:setMainSprite(arg_4_0._imgitem, var_4_2, true)

	if not var_4_0 then
		local var_4_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

		if var_4_3 then
			for iter_4_0, iter_4_1 in ipairs(var_4_3.mainViewActBtn) do
				local var_4_4 = gohelper.findChild(arg_4_0.go, iter_4_1)

				if var_4_4 then
					gohelper.setActive(var_4_4, var_4_0)
				end
			end
		end
	end

	if TurnbackModel.instance:getCurTurnbackMoWithNilError() then
		gohelper.setActive(arg_4_0._godeadline, true)
		arg_4_0:_refreshRemainTime()

		local var_4_5, var_4_6, var_4_7, var_4_8 = TurnbackModel.instance:getRemainTime()

		TaskDispatcher.runDelay(arg_4_0._delayUpdateView, arg_4_0, var_4_8)
	else
		gohelper.setActive(arg_4_0._godeadline, false)
	end

	arg_4_0._redDot:refreshDot()
end

function var_0_0._delayUpdateView(arg_5_0)
	arg_5_0:_refreshRemainTime()

	local var_5_0, var_5_1, var_5_2 = TurnbackModel.instance:getRemainTime()

	TaskDispatcher.cancelTask(arg_5_0._refreshRemainTime, arg_5_0)

	if var_5_0 <= 0 and var_5_1 <= 1 and var_5_2 <= 1 and not arg_5_0._hasSetRefreshTime then
		TaskDispatcher.runRepeat(arg_5_0._refreshRemainTime, arg_5_0, 2)

		arg_5_0._hasSetRefreshTime = true
	else
		TaskDispatcher.runRepeat(arg_5_0._refreshRemainTime, arg_5_0, TimeUtil.OneMinuteSecond)
	end
end

function var_0_0._refreshRemainTime(arg_6_0)
	local var_6_0, var_6_1, var_6_2, var_6_3 = TurnbackModel.instance:getRemainTime()

	if not TurnbackModel.instance:isInOpenTime() then
		TaskDispatcher.cancelTask(arg_6_0._refreshRemainTime, arg_6_0)
	end

	if var_6_0 == 0 and var_6_1 <= 1 and var_6_2 <= 1 and not arg_6_0._hasSetRefreshTime then
		TaskDispatcher.cancelTask(arg_6_0._refreshRemainTime, arg_6_0)
		TaskDispatcher.runRepeat(arg_6_0._refreshRemainTime, arg_6_0, 2)

		arg_6_0._hasSetRefreshTime = true
	end

	if var_6_0 >= 1 then
		arg_6_0._txttime.text = string.format("%d d", var_6_0)
	elseif var_6_0 == 0 and var_6_1 >= 1 then
		arg_6_0._txttime.text = string.format("%d h", var_6_1)
	elseif var_6_0 == 0 and var_6_1 < 1 and var_6_2 >= 1 then
		arg_6_0._txttime.text = string.format("%d m", var_6_2)
	elseif var_6_0 == 0 and var_6_1 < 1 and var_6_2 < 1 and var_6_3 >= 0 then
		arg_6_0._txttime.text = "<1m"
	elseif var_6_0 < 0 or not TurnbackModel.instance:isInOpenTime() then
		TaskDispatcher.cancelTask(arg_6_0._refreshRemainTime, arg_6_0)
	end

	TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshRemainTime)
end

function var_0_0.onDestroyView(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._refreshRemainTime, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._delayUpdateView, arg_7_0)
	var_0_0.super.onDestroyView(arg_7_0)
end

function var_0_0.isShowRedDot(arg_8_0)
	return arg_8_0._redDot.show
end

function var_0_0._initReddotitem(arg_9_0)
	local var_9_0 = arg_9_0.go
	local var_9_1 = gohelper.findChild(var_9_0, "go_activityreddot")

	arg_9_0._redDot = RedDotController.instance:addRedDot(var_9_1, RedDotEnum.DotNode.TurnbackEntre, nil, arg_9_0._checkCustomShowRedDotData, arg_9_0)

	do return end

	local var_9_2 = gohelper.findChild(var_9_0, "go_activityreddot/#go_special_reds")
	local var_9_3 = var_9_2.transform
	local var_9_4 = var_9_3.childCount

	for iter_9_0 = 1, var_9_4 do
		local var_9_5 = var_9_3:GetChild(iter_9_0 - 1)

		gohelper.setActive(var_9_5.gameObject, false)
	end

	local var_9_6 = gohelper.findChild(var_9_2, "#go_turnback_red")

	arg_9_0._redDot = RedDotController.instance:addRedDotTag(var_9_6, RedDotEnum.DotNode.TurnbackEntre, false, arg_9_0._onRefreshDot, arg_9_0)
	arg_9_0._btnitem2 = gohelper.getClick(var_9_6)
end

function var_0_0._onRefreshDot(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:_checkIsShowRed(arg_10_1.dotId, 0)

	arg_10_1.show = var_10_0

	gohelper.setActive(arg_10_1.go, var_10_0)
	gohelper.setActive(arg_10_0._imgGo, not var_10_0)
end

function var_0_0._checkIsShowRed(arg_11_0, arg_11_1, arg_11_2)
	if RedDotModel.instance:isDotShow(arg_11_1, arg_11_2 or 0) then
		return true
	end

	local var_11_0 = TurnbackModel.instance:getCurTurnbackMo()

	if not var_11_0 then
		return false
	end

	if var_11_0:isAdditionInOpenTime() and TurnbackController.instance:checkIsShowCustomRedDot(TurnbackEnum.ActivityId.DungeonShowView) then
		return true
	end

	if TurnbackRecommendModel.instance:getCanShowRecommendCount() > 0 and TurnbackController.instance:checkIsShowCustomRedDot(TurnbackEnum.ActivityId.RecommendView) then
		return true
	end

	return false
end

function var_0_0._checkCustomShowRedDotData(arg_12_0, arg_12_1)
	arg_12_1:defaultRefreshDot()

	if not arg_12_1.show and not TurnbackModel.instance:isNewType() then
		if TurnbackModel.instance:getCurTurnbackMo() and TurnbackModel.instance:getCurTurnbackMo():isAdditionInOpenTime() then
			TurnbackController.instance:_checkCustomShowRedDotData(arg_12_1, TurnbackEnum.ActivityId.DungeonShowView)
		end

		if TurnbackModel.instance:getCurTurnbackMo() and TurnbackRecommendModel.instance:getCanShowRecommendCount() > 0 then
			TurnbackController.instance:_checkCustomShowRedDotData(arg_12_1, TurnbackEnum.ActivityId.RecommendView)
		end
	end
end

return var_0_0
