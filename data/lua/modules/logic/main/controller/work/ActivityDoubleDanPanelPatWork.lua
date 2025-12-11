module("modules.logic.main.controller.work.ActivityDoubleDanPanelPatWork", package.seeall)

local var_0_0 = class("ActivityDoubleDanPanelPatWork", ActivityRoleSignWorkBase)

function var_0_0.onGetViewNames(arg_1_0)
	local var_1_0 = PatFaceConfig.instance:getPatFaceViewName(arg_1_0._patFaceId)

	if not string.nilorempty(var_1_0) then
		return {
			var_1_0
		}
	end

	local var_1_1 = GameBranchMgr.instance:Vxax_ViewName("DoubleDanActivity_PanelView", ViewName.V3a3_DoubleDanActivity_PanelView)

	return {
		var_1_1
	}
end

function var_0_0.onGetActIds(arg_2_0)
	return {
		(ActivityType101Config.instance:getDoubleDanActId())
	}
end

return var_0_0
