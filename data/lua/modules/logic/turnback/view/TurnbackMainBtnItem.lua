module("modules.logic.turnback.view.TurnbackMainBtnItem", package.seeall)

local var_0_0 = class("TurnbackMainBtnItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.turnbackId = arg_1_2
	arg_1_0.go = gohelper.cloneInPlace(arg_1_1)

	gohelper.setActive(arg_1_0.go, true)

	arg_1_0._imgGo = gohelper.findChild(arg_1_0.go, "bg")
	arg_1_0._imgitem = gohelper.findChildImage(arg_1_0._imgGo, "")
	arg_1_0._btnitem = gohelper.getClick(arg_1_0._imgGo)

	arg_1_0:_initReddotitem(arg_1_0.go)

	arg_1_0._txttheme = gohelper.findChildText(arg_1_0.go, "txt_theme")
	arg_1_0._godeadline = gohelper.findChild(arg_1_0.go, "#go_deadline")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.go, "#go_deadline/#txt_time")
	arg_1_0._hasSetRefreshTime = false

	arg_1_0:addEvent()
	arg_1_0:_refreshItem()
end

function var_0_0.addEvent(arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEvent(arg_3_0)
	arg_3_0._btnitem:RemoveClickListener()
end

function var_0_0._onItemClick(arg_4_0)
	local var_4_0 = {
		turnbackId = arg_4_0.turnbackId
	}

	TurnbackController.instance:openTurnbackBeginnerView(var_4_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_activity_open)
end

function var_0_0._refreshItem(arg_5_0)
	local var_5_0 = ActivityModel.showActivityEffect()
	local var_5_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_5_2 = var_5_0 and var_5_1.mainViewActBtnPrefix .. "icon_4" or "icon_4"

	UISpriteSetMgr.instance:setMainSprite(arg_5_0._imgitem, var_5_2, true)

	if not var_5_0 then
		local var_5_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

		if var_5_3 then
			for iter_5_0, iter_5_1 in ipairs(var_5_3.mainViewActBtn) do
				local var_5_4 = gohelper.findChild(arg_5_0.go, iter_5_1)

				if var_5_4 then
					gohelper.setActive(var_5_4, var_5_0)
				end
			end
		end
	end

	if TurnbackModel.instance:getCurTurnbackMoWithNilError() then
		gohelper.setActive(arg_5_0._godeadline, true)
		arg_5_0:_refreshRemainTime()

		local var_5_5, var_5_6, var_5_7, var_5_8 = TurnbackModel.instance:getRemainTime()

		TaskDispatcher.runDelay(arg_5_0._delayUpdateView, arg_5_0, var_5_8)
	else
		gohelper.setActive(arg_5_0._godeadline, false)
	end

	arg_5_0._redDot:refreshDot()
end

function var_0_0._delayUpdateView(arg_6_0)
	arg_6_0:_refreshRemainTime()

	local var_6_0, var_6_1, var_6_2 = TurnbackModel.instance:getRemainTime()

	TaskDispatcher.cancelTask(arg_6_0._refreshRemainTime, arg_6_0)

	if var_6_0 <= 0 and var_6_1 <= 1 and var_6_2 <= 1 and not arg_6_0._hasSetRefreshTime then
		TaskDispatcher.runRepeat(arg_6_0._refreshRemainTime, arg_6_0, 2)

		arg_6_0._hasSetRefreshTime = true
	else
		TaskDispatcher.runRepeat(arg_6_0._refreshRemainTime, arg_6_0, TimeUtil.OneMinuteSecond)
	end
end

function var_0_0._refreshRemainTime(arg_7_0)
	local var_7_0, var_7_1, var_7_2, var_7_3 = TurnbackModel.instance:getRemainTime()

	if not TurnbackModel.instance:isInOpenTime() then
		TaskDispatcher.cancelTask(arg_7_0._refreshRemainTime, arg_7_0)
	end

	if var_7_0 == 0 and var_7_1 <= 1 and var_7_2 <= 1 and not arg_7_0._hasSetRefreshTime then
		TaskDispatcher.cancelTask(arg_7_0._refreshRemainTime, arg_7_0)
		TaskDispatcher.runRepeat(arg_7_0._refreshRemainTime, arg_7_0, 2)

		arg_7_0._hasSetRefreshTime = true
	end

	if var_7_0 >= 1 then
		arg_7_0._txttime.text = string.format("%d d", var_7_0)
	elseif var_7_0 == 0 and var_7_1 >= 1 then
		arg_7_0._txttime.text = string.format("%d h", var_7_1)
	elseif var_7_0 == 0 and var_7_1 < 1 and var_7_2 >= 1 then
		arg_7_0._txttime.text = string.format("%d m", var_7_2)
	elseif var_7_0 == 0 and var_7_1 < 1 and var_7_2 < 1 and var_7_3 >= 0 then
		arg_7_0._txttime.text = "<1m"
	elseif var_7_0 < 0 or not TurnbackModel.instance:isInOpenTime() then
		TaskDispatcher.cancelTask(arg_7_0._refreshRemainTime, arg_7_0)
	end

	TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshRemainTime)
