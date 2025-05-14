module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairPieceView", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryRepairPieceView", BaseView)
local var_0_1 = 3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._viewGoTrans = arg_1_0.viewGO.transform
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._btnMapDrag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._gomap)
	arg_1_0._gorightPiece = gohelper.findChild(arg_1_0.viewGO, "#go_rightPiece")
	arg_1_0._goPiecePanel = gohelper.findChild(arg_1_0.viewGO, "#go_PiecePanel")
	arg_1_0._gopieceItem = gohelper.findChild(arg_1_0.viewGO, "#go_rightPiece/#go_pieceItem")
	arg_1_0._godragItem = gohelper.findChild(arg_1_0.viewGO, "#go_dragItem")
	arg_1_0._godragItemTrs = arg_1_0._godragItem.transform
	arg_1_0._dragItemAnimator = arg_1_0._godragItem:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	arg_1_0._imagedrag = gohelper.findChildImage(arg_1_0.viewGO, "#go_dragItem/#image_drag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, arg_2_0._onGameClear, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragBegin, arg_2_0._onDragBeginEvent, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragIng, arg_2_0._onDragIngEvent, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragEnd, arg_2_0._onDragEndEvent, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceItemRefresh, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, arg_2_0._refreshUI, arg_2_0)

	if arg_2_0._btnMapDrag then
		arg_2_0._btnMapDrag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
		arg_2_0._btnMapDrag:AddDragListener(arg_2_0._onDragIng, arg_2_0)
		arg_2_0._btnMapDrag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, arg_3_0._onGameClear, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragBegin, arg_3_0._onDragBeginEvent, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragIng, arg_3_0._onDragIngEvent, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragEnd, arg_3_0._onDragEndEvent, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceItemRefresh, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, arg_3_0._refreshUI, arg_3_0)

	if arg_3_0._btnMapDrag then
		arg_3_0._btnMapDrag:RemoveDragBeginListener()
		arg_3_0._btnMapDrag:RemoveDragListener()
		arg_3_0._btnMapDrag:RemoveDragEndListener()
	end
end

function var_0_0._onGameClear(arg_4_0)
	arg_4_0._isDrag = false

	arg_4_0:_refreshDragUI()
end

function var_0_0._onDragBeginEvent(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._isDrag = false

	local var_5_0 = ArmPuzzlePipeEnum.UIDragRes[arg_5_2]

	if var_5_0 then
		arg_5_0._isDrag = true
		arg_5_0._curDragPipeTypeId = arg_5_2
		arg_5_0._curDragPipeValue = arg_5_3

		UISpriteSetMgr.instance:setArmPipeSprite(arg_5_0._imagedrag, var_5_0, true)

		local var_5_1 = ArmPuzzleHelper.getRotation(arg_5_2, arg_5_3)

		transformhelper.setLocalRotation(arg_5_0._godragItemTrs, 0, 0, var_5_1)
		arg_5_0:_refreshDragUI()
		arg_5_0:_onDragIngEvent(arg_5_1)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_lyrics_wrongs)
	end
end

function var_0_0._onDragIngEvent(arg_6_0, arg_6_1)
	if not arg_6_0._isDrag then
		return
	end

	local var_6_0 = recthelper.screenPosToAnchorPos(arg_6_1, arg_6_0._viewGoTrans)

	transformhelper.setLocalPosXY(arg_6_0._godragItemTrs, var_6_0.x, var_6_0.y)

	local var_6_1, var_6_2 = arg_6_0:_getPipesXY(arg_6_1)
	local var_6_3 = Activity157RepairGameModel.instance
	local var_6_4, var_6_5 = var_6_3:getPlaceSelectXY()

	if var_6_1 and var_6_2 and var_6_3:isPlaceByXY(var_6_1, var_6_2) then
		if not var_6_3:isPlaceSelectXY(var_6_1, var_6_2) then
			var_6_3:setPlaceSelectXY(var_6_1, var_6_2)
			arg_6_0:_refreshPlacePipeItem(var_6_4, var_6_5)
			arg_6_0:_refreshPlacePipeItem(var_6_1, var_6_2)
		end
	else
		var_6_3:setPlaceSelectXY(nil, nil)
		arg_6_0:_refreshPlacePipeItem(var_6_4, var_6_5)
	end
end

function var_0_0._onDragEndEvent(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0._isDrag then
		return
	end

	arg_7_0._isDrag = false

	local var_7_0 = Activity157RepairGameModel.instance
	local var_7_1, var_7_2 = var_7_0:getPlaceSelectXY()

	var_7_0:setPlaceSelectXY(nil, nil)

	local var_7_3, var_7_4 = arg_7_0:_getPipesXY(arg_7_1)
	local var_7_5

	if var_7_3 and var_7_4 and var_7_0:isPlaceByXY(var_7_3, var_7_4) then
		local var_7_6 = var_7_0:getData(var_7_3, var_7_4)

		if var_7_6 then
			if ArmPuzzlePipeEnum.UIDragRes[var_7_6.typeId] and arg_7_2 and arg_7_3 and var_7_0:isPlaceByXY(arg_7_2, arg_7_3) then
				var_7_5 = var_7_0:getData(arg_7_2, arg_7_3)
				var_7_5.typeId = var_7_6.typeId
				var_7_5.value = var_7_6.value
			end

			var_7_6:setParamStr(var_7_0:getPlaceStrByXY(var_7_3, var_7_4))

			var_7_6.typeId = arg_7_0._curDragPipeTypeId
			var_7_6.value = arg_7_0._curDragPipeValue

			Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, var_7_3, var_7_4)

			if var_7_5 and arg_7_2 and arg_7_3 then
				Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, arg_7_2, arg_7_3)
			end
		end
	end

	arg_7_0:_refreshUI()

	if var_7_1 ~= var_7_3 or var_7_2 ~= var_7_4 then
		arg_7_0:_refreshPlacePipeItem(var_7_1, var_7_2)
	end
