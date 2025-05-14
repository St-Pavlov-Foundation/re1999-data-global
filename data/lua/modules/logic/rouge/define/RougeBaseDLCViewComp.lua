module("modules.logic.rouge.define.RougeBaseDLCViewComp", package.seeall)

local var_0_0 = class("RougeBaseDLCViewComp", BaseViewExtended)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._isImmediate = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	if arg_5_0._isImmediate then
		arg_5_0:addEventCb(RougeDLCController.instance, RougeEvent.UpdateRougeVersion, arg_5_0._updateVersion, arg_5_0)
	end
end

function var_0_0._updateVersion(arg_6_0)
	local var_6_0 = arg_6_0:getSeason()
	local var_6_1 = arg_6_0:getVersions()

	arg_6_0:killAllChildView()

	for iter_6_0, iter_6_1 in pairs(var_6_1 or {}) do
		local var_6_2 = string.format("%s_%s_%s", arg_6_0.viewName, var_6_0, iter_6_1)
		local var_6_3 = _G[var_6_2]

		if var_6_3 then
			local var_6_4

			if var_6_3.ParentObjPath then
				var_6_4 = gohelper.findChild(arg_6_0.viewGO, var_6_3.ParentObjPath)
			end

			arg_6_0:openSubView(var_6_3, var_6_3.AssetUrl, var_6_4, arg_6_0.viewParam)
		end
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_updateVersion()
end

function var_0_0.getSeason(arg_8_0)
	return RougeOutsideModel.instance:season()
end

function var_0_0.getVersions(arg_9_0)
	local var_9_0 = RougeOutsideModel.instance:getRougeGameRecord()

	return var_9_0 and var_9_0:getVersionIds()
end

return var_0_0
