module("modules.logic.rouge.view.RougeCollectionChessPlaceComp", package.seeall)

local var_0_0 = class("RougeCollectionChessPlaceComp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosetipArea = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_closetipArea")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gochessContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_chessContainer")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer")
	arg_1_0._gomeshItem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	arg_1_0._godragContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragContainer")
	arg_1_0._gocellModel = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_cellModel")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer/#go_chessitem")
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
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Start2CheckAndPlace, arg_4_0.try2PlaceCollection, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, arg_4_0.placeCollection2SlotAreaWithAudio, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, arg_4_0._onBeginDragCollection, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, arg_4_0.deleteSlotCollection, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, arg_4_0.updateEnchantInfo, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, arg_4_0.placeCollection2OriginPos, arg_4_0)

	arg_4_0._poolComp = arg_4_0.viewContainer:getRougePoolComp()
	arg_4_0._placeCollectionMap = arg_4_0:getUserDataTb_()
	arg_4_0._placeHoleIndexMap = {}
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:placeAllBagCollections()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.placeAllBagCollections(arg_7_0)
	local var_7_0 = RougeCollectionModel.instance:getSlotAreaCollection()

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			arg_7_0:placeCollection2SlotArea(iter_7_1)
		end
	end
end

function var_0_0.placeCollection2SlotAreaWithAudio(arg_8_0, arg_8_1)
	arg_8_0:placeCollection2SlotArea(arg_8_1)
	AudioMgr.instance:trigger(AudioEnum.UI.PlaceSlotCollection)
end

