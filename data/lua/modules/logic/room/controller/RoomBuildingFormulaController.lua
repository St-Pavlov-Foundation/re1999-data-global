module("modules.logic.room.controller.RoomBuildingFormulaController", package.seeall)

local var_0_0 = class("RoomBuildingFormulaController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.resetSelectFormulaStrId(arg_5_0)
	RoomFormulaListModel.instance:resetSelectFormulaStrId()
end

function var_0_0.setSelectFormulaStrId(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0._waitingSelectFormulaParam then
		return
	end

	local var_6_0 = RoomFormulaModel.instance:getFormulaMo(arg_6_1)

	if not var_6_0 then
		return
	end

	local var_6_1 = false
	local var_6_2 = arg_6_1

	if arg_6_1 == RoomFormulaListModel.instance:getSelectFormulaStrId() and not arg_6_2 then
		var_6_2 = var_6_0:getParentStrId()
		var_6_1 = true
	end

	arg_6_0._waitingSelectFormulaParam = {
		formulaStrId = var_6_2,
		isCollapse = var_6_1,
		treeLevel = arg_6_3
	}

	if arg_6_3 and arg_6_0:_checkTreeLevel(arg_6_3) then
		RoomMapController.instance:dispatchEvent(RoomEvent.UIFormulaIdTreeLevelHideAnim, arg_6_3)
		TaskDispatcher.runDelay(arg_6_0._onDelaySelectFormulaStrId, arg_6_0, RoomProductLineEnum.AnimTime.TreeAnim)
	else
		arg_6_0:_onDelaySelectFormulaStrId()
	end
end

function var_0_0._onDelaySelectFormulaStrId(arg_7_0)
	if arg_7_0._waitingSelectFormulaParam then
		local var_7_0 = RoomFormulaListModel.instance:getSelectFormulaStrId()
		local var_7_1 = arg_7_0._waitingSelectFormulaParam.formulaStrId
		local var_7_2 = arg_7_0._waitingSelectFormulaParam.isCollapse
		local var_7_3 = arg_7_0._waitingSelectFormulaParam.treeLevel

		arg_7_0._waitingSelectFormulaParam = nil

		RoomFormulaListModel.instance:refreshRankDiff()

		if var_7_3 and not arg_7_0:_checkTreeLevel(var_7_3) then
			RoomMapController.instance:dispatchEvent(RoomEvent.UIFormulaIdTreeLevelShowAnim, var_7_3)
		end

		RoomMapController.instance:dispatchEvent(RoomEvent.UIFormulaIdTreeLevelMoveAnim)
		RoomFormulaListModel.instance:setSelectFormulaStrId(var_7_1)
		RoomMapController.instance:dispatchEvent(RoomEvent.SelectFormulaIdChanged, var_7_0, var_7_2)
	end
end

function var_0_0._checkTreeLevel(arg_8_0, arg_8_1)
	local var_8_0 = RoomFormulaListModel.instance:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = iter_8_1:getFormulaTreeLevel()

		if var_8_1 and arg_8_1 < var_8_1 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
