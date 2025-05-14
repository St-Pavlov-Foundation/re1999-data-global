module("modules.logic.activity.view.Activity101SignViewBaseContainer", package.seeall)

local var_0_0 = class("Activity101SignViewBaseContainer", BaseViewContainer)

function var_0_0.actId(arg_1_0)
	return arg_1_0.viewParam.actId
end

function var_0_0._getScrollView(arg_2_0)
	local var_2_0 = arg_2_0:onGetListScrollModelClassType().New()
	local var_2_1 = ListScrollParam.New()

	var_2_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_1.scrollDir = ScrollEnum.ScrollDirH
	var_2_1.sortMode = ScrollEnum.ScrollSortDown
	var_2_1.lineCount = 1
	var_2_1.cellSpaceV = 0
	var_2_1.startSpace = 0
	var_2_1.prefabUrl = arg_2_0._viewSetting.otherRes[1]

	arg_2_0:onModifyListScrollParam(var_2_1)
	assert(var_2_1.cellClass)
	assert(var_2_1.scrollGOPath)
	assert(var_2_1.prefabUrl)

	return var_2_0, var_2_1
end

function var_0_0._createMainView(arg_3_0)
	local var_3_0 = arg_3_0:onGetMainViewClassType()

	if var_3_0 then
		return var_3_0.New()
	end
end

function var_0_0.buildViews(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0:_getScrollView()

	arg_4_0.__scrollModel = var_4_0
	arg_4_0.__listScrollParam = var_4_1
	arg_4_0.__mainView = arg_4_0:_createMainView()

	return arg_4_0:onBuildViews()
end

function var_0_0.onContainerInit(arg_5_0)
	var_0_0.super.onContainerInit(arg_5_0)

	local var_5_0 = arg_5_0:getScrollRect()
	local var_5_1 = var_5_0:GetComponent(gohelper.Type_RectTransform)

	arg_5_0.__scrollContentTrans = var_5_0.content
	arg_5_0.__scrollContentGo = arg_5_0.__scrollContentTrans.gameObject
	arg_5_0.__viewPortHeight = recthelper.getHeight(var_5_1)
	arg_5_0.__viewPortWidth = recthelper.getWidth(var_5_1)
	arg_5_0.__onceGotRewardFetch101Infos = false

	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_5_0._onRefreshNorSignActivity, arg_5_0)
end

function var_0_0.onContainerClose(arg_6_0)
	var_0_0.super.onContainerClose(arg_6_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_6_0._onRefreshNorSignActivity, arg_6_0)

	arg_6_0.__onceGotRewardFetch101Infos = false
end

function var_0_0.getScrollModel(arg_7_0)
	return arg_7_0.__scrollModel
end

function var_0_0.getScrollView(arg_8_0)
	return arg_8_0.__scrollView
end

function var_0_0.getMainView(arg_9_0)
	return arg_9_0.__mainView
end

function var_0_0.isLimitedScrollView(arg_10_0)
	return arg_10_0.__scrollView ~= nil
end

function var_0_0.getCsListScroll(arg_11_0)
	if not arg_11_0:isLimitedScrollView() then
		return
	end

	return arg_11_0:getScrollView():getCsListScroll()
end

function var_0_0.getScrollRect(arg_12_0)
	if arg_12_0.__scrollRect then
		return arg_12_0.__scrollRect
	end

	local var_12_0

	if arg_12_0:isLimitedScrollView() then
		var_12_0 = arg_12_0:getCsListScroll():GetComponent(gohelper.Type_ScrollRect)
	else
		local var_12_1 = arg_12_0:getMainView().viewGO
		local var_12_2 = arg_12_0:getListScrollParam()

		var_12_0 = gohelper.findChildScrollRect(var_12_1, var_12_2.scrollGOPath)
	end

	arg_12_0.__scrollRect = var_12_0

	return var_12_0
end

function var_0_0.getScrollContentTranform(arg_13_0)
	return arg_13_0.__scrollContentTrans
end

function var_0_0.getListScrollParam(arg_14_0)
	return arg_14_0.__listScrollParam
end

function var_0_0.getViewportWH(arg_15_0)
	return arg_15_0.__viewPortWidth, arg_15_0.__viewPortHeight
end

function var_0_0.getScrollContentGo(arg_16_0)
	return arg_16_0.__scrollContentGo
end

function var_0_0.createItemInst(arg_17_0)
	local var_17_0 = arg_17_0:getListScrollParam()
	local var_17_1 = var_17_0.cellClass
	local var_17_2 = var_17_0.prefabUrl
	local var_17_3 = arg_17_0:getScrollContentGo()
	local var_17_4 = arg_17_0:getResInst(var_17_2, var_17_3, var_17_1.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_17_4, var_17_1)
end

function var_0_0.onGetListScrollModelClassType(arg_18_0)
	return Activity101SignViewListModelBase
end

function var_0_0.onGetMainViewClassType(arg_19_0)
	assert(false, "please overeide this function!")
end

function var_0_0.onModifyListScrollParam(arg_20_0, arg_20_1)
	assert(false, "please overeide this function!")
end

function var_0_0.onBuildViews(arg_21_0)
	local var_21_0, var_21_1 = arg_21_0:_getScrollView()

	arg_21_0.__scrollView = LuaListScrollView.New(var_21_0, var_21_1)

	return {
		arg_21_0.__scrollView,
		arg_21_0.__mainView
	}
end

function var_0_0.setOnceGotRewardFetch101Infos(arg_22_0, arg_22_1)
	arg_22_0.__onceGotRewardFetch101Infos = arg_22_1 and true or false
end

function var_0_0._onRefreshNorSignActivity(arg_23_0)
	if arg_23_0.__onceGotRewardFetch101Infos then
		Activity101Rpc.instance:sendGet101InfosRequest(arg_23_0:actId())

		arg_23_0.__onceGotRewardFetch101Infos = false
	end
end

return var_0_0
