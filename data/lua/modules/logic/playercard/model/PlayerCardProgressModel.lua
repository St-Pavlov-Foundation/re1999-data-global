module("modules.logic.playercard.model.PlayerCardProgressModel", package.seeall)

local var_0_0 = class("PlayerCardProgressModel", ListScrollModel)

function var_0_0.refreshList(arg_1_0)
	if #arg_1_0._scrollViews == 0 then
		return
	end

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(PlayerCardConfig.instance:getCardProgressList()) do
		local var_1_1 = {
			index = iter_1_0,
			config = iter_1_1,
			info = arg_1_0.cardInfo
		}

		table.insert(var_1_0, var_1_1)
	end

	table.sort(var_1_0, SortUtil.tableKeyLower({
		"index"
	}))
	arg_1_0:setList(var_1_0)
end

function var_0_0.initSelectData(arg_2_0, arg_2_1)
	arg_2_0.cardInfo = arg_2_1

	arg_2_0:initSelectList()

	arg_2_0._lastSelectList = nil

	if not arg_2_0._lastSelectList then
		arg_2_0._lastSelectList = tabletool.copy(arg_2_0.selectList)
	end

	arg_2_0:setEmptyPosList()
end

function var_0_0.initSelectList(arg_3_0)
	arg_3_0.selectList = {}
	arg_3_0._lastSelectList = nil

	local var_3_0 = arg_3_0.cardInfo:getProgressSetting()

	if var_3_0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			table.insert(arg_3_0.selectList, iter_3_1)
		end
	end
end

function var_0_0.clickItem(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	if arg_4_0:checkhasMO(arg_4_1) then
		arg_4_0:removeSelect(arg_4_1)
	else
		arg_4_0:addSelect(arg_4_1)
	end

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshProgressView, arg_4_0.selectList)
end

function var_0_0.checkhasMO(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.selectList) do
		if iter_5_1[2] == arg_5_1 then
			return true
		end
	end

	return false
end

function var_0_0.addSelect(arg_6_0, arg_6_1)
	if #arg_6_0.selectList >= PlayerCardEnum.MaxProgressCardNum then
		GameFacade.showToast(ToastEnum.PlayerCardMaxSelect)

		return
	end

	arg_6_0:addSelectMo(arg_6_1)
	arg_6_0:setEmptyPosList()
	arg_6_0:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function var_0_0.removeSelect(arg_7_0, arg_7_1)
	arg_7_0:removeSelectMo(arg_7_1)
	arg_7_0:setEmptyPosList()
	arg_7_0:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function var_0_0.getSelectIndex(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.selectList) do
		if iter_8_1[2] == arg_8_1 then
			return iter_8_1[1]
		end
	end
end

function var_0_0.getemptypos(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.emptyPosList) do
		if iter_9_1 then
			return iter_9_0
		end
	end
end

function var_0_0.setEmptyPosList(arg_10_0)
	arg_10_0.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	for iter_10_0 = 1, 5 do
		for iter_10_1, iter_10_2 in ipairs(arg_10_0.selectList) do
			if iter_10_2[1] == iter_10_0 then
				arg_10_0.emptyPosList[iter_10_0] = false
			end
		end
	end
end

function var_0_0.getEmptyPosList(arg_11_0)
	return arg_11_0.emptyPosList
end

function var_0_0.addSelectMo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getemptypos()
	local var_12_1 = {
		var_12_0,
		arg_12_1
	}

	table.insert(arg_12_0.selectList, var_12_1)
end

function var_0_0.removeSelectMo(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.selectList) do
		if iter_13_1[2] == arg_13_1 then
			table.remove(arg_13_0.selectList, iter_13_0)
		end
	end
end

function var_0_0.checkDiff(arg_14_0)
	if #arg_14_0._lastSelectList ~= #arg_14_0.selectList then
		return true
	else
		local var_14_0 = #arg_14_0.selectList

		for iter_14_0 = 1, var_14_0 do
			if arg_14_0._lastSelectList[iter_14_0][2] ~= arg_14_0.selectList[iter_14_0][2] then
				return true
			end
		end
	end

	return false
end

function var_0_0.reselectData(arg_15_0)
	arg_15_0:initSelectList()
	arg_15_0:refreshList()
	arg_15_0:setEmptyPosList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshProgressView, arg_15_0.selectList)
end

function var_0_0.confirmData(arg_16_0)
	if not arg_16_0.selectList or not arg_16_0.cardInfo then
		return
	end

	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.selectList) do
		local var_16_1 = table.concat(iter_16_1, "#")

		table.insert(var_16_0, var_16_1)
	end

	local var_16_2 = table.concat(var_16_0, "|")

	PlayerCardRpc.instance:sendSetPlayerCardProgressSettingRequest(var_16_2)

	arg_16_0._lastSelectList = arg_16_0.selectList
end

function var_0_0.getSelectNum(arg_17_0)
	return #arg_17_0.selectList
end

var_0_0.instance = var_0_0.New()

return var_0_0
