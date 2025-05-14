module("modules.logic.rouge.view.RougeCollectionSlotCellItem", package.seeall)

local var_0_0 = class("RougeCollectionSlotCellItem", RougeCollectionBaseSlotCellItem)

function var_0_0.onInit(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.onInit(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
end

function var_0_0._onInitView(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_0.super._onInitView(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	arg_2_0._goarea = gohelper.findChild(arg_2_0.viewGO, "area")
	arg_2_0._imagestate = gohelper.findChildImage(arg_2_0.viewGO, "area/state")
	arg_2_0._goplace = gohelper.findChild(arg_2_0.viewGO, "area/place")

	arg_2_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, arg_2_0._onBeginDragCollection, arg_2_0)
	arg_2_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnEndDragCollection, arg_2_0._onEndDragCollection, arg_2_0)
end

function var_0_0.chechCellHasPlace(arg_3_0)
	local var_3_0 = RougeCollectionModel.instance:getSlotFilledCollectionId(arg_3_0._cellPosX, arg_3_0._cellPosY)

	return var_3_0 ~= nil and var_3_0 > 0, var_3_0
end

function var_0_0.onCoverCollection(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = arg_4_0:chechCellHasPlace()

	if var_4_0 and var_4_1 == arg_4_1 then
		arg_4_0:updateCellState(RougeEnum.LineState.Green)
		arg_4_0:hideInsideLines(arg_4_2)

		return
	end

	local var_4_2 = RougeCollectionModel.instance:getCollectionByUid(arg_4_1)

	if not var_4_2 then
		return
	end

	if var_4_0 then
		if arg_4_0:checkIsCanEnchant2PlaceCollection(var_4_1, var_4_2) then
			arg_4_0:updateCellState(RougeEnum.LineState.Green)
		else
			arg_4_0:updateCellState(RougeEnum.LineState.Red)
		end
	else
		arg_4_0:updateCellState(RougeEnum.LineState.Green)
	end

	arg_4_0:hideInsideLines(arg_4_2)
end

function var_0_0.checkIsCanEnchant2PlaceCollection(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = RougeCollectionModel.instance:getCollectionByUid(arg_5_1)
	local var_5_1 = RougeCollectionConfig.instance:getCollectionCfg(var_5_0.cfgId).type ~= RougeEnum.CollectionType.Enchant

	return RougeCollectionConfig.instance:getCollectionCfg(arg_5_2.cfgId).type == RougeEnum.CollectionType.Enchant and var_5_1
end

function var_0_0.updateCellColor(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._imagestate.gameObject, true)

	if arg_6_1 == RougeEnum.LineState.Green then
		UISpriteSetMgr.instance:setRougeSprite(arg_6_0._imagestate, "rouge_collection_grid_big_3")
	elseif arg_6_1 == RougeEnum.LineState.Blue then
		UISpriteSetMgr.instance:setRougeSprite(arg_6_0._imagestate, "rouge_collection_grid_big_1")
	else
		gohelper.setActive(arg_6_0._imagestate.gameObject, false)
	end
end

function var_0_0.updateCellState(arg_7_0, arg_7_1)
	var_0_0.super.updateCellState(arg_7_0, arg_7_1)
	arg_7_0:updateCellColor(arg_7_0._curCellState)
end

function var_0_0._onBeginDragCollection(arg_8_0, arg_8_1)
	local var_8_0 = RougeCollectionModel.instance:getSlotFilledCollectionId(arg_8_0._cellPosX, arg_8_0._cellPosY)
	local var_8_1 = arg_8_1 and arg_8_1.id == var_8_0 or not var_8_0 or var_8_0 <= 0

	gohelper.setActive(arg_8_0._goplace, var_8_1)
end

function var_0_0._onEndDragCollection(arg_9_0)
	gohelper.setActive(arg_9_0._goplace, false)
end

function var_0_0.onPlaceCollection(arg_10_0, arg_10_1)
	var_0_0.super.onPlaceCollection(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._imagestate.gameObject, false)
end

function var_0_0.revertCellState(arg_11_0, arg_11_1)
	var_0_0.super.revertCellState(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._imagestate.gameObject, false)
end

function var_0_0.destroy(arg_12_0)
	var_0_0.super.destroy(arg_12_0)
end

return var_0_0
