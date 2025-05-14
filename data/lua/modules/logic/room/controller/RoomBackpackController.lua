module("modules.logic.room.controller.RoomBackpackController", package.seeall)

local var_0_0 = class("RoomBackpackController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.clickCritterRareSort(arg_4_0, arg_4_1)
	local var_4_0 = RoomBackpackCritterListModel.instance:getIsSortByRareAscend()

	RoomBackpackCritterListModel.instance:setIsSortByRareAscend(not var_4_0)
	arg_4_0:refreshCritterBackpackList(arg_4_1)
end

function var_0_0.selectMatureFilterType(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = RoomBackpackCritterListModel.instance:getMatureFilterType()

	if var_5_0 and var_5_0 == arg_5_1 then
		return
	end

	RoomBackpackCritterListModel.instance:setMatureFilterType(arg_5_1)
	arg_5_0:refreshCritterBackpackList(arg_5_2)
end

function var_0_0.refreshCritterBackpackList(arg_6_0, arg_6_1)
	RoomBackpackCritterListModel.instance:setBackpackCritterList(arg_6_1)
end

function var_0_0.openCritterDecomposeView(arg_7_0)
	ViewMgr.instance:openView(ViewName.RoomCritterDecomposeView)
end

function var_0_0.refreshPropBackpackList(arg_8_0)
	RoomBackpackPropListModel.instance:setBackpackPropList()
end

var_0_0.instance = var_0_0.New()

return var_0_0
