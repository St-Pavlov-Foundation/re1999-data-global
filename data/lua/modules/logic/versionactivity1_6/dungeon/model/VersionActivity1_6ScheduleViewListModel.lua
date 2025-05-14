module("modules.logic.versionactivity1_6.dungeon.model.VersionActivity1_6ScheduleViewListModel", package.seeall)

local var_0_0 = class("VersionActivity1_6ScheduleViewListModel", ListScrollModel)

function var_0_0.setStaticData(arg_1_0, arg_1_1)
	arg_1_0._staticData = arg_1_1
end

function var_0_0.getStaticData(arg_2_0)
	return arg_2_0._staticData
end

var_0_0.instance = var_0_0.New()

return var_0_0