end

function var_0_0.destroy(arg_8_0)
	arg_8_0:removeEvent()
	TaskDispatcher.cancelTask(arg_8_0._refreshRemainTime, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayUpdateView, arg_8_0)
	gohelper.destroy(arg_8_0.go)
	arg_8_0:__onDispose()
end

function var_0_0.isShowRedDot(arg_9_0)
	return arg_9_0._redDot.show
end

function var_0_0._initReddotitem(arg_10_0, arg_10_1)
	local var_10_0 = gohelper.findChild(arg_10_1, "go_activityreddot")

	arg_10_0._redDot = RedDotController.instance:addRedDot(var_10_0, RedDotEnum.DotNode.TurnbackEntre, nil, arg_10_0._checkCustomShowRedDotData, arg_10_0)

	do return end

	local var_10_1 = gohelper.findChild(arg_10_1, "go_activityreddot/#go_special_reds")
	local var_10_2 = var_10_1.transform
	local var_10_3 = var_10_2.childCount

	for iter_10_0 = 1, var_10_3 do
		local var_10_4 = var_10_2:GetChild(iter_10_0 - 1)

		gohelper.setActive(var_10_4.gameObject, false)
	end

	local var_10_5 = gohelper.findChild(var_10_1, "#go_turnback_red")

	arg_10_0._redDot = RedDotController.instance:addRedDotTag(var_10_5, RedDotEnum.DotNode.TurnbackEntre, false, arg_10_0._onRefreshDot, arg_10_0)
	arg_10_0._btnitem2 = gohelper.getClick(var_10_5)
end

function var_0_0._onRefreshDot(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:_checkIsShowRed(arg_11_1.dotId, 0)

	arg_11_1.show = var_11_0

	gohelper.setActive(arg_11_1.go, var_11_0)
	gohelper.setActive(arg_11_0._imgGo, not var_11_0)
end

function var_0_0._checkIsShowRed(arg_12_0, arg_12_1, arg_12_2)
	if RedDotModel.instance:isDotShow(arg_12_1, arg_12_2 or 0) then
		return true
	end

	local var_12_0 = TurnbackModel.instance:getCurTurnbackMo()

	if not var_12_0 then
		return false
	end

	if var_12_0:isAdditionInOpenTime() and TurnbackController.instance:checkIsShowCustomRedDot(TurnbackEnum.ActivityId.DungeonShowView) then
		return true
	end

	if TurnbackRecommendModel.instance:getCanShowRecommendCount() > 0 and TurnbackController.instance:checkIsShowCustomRedDot(TurnbackEnum.ActivityId.RecommendView) then
		return true
	end

	return false
end

function var_0_0._checkCustomShowRedDotData(arg_13_0, arg_13_1)
	arg_13_1:defaultRefreshDot()

	if not arg_13_1.show and not TurnbackModel.instance:isNewType() then
		if TurnbackModel.instance:getCurTurnbackMo() and TurnbackModel.instance:getCurTurnbackMo():isAdditionInOpenTime() then
			TurnbackController.instance:_checkCustomShowRedDotData(arg_13_1, TurnbackEnum.ActivityId.DungeonShowView)
		end

		if TurnbackModel.instance:getCurTurnbackMo() and TurnbackRecommendModel.instance:getCanShowRecommendCount() > 0 then
			TurnbackController.instance:_checkCustomShowRedDotData(arg_13_1, TurnbackEnum.ActivityId.RecommendView)
		end
	end
end

return var_0_0
