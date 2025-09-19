module("modules.logic.activity.view.Activity101SignViewItemBase", package.seeall)

local var_0_0 = class("Activity101SignViewItemBase", ListScrollCellExtend)
local var_0_1 = 0.03
local var_0_2 = 0.25
local var_0_3 = false

function var_0_0._optimizePlayOpenAnim(arg_1_0)
	if arg_1_0:getScrollModel():getStartPinIndex() >= arg_1_0._index then
		var_0_3 = true
	end

	if var_0_3 then
		arg_1_0:playOpenAnim()
	end
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1

	if arg_2_0:isLimitedScrollViewItem() then
		arg_2_0:_optimizePlayOpenAnim()
	end

	arg_2_0:onRefresh()
	arg_2_0:_refresh_TomorrowTagGo()
end

function var_0_0._animCmp(arg_3_0)
	if not arg_3_0._anim then
		arg_3_0._anim = arg_3_0.viewGO:GetComponent(gohelper.Type_Animator)

		assert(arg_3_0._anim, "can not found anim component!!")
	end

	return arg_3_0._anim
end

function var_0_0.onDestroyView(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._playOpenInner, arg_4_0)

	var_0_3 = false
end

function var_0_0._onItemClick(arg_5_0)
	local var_5_0 = arg_5_0:actId()
	local var_5_1 = arg_5_0._index

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if not ActivityModel.instance:isActOnLine(var_5_0) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local var_5_2 = ActivityType101Model.instance:isType101RewardCouldGet(var_5_0, var_5_1)
	local var_5_3 = ActivityType101Model.instance:getType101LoginCount(var_5_0)

	if var_5_2 then
		Activity101Rpc.instance:sendGet101BonusRequest(var_5_0, var_5_1)
	end

	if var_5_3 < var_5_1 then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function var_0_0._playOpenInner(arg_6_0)
	arg_6_0:setActive(true)
	arg_6_0:_animCmp():Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.playOpenAnim(arg_7_0)
	local var_7_0 = arg_7_0._mo

	if var_7_0.__isPlayedOpenAnim then
		arg_7_0:_playIdle()

		return
	end

	var_7_0.__isPlayedOpenAnim = true

	local var_7_1 = arg_7_0._index
	local var_7_2

	if arg_7_0:isLimitedScrollViewItem() then
		local var_7_3 = arg_7_0:getScrollModel():getStartPinIndex()

		if var_7_1 < var_7_3 then
			arg_7_0:_playIdle()

			return
		end

		var_7_2 = math.max(0, var_7_1 - var_7_3 + 1) * var_0_1

		if var_7_2 > var_0_2 then
			var_7_2 = var_0_2

			arg_7_0:_playIdle()

			return
		end
	else
		var_7_2 = var_7_1 * var_0_1
	end

	arg_7_0:setActive(false)
	TaskDispatcher.runDelay(arg_7_0._playOpenInner, arg_7_0, var_7_2)
end

function var_0_0._playIdle(arg_8_0)
	arg_8_0:_animCmp():Play(UIAnimationName.Idle, 0, 1)
end

function var_0_0.setActive(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0.viewGO, arg_9_1)
end

function var_0_0.isLimitedScrollViewItem(arg_10_0)
	local var_10_0 = arg_10_0._view

	return type(var_10_0.getScrollModel) ~= "function"
end

function var_0_0.getScrollModel(arg_11_0)
	local var_11_0 = arg_11_0._view

	if arg_11_0:isLimitedScrollViewItem() then
		return var_11_0._model
	end

	if isDebugBuild then
		assert(type(var_11_0.getScrollModel == "function", "please override this function"))
	end

	return var_11_0:getScrollModel()
end

function var_0_0.getCsListScroll(arg_12_0)
	local var_12_0 = arg_12_0._view

	if arg_12_0:isLimitedScrollViewItem() then
		return var_12_0:getCsListScroll()
	end

	if isDebugBuild then
		assert(type(var_12_0.getCsListScroll == "function", "please override this function"))
	end

	return var_12_0:getCsListScroll()
end

function var_0_0._refreshRewardItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1:setMOValue(arg_13_2[1], arg_13_2[2], arg_13_2[3])
	arg_13_1:setCountFontSize(46)
	arg_13_1:setHideLvAndBreakFlag(true)
	arg_13_1:hideEquipLvAndBreak(true)
	arg_13_1:customOnClickCallback(function()
		local var_14_0 = arg_13_0:actId()
		local var_14_1 = arg_13_0._index

		if not ActivityModel.instance:isActOnLine(var_14_0) then
			GameFacade.showToast(ToastEnum.BattlePass)

			return
		end

		if ActivityType101Model.instance:isType101RewardCouldGet(var_14_0, var_14_1) then
			Activity101Rpc.instance:sendGet101BonusRequest(var_14_0, var_14_1)

			return
		end

		MaterialTipController.instance:showMaterialInfo(arg_13_2[1], arg_13_2[2])
	end)
end

function var_0_0._setActive_TomorrowTagGo(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0:_tomorrowTagGo(), arg_15_1)
end

function var_0_0._setActive_kelingquGo(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0:_kelingquGo(), arg_16_1)
end

local var_0_4 = 86400

function var_0_0._refresh_TomorrowTagGo(arg_17_0)
	local var_17_0 = arg_17_0:actId()
	local var_17_1 = arg_17_0._index == ActivityType101Model.instance:getType101LoginCount(var_17_0) + 1 and arg_17_0:getRemainTimeSec() >= var_0_4 or false

	arg_17_0:_setActive_TomorrowTagGo(var_17_1)
end

function var_0_0.actId(arg_18_0)
	return arg_18_0._mo.data[1]
end

function var_0_0.view(arg_19_0)
	return arg_19_0._view
end

function var_0_0.viewContainer(arg_20_0)
	return arg_20_0:view().viewContainer
end

function var_0_0.getRemainTimeSec(arg_21_0)
	local var_21_0 = arg_21_0:actId()

	return ActivityModel.instance:getRemainTimeSec(var_21_0) or 0
end

function var_0_0.onRefresh(arg_22_0)
	assert(false, "please override thid function")
end

function var_0_0._kelingquGo(arg_23_0)
	if not arg_23_0._kelinquGo then
		if arg_23_0._goSelectedBG then
			arg_23_0._kelinquGo = gohelper.findChild(arg_23_0._goSelectedBG, "kelinqu")
		else
			arg_23_0._kelinquGo = gohelper.findChild(arg_23_0.viewGO, "Root/#go_SelectedBG/kelinqu")
		end
	end

	return arg_23_0._kelinquGo
end

function var_0_0._tomorrowTagGo(arg_24_0)
	if not arg_24_0._goTomorrowTag then
		arg_24_0._goTomorrowTag = gohelper.findChild(arg_24_0.viewGO, "Root/#go_TomorrowTag")
	end

	return arg_24_0._goTomorrowTag
end

function var_0_0.setScrollparentGameObject(arg_25_0, arg_25_1)
	if gohelper.isNil(arg_25_1) then
		return
	end

	local var_25_0 = arg_25_1:GetComponent(gohelper.Type_LimitedScrollRect)

	assert(var_25_0, "must add csharp LimitedScrollRect component!!")

	local var_25_1 = arg_25_0:getCsListScroll()

	assert(var_25_1, "parent scroll must add csharp ListScrollView component!!")

	var_25_0.parentGameObject = var_25_1.gameObject
end

return var_0_0
