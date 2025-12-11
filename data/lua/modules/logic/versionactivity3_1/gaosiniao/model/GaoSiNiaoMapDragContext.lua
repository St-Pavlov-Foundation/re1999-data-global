module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapDragContext", package.seeall)

local var_0_0 = class("GaoSiNiaoMapDragContext", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
end

function var_0_0._mapMO(arg_2_0)
	return GaoSiNiaoBattleModel.instance:mapMO()
end

function var_0_0._single(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0:_mapMO():single(arg_3_1, arg_3_2)
end

function var_0_0._single1(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0:_mapMO():single({
		arg_4_1._mo
	}, arg_4_2)
end

function var_0_0._tryMergeAll(arg_5_0, arg_5_1)
	return arg_5_0:_mapMO():tryMergeAll(arg_5_1)
end

function var_0_0._tryMerge1(arg_6_0, arg_6_1)
	return arg_6_0:_tryMergeAll({
		arg_6_1._mo
	})
end

function var_0_0._gridObjList(arg_7_0)
	return arg_7_0._viewObj._gridObjList
end

function var_0_0._goMapTransform(arg_8_0)
	return arg_8_0._viewObj._goMapTran
end

function var_0_0.clear(arg_9_0)
	arg_9_0:__onDispose()
	arg_9_0:__onInit()

	arg_9_0._enabled = false
	arg_9_0._viewObj = false
	arg_9_0._viewContainer = false
	arg_9_0._draggingItemTran = false
	arg_9_0._draggingItemImg = false
	arg_9_0._hitGridItemObj = false
	arg_9_0._isCompleted = false
	arg_9_0._gridItem2placedBagItem = {}
	arg_9_0._gridItemObj2placedBagItemObj = arg_9_0:getUserDataTb_()
	arg_9_0._draggingBagItemFromGrid = arg_9_0:getUserDataTb_()
end

function var_0_0.reset(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:clear()

	arg_10_0._viewObj = arg_10_1
	arg_10_0._viewContainer = arg_10_0._viewObj.viewContainer
	arg_10_0._draggingItemTran = arg_10_2
	arg_10_0._draggingItemImg = arg_10_3
	arg_10_0._draggingItemImgTran = arg_10_3.transform

	arg_10_0:_setActive(false)
	gohelper.setActive(arg_10_2.gameObject, true)
	arg_10_0:setEnabled(true)
end

function var_0_0.isPlacedBagItemObj(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return nil
	end

	return arg_11_0:getPlacedBagItemObj(arg_11_1) and true or false
end

function var_0_0.getPlacedBagItemObj(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return nil
	end

	return arg_12_0._gridItemObj2placedBagItemObj[arg_12_1]
end

function var_0_0.isPlacedBagItem(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return nil
	end

	return arg_13_0:getPlacedBagItem(arg_13_1) and true or false
end

function var_0_0.getPlacedBagItem(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return nil
	end

	return arg_14_0._gridItem2placedBagItem[arg_14_1]
end

function var_0_0._setPlacedBagItemObj(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._gridItemObj2placedBagItemObj[arg_15_1] = arg_15_2

	local var_15_0 = arg_15_1._mo
	local var_15_1 = arg_15_2 and arg_15_2._mo or nil

	arg_15_0._gridItem2placedBagItem[var_15_0] = var_15_1
end

function var_0_0._setLocalRotZ(arg_16_0, arg_16_1)
	arg_16_0._viewContainer:setLocalRotZ(arg_16_0._draggingItemImgTran, arg_16_1)
end

function var_0_0._setAPos(arg_17_0, arg_17_1, arg_17_2)
	recthelper.setAnchor(arg_17_0._draggingItemTran, arg_17_1, arg_17_2)
end

function var_0_0._setActive(arg_18_0, arg_18_1)
	GameUtil.setActive01(arg_18_0._draggingItemTran, arg_18_1)
end

function var_0_0._setSprite(arg_19_0, arg_19_1)
	arg_19_0._draggingItemImg.sprite = arg_19_1
end

function var_0_0._refreshDraggingItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0:_setActive(arg_20_1)

	if arg_20_2 then
		arg_20_0:_setAPos(arg_20_2.x, arg_20_2.y)
	end

	if arg_20_3 then
		local var_20_0, var_20_1 = arg_20_3:getDraggingSpriteAndZRot()

		arg_20_0:_setLocalRotZ(var_20_1)
		arg_20_0:_setSprite(var_20_0)
	end
end

function var_0_0._isInsideMapArea(arg_21_0, arg_21_1)
	return gohelper.isMouseOverGo(arg_21_0:_goMapTransform(), arg_21_1.screenPos)
end

function var_0_0._setDragInstToTargetItemObj(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:screenPosV2ToAnchorPosV2(arg_22_0._draggingItemTran)

	arg_22_0:_refreshDraggingItem(true, var_22_0, arg_22_2)
end

function var_0_0._calcHitWhichGridItemObj(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:_gridObjList()

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if gohelper.isMouseOverGo(iter_23_1:transform(), arg_23_1.screenPos) and iter_23_1:isSelectable() then
			arg_23_0:_onHitGridItemObj(iter_23_1)

			return
		end
	end

	arg_23_0:_onHitGridItemObj(nil)
end

function var_0_0._isValidDrag_TargetItemObj(arg_24_0, arg_24_1)
	if not arg_24_0._enabled then
		return false
	end

	if arg_24_0:_peakFlyingBagItemObj(arg_24_1) then
		return true
	end

	if not arg_24_1:isDraggable() then
		return false
	end

	return true
end

function var_0_0._clearHitInfo(arg_25_0)
	arg_25_0:_onHitGridItemObj(nil)
	arg_25_0:_collectFlyingBagItemObjBackToBag()
end

function var_0_0._critical_beforeClear(arg_26_0)
	arg_26_0:setEnabled(false)
	arg_26_0:_onHitGridItemObj(nil)
end

function var_0_0._onHitGridItemObj(arg_27_0, arg_27_1)
	if arg_27_0._hitGridItemObj then
		arg_27_0._hitGridItemObj:setSelected(false)
	end

	arg_27_0._hitGridItemObj = arg_27_1

	if arg_27_1 then
		arg_27_1:setSelected(true)
	end
end

function var_0_0._peakFlyingBagItemObj(arg_28_0, arg_28_1)
	return arg_28_0._draggingBagItemFromGrid[arg_28_1]
end

function var_0_0._detachFlyingBagItemObj(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:_peakFlyingBagItemObj(arg_29_1)

	if var_29_0 then
		rawset(arg_29_0._draggingBagItemFromGrid, arg_29_1, nil)

		return var_29_0
	end
end

function var_0_0._collectFlyingBagItemObjBackToBag(arg_30_0)
	local var_30_0 = false

	for iter_30_0, iter_30_1 in pairs(arg_30_0._draggingBagItemFromGrid) do
		if iter_30_1 then
			iter_30_1._mo:addCnt(1)

			var_30_0 = true
		end

		rawset(arg_30_0._draggingBagItemFromGrid, iter_30_0, nil)
	end

	if var_30_0 and arg_30_0._viewObj then
		arg_30_0._viewObj:_refreshBagList()
	end
end

function var_0_0.onBeginDrag_BagItemObj(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0._enabled then
		return
	end

	arg_31_0:_clearHitInfo()

	if not arg_31_0:_isValidDrag_TargetItemObj(arg_31_1) then
		return
	end

	arg_31_1:setShowCount(arg_31_1:getCount() - 1)
	arg_31_0:_setDragInstToTargetItemObj(arg_31_2, arg_31_1)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_anzhu)
end

function var_0_0.onDragging_BagItemObj(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0:_isValidDrag_TargetItemObj(arg_32_1) then
		arg_32_0:_clearHitInfo()

		return
	end

	arg_32_2:tweenToScreenPos(arg_32_0._draggingItemTran, nil, 0.1)

	if not arg_32_0:_isInsideMapArea(arg_32_2) then
		arg_32_0:_onHitGridItemObj(nil)

		return
	end

	arg_32_0:_calcHitWhichGridItemObj(arg_32_2)
end

function var_0_0.onEndDrag_BagItemObj(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0:_isValidDrag_TargetItemObj(arg_33_1) then
		arg_33_0:_clearHitInfo()

		return
	end

	if arg_33_0._hitGridItemObj then
		arg_33_0:onPushBagToGrid(arg_33_1, arg_33_0._hitGridItemObj, arg_33_2)
	end

	arg_33_0:_refreshDraggingItem(false)
	arg_33_1:refresh()
	arg_33_0:_clearHitInfo()
end

function var_0_0.onPushBagToGrid(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if not gohelper.isMouseOverGo(arg_34_2:transform(), arg_34_3.screenPos) then
		return
	end

	arg_34_1._mo:addCnt(-1)

	if arg_34_0:_onPushBagToGrid(arg_34_1, arg_34_2) == false then
		arg_34_1._mo:addCnt(1)
	end
end

function var_0_0._onPushBagToGrid(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:getPlacedBagItemObj(arg_35_2)
	local var_35_1 = var_35_0 and true or false

	if var_35_1 then
		if var_35_0:getType() == arg_35_1:getType() then
			return false
		end

		var_35_0._mo:addCnt(1)
		var_35_0:refresh()
	end

	arg_35_0:_setPlacedBagItemObj(arg_35_2, arg_35_1)

	if var_35_1 then
		arg_35_0:_single1(arg_35_2)
	else
		arg_35_0:_tryMerge1(arg_35_2)
	end

	arg_35_2:refresh()
	arg_35_2:onPushBagToGrid()
	arg_35_0._viewObj:_refresh()
	arg_35_0:_checkCompleteAndSetFinished()
end

function var_0_0.onBeginDrag_GridItemObj(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0:_clearHitInfo()

	if not arg_36_0:_isValidDrag_TargetItemObj(arg_36_1) then
		return
	end

	local var_36_0 = arg_36_0:getPlacedBagItemObj(arg_36_1)

	arg_36_0._draggingBagItemFromGrid[arg_36_1] = var_36_0

	arg_36_0:_setDragInstToTargetItemObj(arg_36_2, arg_36_1)
	arg_36_0:_setPlacedBagItemObj(arg_36_1, nil)
	arg_36_0:_single1(arg_36_1)
	arg_36_0._viewObj:_refresh()
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_anzhu)
end

function var_0_0.onDragging_GridItemObj(arg_37_0, arg_37_1, arg_37_2)
	if not arg_37_0:_isValidDrag_TargetItemObj(arg_37_1) then
		arg_37_0:_clearHitInfo()

		return
	end

	arg_37_2:tweenToScreenPos(arg_37_0._draggingItemTran, nil, 0.1)

	if not arg_37_0:_isInsideMapArea(arg_37_2) then
		arg_37_0:_onHitGridItemObj(nil)

		return
	end

	arg_37_0:_calcHitWhichGridItemObj(arg_37_2)
end

function var_0_0.onEndDrag_GridItemObj(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_0:_isValidDrag_TargetItemObj(arg_38_1) then
		arg_38_0:_clearHitInfo()

		return
	end

	arg_38_0._hitGridItemObj = arg_38_0._hitGridItemObj or arg_38_1

	arg_38_0:_onPushGridToGrid(arg_38_1, arg_38_0._hitGridItemObj, arg_38_2)
	arg_38_0:_refreshDraggingItem(false)
	arg_38_0:_clearHitInfo()
end

function var_0_0._onPushGridToGrid(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if not gohelper.isMouseOverGo(arg_39_2:transform(), arg_39_3.screenPos) then
		return
	end

	local var_39_0 = arg_39_0:_detachFlyingBagItemObj(arg_39_1)

	if arg_39_1 == arg_39_2 then
		arg_39_0:_onPushBagToGrid(var_39_0, arg_39_2)

		return
	end

	local var_39_1 = arg_39_0:getPlacedBagItemObj(arg_39_2)

	if not var_39_1 then
		if arg_39_2._mo:isEmpty() then
			arg_39_0:_onPushBagToGrid(var_39_0, arg_39_2)
		else
			logError("unsupported")
		end

		return
	end

	local var_39_2 = arg_39_0:_single({
		arg_39_1._mo,
		arg_39_2._mo
	}, true)

	arg_39_0:_setPlacedBagItemObj(arg_39_1, var_39_1)
	arg_39_0:_setPlacedBagItemObj(arg_39_2, var_39_0)
	arg_39_0:_tryMergeAll(var_39_2)
	arg_39_1:refresh()
	arg_39_1:onPushBagToGrid()
	arg_39_2:refresh()
	arg_39_2:onPushBagToGrid()
	arg_39_0._viewObj:_refresh()
	arg_39_0:_checkCompleteAndSetFinished()
end

function var_0_0.setEnabled(arg_40_0, arg_40_1)
	arg_40_0._enabled = arg_40_1 and true or false
end

function var_0_0.isCompleted(arg_41_0)
	return arg_41_0._isCompleted
end

function var_0_0._checkCompleteAndSetFinished(arg_42_0)
	if arg_42_0:_mapMO():isCompleted() then
		arg_42_0._isCompleted = true

		arg_42_0:setEnabled(false)
		arg_42_0._viewObj:completeGame()
	end
end

return var_0_0
