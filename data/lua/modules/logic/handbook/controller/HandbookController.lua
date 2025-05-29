module("modules.logic.handbook.controller.HandbookController", package.seeall)

local var_0_0 = class("HandbookController", BaseController)

var_0_0.EventName = {
	PlayCharacterSwitchCloseAnim = 3,
	PlayCharacterSwitchOpenAnim = 2,
	OnShowSubCharacterView = 1
}
var_0_0.OpenViewNameEnum = {
	HandbookCharacterView = 1,
	HandbookStoryView = 3,
	HandbookEquipView = 2
}

function var_0_0.onInit(arg_1_0)
	arg_1_0._openViewName = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._openViewName = 0
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.jumpView(arg_4_0, arg_4_1)
	local var_4_0 = {}

	arg_4_0:openView()

	if #arg_4_1 <= 1 then
		return var_4_0
	end

	local var_4_1 = tonumber(arg_4_1[2])

	if var_4_1 == JumpEnum.HandbookType.Character then
		arg_4_0:openCharacterView()
		table.insert(var_4_0, ViewName.HandBookCharacterSwitchView)
	elseif var_4_1 == JumpEnum.HandbookType.Equip then
		arg_4_0:openEquipView()
		table.insert(var_4_0, HandbookEquipView)
	elseif var_4_1 == JumpEnum.HandbookType.Story then
		local var_4_2 = tonumber(arg_4_1[3])

		if var_4_2 then
			arg_4_0:openStoryView(var_4_2)
		else
			arg_4_0:openStoryView()
		end

		table.insert(var_4_0, HandbookStoryView)
	elseif var_4_1 == JumpEnum.HandbookType.CG then
		arg_4_0:openCGView()
		table.insert(var_4_0, HandbookCGView)
	end

	return var_4_0
end

function var_0_0.openView(arg_5_0, arg_5_1)
	arg_5_0:markNotFirstHandbook()
	ViewMgr.instance:openView(ViewName.HandbookView, arg_5_1)
end

function var_0_0.openCharacterView(arg_6_0, arg_6_1)
	arg_6_0._openViewParam = arg_6_1
	arg_6_0._openViewName = var_0_0.OpenViewNameEnum.HandbookCharacterView

	HandbookRpc.instance:sendGetHandbookInfoRequest(arg_6_0._getHandbookInfoReply, arg_6_0)
end

function var_0_0.openEquipView(arg_7_0, arg_7_1)
	arg_7_0._openViewParam = arg_7_1
	arg_7_0._openViewName = var_0_0.OpenViewNameEnum.HandbookEquipView

	HandbookRpc.instance:sendGetHandbookInfoRequest(arg_7_0._getHandbookInfoReply, arg_7_0)
end

function var_0_0.openStoryView(arg_8_0, arg_8_1)
	arg_8_0._openViewParam = arg_8_1
	arg_8_0._openViewName = var_0_0.OpenViewNameEnum.HandbookStoryView

	HandbookRpc.instance:sendGetHandbookInfoRequest(arg_8_0._getHandbookInfoReply, arg_8_0)
end

function var_0_0._getHandbookInfoReply(arg_9_0)
	if not arg_9_0.viewNameDict then
		arg_9_0.viewNameDict = {
			[var_0_0.OpenViewNameEnum.HandbookCharacterView] = ViewName.HandBookCharacterSwitchView,
			[var_0_0.OpenViewNameEnum.HandbookEquipView] = ViewName.HandbookEquipView,
			[var_0_0.OpenViewNameEnum.HandbookStoryView] = ViewName.HandbookStoryView
		}
	end

	ViewMgr.instance:openView(arg_9_0.viewNameDict[arg_9_0._openViewName], arg_9_0._openViewParam)

	arg_9_0._openViewParam = nil
end

function var_0_0.openCGView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.HandbookCGView, arg_10_1)
end

function var_0_0.openCGDetailView(arg_11_0, arg_11_1)
	ViewMgr.instance:openView(ViewName.HandbookCGDetailView, arg_11_1)
end

function var_0_0.markNotFirstHandbook(arg_12_0)
	local var_12_0 = PlayerModel.instance:getMyUserId()
	local var_12_1 = PlayerPrefsKey.FirstHandbook .. tostring(var_12_0)

	PlayerPrefsHelper.setNumber(var_12_1, 1)
end

function var_0_0.isFirstHandbook(arg_13_0)
	local var_13_0 = PlayerModel.instance:getMyUserId()
	local var_13_1 = PlayerPrefsKey.FirstHandbook .. tostring(var_13_0)

	return PlayerPrefsHelper.getNumber(var_13_1, 0) <= 0
end

function var_0_0.openHandbookWeekWalkMapView(arg_14_0, arg_14_1)
	arg_14_0._openViewParam = arg_14_1

	WeekwalkRpc.instance:sendGetWeekwalkEndRequest(arg_14_0._getWeekWalkEndReply, arg_14_0)
end

function var_0_0._getWeekWalkEndReply(arg_15_0)
	ViewMgr.instance:openView(ViewName.HandbookWeekWalkMapView, arg_15_0._openViewParam)

	arg_15_0._openViewParam = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
