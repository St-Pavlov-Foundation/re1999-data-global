module("modules.logic.rouge.view.RougeCollectionBaseSlotCellItem", package.seeall)

local var_0_0 = class("RougeCollectionBaseSlotCellItem", UserDataDispose)

function var_0_0.onInit(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()
	arg_1_0:_onInitView(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:_editableInitView()
end

function var_0_0._onInitView(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.viewGO = arg_2_1
	arg_2_0._cellPosX = arg_2_2
	arg_2_0._cellPosY = arg_2_3
	arg_2_0._curLineState = RougeEnum.LineState.Grey
	arg_2_0._curInsideLines = nil
	arg_2_0._cellLineNameMap = arg_2_4.cellLineNameMap
	arg_2_0._cellWidth = arg_2_4.cellWidth
	arg_2_0._cellHeight = arg_2_4.cellHeight
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0:buildLineTranMap()
	arg_3_0:initSlotCellLines()
end

local var_0_1 = {
	[RougeEnum.SlotCellDirection.Top] = "top",
	[RougeEnum.SlotCellDirection.Bottom] = "bottom",
	[RougeEnum.SlotCellDirection.Left] = "left",
	[RougeEnum.SlotCellDirection.Right] = "right"
}

function var_0_0.buildLineTranMap(arg_4_0)
	arg_4_0._directionTranMap = arg_4_0:getUserDataTb_()

	for iter_4_0, iter_4_1 in pairs(RougeEnum.SlotCellDirection) do
		arg_4_0:buildSingleLineTranMap(iter_4_1, arg_4_0._directionTranMap)
	end
end

local var_0_2 = 2

function var_0_0.buildSingleLineTranMap(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 and arg_5_2 then
		local var_5_0 = var_0_1[arg_5_1]
		local var_5_1 = gohelper.findChildImage(arg_5_0.viewGO, var_5_0)

		arg_5_2[arg_5_1] = var_5_1

		recthelper.setSize(var_5_1.transform, arg_5_0._cellWidth, var_0_2)
	end
end

function var_0_0.initSlotCellLines(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:chechCellHasPlace()
	local var_6_2
	local var_6_3 = RougeEnum.LineState.Grey

	if var_6_0 then
		var_6_2 = arg_6_0:getInsideLines(var_6_1)
		var_6_3 = RougeEnum.LineState.Green
	end

	arg_6_0:updateCellState(var_6_3)
	arg_6_0:hideInsideLines(var_6_2)
end

function var_0_0.chechCellHasPlace(arg_7_0)
	return false, nil
end

function var_0_0.getInsideLines(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = RougeCollectionModel.instance:getSlotFilledCollectionId(arg_8_0._cellPosX + 1, arg_8_0._cellPosY)
	local var_8_2 = RougeCollectionModel.instance:getSlotFilledCollectionId(arg_8_0._cellPosX - 1, arg_8_0._cellPosY)
	local var_8_3 = RougeCollectionModel.instance:getSlotFilledCollectionId(arg_8_0._cellPosX, arg_8_0._cellPosY - 1)
	local var_8_4 = RougeCollectionModel.instance:getSlotFilledCollectionId(arg_8_0._cellPosX, arg_8_0._cellPosY + 1)

	if var_8_1 == arg_8_1 then
		table.insert(var_8_0, RougeEnum.SlotCellDirection.Right)
	end

	if var_8_2 == arg_8_1 then
		table.insert(var_8_0, RougeEnum.SlotCellDirection.Left)
	end

	if var_8_3 == arg_8_1 then
		table.insert(var_8_0, RougeEnum.SlotCellDirection.Top)
	end

	if var_8_4 == arg_8_1 then
		table.insert(var_8_0, RougeEnum.SlotCellDirection.Bottom)
	end

	return var_8_0
end

function var_0_0.onPlaceCollection(arg_9_0, arg_9_1)
	arg_9_0:updateCellState(RougeEnum.LineState.Green)
	arg_9_0:hideInsideLines(arg_9_1)
end

function var_0_0.revertCellState(arg_10_0, arg_10_1)
	local var_10_0 = RougeCollectionModel.instance:getSlotFilledCollectionId(arg_10_0._cellPosX, arg_10_0._cellPosY)

	if var_10_0 and arg_10_1 and var_10_0 == arg_10_1 then
		arg_10_0:updateCellState()

		return
	end

	arg_10_0:initSlotCellLines()
end

function var_0_0.hideInsideLines(arg_11_0, arg_11_1)
	if arg_11_1 then
		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			local var_11_0 = arg_11_0._directionTranMap[iter_11_1]

			gohelper.setActive(var_11_0.gameObject, false)
		end
	end
end

function var_0_0.updateCellState(arg_12_0, arg_12_1)
	arg_12_0._curCellState = arg_12_1 or RougeEnum.LineState.Grey

	arg_12_0:updateAllCellLine(arg_12_0._curCellState)
end

function var_0_0.updateAllCellLine(arg_13_0, arg_13_1)
	if arg_13_0._directionTranMap then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._directionTranMap) do
			local var_13_0 = arg_13_0._cellLineNameMap and arg_13_0._cellLineNameMap[arg_13_1]

			gohelper.setActive(iter_13_1.transform, true)
			UISpriteSetMgr.instance:setRougeSprite(iter_13_1, var_13_0)
		end
	end
end

function var_0_0.getSlotCellPosition(arg_14_0)
	return arg_14_0._cellPosX, arg_14_0._cellPosY
end

function var_0_0.setItemVisible(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0.viewGO, arg_15_1)
end

function var_0_0.destroy(arg_16_0)
	arg_16_0:__onDispose()
end

return var_0_0
