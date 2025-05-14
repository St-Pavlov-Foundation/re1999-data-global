module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipePieceView", package.seeall)

local var_0_0 = class("ArmPuzzlePipePieceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._gorightPiece = gohelper.findChild(arg_1_0.viewGO, "#go_rightPiece")
	arg_1_0._goPiecePanel = gohelper.findChild(arg_1_0.viewGO, "#go_PiecePanel")
	arg_1_0._gopieceItem = gohelper.findChild(arg_1_0.viewGO, "#go_rightPiece/#go_pieceItem")
	arg_1_0._godragItem = gohelper.findChild(arg_1_0.viewGO, "#go_dragItem")
	arg_1_0._imagedrag = gohelper.findChildImage(arg_1_0.viewGO, "#go_dragItem/#image_drag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if arg_2_0._btnUIClick then
		arg_2_0._btnUIClick:AddClickDownListener(arg_2_0._onUIClickDown, arg_2_0)
		arg_2_0._btnUIClick:AddClickUpListener(arg_2_0._onUIClickUp, arg_2_0)
	end

	if arg_2_0._btnUIdrag then
		arg_2_0._btnUIdrag:AddDragListener(arg_2_0._onDragIng, arg_2_0)
		arg_2_0._btnUIdrag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
		arg_2_0._btnUIdrag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._btnUIClick then
		arg_3_0._btnUIClick:RemoveClickDownListener()
		arg_3_0._btnUIClick:RemoveClickUpListener()
	end

	if arg_3_0._btnUIdrag then
		arg_3_0._btnUIdrag:RemoveDragBeginListener()
		arg_3_0._btnUIdrag:RemoveDragListener()
		arg_3_0._btnUIdrag:RemoveDragEndListener()
	end
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._btnUIdrag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._gomap)
	arg_4_0._isDrag = false
	arg_4_0._godragItemTrs = arg_4_0._godragItem.transform
	arg_4_0._gomapTrs = arg_4_0.viewGO.transform
	arg_4_0._dragItemAnimator = arg_4_0._godragItem:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)

	local var_4_0 = {
		ArmPuzzlePipeEnum.type.straight,
		ArmPuzzlePipeEnum.type.corner,
		ArmPuzzlePipeEnum.type.t_shape
	}

	arg_4_0._typeIdList = {}
	arg_4_0._pieceItemList = arg_4_0:getUserDataTb_()

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if ArmPuzzlePipeModel.instance:isHasPlaceByTypeId(iter_4_1) then
			table.insert(arg_4_0._typeIdList, iter_4_1)

			local var_4_1 = gohelper.clone(arg_4_0._gopieceItem, arg_4_0._gorightPiece, "pieceitem_" .. iter_4_1)
			local var_4_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_1, ArmPuzzlePipePieceItem, arg_4_0)

			var_4_2:setTypeId(iter_4_1)
			table.insert(arg_4_0._pieceItemList, var_4_2)
		end
	end

	for iter_4_2 = 1, 3 do
		local var_4_3 = gohelper.findChild(arg_4_0.viewGO, "#go_PiecePanel/#image_PanelBG" .. iter_4_2)

		gohelper.setActive(var_4_3, iter_4_2 == #arg_4_0._pieceItemList)
	end

	gohelper.setActive(arg_4_0._gopieceItem, false)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PipeGameClear, arg_6_0._onGameClear, arg_6_0)
	arg_6_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.UIPipeDragBegin, arg_6_0._onDragBeginEvent, arg_6_0)
	arg_6_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.UIPipeDragIng, arg_6_0._onDragIngEvent, arg_6_0)
	arg_6_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.UIPipeDragEnd, arg_6_0._onDragEndEvent, arg_6_0)
	arg_6_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PlaceItemRefresh, arg_6_0._refreshUI, arg_6_0)
	arg_6_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.ResetGameRefresh, arg_6_0._refreshUI, arg_6_0)
	arg_6_0:_refreshUI()
end

function var_0_0._onGameClear(arg_7_0)
	arg_7_0._isDrag = false

	arg_7_0:_refreshDragUI()
end

