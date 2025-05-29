module("modules.logic.rouge.controller.RougeDLCController", package.seeall)

local var_0_0 = class("RougeDLCController", BaseController)

function var_0_0.addDLC(arg_1_0, arg_1_1)
	if not arg_1_0:checkCanUpdateVersion(arg_1_1) then
		GameFacade.showToast(ToastEnum.CantUpdateVersion)

		return
	end

	local var_1_0 = arg_1_0:_getTargetDLCs(arg_1_1, true)
	local var_1_1 = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeDLCSettingSaveRequest(var_1_1, var_1_0)
end

function var_0_0.removeDLC(arg_2_0, arg_2_1)
	if not arg_2_0:checkCanUpdateVersion(arg_2_1) then
		GameFacade.showToast(ToastEnum.CantUpdateVersion)

		return
	end

	local var_2_0 = arg_2_0:_getTargetDLCs(arg_2_1, false)
	local var_2_1 = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeDLCSettingSaveRequest(var_2_1, var_2_0)
end

function var_0_0.checkCanUpdateVersion(arg_3_0, arg_3_1)
	if RougeModel.instance:inRouge() then
		return
	end

	if not lua_rouge_season.configDict[arg_3_1] then
		logError(string.format("无法挂移除《%s》DLC,原因:DLC配置不存在", arg_3_1))

		return
	end

	return true
end

function var_0_0._getTargetDLCs(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = RougeDLCSelectListModel.instance:getCurSelectVersions()

	if arg_4_2 then
		table.insert(var_4_0, arg_4_1)
	else
		tabletool.removeValue(var_4_0, arg_4_1)
	end

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	return var_4_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
