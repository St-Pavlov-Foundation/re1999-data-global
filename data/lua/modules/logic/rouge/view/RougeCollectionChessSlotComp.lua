module("modules.logic.rouge.view.RougeCollectionChessSlotComp", package.seeall)

local var_0_0 = class("RougeCollectionChessSlotComp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosetipArea = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_closetipArea")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gochessContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_chessContainer")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer")
	arg_1_0._gomeshItem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	arg_1_0._godragContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragContainer")
	arg_1_0._gocellModel = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_cellModel")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragContainer/#go_chessitem")
	arg_1_0._goraychessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_raychessitem")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_block")
	arg_1_0._scrollbag = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_bag")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_bag/Viewport/#go_Content")
	arg_1_0._gocollectionItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_bag/Viewport/#go_Content/#go_collectionItem")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._gosingleTipsContent = gohelper.findChild(arg_1_0.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	arg_1_0._gosingleAttributeItem = gohelper.findChild(arg_1_0.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateSlotCellState, arg_4_0.updateSlotCellState, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, arg_4_0.placeCollection2SlotAreaSucc, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.NullSpace2PlaceCollection, arg_4_0.onNullSpace2PlaceCollection, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, arg_4_0.placeCollection2SlotAreaFailed, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, arg_4_0.deleteSlotCollection, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, arg_4_0.updateCollectionEnchant, arg_4_0)

	arg_4_0._coverCells = arg_4_0:getUserDataTb_()
	arg_4_0._conflictIds = arg_4_0:getUserDataTb_()
	arg_4_0._placeCollectionMap = {}
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = RougeCollectionModel.instance:getCurSlotAreaSize()

	arg_5_0:initCollectionSlot(var_5_0.col, var_5_0.row)
	arg_5_0:updateAllFilledCellState()
end

