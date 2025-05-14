module("modules.logic.versionactivity2_4.wuerlixi.controller.WuErLiXiController", package.seeall)

local var_0_0 = class("WuErLiXiController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.enterLevelView(arg_4_0)
	Activity180Rpc.instance:sendGet180InfosRequest(VersionActivity2_4Enum.ActivityId.WuErLiXi, arg_4_0._onRecInfo, arg_4_0)
end

function var_0_0._onRecInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 == 0 then
		ViewMgr.instance:openView(ViewName.WuErLiXiLevelView)
	end
end

function var_0_0.enterGameView(arg_6_0, arg_6_1, arg_6_2)
	ViewMgr.instance:openView(ViewName.WuErLiXiGameView, arg_6_1, arg_6_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
