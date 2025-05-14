module("modules.logic.rouge.model.RougeDLCSelectListModel", package.seeall)

local var_0_0 = class("RougeDLCSelectListModel", MixScrollModel)
local var_0_1 = 1

function var_0_0.onInit(arg_1_0)
	arg_1_0:_initList()
end

function var_0_0._initList(arg_2_0)
	local var_2_0 = RougeOutsideModel.instance:season()
	local var_2_1 = {}

	arg_2_0._recordInfo = RougeOutsideModel.instance:getRougeGameRecord()

	for iter_2_0, iter_2_1 in ipairs(lua_rouge_season.configList) do
		if iter_2_1.season == var_2_0 then
			table.insert(var_2_1, iter_2_1)
		end
	end

	arg_2_0:setList(var_2_1)
	arg_2_0:selectCell(var_0_1, true)
end

function var_0_0.updateVersions(arg_3_0)
	arg_3_0:onModelUpdate()
end

function var_0_0.getCurSelectVersions(arg_4_0)
	return arg_4_0._recordInfo and arg_4_0._recordInfo:getVersionIds()
end

function var_0_0.isAddDLC(arg_5_0, arg_5_1)
	return arg_5_0._recordInfo and arg_5_0._recordInfo:isSelectDLC(arg_5_1)
end

local var_0_2 = 220
local var_0_3 = 310

function var_0_0.getInfoList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:getCount()

	for iter_6_0 = 1, var_6_1 do
		local var_6_2 = var_6_1 <= iter_6_0 and var_0_3 or var_0_2
		local var_6_3 = SLFramework.UGUI.MixCellInfo.New(1, var_6_2, nil)

		table.insert(var_6_0, var_6_3)
	end

	return var_6_0
end

function var_0_0.selectCell(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getByIndex(arg_7_1)

	if not var_7_0 then
		return
	end

	arg_7_0._selectIndex = arg_7_1

	RougeDLCController.instance:dispatchEvent(RougeEvent.OnSelectDLC, var_7_0.id)
end

function var_0_0.getCurSelectIndex(arg_8_0)
	return arg_8_0._selectIndex or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