end

function var_0_0._onDragBegin(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._isCanDragUIOP then
		arg_8_0:_checkDragBegin(arg_8_2.position)
	end
end

function var_0_0._checkDragBegin(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 or GamepadController.instance:getMousePosition()

	arg_9_0._isCanDragUIOP = false
	arg_9_0._fromX = nil
	arg_9_0._fromY = nil

	local var_9_1, var_9_2 = arg_9_0:_getPipesXY(var_9_0)
	local var_9_3 = Activity157RepairGameModel.instance

	if var_9_1 and var_9_2 and var_9_3:isPlaceByXY(var_9_1, var_9_2) then
		local var_9_4 = var_9_3:getData(var_9_1, var_9_2)

		if var_9_4 and ArmPuzzlePipeEnum.UIDragRes[var_9_4.typeId] then
			arg_9_0._isCanDragUIOP = true

			local var_9_5 = var_9_4.typeId
			local var_9_6 = var_9_4.value

			arg_9_0._fromX = var_9_1
			arg_9_0._fromY = var_9_2

			var_9_4:setParamStr(var_9_3:getPlaceStrByXY(var_9_1, var_9_2))
			arg_9_0:_onDragBeginEvent(var_9_0, var_9_5, var_9_6)
			Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, var_9_1, var_9_2)
			Activity157RepairGameModel.instance:setPlaceSelectXY(var_9_1, var_9_2)
			arg_9_0:_refreshPlacePipeItem(var_9_1, var_9_2)
			AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_mark_finish)
		end
	end
end

function var_0_0._onDragIng(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._isCanDragUIOP then
		return
	end

	arg_10_0:_onDragIngEvent(arg_10_2.position)
end

function var_0_0._onDragEnd(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._isCanDragUIOP then
		arg_11_0._isCanDragUIOP = false

		arg_11_0:_onDragEndEvent(arg_11_2.position, arg_11_0._fromX, arg_11_0._fromY)
	end
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._isDrag = false

	local var_12_0 = {
		ArmPuzzlePipeEnum.type.straight,
		ArmPuzzlePipeEnum.type.corner,
		ArmPuzzlePipeEnum.type.t_shape
	}

	arg_12_0._typeIdList = {}
	arg_12_0._pieceItemList = arg_12_0:getUserDataTb_()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if Activity157RepairGameModel.instance:isHasPlaceByTypeId(iter_12_1) then
			table.insert(arg_12_0._typeIdList, iter_12_1)

			local var_12_1 = gohelper.clone(arg_12_0._gopieceItem, arg_12_0._gorightPiece, "pieceitem_" .. iter_12_1)
			local var_12_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1, VersionActivity1_8FactoryRepairPieceItem, arg_12_0)

			var_12_2:setTypeId(iter_12_1)
			table.insert(arg_12_0._pieceItemList, var_12_2)
		end
	end

	gohelper.setActive(arg_12_0._gopieceItem, false)

	local var_12_3 = #arg_12_0._pieceItemList

	for iter_12_2 = 1, var_0_1 do
		local var_12_4 = gohelper.findChild(arg_12_0.viewGO, "#go_PiecePanel/#image_PanelBG" .. iter_12_2)

		gohelper.setActive(var_12_4, iter_12_2 == var_12_3)
	end
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_refreshUI()
end

function var_0_0._refreshUI(arg_15_0)
	local var_15_0 = Activity157RepairGameModel.instance:isHasPlace()

	gohelper.setActive(arg_15_0._gorightPiece, var_15_0)
	gohelper.setActive(arg_15_0._goPiecePanel, var_15_0)

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._pieceItemList) do
			iter_15_1:refreshUI()
		end
	end

	arg_15_0:_refreshDragUI()
end

function var_0_0._refreshDragUI(arg_16_0)
	gohelper.setActive(arg_16_0._godragItem, arg_16_0._isDrag)
end

function var_0_0._refreshPlacePipeItem(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 and arg_17_2 and Activity157RepairGameModel.instance:isPlaceByXY(arg_17_1, arg_17_2) then
		arg_17_0.viewContainer:getPipes():initItem(arg_17_1, arg_17_2)
	end
end

function var_0_0._getPipesXY(arg_18_0, arg_18_1)
	if arg_18_0.viewContainer then
		return arg_18_0.viewContainer:getPipesXYByPosition(arg_18_1)
	end
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
