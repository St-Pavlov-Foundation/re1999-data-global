module("modules.logic.versionactivity2_2.act101.view.VersionActivity2_2RoomSignView", package.seeall)

local var_0_0 = class("VersionActivity2_2RoomSignView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "timebg/#txt_LimitTime")
	arg_1_0._goScroll = gohelper.findChild(arg_1_0.viewGO, "#scroll_ItemList")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_ItemList/Viewport/Content")
	arg_1_0.itemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_2_0._onRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_3_0._onRefresh, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onRefresh(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.parent

	arg_7_0._actId = arg_7_0.viewParam.actId

	gohelper.addChild(var_7_0, arg_7_0.viewGO)

	arg_7_0.isFirstOpen = true

	arg_7_0:refreshView()
	arg_7_0:moveLast()
end

function var_0_0.refreshView(arg_8_0)
	if arg_8_0.isFirstOpen then
		arg_8_0.isFirstOpen = false

		arg_8_0:refreshItemListDelay()
	else
		arg_8_0:refreshItemList()
	end

	arg_8_0:_showDeadline()
end

function var_0_0.refreshItemList(arg_9_0)
	if arg_9_0.curIndex then
		return
	end

	local var_9_0 = Activity125Model.instance:getById(arg_9_0._actId)
	local var_9_1 = var_9_0:getEpisodeList()
	local var_9_2 = #var_9_1

	for iter_9_0 = 1, math.max(#arg_9_0.itemList, var_9_2) do
		local var_9_3 = arg_9_0.itemList[iter_9_0]

		if not var_9_3 then
			local var_9_4 = arg_9_0:getResInst(arg_9_0.viewContainer:getSetting().otherRes[1], arg_9_0._goContent)

			var_9_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_4, VersionActivity2_2RoomSignItem)
			var_9_3._index = iter_9_0
			arg_9_0.itemList[iter_9_0] = var_9_3
		end

		var_9_3:onUpdateMO(var_9_1[iter_9_0], var_9_0)
	end
end

function var_0_0.refreshItemListDelay(arg_10_0)
	arg_10_0.curIndex = 0

	TaskDispatcher.cancelTask(arg_10_0._refreshCurItem, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._refreshCurItem, arg_10_0, 0.06)
end

function var_0_0._refreshCurItem(arg_11_0)
	arg_11_0.curIndex = arg_11_0.curIndex + 1

	local var_11_0 = Activity125Model.instance:getById(arg_11_0._actId)
	local var_11_1 = var_11_0:getEpisodeList()[arg_11_0.curIndex]

	if var_11_1 then
		arg_11_0:refreshItem(arg_11_0.curIndex, var_11_1, var_11_0)
	else
		arg_11_0.curIndex = nil

		TaskDispatcher.cancelTask(arg_11_0._refreshCurItem, arg_11_0)
	end
end

function var_0_0.refreshItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0.itemList[arg_12_1]

	if not var_12_0 then
		local var_12_1 = arg_12_0:getResInst(arg_12_0.viewContainer:getSetting().otherRes[1], arg_12_0._goContent)

		var_12_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1, VersionActivity2_2RoomSignItem)
		var_12_0._index = arg_12_1
		arg_12_0.itemList[arg_12_1] = var_12_0
	end

	var_12_0:onUpdateMO(arg_12_2, arg_12_3)
end

function var_0_0.moveLast(arg_13_0)
	local var_13_0 = Activity125Model.instance:getById(arg_13_0._actId)
	local var_13_1 = var_13_0:getEpisodeList()
	local var_13_2 = 1

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if var_13_0:isEpisodeDayOpen(iter_13_1.id) and not var_13_0:isEpisodeFinished(iter_13_1.id) then
			var_13_2 = iter_13_0

			break
		end
	end

	local var_13_3 = 0
	local var_13_4 = arg_13_0:getMaxScrollX()
	local var_13_5 = 476
	local var_13_6 = 30
	local var_13_7 = math.max(0, var_13_3 + (var_13_2 - 1) * (var_13_5 + var_13_6))
	local var_13_8 = math.min(var_13_4, var_13_7)

	recthelper.setAnchorX(arg_13_0._goContent.transform, -var_13_8)
end

function var_0_0.getMaxScrollX(arg_14_0)
	local var_14_0 = recthelper.getWidth(arg_14_0._goScroll.transform)
	local var_14_1 = 506 * #Activity125Model.instance:getById(arg_14_0._actId):getEpisodeList() - 12

	recthelper.setWidth(arg_14_0._goContent.transform, var_14_1)

	return math.max(0, var_14_1 - var_14_0)
end

function var_0_0._showDeadline(arg_15_0)
	arg_15_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_15_0._onRefreshDeadline, arg_15_0)
	TaskDispatcher.runRepeat(arg_15_0._onRefreshDeadline, arg_15_0, 60)
end

function var_0_0._onRefreshDeadline(arg_16_0)
	arg_16_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_16_0._actId)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._refreshCurItem, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._onRefreshDeadline, arg_18_0)

	arg_18_0.itemList = nil
end

return var_0_0
