local var_0_0 = string.format

module("modules.logic.activity.model.ActivityType101Model", package.seeall)

local var_0_1 = class("ActivityType101Model", BaseModel)

function var_0_1.getRoleSignActIdList(arg_1_0)
	return ActivityType101Config.instance:getRoleSignActIdList()
end

local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function var_0_1.onInit(arg_2_0)
	arg_2_0:reInit()
end

function var_0_1.reInit(arg_3_0)
	arg_3_0._type101Info = {}

	arg_3_0:setCurIndex(nil)
end

function var_0_1.getCurIndex(arg_4_0)
	return arg_4_0._curIndex
end

function var_0_1.setCurIndex(arg_5_0, arg_5_1)
	arg_5_0._curIndex = arg_5_1
end

function var_0_1.setType101Info(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.infos) do
		local var_6_3 = ActivityType101InfoMo.New()

		var_6_3:init(iter_6_1)

		var_6_1[iter_6_1.id] = var_6_3
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_1.spInfos) do
		local var_6_4 = iter_6_3.id
		local var_6_5 = ActivityType101SpInfoMo.New()

		var_6_5:init(iter_6_3)

		var_6_2[var_6_4] = var_6_5
	end

	var_6_0.infos = var_6_1
	var_6_0.count = arg_6_1.loginCount
	var_6_0.spInfos = var_6_2
	arg_6_0._type101Info[arg_6_1.activityId] = var_6_0
end

