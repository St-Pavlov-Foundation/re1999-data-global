module("modules.logic.help.model.HelpModel", package.seeall)

local var_0_0 = class("HelpModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._targetPageIndex = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._targetPageIndex = 0
end

function var_0_0.setTargetPageIndex(arg_3_0, arg_3_1)
	arg_3_0._targetPageIndex = arg_3_1
end

function var_0_0.getTargetPageIndex(arg_4_0)
	return arg_4_0._targetPageIndex
end

function var_0_0.updateShowedHelpId(arg_5_0)
	local var_5_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ShowHelpIds)

	if string.nilorempty(var_5_0) then
		arg_5_0.showedHelpIdList = {}
	elseif string.sub(var_5_0, 1, 1) == "L" then
		arg_5_0.showedHelpIdList = NumberCompressUtil.decompress(string.sub(var_5_0, 2))
	else
		arg_5_0.showedHelpIdList = string.splitToNumber(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ShowHelpIds), "#")
	end
end

function var_0_0.isShowedHelp(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return false
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.showedHelpIdList) do
		if iter_6_1 == arg_6_1 then
			return true
		end
	end

	return false
end

function var_0_0.setShowedHelp(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	if arg_7_0:isShowedHelp(arg_7_1) then
		return
	end

	table.insert(arg_7_0.showedHelpIdList, arg_7_1)
	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.ShowHelpIds, "L" .. NumberCompressUtil.compress(arg_7_0.showedHelpIdList))
end

var_0_0.instance = var_0_0.New()

return var_0_0
