module("modules.logic.roomfishing.model.FishingFriendListModel", package.seeall)

local var_0_0 = class("FishingFriendListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0._selectedTab = nil
	arg_3_0.unFishingFriendList = {}
end

function var_0_0.updateFriendListInfo(arg_4_0, arg_4_1)
	arg_4_0.unFishingFriendList = {}

	if arg_4_1 then
		arg_4_0.unFishingFriendList = GameUtil.rpcInfosToList(arg_4_1, FishingFriendInfoMO)
	end

	arg_4_0:setFriendList()
end

function var_0_0.onSelectFriendTab(arg_5_0, arg_5_1)
	if arg_5_0._selectedTab == arg_5_1 then
		return
	end

	arg_5_0._selectedTab = arg_5_1

	arg_5_0:setFriendList()
end

local function var_0_1(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.userId or 0
	local var_6_1 = arg_6_1.userId or 0
	local var_6_2 = FishingModel.instance:getCurShowingUserId()
	local var_6_3 = var_6_0 == var_6_2

	if var_6_3 ~= (var_6_1 == var_6_2) then
		return var_6_3
	end

	local var_6_4 = FishingModel.instance:getMyFishingProgress(var_6_0)
	local var_6_5 = FishingModel.instance:getMyFishingProgress(var_6_1)

	if var_6_4 ~= var_6_5 then
		return var_6_5 < var_6_4
	end

	return var_6_0 < var_6_1
end

function var_0_0.setFriendList(arg_7_0)
	arg_7_0:clear()

	local var_7_0 = {}

	if arg_7_0._selectedTab == FishingEnum.FriendListTag.UnFishing then
		var_7_0 = arg_7_0.unFishingFriendList
	elseif arg_7_0._selectedTab == FishingEnum.FriendListTag.Fishing then
		var_7_0 = FishingModel.instance:getMyFishingFriendList()
	end

	table.sort(var_7_0, var_0_1)
	arg_7_0:setList(var_7_0)
end

function var_0_0.getSelectedTab(arg_8_0)
	return arg_8_0._selectedTab
end

var_0_0.instance = var_0_0.New()

return var_0_0
