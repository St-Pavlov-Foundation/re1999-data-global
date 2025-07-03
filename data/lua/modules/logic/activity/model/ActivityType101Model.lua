local var_0_0 = string.format

module("modules.logic.activity.model.ActivityType101Model", package.seeall)

local var_0_1 = class("ActivityType101Model", BaseModel)
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function var_0_1.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_1.reInit(arg_2_0)
	arg_2_0._type101Info = {}

	arg_2_0:setCurIndex(nil)
end

function var_0_1.setType101Info(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.infos) do
		local var_3_3 = ActivityType101InfoMo.New()

		var_3_3:init(iter_3_1)

		var_3_1[iter_3_1.id] = var_3_3
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.spInfos) do
		local var_3_4 = iter_3_3.id
		local var_3_5 = ActivityType101SpInfoMo.New()

		var_3_5:init(iter_3_3)

		var_3_2[var_3_4] = var_3_5
	end

	var_3_0.infos = var_3_1
	var_3_0.count = arg_3_1.loginCount
	var_3_0.spInfos = var_3_2
	arg_3_0._type101Info[arg_3_1.activityId] = var_3_0
end

function var_0_1.setBonusGet(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.activityId

	if not arg_4_0:isInit(var_4_0) then
		return
	end

	arg_4_0._type101Info[var_4_0].infos[arg_4_1.id].state = var_0_4
end

function var_0_1.getType101LoginCount(arg_5_0, arg_5_1)
	if not arg_5_0:isInit(arg_5_1) then
		return 0
	end

	return arg_5_0._type101Info[arg_5_1].count
end

function var_0_1.isType101RewardGet(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0:getType101InfoState(arg_6_1, arg_6_2) == var_0_4
end

function var_0_1.isType101RewardCouldGet(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0:getType101InfoState(arg_7_1, arg_7_2) == var_0_3
end

function var_0_1.getType101Info(arg_8_0, arg_8_1)
	if not arg_8_0:isInit(arg_8_1) then
		return
	end

	return arg_8_0._type101Info[arg_8_1].infos
end

function var_0_1.getCurIndex(arg_9_0)
	return arg_9_0._curIndex
end

function var_0_1.setCurIndex(arg_10_0, arg_10_1)
	arg_10_0._curIndex = arg_10_1
end

function var_0_1.isType101RewardCouldGetAnyOne(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getType101Info(arg_11_1)

	if not var_11_0 then
		return false
	end

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if iter_11_1.state == var_0_3 then
			return true
		end
	end

	return false
end

function var_0_1.hasReceiveAllReward(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getType101Info(arg_12_1)

	if not var_12_0 then
		return true
	end

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if iter_12_1.state == var_0_2 or iter_12_1.state == var_0_3 then
			return false
		end
	end

	return true
end

function var_0_1.isInit(arg_13_0, arg_13_1)
	return arg_13_0._type101Info[arg_13_1] and true or false
end

function var_0_1.isOpen(arg_14_0, arg_14_1)
	return ActivityHelper.getActivityStatus(arg_14_1, true) == ActivityEnum.ActivityStatus.Normal
end

function var_0_1.getLastGetIndex(arg_15_0, arg_15_1)
	local var_15_0 = var_0_1.instance:getType101LoginCount(arg_15_1)

	if var_15_0 == 0 then
		return 0
	end

	if arg_15_0:isType101RewardGet(var_15_0) then
		return var_15_0
	end

	local var_15_1 = arg_15_0:getType101Info(arg_15_1)

	if not var_15_1 then
		return 0
	end

	local var_15_2 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		local var_15_3 = iter_15_1.id

		if iter_15_1.state == var_0_4 then
			var_15_2[#var_15_2 + 1] = var_15_3
		end
	end

	table.sort(var_15_2)

	return var_15_2[#var_15_2] or 0
end

function var_0_1.getType101InfoState(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0:isInit(arg_16_1) then
		return var_0_2
	end

	local var_16_0 = arg_16_0:getType101Info(arg_16_1)

	if not var_16_0 then
		return var_0_2
	end

	local var_16_1 = var_16_0[arg_16_2]

	if not var_16_1 then
		return var_0_2
	end

	return var_16_1.state or var_0_2
end

function var_0_1.getType101SpInfo(arg_17_0, arg_17_1)
	if not arg_17_0:isInit(arg_17_1) then
		return
	end

	return arg_17_0._type101Info[arg_17_1].spInfos
end

function var_0_1.getType101SpInfoMo(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0:isInit(arg_18_1) then
		return
	end

	local var_18_0 = arg_18_0:getType101SpInfo(arg_18_1)

	if not var_18_0 then
		return
	end

	return var_18_0[arg_18_2]
end

function var_0_1.isType101SpRewardUncompleted(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getType101SpInfoMo(arg_19_1, arg_19_2)

	if not var_19_0 then
		return false
	end

	return var_19_0:isNone()
end

function var_0_1.isType101SpRewardCouldGet(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getType101SpInfoMo(arg_20_1, arg_20_2)

	if not var_20_0 then
		return false
	end

	return var_20_0:isAvailable()
end

function var_0_1.isType101SpRewardGot(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getType101SpInfoMo(arg_21_1, arg_21_2)

	if not var_21_0 then
		return false
	end

	return var_21_0:isReceived()
end

function var_0_1.setSpBonusGet(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.activityId
	local var_22_1 = arg_22_1.id
	local var_22_2 = arg_22_0:getType101SpInfoMo(var_22_0, var_22_1)

	if not var_22_2 then
		return
	end

	var_22_2:setState_Received()
end

function var_0_1.isType101SpRewardCouldGetAnyOne(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getType101SpInfo(arg_23_1)

	if not var_23_0 then
		return false
	end

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if iter_23_1:isAvailable() then
			return true
		end
	end

	return false
end

function var_0_1.claimAll(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if var_0_1.instance:getType101LoginCount(arg_24_1) == 0 then
		if arg_24_2 then
			arg_24_2(arg_24_3)
		end

		return
	end

	local var_24_0 = arg_24_0:getType101Info(arg_24_1)

	if not var_24_0 then
		if arg_24_2 then
			arg_24_2(arg_24_3)
		end

		return
	end

	local var_24_1 = {}

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		local var_24_2 = iter_24_1.id

		if iter_24_1.state == var_0_3 then
			var_24_1[#var_24_1 + 1] = var_24_2
		end
	end

	for iter_24_2, iter_24_3 in ipairs(var_24_1) do
		local var_24_3
		local var_24_4

		if iter_24_2 == #var_24_1 then
			var_24_3 = arg_24_2
			var_24_4 = arg_24_3
		end

		Activity101Rpc.instance:sendGet101BonusRequest(arg_24_1, iter_24_3, var_24_3, var_24_4)
	end
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

local function var_0_16(arg_25_0, arg_25_1, arg_25_2)
	local function var_25_0(arg_26_0)
		local var_26_0 = var_0_0(arg_26_0._viewName, arg_25_0, arg_25_1)
		local var_26_1 = var_0_0(arg_26_0._viewContainerName, arg_25_0, arg_25_1)

		arg_26_0.mainRes = var_0_0(arg_26_0.mainRes, arg_25_0, arg_25_1)
		arg_26_0.otherRes[1] = var_0_0(arg_26_0.otherRes[1], arg_25_0, arg_25_1)
		arg_26_0._viewName = var_26_0

		local var_26_2
		local var_26_3 = _G.class(var_26_1, Vxax_Role_SignItem_SignViewContainer)

		if arg_26_0._isFullView then
			var_26_2 = _G.class(var_26_0, Vxax_Role_FullSignView)

			Vxax_Role_SignItem_SignViewContainer.Vxax_Role_FullSignView_PartX(var_26_2, arg_25_0, arg_25_1, arg_26_0._whichPart)
		else
			var_26_2 = _G.class(var_26_0, Vxax_Role_PanelSignView)

			Vxax_Role_SignItem_SignViewContainer.Vxax_Role_PanelSignView_PartX(var_26_2, arg_25_0, arg_25_1, arg_26_0._whichPart)
		end

		Vxax_Role_SignItem_SignViewContainer.Vxax_Role_xxxSignView_Container(var_26_3, var_26_2)

		arg_25_2[var_26_0] = arg_26_0

		rawset(_G.ViewName, var_26_0, var_26_0)
		rawset(_G, var_26_0, var_26_2)
		rawset(_G, var_26_1, var_26_3)
	end

	var_25_0(var_0_7)
	var_25_0(var_0_8)
	var_25_0(var_0_10)
	var_25_0(var_0_11)
end

local function var_0_17(arg_27_0, arg_27_1, arg_27_2)
	local function var_27_0(arg_28_0)
		local var_28_0 = var_0_0(arg_28_0._viewName, arg_27_0, arg_27_1)
		local var_28_1 = var_0_0(arg_28_0._viewContainerName, arg_27_0, arg_27_1)

		arg_28_0.mainRes = var_0_0(arg_28_0.mainRes, arg_27_0, arg_27_1)
		arg_28_0._viewName = var_28_0

		local var_28_2
		local var_28_3 = _G.class(var_28_1, Vxax_Special_SignItemViewContainer)

		if arg_28_0._isFullView then
			var_28_2 = _G.class(var_28_0, var_0_12)

			Vxax_Special_SignItemViewContainer.Vxax_Special_FullSignView(var_28_2, arg_27_0, arg_27_1)
		else
			var_28_2 = _G.class(var_28_0, var_0_13)

			Vxax_Special_SignItemViewContainer.Vxax_Special_PanelSignView(var_28_2, arg_27_0, arg_27_1)
		end

		Vxax_Special_SignItemViewContainer.Vxax_Special_xxxSignView_Container(var_28_3, var_28_2)

		arg_27_2[var_28_0] = arg_28_0

		rawset(_G.ViewName, var_28_0, var_28_0)
		rawset(_G, var_28_0, var_28_2)
		rawset(_G, var_28_1, var_28_3)
	end

	var_27_0(var_0_12)
	var_27_0(var_0_13)
end

local function var_0_18(arg_29_0, arg_29_1, arg_29_2)
	local function var_29_0(arg_30_0)
		local var_30_0 = var_0_0(arg_30_0._viewName, arg_29_0, arg_29_1)
		local var_30_1 = var_0_0(arg_30_0._viewContainerName, arg_29_0, arg_29_1)

		arg_30_0.mainRes = var_0_0(arg_30_0.mainRes, arg_29_0, arg_29_1)
		arg_30_0._viewName = var_30_0

		local var_30_2
		local var_30_3 = _G.class(var_30_1, LinkageActivity_BaseViewContainer)

		if arg_30_0._isFullView then
			var_30_2 = _G.class(var_30_0, LinkageActivity_FullView)

			LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_FullView(var_30_2, arg_29_0, arg_29_1)
		else
			var_30_2 = _G.class(var_30_0, LinkageActivity_PanelView)

			LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_PanelView(var_30_2, arg_29_0, arg_29_1)
		end

		LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_xxxView_Container(var_30_3, var_30_2)

		arg_29_2[var_30_0] = arg_30_0

		rawset(_G.ViewName, var_30_0, var_30_0)
		rawset(_G, var_30_0, var_30_2)
		rawset(_G, var_30_1, var_30_3)
	end

	var_29_0(var_0_14)
	var_29_0(var_0_15)
end

function var_0_1.onModuleViews(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1.curV
	local var_31_1 = arg_31_1.curA

	var_0_16(var_31_0, var_31_1, arg_31_2)
	var_0_17(var_31_0, var_31_1, arg_31_2)
	var_0_18(var_31_0, var_31_1, arg_31_2)
end

var_0_1.instance = var_0_1.New()

return var_0_1