function var_0_0.placeCollection2SlotArea(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	arg_9_0:revertErrorCollection(arg_9_1.id)

	local var_9_0 = arg_9_0:getOrCreateCollectionItem(arg_9_1.id)

	var_9_0:onUpdateMO(arg_9_1)
	var_9_0:setHoleToolVisible(true)
	var_9_0:setShowTypeFlagVisible(true)
	var_9_0:setParent(arg_9_0._gocellModel.transform, false)
end

function var_0_0.getOrCreateCollectionItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._placeCollectionMap[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0._poolComp:getCollectionItem(RougeCollectionDragItem.__cname)
		arg_10_0._placeCollectionMap[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0._onBeginDragCollection(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 and arg_11_1.id

	arg_11_0:revertErrorCollection(var_11_0)

	local var_11_1 = arg_11_0._placeCollectionMap[var_11_0]

	if var_11_1 then
		var_11_1:setItemVisible(false)
	end
end

function var_0_0.revertErrorCollection(arg_12_0, arg_12_1)
	if arg_12_0._errorItemId and arg_12_0._errorItemId > 0 and arg_12_0._errorItemId ~= arg_12_1 then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, arg_12_0._errorItemId)

		arg_12_0._errorItemId = nil
	end
end

function var_0_0.try2PlaceCollection(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1 then
		return
	end

	arg_13_0:revertErrorCollection(arg_13_1.id)

	local var_13_0 = arg_13_1.cfgId
	local var_13_1 = arg_13_1:getCenterSlotPos()
	local var_13_2 = arg_13_1:getRotation()
	local var_13_3 = arg_13_1:getLeftTopPos()
	local var_13_4 = RougeCollectionHelper.checkIsCollectionSlotArea(var_13_0, var_13_3, var_13_2)
	local var_13_5 = RougeCollectionHelper.isUnremovableCollection(var_13_0)

	if not var_13_4 then
		if var_13_5 then
			local var_13_6 = RougeCollectionConfig.instance:getCollectionName(var_13_0)

			GameFacade.showToast(ToastEnum.RougeUnRemovableCollection, var_13_6)
			RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, arg_13_1.id)
		else
			arg_13_0:removeCollectionFromSlotArea(arg_13_1)
		end

		return
	end

	local var_13_7 = RougeCollectionConfig.instance:getCollectionCfg(var_13_0)

	if var_13_7 and var_13_7.type == RougeEnum.CollectionType.Enchant and not var_13_5 then
		local var_13_8 = RougeCollectionModel.instance:getSlotFilledCollectionId(var_13_1.x, var_13_1.y)

		if arg_13_0:tryPlaceEnchant2Collection(var_13_8, arg_13_1.id) then
			return
		end
	end

	if arg_13_0:checkHasSpace2Place(arg_13_1, var_13_1, var_13_2) then
		RougeCollectionChessController.instance:placeCollection2SlotArea(arg_13_1.id, var_13_3, var_13_2)
	else
		local var_13_9 = arg_13_0:getOrCreateCollectionItem(arg_13_1.id)

		var_13_9:onUpdateMO(arg_13_1)
		var_13_9:setShapeCellsVisible(true)
		var_13_9:setSelectFrameVisible(true)
		var_13_9:setParent(arg_13_0._gocellModel.transform, false)

		arg_13_0._errorItemId = arg_13_1.id

		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.NullSpace2PlaceCollection, arg_13_1)
	end
end

function var_0_0.placeCollection2OriginPos(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._placeCollectionMap[arg_14_1]
	local var_14_1 = RougeCollectionModel.instance:getCollectionByUid(arg_14_1)

	if var_14_0 and var_14_1 then
		if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(arg_14_1) and not arg_14_2 then
			var_14_0:onUpdateMO(var_14_1)
			var_14_0:setShapeCellsVisible(false)
		else
			arg_14_0._poolComp:recycleCollectionItem(RougeCollectionDragItem.__cname, var_14_0)

			arg_14_0._placeCollectionMap[arg_14_1] = nil
		end
	end
end

function var_0_0.checkHasSpace2Place(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = true

	if arg_15_1 then
		local var_15_1 = arg_15_1:getCollectionCfgId()
		local var_15_2 = RougeCollectionConfig.instance:getRotateEditorParam(var_15_1, arg_15_3, RougeEnum.CollectionEditorParamType.Shape)

		if var_15_2 then
			for iter_15_0, iter_15_1 in ipairs(var_15_2) do
				local var_15_3 = iter_15_1.x + arg_15_2.x
				local var_15_4 = arg_15_2.y - iter_15_1.y
				local var_15_5 = arg_15_0:isInSlotAreaSize(var_15_3, var_15_4)
				local var_15_6 = RougeCollectionModel.instance:getSlotFilledCollectionId(var_15_3, var_15_4)
				local var_15_7 = var_15_6 and var_15_6 > 0 and var_15_6 ~= arg_15_1.id

				if not var_15_5 or var_15_7 then
					var_15_0 = false

					break
				end
			end
		end
	end

	return var_15_0
end

function var_0_0.isInSlotAreaSize(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = RougeCollectionModel.instance:getCurSlotAreaSize()

	if arg_16_1 >= 0 and arg_16_1 < var_16_0.row and arg_16_2 >= 0 and arg_16_2 < var_16_0.col then
		return true
	end
end

function var_0_0.removeCollectionFromSlotArea(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	local var_17_0 = arg_17_1:getCollectionId()

	if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(var_17_0) then
		RougeCollectionChessController.instance:deselectCollection()
		RougeCollectionChessController.instance:removeCollectionFromSlotArea(var_17_0)
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, var_17_0, true)
end

function var_0_0.tryPlaceEnchant2Collection(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = RougeCollectionModel.instance:getCollectionByUid(arg_18_1)

	if not var_18_0 or not arg_18_2 or arg_18_1 == arg_18_2 then
		return
	end

	local var_18_1 = RougeCollectionConfig.instance:getCollectionCfg(var_18_0.cfgId)

	if not var_18_1 then
		return
	end

	local var_18_2 = var_18_1.type == RougeEnum.CollectionType.Enchant
	local var_18_3 = var_18_1.holeNum or 0

	if var_18_2 or var_18_3 <= 0 then
		return
	end

	local var_18_4 = arg_18_0:getCollectionNextPlaceHole(arg_18_1)

	if var_18_4 and var_18_4 > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.CollectionEnchant)
		RougeCollectionEnchantController.instance:trySendRogueCollectionEnchantRequest(arg_18_1, arg_18_2, var_18_4)
		arg_18_0:updateCollectionNextPlaceHole(arg_18_1)

		return true
	end
end

function var_0_0.deleteSlotCollection(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._placeCollectionMap and arg_19_0._placeCollectionMap[arg_19_1]

	if var_19_0 then
		arg_19_0._poolComp:recycleCollectionItem(RougeCollectionDragItem.__cname, var_19_0)

		arg_19_0._placeCollectionMap[arg_19_1] = nil
	end

	if arg_19_0._placeHoleIndexMap and arg_19_0._placeHoleIndexMap[arg_19_1] then
		arg_19_0._placeHoleIndexMap[arg_19_1] = nil
	end
end

function var_0_0.updateEnchantInfo(arg_20_0, arg_20_1)
	local var_20_0 = RougeCollectionModel.instance:getCollectionByUid(arg_20_1)

	if not var_20_0 then
		return
	end

	local var_20_1 = var_20_0:getAllEnchantId()

	if not var_20_1 then
		return
	end

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		local var_20_2 = arg_20_0._placeCollectionMap and arg_20_0._placeCollectionMap[iter_20_1]

		if var_20_2 then
			arg_20_0._poolComp:recycleCollectionItem(RougeCollectionDragItem.__cname, var_20_2)

			arg_20_0._placeCollectionMap[iter_20_1] = nil
		end
	end
end

function var_0_0.getPlaceCollectionItem(arg_21_0, arg_21_1)
	return arg_21_0._placeCollectionMap and arg_21_0._placeCollectionMap[arg_21_1]
end

function var_0_0.getCollectionNextPlaceHole(arg_22_0, arg_22_1)
	local var_22_0 = RougeCollectionModel.instance:getCollectionByUid(arg_22_1)

	if not var_22_0 then
		return
	end

	local var_22_1
	local var_22_2 = var_22_0:getAllEnchantId()

	if var_22_2 then
		for iter_22_0, iter_22_1 in ipairs(var_22_2) do
			if not var_22_0:isEnchant(iter_22_0) then
				var_22_1 = iter_22_0

				break
			end
		end
	end

	var_22_1 = var_22_1 or arg_22_0._placeHoleIndexMap[arg_22_1] or 1
	arg_22_0._placeHoleIndexMap[arg_22_1] = var_22_1

	return var_22_1
end

function var_0_0.updateCollectionNextPlaceHole(arg_23_0, arg_23_1)
	local var_23_0 = RougeCollectionModel.instance:getCollectionByUid(arg_23_1)

	if not var_23_0 then
		return
	end

	local var_23_1 = arg_23_0._placeHoleIndexMap[arg_23_1]

	if var_23_1 then
		local var_23_2 = var_23_0.cfgId
		local var_23_3 = RougeCollectionConfig.instance:getCollectionCfg(var_23_2)
		local var_23_4 = var_23_3 and var_23_3.holeNum or 0
		local var_23_5 = (var_23_1 + 1) % var_23_4

		if var_23_5 <= 0 then
			var_23_5 = var_23_4
		end

		arg_23_0._placeHoleIndexMap[arg_23_1] = var_23_5
	end
end

function var_0_0.onClose(arg_24_0)
	return
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0._poolComp = nil

	if arg_25_0._placeCollectionMap then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._placeCollectionMap) do
			iter_25_1:destroy()
		end
	end
end

return var_0_0
