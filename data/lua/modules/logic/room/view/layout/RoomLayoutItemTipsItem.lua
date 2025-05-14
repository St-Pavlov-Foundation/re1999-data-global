module("modules.logic.room.view.layout.RoomLayoutItemTipsItem", package.seeall)

local var_0_0 = class("RoomLayoutItemTipsItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "content")
	arg_1_0._gobuildingicon = gohelper.findChild(arg_1_0.viewGO, "content/#go_buildingicon")
	arg_1_0._godikuaiicon = gohelper.findChild(arg_1_0.viewGO, "content/#go_dikuaiicon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_name")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_num")
	arg_1_0._txtdegree = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_degree")
	arg_1_0._gobtnbuy = gohelper.findChild(arg_1_0.viewGO, "#btn_buy")
	arg_1_0._gocanbuy = gohelper.findChild(arg_1_0.viewGO, "#btn_buy/canBuy")
	arg_1_0._gonotcanbuy = gohelper.findChild(arg_1_0.viewGO, "#btn_buy/notCanBuy")
	arg_1_0._btnbuy = gohelper.getClickWithDefaultAudio(arg_1_0._gobtnbuy)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._onBtnBuyClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
end

function var_0_0._onBtnBuyClick(arg_4_0)
	local var_4_0 = arg_4_0._layoutItemMO
	local var_4_1 = var_4_0 and var_4_0.materialType
	local var_4_2 = var_4_0 and var_4_0.itemId
	local var_4_3 = StoreConfig.instance:getRoomProductGoodsId(var_4_1, var_4_2)
	local var_4_4 = arg_4_0:isCanBuyGoods()
	local var_4_5 = var_4_3 and StoreModel.instance:getGoodsMO(var_4_3)

	if var_4_5 and var_4_4 then
		StoreController.instance:checkAndOpenStoreView(tonumber(var_4_5.config.storeId), var_4_3)
	else
		GameFacade.showToast(ToastEnum.RoomNoneGoods)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._canvasGroup = gohelper.onceAddComponent(arg_5_0._gocontent, gohelper.Type_CanvasGroup)
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._layoutItemMO = arg_8_1

	arg_8_0:_refreshUI()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0._refreshUI(arg_10_0)
	local var_10_0 = arg_10_0._layoutItemMO

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0:getItemConfig()

	if not var_10_1 then
		logError(string.format("itemId:%s itemType:%s not find itemConfig.", var_10_0.itemId, var_10_0.itemType))

		return
	end

	gohelper.setActive(arg_10_0._gobuildingicon, var_10_0:isBuilding())
	gohelper.setActive(arg_10_0._godikuaiicon, var_10_0:isBlockPackage() or var_10_0:isSpecialBlock())

	local var_10_2 = var_10_0.itemNum or 0
	local var_10_3 = 0
	local var_10_4 = var_10_0:isLack()

	if var_10_0:isBuilding() then
		local var_10_5 = RoomMapModel.instance:getBuildingConfigParam(var_10_0.itemId)

		var_10_2 = var_10_5 and var_10_5.pointList and #var_10_5.pointList or 0
		var_10_3 = var_10_1.buildDegree or 0
	elseif var_10_0:isBlockPackage() then
		var_10_3 = (var_10_1.blockBuildDegree or 0) * var_10_2
	elseif var_10_0:isSpecialBlock() then
		local var_10_6 = RoomConfig.instance:getBlockPackageConfig(RoomBlockPackageEnum.ID.RoleBirthday)

		var_10_3 = var_10_6 and var_10_6.blockBuildDegree or 0
	end

	if var_10_4 then
		arg_10_0._txtname.text = formatLuaLang("room_layoutplan_namemask_lack", var_10_1.name)
	else
		arg_10_0._txtname.text = var_10_1.name
	end

	arg_10_0._txtnum.text = var_10_2
	arg_10_0._txtdegree.text = var_10_3
	arg_10_0._canvasGroup.alpha = var_10_4 and 0.3 or 1

	arg_10_0:refreshBtnBuy()
end

function var_0_0.refreshBtnBuy(arg_11_0)
	local var_11_0 = false
	local var_11_1 = arg_11_0._layoutItemMO

	if arg_11_0._view and arg_11_0._view.viewParam and arg_11_0._view.viewParam.showBuy then
		var_11_0 = var_11_1 and var_11_1:isLack()
	end

	if var_11_0 then
		local var_11_2 = arg_11_0:isCanBuyGoods()

		gohelper.setActive(arg_11_0._gocanbuy, var_11_2)
		gohelper.setActive(arg_11_0._gonotcanbuy, not var_11_2)
	end

	gohelper.setActive(arg_11_0._gobtnbuy, var_11_0)
end

function var_0_0.isCanBuyGoods(arg_12_0)
	local var_12_0 = true
	local var_12_1 = true
	local var_12_2 = arg_12_0._layoutItemMO
	local var_12_3 = var_12_2 and var_12_2.materialType
	local var_12_4 = var_12_2 and var_12_2.itemId
	local var_12_5 = StoreConfig.instance:getRoomProductGoodsId(var_12_3, var_12_4)
	local var_12_6 = var_12_5 and StoreModel.instance:getGoodsMO(var_12_5)

	if var_12_6 then
		if var_12_6:getIsActivityGoods() then
			var_12_0 = ActivityHelper.getActivityStatus(var_12_6.config.activityId) ~= ActivityEnum.ActivityStatus.Normal
		else
			local var_12_7 = ServerTime.now()

			if var_12_6:getIsPackageGoods() then
				local var_12_8 = StoreModel.instance:getGoodsMO(var_12_6.config.bindgoodid)

				if var_12_8 then
					local var_12_9 = TimeUtil.stringToTimestamp(var_12_8.config.onlineTime)
					local var_12_10 = TimeUtil.stringToTimestamp(var_12_8.config.offlineTime)

					var_12_0 = var_12_7 < var_12_9 or var_12_10 <= var_12_7
				else
					var_12_0 = true
				end
			else
				local var_12_11 = var_12_6:getOfflineTime()

				var_12_0 = var_12_11 > 0 and var_12_11 <= var_12_7
			end
		end

		var_12_1 = var_12_6:isSoldOut()
	end

	return not var_12_0 and not var_12_1 and var_12_6:checkJumpGoodCanOpen()
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
