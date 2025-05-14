module("modules.logic.activity.view.Activity101SignViewBase", package.seeall)

local var_0_0 = class("Activity101SignViewBase", BaseView)

var_0_0.eOpenMode = {
	PaiLian = 2,
	ActivityBeginnerView = 1
}

function var_0_0.addEvents(arg_1_0)
	arg_1_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_1_0._refresh, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_2_0._refresh, arg_2_0)
end

function var_0_0.internal_set_actId(arg_3_0, arg_3_1)
	arg_3_0._actId = arg_3_1
end

function var_0_0.internal_set_openMode(arg_4_0, arg_4_1)
	arg_4_0._eOpenMode = arg_4_1
end

function var_0_0.actId(arg_5_0)
	return assert(arg_5_0._actId, "please call self:internal_set_actId(actId) first")
end

function var_0_0.openMode(arg_6_0)
	return assert(arg_6_0._eOpenMode, "please call self:internal_set_openMode(eOpenMode) first")
end

function var_0_0.actCO(arg_7_0)
	local var_7_0 = arg_7_0:actId()

	return lua_activity.configDict[var_7_0]
end

function var_0_0.internal_onOpen(arg_8_0)
	local var_8_0 = arg_8_0:openMode()
	local var_8_1 = var_0_0.eOpenMode

	if var_8_0 == var_8_1.ActivityBeginnerView then
		local var_8_2 = arg_8_0.viewParam.actId
		local var_8_3 = arg_8_0.viewParam.parent

		arg_8_0:internal_set_actId(var_8_2)
		gohelper.addChild(var_8_3, arg_8_0.viewGO)
		arg_8_0:_internal_onOpen()
		arg_8_0:_refresh()
	elseif var_8_0 == var_8_1.PaiLian then
		arg_8_0:_internal_onOpen()
		arg_8_0:_refresh()
	else
		assert(false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function var_0_0._internal_onOpen(arg_9_0)
	arg_9_0:onStart()
end

function var_0_0._internal_onDestroy(arg_10_0)
	FrameTimerController.onDestroyViewMember(arg_10_0, "__createTimer")
	GameUtil.onDestroyViewMemberList(arg_10_0, "__itemList")
end

function var_0_0._refresh(arg_11_0)
	arg_11_0:onRefresh()
end

function var_0_0.getHelpViewParam(arg_12_0, arg_12_1)
	local var_12_0 = ActivityConfig.instance:getActivityCo(arg_12_0._actId)

	return {
		title = luaLang("rule"),
		desc = var_12_0.actTip,
		rootGo = arg_12_1
	}
end

function var_0_0.getDataList(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = arg_13_0:actId()

	for iter_13_0, iter_13_1 in pairs(lua_activity101.configDict[var_13_1] or {}) do
		local var_13_2 = {
			day = iter_13_0,
			data = iter_13_1
		}

		var_13_0[#var_13_0 + 1] = var_13_2
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.day < arg_14_1.day
	end)

	arg_13_0._tempDataList = var_13_0

	return var_13_0
end

function var_0_0.getTempDataList(arg_15_0)
	return arg_15_0._tempDataList
end

function var_0_0.getRewardCouldGetIndex(arg_16_0)
	local var_16_0 = arg_16_0:actId()
	local var_16_1 = arg_16_0:getDataList()
	local var_16_2 = #var_16_1

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		local var_16_3 = iter_16_1.day

		if not ActivityType101Model.instance:isType101RewardGet(var_16_0, var_16_3) then
			return true, iter_16_0
		end
	end

	return false, var_16_2
end

function var_0_0.updateRewardCouldGetHorizontalScrollPixel(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = arg_17_0:getRewardCouldGetIndex()

	if arg_17_1 then
		var_17_1 = arg_17_1(var_17_1)
	end

	if arg_17_0.viewContainer:getCsListScroll() then
		arg_17_0:_tweenByLimitedScrollView(var_17_1)
	else
		arg_17_0:_tweenByScrollContent(var_17_1)
	end
end

function var_0_0._tweenByLimitedScrollView(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.viewContainer:getCsListScroll()
	local var_18_1 = arg_18_0.viewContainer:getListScrollParam()
	local var_18_2 = (var_18_1.cellWidth + var_18_1.cellSpaceH) * math.max(0, arg_18_1)

	var_18_0.HorizontalScrollPixel = math.max(0, var_18_2)

	var_18_0:UpdateCells(true)
end

function var_0_0._tweenByScrollContent(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.viewContainer:getScrollContentTranform()
	local var_19_1 = arg_19_0.viewContainer:getListScrollParam()
	local var_19_2 = var_19_1.startSpace

	if arg_19_1 <= 1 then
		recthelper.setAnchorX(var_19_0, var_19_2 or 0)

		return
	end

	local var_19_3 = arg_19_0:getMaxScrollX()
	local var_19_4 = var_19_1.cellWidth
	local var_19_5 = var_19_1.cellSpaceH
	local var_19_6 = math.max(0, var_19_2 + (arg_19_1 - 1) * (var_19_4 + var_19_5))
	local var_19_7 = math.min(var_19_3, var_19_6)

	recthelper.setAnchorX(var_19_0, -var_19_7)
end

function var_0_0.getRemainTimeStr(arg_20_0)
	local var_20_0 = arg_20_0:actId()
	local var_20_1 = arg_20_0:getRemainTimeSec()

	if var_20_1 <= 0 then
		return luaLang("turnback_end")
	end

	local var_20_2, var_20_3, var_20_4, var_20_5 = TimeUtil.secondsToDDHHMMSS(var_20_1)

	if var_20_2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_20_2,
			var_20_3
		})
	elseif var_20_3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			var_20_3,
			var_20_4
		})
	elseif var_20_4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			var_20_4
		})
	elseif var_20_5 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function var_0_0._createList(arg_21_0)
	if arg_21_0.__itemList then
		return
	end

	local var_21_0 = arg_21_0:getDataList()

	recthelper.setWidth(arg_21_0.viewContainer:getScrollContentTranform(), arg_21_0:calcContentWidth())

	if arg_21_0._scrollItemList then
		arg_21_0._scrollItemList:GetComponent(gohelper.Type_RectMask2D).enabled = #var_21_0 > 7
	end

	arg_21_0.__itemList = {}

	if #var_21_0 <= 7 then
		arg_21_0:_createListDirectly()
	else
		arg_21_0:_createListSplitFrame()
	end
