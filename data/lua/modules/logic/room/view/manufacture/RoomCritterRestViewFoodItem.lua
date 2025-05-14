module("modules.logic.room.view.manufacture.RoomCritterRestViewFoodItem", package.seeall)

local var_0_0 = class("RoomCritterRestViewFoodItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagequality = gohelper.findChildImage(arg_1_0.viewGO, "#simage_quality")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_num/#txt_num")
	arg_1_0._goprefer = gohelper.findChild(arg_1_0.viewGO, "#go_prefer")
	arg_1_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goclickEff = gohelper.findChild(arg_1_0.viewGO, "click_full")

	gohelper.setActive(arg_1_0._goclickEff, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0.onClick, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0.refreshQuantity, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0.refreshQuantity, arg_3_0)
end

function var_0_0.onClick(arg_4_0)
	local var_4_0, var_4_1 = ManufactureModel.instance:getSelectedCritterSeatSlot()
	local var_4_2 = RoomMapBuildingModel.instance:getBuildingMOById(var_4_0):getRestingCritter(var_4_1)

	if not var_4_2 then
		return
	end

	local var_4_3 = arg_4_0._mo.id

	if ItemModel.instance:getItemCount(var_4_3) <= 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.IsJumpCritterStoreBuyFood, MsgBoxEnum.BoxType.Yes_No, arg_4_0._confirmJumpStore, nil, nil, arg_4_0, nil, nil, arg_4_0._name)

		return
	end

	local var_4_4 = CritterModel.instance:getCritterMOByUid(var_4_2)
	local var_4_5 = 0

	if var_4_4 then
		var_4_5 = var_4_4:getMoodValue()
	end

	local var_4_6 = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)
	local var_4_7 = tonumber(var_4_6) or 0

	if var_4_5 ~= 0 and var_4_7 <= var_4_5 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomFeedCritterMaxMood, MsgBoxEnum.BoxType.Yes_No, function()
			arg_4_0:sendFeedRequest(var_4_2)
		end)
	else
		arg_4_0:sendFeedRequest(var_4_2)
	end
end

function var_0_0._confirmJumpStore(arg_6_0)
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.CritterStore)
end

function var_0_0.sendFeedRequest(arg_7_0, arg_7_1)
	local var_7_0 = {
		quantity = 1,
		type = MaterialEnum.MaterialType.Item,
		id = arg_7_0._mo.id
	}

	RoomRpc.instance:sendFeedCritterRequest(arg_7_1, var_7_0, arg_7_0._afterFeed, arg_7_0)
end

function var_0_0._afterFeed(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= 0 then
		return
	end

	local var_8_0 = false
	local var_8_1, var_8_2 = ManufactureModel.instance:getSelectedCritterSeatSlot()
	local var_8_3 = RoomMapBuildingModel.instance:getBuildingMOById(var_8_1)
	local var_8_4 = var_8_3 and var_8_3:getRestingCritter(var_8_2)
	local var_8_5 = CritterModel.instance:getCritterMOByUid(var_8_4)

	if var_8_5 then
		local var_8_6 = var_8_5:getDefineId()

		var_8_0 = CritterConfig.instance:isFavoriteFood(var_8_6, arg_8_0._mo.id)
	end

	arg_8_0:playClickEff()

	local var_8_7 = {
		[arg_8_3.critterUid] = true
	}

	CritterController.instance:dispatchEvent(CritterEvent.CritterFeedFood, var_8_7, var_8_0)
end

function var_0_0.playClickEff(arg_9_0)
	gohelper.setActive(arg_9_0._goclickEff, false)
	gohelper.setActive(arg_9_0._goclickEff, true)
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	local var_10_0 = arg_10_0._mo.id
	local var_10_1, var_10_2 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_10_0)

	arg_10_0._name = var_10_1.name

	local var_10_3 = RoomManufactureEnum.RareImageMap[var_10_1.rare]

	UISpriteSetMgr.instance:setCritterSprite(arg_10_0._imagequality, var_10_3)
	arg_10_0._simageicon:LoadImage(var_10_2)
	arg_10_0:refreshQuantity()
	gohelper.setActive(arg_10_0._goprefer, arg_10_0._mo.isFavorite)
	gohelper.setActive(arg_10_0._goclickEff, false)
end

function var_0_0.refreshQuantity(arg_11_0)
	local var_11_0 = arg_11_0._mo.id
	local var_11_1 = ItemModel.instance:getItemCount(var_11_0)

	arg_11_0._txtnum.text = var_11_1
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageicon:UnLoadImage()
end

return var_0_0