function var_0_1.setBonusGet(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.activityId

	if not arg_7_0:isInit(var_7_0) then
		return
	end

	arg_7_0._type101Info[var_7_0].infos[arg_7_1.id].state = var_0_4
end

function var_0_1.getType101LoginCount(arg_8_0, arg_8_1)
	if not arg_8_0:isInit(arg_8_1) then
		return 0
	end

	return arg_8_0._type101Info[arg_8_1].count
end

function var_0_1.isType101RewardGet(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0:getType101InfoState(arg_9_1, arg_9_2) == var_0_4
end

function var_0_1.isType101RewardCouldGet(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0:getType101InfoState(arg_10_1, arg_10_2) == var_0_3
end

function var_0_1.getType101Info(arg_11_0, arg_11_1)
	if not arg_11_0:isInit(arg_11_1) then
		return
	end

	return arg_11_0._type101Info[arg_11_1].infos
end

function var_0_1.isType101RewardCouldGetAnyOne(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getType101Info(arg_12_1)

	if not var_12_0 then
		return false
	end

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if iter_12_1.state == var_0_3 then
			return true
		end
	end

	return false
end

function var_0_1.hasReceiveAllReward(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getType101Info(arg_13_1)

	if not var_13_0 then
		return true
	end

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1.state == var_0_2 or iter_13_1.state == var_0_3 then
			return false
		end
	end

	return true
end

function var_0_1.isInit(arg_14_0, arg_14_1)
	return arg_14_0._type101Info[arg_14_1] and true or false
end

function var_0_1.isOpen(arg_15_0, arg_15_1)
	return ActivityHelper.getActivityStatus(arg_15_1, true) == ActivityEnum.ActivityStatus.Normal
end

function var_0_1.getLastGetIndex(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getType101LoginCount(arg_16_1)

	if var_16_0 == 0 then
		return 0
	end

	if arg_16_0:isType101RewardGet(var_16_0) then
		return var_16_0
	end

	local var_16_1 = arg_16_0:getType101Info(arg_16_1)

	if not var_16_1 then
		return 0
	end

	local var_16_2 = {}

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		local var_16_3 = iter_16_1.id

		if iter_16_1.state == var_0_4 then
			var_16_2[#var_16_2 + 1] = var_16_3
		end
	end

	table.sort(var_16_2)

	return var_16_2[#var_16_2] or 0
end

function var_0_1.getType101InfoState(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0:isInit(arg_17_1) then
		return var_0_2
	end

	local var_17_0 = arg_17_0:getType101Info(arg_17_1)

	if not var_17_0 then
		return var_0_2
	end

	local var_17_1 = var_17_0[arg_17_2]

	if not var_17_1 then
		return var_0_2
	end

	return var_17_1.state or var_0_2
end

function var_0_1.getType101SpInfo(arg_18_0, arg_18_1)
	if not arg_18_0:isInit(arg_18_1) then
		return
	end

	return arg_18_0._type101Info[arg_18_1].spInfos
end

function var_0_1.getType101SpInfoMo(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0:isInit(arg_19_1) then
		return
	end

	local var_19_0 = arg_19_0:getType101SpInfo(arg_19_1)

	if not var_19_0 then
		return
	end

	return var_19_0[arg_19_2]
end

function var_0_1.isType101SpRewardUncompleted(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getType101SpInfoMo(arg_20_1, arg_20_2)

	if not var_20_0 then
		return false
	end

	return var_20_0:isNone()
end

function var_0_1.isType101SpRewardCouldGet(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getType101SpInfoMo(arg_21_1, arg_21_2)

	if not var_21_0 then
		return false
	end

	return var_21_0:isAvailable()
end

function var_0_1.isType101SpRewardGot(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getType101SpInfoMo(arg_22_1, arg_22_2)

	if not var_22_0 then
		return false
	end

	return var_22_0:isReceived()
end

function var_0_1.setSpBonusGet(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.activityId
	local var_23_1 = arg_23_1.id
	local var_23_2 = arg_23_0:getType101SpInfoMo(var_23_0, var_23_1)

	if not var_23_2 then
		return
	end

	var_23_2:setState_Received()
end

function var_0_1.isType101SpRewardCouldGetAnyOne(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getType101SpInfo(arg_24_1)

	if not var_24_0 then
		return false
	end

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		if iter_24_1:isAvailable() then
			return true
		end
	end

	return false
end

function var_0_1.claimAll(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0:getType101LoginCount(arg_25_1) == 0 then
		if arg_25_2 then
			arg_25_2(arg_25_3)
		end

		return
	end

	local var_25_0 = arg_25_0:getType101Info(arg_25_1)

	if not var_25_0 then
		if arg_25_2 then
			arg_25_2(arg_25_3)
		end

		return
	end

	local var_25_1 = {}

	for iter_25_0, iter_25_1 in pairs(var_25_0) do
		local var_25_2 = iter_25_1.id

		if iter_25_1.state == var_0_3 then
			var_25_1[#var_25_1 + 1] = var_25_2
		end
	end

	for iter_25_2, iter_25_3 in ipairs(var_25_1) do
		local var_25_3
		local var_25_4

		if iter_25_2 == #var_25_1 then
			var_25_3 = arg_25_2
			var_25_4 = arg_25_3
		end

		Activity101Rpc.instance:sendGet101BonusRequest(arg_25_1, iter_25_3, var_25_3, var_25_4)
	end
end

function var_0_1.getFirstAvailableIndex(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getType101Info(arg_26_1)

	for iter_26_0, iter_26_1 in ipairs(var_26_0 or {}) do
		local var_26_1 = iter_26_1.id

		if iter_26_1.state == var_0_3 then
			return iter_26_0
		end
	end

	return 0
end

function var_0_1.isDayOpen(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_2 or not arg_27_0:isInit(arg_27_1) then
		return false
	end

	return arg_27_2 <= arg_27_0:getType101LoginCount(arg_27_1)
end

local var_0_5 = "_Container"
local var_0_6 = {
	bgBlur = 0,
	destroy = 0,
	mainRes = "ui/viewres/activity/v%sa%s_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v%sa%s_role_signitem.prefab"
	}
}
local var_0_7 = var_0_6
local var_0_8 = tabletool.copy(var_0_6)

var_0_7.container = "Vxax_Role_FullSignView_Part1_Container"
var_0_8.container = "Vxax_Role_FullSignView_Part2_Container"
var_0_7._viewName = "V%sa%s_Role_FullSignView_Part1"
var_0_8._viewName = "V%sa%s_Role_FullSignView_Part2"
var_0_7._viewContainerName = var_0_7._viewName .. var_0_5
var_0_8._viewContainerName = var_0_8._viewName .. var_0_5
var_0_7._isFullView = true
var_0_8._isFullView = true
var_0_7._whichPart = 1
var_0_8._whichPart = 2

local var_0_9 = {
	bgBlur = 1,
	destroy = 0,
	mainRes = "ui/viewres/activity/v%sa%s_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v%sa%s_role_signitem.prefab"
	}
}
local var_0_10 = var_0_9
local var_0_11 = tabletool.copy(var_0_9)

var_0_10.container = "Vxax_Role_PanelSignView_Part1_Container"
var_0_11.container = "Vxax_Role_PanelSignView_Part2_Container"
var_0_10._viewName = "V%sa%s_Role_PanelSignView_Part1"
var_0_11._viewName = "V%sa%s_Role_PanelSignView_Part2"
var_0_10._viewContainerName = var_0_10._viewName .. var_0_5
var_0_11._viewContainerName = var_0_11._viewName .. var_0_5
var_0_10._isFullView = false
var_0_11._isFullView = false
var_0_10._whichPart = 1
var_0_11._whichPart = 2

local var_0_12 = {
	bgBlur = 0,
	container = "Vxax_Special_FullSignViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_Special_FullSignViewContainer",
	_isFullView = true,
	_viewName = "V%sa%s_Special_FullSignView",
	mainRes = "ui/viewres/activity/v%sa%s_special_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
local var_0_13 = {
	bgBlur = 1,
	container = "Vxax_Special_PanelSignViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_Special_PanelSignViewContainer",
	_isFullView = false,
	_viewName = "V%sa%s_Special_PanelSignView",
	mainRes = "ui/viewres/activity/v%sa%s_special_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
local var_0_14 = {
	bgBlur = 0,
	container = "Vxax_LinkageActivity_FullViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_LinkageActivity_FullViewContainer",
	_isFullView = true,
	_viewName = "V%sa%s_LinkageActivity_FullView",
	mainRes = "ui/viewres/activity/v%sa%s_linkageactivity_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
local var_0_15 = {
	bgBlur = 1,
	container = "Vxax_LinkageActivity_PanelViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_LinkageActivity_PanelViewContainer",
	_isFullView = false,
	_viewName = "V%sa%s_LinkageActivity_PanelView",
	mainRes = "ui/viewres/activity/v%sa%s_linkageactivity_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}

local function var_0_16(arg_28_0, arg_28_1, arg_28_2)
	local function var_28_0(arg_29_0)
		local var_29_0 = var_0_0(arg_29_0._viewName, arg_28_0, arg_28_1)
		local var_29_1 = var_0_0(arg_29_0._viewContainerName, arg_28_0, arg_28_1)

		arg_29_0.mainRes = var_0_0(arg_29_0.mainRes, arg_28_0, arg_28_1)
		arg_29_0.otherRes[1] = var_0_0(arg_29_0.otherRes[1], arg_28_0, arg_28_1)
		arg_29_0._viewName = var_29_0

		local var_29_2
		local var_29_3 = _G.class(var_29_1, Vxax_Role_SignItem_SignViewContainer)

		if arg_29_0._isFullView then
			var_29_2 = _G.class(var_29_0, Vxax_Role_FullSignView)

			Vxax_Role_SignItem_SignViewContainer.Vxax_Role_FullSignView_PartX(var_29_2, arg_28_0, arg_28_1, arg_29_0._whichPart)
		else
			var_29_2 = _G.class(var_29_0, Vxax_Role_PanelSignView)

			Vxax_Role_SignItem_SignViewContainer.Vxax_Role_PanelSignView_PartX(var_29_2, arg_28_0, arg_28_1, arg_29_0._whichPart)
		end

		Vxax_Role_SignItem_SignViewContainer.Vxax_Role_xxxSignView_Container(var_29_3, var_29_2)

		arg_28_2[var_29_0] = arg_29_0

		rawset(_G.ViewName, var_29_0, var_29_0)
		rawset(_G, var_29_0, var_29_2)
		rawset(_G, var_29_1, var_29_3)
	end

	var_28_0(var_0_7)
	var_28_0(var_0_8)
	var_28_0(var_0_10)
	var_28_0(var_0_11)
end

local function var_0_17(arg_30_0, arg_30_1, arg_30_2)
	local function var_30_0(arg_31_0)
		local var_31_0 = var_0_0(arg_31_0._viewName, arg_30_0, arg_30_1)
		local var_31_1 = var_0_0(arg_31_0._viewContainerName, arg_30_0, arg_30_1)

		arg_31_0.mainRes = var_0_0(arg_31_0.mainRes, arg_30_0, arg_30_1)
		arg_31_0._viewName = var_31_0

		local var_31_2
		local var_31_3 = _G.class(var_31_1, Vxax_Special_SignItemViewContainer)

		if arg_31_0._isFullView then
			var_31_2 = _G.class(var_31_0, var_0_12)

			Vxax_Special_SignItemViewContainer.Vxax_Special_FullSignView(var_31_2, arg_30_0, arg_30_1)
		else
			var_31_2 = _G.class(var_31_0, var_0_13)

			Vxax_Special_SignItemViewContainer.Vxax_Special_PanelSignView(var_31_2, arg_30_0, arg_30_1)
		end

		Vxax_Special_SignItemViewContainer.Vxax_Special_xxxSignView_Container(var_31_3, var_31_2)

		arg_30_2[var_31_0] = arg_31_0

		rawset(_G.ViewName, var_31_0, var_31_0)
		rawset(_G, var_31_0, var_31_2)
		rawset(_G, var_31_1, var_31_3)
	end

	var_30_0(var_0_12)
	var_30_0(var_0_13)
end

local function var_0_18(arg_32_0, arg_32_1, arg_32_2)
	local function var_32_0(arg_33_0)
		local var_33_0 = var_0_0(arg_33_0._viewName, arg_32_0, arg_32_1)
		local var_33_1 = var_0_0(arg_33_0._viewContainerName, arg_32_0, arg_32_1)

		arg_33_0.mainRes = var_0_0(arg_33_0.mainRes, arg_32_0, arg_32_1)
		arg_33_0._viewName = var_33_0

		local var_33_2
		local var_33_3 = _G.class(var_33_1, LinkageActivity_BaseViewContainer)

		if arg_33_0._isFullView then
			var_33_2 = _G.class(var_33_0, LinkageActivity_FullView)

			LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_FullView(var_33_2, arg_32_0, arg_32_1)
		else
			var_33_2 = _G.class(var_33_0, LinkageActivity_PanelView)

			LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_PanelView(var_33_2, arg_32_0, arg_32_1)
		end

		LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_xxxView_Container(var_33_3, var_33_2)

		arg_32_2[var_33_0] = arg_33_0

		rawset(_G.ViewName, var_33_0, var_33_0)
		rawset(_G, var_33_0, var_33_2)
		rawset(_G, var_33_1, var_33_3)
	end

	var_32_0(var_0_14)
	var_32_0(var_0_15)
end

function var_0_1.onModuleViews(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_1.curV
	local var_34_1 = arg_34_1.curA

	var_0_17(var_34_0, var_34_1, arg_34_2)
	var_0_18(var_34_0, var_34_1, arg_34_2)
end

var_0_1.instance = var_0_1.New()

return var_0_1