function var_0_0.initCollectionSlot(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1 = arg_6_1 or 0
	arg_6_2 = arg_6_2 or 0

	local var_6_0 = RougeCollectionHelper.CollectionSlotCellSize.x
	local var_6_1 = RougeCollectionHelper.CollectionSlotCellSize.y
	local var_6_2 = gohelper.findChild(arg_6_0.viewGO, "chessboard")

	recthelper.setWidth(var_6_2.transform, arg_6_1 * var_6_0)
	recthelper.setHeight(var_6_2.transform, arg_6_2 * var_6_1)
	recthelper.setAnchor(arg_6_0._gomeshContainer.transform, var_6_0 / 2, -var_6_1 / 2)
	recthelper.setAnchor(arg_6_0._godragContainer.transform, var_6_0 / 2, -var_6_1 / 2)
	recthelper.setAnchor(arg_6_0._gocellModel.transform, var_6_0 / 2, -var_6_1 / 2)

	for iter_6_0 = 0, arg_6_2 - 1 do
		for iter_6_1 = 0, arg_6_1 - 1 do
			arg_6_0:createCollectionSlotCell(iter_6_1, iter_6_0)
		end
	end
end

function var_0_0.updateAllFilledCellState(arg_7_0)
	local var_7_0 = RougeCollectionModel.instance:getSlotAreaCollection()

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			arg_7_0:placeCollection2SlotAreaSucc(iter_7_1)
		end
	end
end

function var_0_0.getCollectionSlotCell(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0._slotCellTab and arg_8_0._slotCellTab[arg_8_1] and arg_8_0._slotCellTab[arg_8_1][arg_8_2]
end

function var_0_0.createCollectionSlotCell(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = gohelper.cloneInPlace(arg_9_0._gomeshItem, string.format("%s_%s", arg_9_1, arg_9_2))
	local var_9_1, var_9_2 = RougeCollectionHelper.slotPos2AnchorPos(Vector2(arg_9_1, arg_9_2))

	recthelper.setAnchor(var_9_0.transform, var_9_1, var_9_2)
	gohelper.setActive(var_9_0, true)

	local var_9_3 = RougeCollectionSlotCellItem.New()

	var_9_3:onInit(var_9_0, arg_9_1, arg_9_2, RougeCollectionHelper.ResultReViewCollectionSlotParam)

	arg_9_0._slotCellTab = arg_9_0._slotCellTab or arg_9_0:getUserDataTb_()
	arg_9_0._slotCellTab[arg_9_1] = arg_9_0._slotCellTab[arg_9_1] or arg_9_0:getUserDataTb_()
	arg_9_0._slotCellTab[arg_9_1][arg_9_2] = var_9_3
end

function var_0_0.updateSlotCellState(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_1.id

	arg_10_0:revertCoverCells(var_10_0)
	arg_10_0:revertConflictCells()
	arg_10_0:updateSlotCells(arg_10_1)
end

function var_0_0.updateSlotCells(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.id
	local var_11_1 = arg_11_1.cfgId
	local var_11_2 = arg_11_1:getRotation()
	local var_11_3 = arg_11_1:getCenterSlotPos()
	local var_11_4 = RougeCollectionConfig.instance:getRotateEditorParam(var_11_1, var_11_2, RougeEnum.CollectionEditorParamType.Shape)
	local var_11_5 = RougeCollectionConfig.instance:getRotateEditorParam(var_11_1, var_11_2, RougeEnum.CollectionEditorParamType.Effect)
	local var_11_6 = RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(var_11_1, var_11_2)

	if not var_11_4 then
		return
	end

	local var_11_7 = false

	for iter_11_0, iter_11_1 in ipairs(var_11_4) do
		local var_11_8 = RougeCollectionHelper.getCollectionCellSlotPos(var_11_3, iter_11_1)
		local var_11_9 = arg_11_0:getCollectionSlotCell(var_11_8.x, var_11_8.y)
		local var_11_10 = RougeCollectionModel.instance:getSlotFilledCollectionId(var_11_8.x, var_11_8.y)

		if var_11_9 and var_11_10 > 0 and var_11_10 ~= var_11_0 then
			arg_11_0._conflictIds[var_11_10] = true
			var_11_7 = true
		end
	end

	if var_11_7 then
		arg_11_0:refreshConflictCells(var_11_1)

		return
	end

	local var_11_11 = arg_11_1:getLeftTopPos()
	local var_11_12 = RougeCollectionHelper.checkIsCollectionSlotArea(var_11_1, var_11_11, var_11_2, true)

	for iter_11_2, iter_11_3 in ipairs(var_11_4) do
		local var_11_13 = RougeCollectionHelper.getCollectionCellSlotPos(var_11_3, iter_11_3)
		local var_11_14 = arg_11_0:getCollectionSlotCell(var_11_13.x, var_11_13.y)

		if var_11_14 then
			local var_11_15 = RougeCollectionHelper.getSlotCellInsideLine(var_11_6, iter_11_3)

			if var_11_12 then
				var_11_14:updateCellState(RougeEnum.LineState.Red)
				var_11_14:hideInsideLines(var_11_15)
			else
				var_11_14:onCoverCollection(var_11_0, var_11_15)
			end

			arg_11_0._coverCells[var_11_0] = arg_11_0._coverCells[var_11_0] or {}

			table.insert(arg_11_0._coverCells[var_11_0], var_11_14)
		end
	end

	for iter_11_4, iter_11_5 in ipairs(var_11_5) do
		local var_11_16 = RougeCollectionHelper.getCollectionCellSlotPos(var_11_3, iter_11_5)
		local var_11_17 = arg_11_0:getCollectionSlotCell(var_11_16.x, var_11_16.y)

		if var_11_17 then
			var_11_17:updateCellState(RougeEnum.LineState.Blue)

			arg_11_0._coverCells[var_11_0] = arg_11_0._coverCells[var_11_0] or {}

			table.insert(arg_11_0._coverCells[var_11_0], var_11_17)
		end
	end
end

function var_0_0.foreachCollectionCells(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_1 or not arg_12_2 or not arg_12_3 then
		return
	end

	local var_12_0 = arg_12_1.cfgId
	local var_12_1 = arg_12_1:getRotation()
	local var_12_2 = RougeCollectionConfig.instance:getShapeMatrix(var_12_0, var_12_1)

	if var_12_2 then
		for iter_12_0, iter_12_1 in ipairs(var_12_2) do
			for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
				if iter_12_3 and iter_12_3 > 0 then
					arg_12_2(arg_12_3, arg_12_1, var_12_2, iter_12_0, iter_12_2)
				end
			end
		end
	end
end

function var_0_0.onCoverCellCallBack(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_1:getLeftTopPos()
	local var_13_1 = var_13_0.y + arg_13_4 - 1
	local var_13_2 = var_13_0.x + arg_13_3 - 1
	local var_13_3 = arg_13_0:getCollectionSlotCell(var_13_1, var_13_2)

	if var_13_3 then
		local var_13_4 = arg_13_0:getSlotCellInsideLine(arg_13_2, arg_13_4, arg_13_3)
		local var_13_5 = arg_13_1.id

		var_13_3:onCoverCollection(var_13_5, var_13_4)

		arg_13_0._coverCells[var_13_5] = arg_13_0._coverCells[var_13_5] or {}

		table.insert(arg_13_0._coverCells[var_13_5], var_13_3)
	end
end

function var_0_0.getSlotCellInsideLine(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}

	if arg_14_0:isCellExist(arg_14_1, arg_14_2, arg_14_3 - 1) then
		table.insert(var_14_0, RougeEnum.SlotCellDirection.Top)
	end

	if arg_14_0:isCellExist(arg_14_1, arg_14_2, arg_14_3 + 1) then
		table.insert(var_14_0, RougeEnum.SlotCellDirection.Bottom)
	end

	if arg_14_0:isCellExist(arg_14_1, arg_14_2 - 1, arg_14_3) then
		table.insert(var_14_0, RougeEnum.SlotCellDirection.Left)
	end

	if arg_14_0:isCellExist(arg_14_1, arg_14_2 + 1, arg_14_3) then
		table.insert(var_14_0, RougeEnum.SlotCellDirection.Right)
	end

	return var_14_0
end

function var_0_0.isCellExist(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	return arg_15_1[arg_15_2] and arg_15_1[arg_15_2][arg_15_3] and arg_15_1[arg_15_2][arg_15_3] > 0
end

function var_0_0.refreshConflictCells(arg_16_0, arg_16_1)
	local var_16_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_16_1)
	local var_16_1 = var_16_0 and var_16_0.type == RougeEnum.CollectionType.Enchant
	local var_16_2 = var_16_1 and RougeEnum.LineState.Green or RougeEnum.LineState.Red

	for iter_16_0, iter_16_1 in pairs(arg_16_0._conflictIds) do
		if arg_16_0._coverCells and arg_16_0._coverCells[iter_16_0] then
			local var_16_3 = false

			if var_16_1 then
				local var_16_4 = RougeCollectionModel.instance:getCollectionByUid(iter_16_0)
				local var_16_5 = var_16_4 and var_16_4.cfgId
				local var_16_6 = RougeCollectionConfig.instance:getCollectionCfg(var_16_5)

				var_16_3 = (var_16_6 and var_16_6.holeNum or 0) > 0
				var_16_2 = var_16_3 and RougeEnum.LineState.Green or RougeEnum.LineState.Red
			else
				var_16_2 = RougeEnum.LineState.Red
			end

			for iter_16_2, iter_16_3 in ipairs(arg_16_0._coverCells[iter_16_0]) do
				local var_16_7, var_16_8 = iter_16_3:getSlotCellPosition()
				local var_16_9 = arg_16_0:getInsideLines(var_16_7, var_16_8, iter_16_0)

				iter_16_3:updateCellState(var_16_2)
				iter_16_3:hideInsideLines(var_16_9)
			end

			if var_16_3 then
				break
			end
		end
	end
end

function var_0_0.getInsideLines(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = Vector2(arg_17_1, arg_17_2)
	local var_17_1 = var_17_0 - Vector2(0, 1)
	local var_17_2 = var_17_0 + Vector2(0, 1)
	local var_17_3 = var_17_0 - Vector2(1, 0)
	local var_17_4 = var_17_0 + Vector2(1, 0)
	local var_17_5 = {}

	if RougeCollectionModel.instance:getSlotFilledCollectionId(var_17_1.x, var_17_1.y) == arg_17_3 then
		table.insert(var_17_5, RougeEnum.SlotCellDirection.Top)
	end

	if RougeCollectionModel.instance:getSlotFilledCollectionId(var_17_2.x, var_17_2.y) == arg_17_3 then
		table.insert(var_17_5, RougeEnum.SlotCellDirection.Bottom)
	end

	if RougeCollectionModel.instance:getSlotFilledCollectionId(var_17_3.x, var_17_3.y) == arg_17_3 then
		table.insert(var_17_5, RougeEnum.SlotCellDirection.Left)
	end

	if RougeCollectionModel.instance:getSlotFilledCollectionId(var_17_4.x, var_17_4.y) == arg_17_3 then
		table.insert(var_17_5, RougeEnum.SlotCellDirection.Right)
	end

	return var_17_5
end

function var_0_0.placeCollection2SlotAreaSucc(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	local var_18_0 = arg_18_1 and arg_18_1.id

	if arg_18_0._placeCollectionMap[var_18_0] then
		arg_18_0._placeCollectionMap[var_18_0] = nil
	end

	local var_18_1 = arg_18_1:getRotation()
	local var_18_2 = RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(arg_18_1.cfgId, var_18_1)
	local var_18_3 = arg_18_1:getCenterSlotPos()
	local var_18_4 = RougeCollectionConfig.instance:getRotateEditorParam(arg_18_1.cfgId, var_18_1, RougeEnum.CollectionEditorParamType.Shape)

	arg_18_0:revertCoverCells(arg_18_1.id)

	for iter_18_0, iter_18_1 in ipairs(var_18_4) do
		local var_18_5 = RougeCollectionHelper.getCollectionCellSlotPos(var_18_3, iter_18_1)
		local var_18_6 = arg_18_0:getCollectionSlotCell(var_18_5.x, var_18_5.y)

		if var_18_6 then
			local var_18_7 = RougeCollectionHelper.getSlotCellInsideLine(var_18_2, iter_18_1)

			var_18_6:onPlaceCollection(var_18_7)

			arg_18_0._placeCollectionMap[var_18_0] = arg_18_0._placeCollectionMap[var_18_0] or {}
			arg_18_0._coverCells[var_18_0] = arg_18_0._coverCells[var_18_0] or {}

			table.insert(arg_18_0._placeCollectionMap[var_18_0], var_18_5)
			table.insert(arg_18_0._coverCells[var_18_0], var_18_6)
		end
	end
end

function var_0_0.placeCollection2SlotAreaFailed(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:revertCoverCells(arg_19_1)
	arg_19_0:revertConflictCells()

	if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(arg_19_1) and not arg_19_2 then
		local var_19_0 = RougeCollectionModel.instance:getCollectionByUid(arg_19_1)

		arg_19_0:placeCollection2SlotAreaSucc(var_19_0)
	end
end

function var_0_0.revertCoverCells(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._coverCells and arg_20_0._coverCells[arg_20_1]

	if var_20_0 then
		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			iter_20_1:revertCellState(arg_20_1)
		end

		arg_20_0._coverCells[arg_20_1] = {}
	end
end

function var_0_0.revertConflictCells(arg_21_0)
	if arg_21_0._conflictIds then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._conflictIds) do
			local var_21_0 = arg_21_0._coverCells and arg_21_0._coverCells[iter_21_0]

			if var_21_0 then
				for iter_21_2, iter_21_3 in pairs(var_21_0) do
					iter_21_3:revertCellState()
				end
			end
		end

		arg_21_0._conflictIds = {}
	end
end

function var_0_0.deleteSlotCollection(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._coverCells and arg_22_0._coverCells[arg_22_1]

	if var_22_0 then
		for iter_22_0, iter_22_1 in ipairs(var_22_0) do
			iter_22_1:revertCellState()
		end

		var_22_0[arg_22_1] = nil
	end

	arg_22_0:revertConflictCells()
end

function var_0_0.updateCollectionEnchant(arg_23_0, arg_23_1)
	local var_23_0 = RougeCollectionModel.instance:getCollectionByUid(arg_23_1)

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0:getAllEnchantId()

	if not var_23_1 then
		return
	end

	for iter_23_0, iter_23_1 in pairs(var_23_1) do
		local var_23_2 = arg_23_0._coverCells and arg_23_0._coverCells[iter_23_1]

		if var_23_2 then
			for iter_23_2, iter_23_3 in pairs(var_23_2) do
				iter_23_3:updateCellState(RougeEnum.LineState.Grey)
			end

			arg_23_0._coverCells[iter_23_1] = nil
		end
	end
end

function var_0_0.onNullSpace2PlaceCollection(arg_24_0, arg_24_1)
	arg_24_0:updateSlotCellState(arg_24_1)
end

function var_0_0.disposeAllSlotCells(arg_25_0)
	if arg_25_0._slotCellTab then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._slotCellTab) do
			for iter_25_2, iter_25_3 in pairs(iter_25_1) do
				iter_25_3:destroy()
			end
		end

		arg_25_0._slotCellTab = nil
	end

	arg_25_0._coverCells = nil
end

function var_0_0.onClose(arg_26_0)
	arg_26_0:disposeAllSlotCells()
end

function var_0_0.onDestroyView(arg_27_0)
	return
end

return var_0_0
