module("modules.logic.dungeon.view.puzzle.PutCubeGameView", package.seeall)

local var_0_0 = class("PutCubeGameView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochessContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_chessContainer")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer")
	arg_1_0._gomeshItem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	arg_1_0._godragAnchor = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor")
	arg_1_0._godragContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer")
	arg_1_0._gocellModel = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor/#go_cellModel")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_chessitem")
	arg_1_0._goraychessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_raychessitem")
	arg_1_0._scrollinspiration = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_inspiration")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_inspiration/Viewport/#go_Content")
	arg_1_0._goinspirationItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_inspiration/Viewport/#go_Content/#go_inspirationItem")
	arg_1_0._btnrevertlastoperation = gohelper.findChildButton(arg_1_0.viewGO, "#btn_revert_last_operation")
	arg_1_0._btnreset = gohelper.findChildButton(arg_1_0.viewGO, "#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnrevertlastoperation, arg_2_0._onBtnRevertLastOperation, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnreset, arg_2_0.onOpen, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_setChessData()
	arg_6_0:_setDebrisData()
end

function var_0_0._setChessData(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.param

	arg_7_0.chess_data = GameUtil.splitString2(var_7_0, true, "#", ",")

	local var_7_1 = #arg_7_0.chess_data
	local var_7_2 = #arg_7_0.chess_data[1]

	arg_7_0.cell_length = 70
	arg_7_0._rabbet_cell = {}
	arg_7_0._rabbet_cell_list = {}

	local var_7_3 = 0

	for iter_7_0 = 1, var_7_1 do
		arg_7_0._rabbet_cell[iter_7_0] = {}

		for iter_7_1 = 1, var_7_2 do
			local var_7_4

			if var_7_3 < arg_7_0._gomeshContainer.transform.childCount then
				var_7_4 = arg_7_0._gomeshContainer.transform:GetChild(var_7_3).gameObject
			else
				var_7_4 = gohelper.clone(arg_7_0._gomeshItem, arg_7_0._gomeshContainer)
			end

			local var_7_5 = iter_7_1 - (var_7_2 + 1) / 2
			local var_7_6 = (var_7_1 + 1) / 2 - iter_7_0

			recthelper.setAnchor(var_7_4.transform, var_7_5 * arg_7_0.cell_length, var_7_6 * arg_7_0.cell_length)

			local var_7_7 = arg_7_0:openSubView(PutCubeGameItemView, var_7_4, nil, arg_7_0.chess_data[iter_7_0][iter_7_1], arg_7_0)

			arg_7_0._rabbet_cell[iter_7_0][iter_7_1] = var_7_7

			table.insert(arg_7_0._rabbet_cell_list, arg_7_0._rabbet_cell[iter_7_0][iter_7_1])

			var_7_3 = var_7_3 + 1
		end
	end
end

function var_0_0._setDebrisData(arg_8_0)
	arg_8_0.debris_list = {}
	arg_8_0.debris_count_dic = {}

	for iter_8_0, iter_8_1 in ipairs(DungeonConfig.instance:getPuzzleSquareDebrisGroupList(arg_8_0.viewParam.id)) do
		arg_8_0.debris_count_dic[iter_8_1.id] = iter_8_1.count

		table.insert(arg_8_0.debris_list, iter_8_1)
	end

	arg_8_0:_refreshDebrisList()
end

function var_0_0._refreshDebrisList(arg_9_0)
	gohelper.CreateObjList(arg_9_0, arg_9_0._onDebrisItemShow, arg_9_0.debris_list, arg_9_0._goContent, arg_9_0._goinspirationItem)
end

function var_0_0._onDebrisItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1.transform

	arg_10_1.name = arg_10_3

	local var_10_1 = var_10_0:Find("item/slot"):GetComponent(gohelper.Type_Image)
	local var_10_2 = var_10_0:Find("item/slot/icon"):GetComponent(gohelper.Type_Image)
	local var_10_3 = var_10_0:Find("item/slot/countbg")
	local var_10_4 = var_10_0:Find("item/slot/countbg/count"):GetComponent(gohelper.Type_TextMesh)
	local var_10_5 = var_10_0:Find("item/slot/glow"):GetComponent(gohelper.Type_Image)

	var_10_4.text = arg_10_0.debris_count_dic[arg_10_2.id]

	gohelper.setActive(arg_10_1, arg_10_0.debris_count_dic[arg_10_2.id] > 0)
	SLFramework.UGUI.UIDragListener.Get(var_10_1.gameObject):AddDragBeginListener(arg_10_0._onDragBegin, arg_10_0, arg_10_2)
	SLFramework.UGUI.UIDragListener.Get(var_10_1.gameObject):AddDragListener(arg_10_0._onDrag, arg_10_0)
	SLFramework.UGUI.UIDragListener.Get(var_10_1.gameObject):AddDragEndListener(arg_10_0._onDragEnd, arg_10_0)
end

function var_0_0._onDragBegin(arg_11_0, arg_11_1)
	arg_11_0:_createDragItem(arg_11_1)
end

function var_0_0._createDragItem(arg_12_0, arg_12_1)
	if not arg_12_0.drag_container then
		arg_12_0.drag_container = arg_12_0._godragContainer
		arg_12_0.drag_container_transform = arg_12_0.drag_container.transform
	end

	local var_12_0 = arg_12_1.id

	transformhelper.setLocalRotation(arg_12_0.drag_container_transform, 0, 0, 0)

	local var_12_1 = arg_12_0.drag_container_transform:Find(var_12_0)

	if not var_12_1 then
		var_12_1 = gohelper.clone(arg_12_0._gocellModel, arg_12_0.drag_container, var_12_0)

		recthelper.setAnchor(var_12_1.transform, 0, 0)
	end

	gohelper.setActive(arg_12_0.drag_container, true)

	if arg_12_0.drag_data then
		gohelper.setActive(arg_12_0.drag_container_transform:Find(arg_12_0.drag_data.drag_id).gameObject, false)
	else
		arg_12_0.drag_data = {}
	end

	arg_12_0.drag_data.drag_id = var_12_0
	arg_12_0.drag_data.config = arg_12_1

	local var_12_2 = var_12_1.gameObject

	if not arg_12_0.drag_cube_child_list then
		arg_12_0.drag_cube_child_list = {}
		arg_12_0.cube_rightful_count = {}
	end

	if not arg_12_0.drag_cube_child_list[var_12_0] then
		arg_12_0.drag_cube_child_list[var_12_0] = {}
		arg_12_0.cube_rightful_count[var_12_0] = {}

		arg_12_0:_createDragCubeChild(arg_12_0.drag_cube_child_list[var_12_0], arg_12_1, var_12_2)
	end

	gohelper.setActive(var_12_2, true)
end

function var_0_0._createDragCubeChild(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = GameUtil.splitString2(arg_13_2.shape, true, "#", ",")
	local var_13_1 = GameUtil.getTabLen(var_13_0)
	local var_13_2 = GameUtil.getTabLen(var_13_0[1])
	local var_13_3 = 0

	for iter_13_0 = 1, var_13_1 do
		for iter_13_1 = 1, var_13_2 do
			local var_13_4 = arg_13_0:getUserDataTb_()

			var_13_4.gameObject = gohelper.clone(arg_13_0._gocellModel, arg_13_3)
			var_13_4.transform = var_13_4.gameObject.transform
			var_13_4.rightful = var_13_0[iter_13_0][iter_13_1] == 1

			if var_13_4.rightful then
				var_13_3 = var_13_3 + 1
			end

			local var_13_5 = iter_13_1 - (var_13_2 + 1) / 2
			local var_13_6 = (var_13_1 + 1) / 2 - iter_13_0

			recthelper.setAnchor(var_13_4.transform, var_13_5 * arg_13_0.cell_length, var_13_6 * arg_13_0.cell_length)
			table.insert(arg_13_1, var_13_4)

			if iter_13_0 == 1 and iter_13_1 == 1 then
				-- block empty
			end
		end
	end

	arg_13_0.cube_rightful_count[arg_13_2.id] = var_13_3
end

function var_0_0._onDrag(arg_14_0)
	if not arg_14_0.drag_data then
		return
	end

	local var_14_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_14_0._gomeshContainer.transform)

	recthelper.setAnchor(arg_14_0.drag_container_transform, var_14_0.x, var_14_0.y)
end

function var_0_0._detectDragResult(arg_15_0, arg_15_1)
	arg_15_0.cur_fill_count = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._rabbet_cell_list) do
		local var_15_0 = iter_15_1

		for iter_15_2, iter_15_3 in ipairs(arg_15_0.drag_cube_child_list[arg_15_0.drag_data.drag_id]) do
			local var_15_1 = iter_15_3.transform
			local var_15_2 = recthelper.getAnchorX(var_15_1)
			local var_15_3 = recthelper.getAnchorY(var_15_1)
			local var_15_4 = recthelper.getAnchorX(arg_15_0.drag_container_transform) + var_15_2
			local var_15_5 = recthelper.getAnchorY(arg_15_0.drag_container_transform) + var_15_3

			if var_15_0:detectPosCover(var_15_4, var_15_5) and iter_15_3.rightful and var_15_0.level < 3 then
				arg_15_0.cur_fill_count = arg_15_0.cur_fill_count + 1

				if arg_15_1 then
					table.insert(arg_15_1, var_15_0)
				end
			end
		end
	end
end

function var_0_0._onDragEnd(arg_16_0)
	local var_16_0 = {}

	arg_16_0:_detectDragResult(var_16_0)

	if not arg_16_0.drag_data then
		arg_16_0:_releaseDragItem()

		arg_16_0.cur_fill_count = 0

		return
	end

	if arg_16_0.cur_fill_count == arg_16_0.cube_rightful_count[arg_16_0.drag_data.config.id] then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			iter_16_1.level = iter_16_1.level + 1

			iter_16_1:onOpen()
		end

		if not arg_16_0.step_data then
			arg_16_0.step_data = {}
		end

		table.insert(arg_16_0.step_data, {
			config = arg_16_0.drag_data.config,
			fill_cell = var_16_0
		})

		arg_16_0.debris_count_dic[arg_16_0.drag_data.config.id] = arg_16_0.debris_count_dic[arg_16_0.drag_data.config.id] - 1

		arg_16_0:_refreshDebrisList()

		if arg_16_0:_detectGameWin() then
			DungeonRpc.instance:sendMapElementRequest(arg_16_0.viewParam.id)
			arg_16_0:closeThis()
		end
	end

	arg_16_0:_releaseDragItem()

	arg_16_0.cur_fill_count = 0
end

function var_0_0._detectGameWin(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._rabbet_cell_list) do
		if iter_17_1.level < 3 then
			return false
		end
	end

	return true
end

function var_0_0._releaseDragItem(arg_18_0)
	if arg_18_0.drag_data then
		gohelper.setActive(arg_18_0.drag_container_transform:Find(arg_18_0.drag_data.drag_id).gameObject, false)
	end

	arg_18_0.drag_data = nil

	gohelper.setActive(arg_18_0.drag_container, false)
end

function var_0_0._onBtnRevertLastOperation(arg_19_0)
	if arg_19_0.step_data and #arg_19_0.step_data > 0 then
		local var_19_0 = table.remove(arg_19_0.step_data)
		local var_19_1 = var_19_0.config.id

		arg_19_0.debris_count_dic[var_19_1] = arg_19_0.debris_count_dic[var_19_1] + 1

		for iter_19_0, iter_19_1 in ipairs(var_19_0.fill_cell) do
			iter_19_1.level = iter_19_1.level - 1

			iter_19_1:onOpen()
		end

		arg_19_0:_refreshDebrisList()
	end
end

function var_0_0.onClose(arg_20_0)
	local var_20_0 = arg_20_0._goContent.transform
	local var_20_1 = var_20_0.childCount

	for iter_20_0 = 0, var_20_1 - 1 do
		local var_20_2 = var_20_0:GetChild(iter_20_0):Find("item/slot").gameObject

		SLFramework.UGUI.UIDragListener.Get(var_20_2):RemoveDragBeginListener()
		SLFramework.UGUI.UIDragListener.Get(var_20_2):RemoveDragListener()
		SLFramework.UGUI.UIDragListener.Get(var_20_2):RemoveDragEndListener()
	end
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