function var_0_0._onUIClickDown(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:_cancelLongPressDown()

	if ArmPuzzlePipeModel.instance:isHasPlace() then
		local var_8_0, var_8_1 = arg_8_0:_getPipesXY(GamepadController.instance:getMousePosition())

		if var_8_0 and var_8_1 and ArmPuzzlePipeModel.instance:isPlaceByXY(var_8_0, var_8_1) then
			arg_8_0._isHasLongPressTask = true

			TaskDispatcher.runDelay(arg_8_0._onLongPressDown, arg_8_0, 0.3)
		end
	end
end

function var_0_0._onUIClickUp(arg_9_0)
	arg_9_0:_cancelLongPressDown()

	if arg_9_0._isCanDragUIOP then
		arg_9_0._isCanDragUIOP = false

		arg_9_0:_onDragEndEvent(GamepadController.instance:getMousePosition(), arg_9_0._fromX, arg_9_0._fromY)
	end
end

function var_0_0._onDragBegin(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._isCanDragUIOP then
		arg_10_0:_checkDragBegin(arg_10_2.position)
	end
end

function var_0_0._onDragIng(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._isCanDragUIOP then
		arg_11_0:_onDragIngEvent(arg_11_2.position)
	end
end

function var_0_0._onDragEnd(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._isCanDragUIOP then
		arg_12_0._isCanDragUIOP = false

		arg_12_0:_onDragEndEvent(arg_12_2.position, arg_12_0._fromX, arg_12_0._fromY)
	end
end

function var_0_0._onDragBeginEvent(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0._isDrag = false

	if ArmPuzzlePipeEnum.UIDragRes[arg_13_2] then
		arg_13_0._isDrag = true
		arg_13_0._curDragPipeTypeId = arg_13_2
		arg_13_0._curDragPipeValue = arg_13_3

		UISpriteSetMgr.instance:setArmPipeSprite(arg_13_0._imagedrag, ArmPuzzlePipeEnum.UIDragRes[arg_13_2], true)
		transformhelper.setLocalRotation(arg_13_0._godragItemTrs, 0, 0, ArmPuzzleHelper.getRotation(arg_13_2, arg_13_3))
		arg_13_0:_refreshDragUI()
		arg_13_0:_onDragIngEvent(arg_13_1)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_lyrics_wrongs)
	end
end

function var_0_0._cancelLongPressDown(arg_14_0)
	if arg_14_0._isHasLongPressTask then
		arg_14_0._isHasLongPressTask = false

		TaskDispatcher.cancelTask(arg_14_0._onLongPressDown, arg_14_0)
	end
end

function var_0_0._onLongPressDown(arg_15_0)
	arg_15_0._isHasLongPressTask = false

	if ArmPuzzlePipeModel.instance:isHasPlace() and not arg_15_0._isCanDragUIOP then
		arg_15_0:_checkDragBegin()
	end
end

function var_0_0._checkDragBegin(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 or GamepadController.instance:getMousePosition()

	arg_16_0._isCanDragUIOP = false
	arg_16_0._fromX = nil
	arg_16_0._fromY = nil

	local var_16_1, var_16_2 = arg_16_0:_getPipesXY(var_16_0)
	local var_16_3 = ArmPuzzlePipeModel.instance

	if var_16_1 and var_16_2 and var_16_3:isPlaceByXY(var_16_1, var_16_2) then
		local var_16_4 = var_16_3:getData(var_16_1, var_16_2)

		if var_16_4 and ArmPuzzlePipeEnum.UIDragRes[var_16_4.typeId] then
			arg_16_0._isCanDragUIOP = true

			local var_16_5 = var_16_4.typeId
			local var_16_6 = var_16_4.value

			arg_16_0._fromX = var_16_1
			arg_16_0._fromY = var_16_2

			var_16_4:setParamStr(var_16_3:getPlaceStrByXY(var_16_1, var_16_2))
			arg_16_0:_onDragBeginEvent(var_16_0, var_16_5, var_16_6)
			ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, var_16_1, var_16_2)
			ArmPuzzlePipeModel.instance:setPlaceSelectXY(var_16_1, var_16_2)
			arg_16_0:_refreshPlacePipeItem(var_16_1, var_16_2)
			AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_mark_finish)
		end
	end
end

function var_0_0._onDragIngEvent(arg_17_0, arg_17_1)
	if arg_17_0._isDrag then
		local var_17_0 = recthelper.screenPosToAnchorPos(arg_17_1, arg_17_0._gomapTrs)

		transformhelper.setLocalPosXY(arg_17_0._godragItemTrs, var_17_0.x, var_17_0.y)

		local var_17_1, var_17_2 = arg_17_0:_getPipesXY(arg_17_1)
		local var_17_3 = ArmPuzzlePipeModel.instance
		local var_17_4, var_17_5 = var_17_3:getPlaceSelectXY()

		if var_17_1 and var_17_2 and var_17_3:isPlaceByXY(var_17_1, var_17_2) then
			if not var_17_3:isPlaceSelectXY(var_17_1, var_17_2) then
				var_17_3:setPlaceSelectXY(var_17_1, var_17_2)
				arg_17_0:_refreshPlacePipeItem(var_17_4, var_17_5)
				arg_17_0:_refreshPlacePipeItem(var_17_1, var_17_2)
			end
		else
			var_17_3:setPlaceSelectXY(nil, nil)
			arg_17_0:_refreshPlacePipeItem(var_17_4, var_17_5)
		end
	end
end

function var_0_0._onDragEndEvent(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0._isDrag then
		arg_18_0._isDrag = false

		local var_18_0 = ArmPuzzlePipeModel.instance
		local var_18_1, var_18_2 = var_18_0:getPlaceSelectXY()

		var_18_0:setPlaceSelectXY(nil, nil)

		local var_18_3, var_18_4 = arg_18_0:_getPipesXY(arg_18_1)
		local var_18_5

		if var_18_3 and var_18_4 and var_18_0:isPlaceByXY(var_18_3, var_18_4) then
			local var_18_6 = var_18_0:getData(var_18_3, var_18_4)

			if var_18_6 then
				if ArmPuzzlePipeEnum.UIDragRes[var_18_6.typeId] and arg_18_2 and arg_18_3 and var_18_0:isPlaceByXY(arg_18_2, arg_18_3) then
					var_18_5 = var_18_0:getData(arg_18_2, arg_18_3)
					var_18_5.typeId = var_18_6.typeId
					var_18_5.value = var_18_6.value
				end

				var_18_6:setParamStr(var_18_0:getPlaceStrByXY(var_18_3, var_18_4))

				var_18_6.typeId = arg_18_0._curDragPipeTypeId
				var_18_6.value = arg_18_0._curDragPipeValue

				ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, var_18_3, var_18_4)

				if var_18_5 and arg_18_2 and arg_18_3 then
					ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, arg_18_2, arg_18_3)
				end
			end
		end

		arg_18_0:_refreshUI()

		if var_18_1 ~= var_18_3 or var_18_2 ~= var_18_4 then
			arg_18_0:_refreshPlacePipeItem(var_18_1, var_18_2)
		end
	end
end

function var_0_0._refreshDragUI(arg_19_0)
	gohelper.setActive(arg_19_0._godragItem, arg_19_0._isDrag)
end

function var_0_0._refreshUI(arg_20_0)
	local var_20_0 = ArmPuzzlePipeModel.instance:isHasPlace()

	gohelper.setActive(arg_20_0._gorightPiece, var_20_0)
	gohelper.setActive(arg_20_0._goPiecePanel, var_20_0)
	arg_20_0:_refreshDragUI()

	if var_20_0 then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._pieceItemList) do
			iter_20_1:refreshUI()
		end
	end
end

function var_0_0._getPipesXY(arg_21_0, arg_21_1)
	if arg_21_0.viewContainer then
		return arg_21_0.viewContainer:getPipesXYByPostion(arg_21_1)
	end
end

function var_0_0._refreshPlacePipeItem(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 and arg_22_2 and ArmPuzzlePipeModel.instance:isPlaceByXY(arg_22_1, arg_22_2) then
		arg_22_0.viewContainer:getPipes():initItem(arg_22_1, arg_22_2)
	end
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0:_cancelLongPressDown()
end

return var_0_0
