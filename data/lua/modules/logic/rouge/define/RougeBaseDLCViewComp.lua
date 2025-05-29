module("modules.logic.rouge.define.RougeBaseDLCViewComp", package.seeall)

local var_0_0 = class("RougeBaseDLCViewComp", BaseViewExtended)

function var_0_0._updateVersion(arg_1_0)
	local var_1_0 = arg_1_0:getSeason()
	local var_1_1 = arg_1_0:getVersions()

	arg_1_0:killAllChildView()

	for iter_1_0, iter_1_1 in pairs(var_1_1 or {}) do
		local var_1_2 = string.format("%s_%s_%s", arg_1_0.viewName, var_1_0, iter_1_1)
		local var_1_3 = _G[var_1_2]

		if var_1_3 then
			local var_1_4 = var_1_3.AssetUrl or arg_1_0.viewGO
			local var_1_5 = gohelper.findChild(arg_1_0.viewGO, var_1_3.ParentObjPath or "") or arg_1_0.viewGO

			arg_1_0:openSubView(var_1_3, var_1_4, var_1_5, arg_1_0.viewParam)
		end
	end
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:addEventCb(RougeDLCController.instance, RougeEvent.UpdateRougeVersion, arg_2_0._updateVersion, arg_2_0)
	arg_2_0:_updateVersion()
end

function var_0_0.getSeason(arg_3_0)
	return RougeOutsideModel.instance:season()
end

function var_0_0.getVersions(arg_4_0)
	local var_4_0 = RougeOutsideModel.instance:getRougeGameRecord()

	return var_4_0 and var_4_0:getVersionIds()
end

return var_0_0