end

function var_0_0._createListDirectly(arg_22_0)
	local var_22_0 = arg_22_0:getDataList()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_1 = arg_22_0.viewContainer:createItemInst()

		var_22_1._index = iter_22_0
		var_22_1._view = arg_22_0

		var_22_1:onUpdateMO(iter_22_1)
		var_22_1:playOpenAnim()
		table.insert(arg_22_0.__itemList, var_22_1)
	end
end

function var_0_0._createListSplitFrame(arg_23_0)
	local var_23_0 = arg_23_0:getDataList()

	arg_23_0.__createTimer = FrameTimerController.instance:register(arg_23_0.__createInner, arg_23_0, 1, #var_23_0 + 1)

	arg_23_0.__createTimer:Start()
end

local var_0_1 = 3

function var_0_0.__createInner(arg_24_0)
	local var_24_0 = arg_24_0:getDataList()
	local var_24_1 = #var_24_0

	if var_24_1 == #arg_24_0.__itemList then
		FrameTimerController.onDestroyViewMember(arg_24_0, "__createTimer")

		return
	end

	local var_24_2 = var_0_1

	for iter_24_0 = #arg_24_0.__itemList + 1, var_24_1 do
		if var_24_2 <= 0 and var_24_1 - iter_24_0 >= var_0_1 then
			break
		end

		local var_24_3 = var_24_0[iter_24_0]
		local var_24_4 = arg_24_0.viewContainer:createItemInst()

		var_24_4._index = iter_24_0
		var_24_4._view = arg_24_0

		var_24_4:onUpdateMO(var_24_3)
		var_24_4:playOpenAnim()
		table.insert(arg_24_0.__itemList, var_24_4)

		var_24_2 = var_24_2 - 1
	end
end

function var_0_0._refreshList(arg_25_0, arg_25_1)
	local var_25_0

	if arg_25_1 then
		var_25_0 = arg_25_0:getTempDataList()
	else
		var_25_0 = arg_25_0:getDataList()
	end

	arg_25_0:_setPinStartIndex(var_25_0)
	arg_25_0:onRefreshList(var_25_0)
end

function var_0_0.refreshListByLimitedScollRect(arg_26_0, arg_26_1)
	arg_26_0:getScrollModel():setList(arg_26_1)
end

function var_0_0._updateScrollViewPos(arg_27_0)
	arg_27_0:updateRewardCouldGetHorizontalScrollPixel(function(arg_28_0)
		if arg_28_0 <= 4 then
			return arg_28_0 - 4
		else
			local var_28_0 = arg_27_0:getTempDataList()

			return var_28_0 and #var_28_0 or arg_28_0
		end
	end)
end

function var_0_0.calcContentWidth(arg_29_0)
	local var_29_0 = arg_29_0:getTempDataList() or arg_29_0:getDataList()
	local var_29_1 = arg_29_0.viewContainer:getListScrollParam()
	local var_29_2 = var_29_1.cellWidth
	local var_29_3 = var_29_1.cellSpaceH
	local var_29_4 = var_29_1.startSpace
	local var_29_5 = var_29_1.endSpace

	return ((var_29_0 and #var_29_0 or 0) - 1) * (var_29_2 + var_29_3) + var_29_2 + var_29_4 + var_29_5
end

function var_0_0.getMaxScrollX(arg_30_0)
	local var_30_0 = arg_30_0.viewContainer:getViewportWH()
	local var_30_1 = arg_30_0:calcContentWidth()

	return math.max(0, var_30_1 - var_30_0)
end

function var_0_0.getScrollModel(arg_31_0)
	return arg_31_0.viewContainer:getScrollModel()
end

function var_0_0.getRemainTimeSec(arg_32_0)
	local var_32_0 = arg_32_0:actId()

	return ActivityModel.instance:getRemainTimeSec(var_32_0) or 0
end

function var_0_0._editableInitView(arg_33_0)
	assert(false, "please override this function")
end

function var_0_0._setPinStartIndex(arg_34_0, arg_34_1)
	local var_34_0, var_34_1 = arg_34_0:getRewardCouldGetIndex()

	arg_34_0:getScrollModel():setDefaultPinStartIndex(arg_34_1, var_34_0 and var_34_1 or 1)
end

function var_0_0.onStart(arg_35_0)
	if arg_35_0.viewContainer:isLimitedScrollView() then
		return
	end

	arg_35_0:_createList()
	arg_35_0:_updateScrollViewPos()
end

function var_0_0.onRefresh(arg_36_0)
	arg_36_0:_refreshList()
end

function var_0_0.onRefreshList(arg_37_0, arg_37_1)
	if not arg_37_1 then
		return
	end

	local var_37_0 = arg_37_0.__itemList

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		local var_37_1 = var_37_0[iter_37_0]

		if var_37_1 then
			local var_37_2 = var_37_1._mo

			if var_37_2 then
				iter_37_1.__isPlayedOpenAnim = var_37_2.__isPlayedOpenAnim
			end

			var_37_1:onUpdateMO(iter_37_1)
		end
	end
end

return var_0_0
