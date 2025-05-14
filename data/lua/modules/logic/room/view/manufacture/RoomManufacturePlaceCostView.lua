module("modules.logic.room.view.manufacture.RoomManufacturePlaceCostView", package.seeall)

local var_0_0 = class("RoomManufacturePlaceCostView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "go_normalroot/#txt_title")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "go_normalroot/#txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "go_normalroot/#txt_desc")
	arg_1_0._btninform = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/#btn_inform")
	arg_1_0._scrollcost = gohelper.findChildScrollRect(arg_1_0.viewGO, "go_normalroot/#scroll_cost")
	arg_1_0._gocosts = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#scroll_cost/Viewport/#go_costs")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_normalroot/#simage_icon")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninform:AddClickListener(arg_2_0._btninformOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninform:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btninformOnClick(arg_5_0)
	local var_5_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not var_5_0 or tonumber(var_5_0.id) > 0 then
		arg_5_0:closeThis()
	elseif arg_5_0:_checkCost() then
		RoomBuildingController.instance:sendBuyManufactureBuildingRpc(var_5_0.buildingId)
	else
		GameFacade.showToast(ToastEnum.RoomPlaceCostItemSufficient)
	end
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	if not RoomMapBuildingModel.instance:getTempBuildingMO() then
		arg_8_0:closeThis()

		return
	end

	arg_8_0:_refreshUI()
end

function var_0_0.onClose(arg_9_0)
	arg_9_0._simageicon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not var_11_0 then
		return
	end

	local var_11_1 = ManufactureConfig.instance:getManufactureBuildingCfg(var_11_0.buildingId)

	if not var_11_1 then
		return
	end

	local var_11_2 = var_11_0.config

	arg_11_0._txtname.text = var_11_2.name
	arg_11_0._txtdesc.text = var_11_2.desc
	arg_11_0._txttitle.text = var_11_2.useDesc

	arg_11_0._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. var_11_0:getIcon()))

	arg_11_0._costDataList = ItemModel.instance:getItemDataListByConfigStr(var_11_1.placeCost)

	IconMgr.instance:getCommonPropItemIconList(arg_11_0, arg_11_0._onItemShow, arg_11_0._costDataList, arg_11_0._gocosts)
end

function var_0_0._checkCost(arg_12_0)
	if arg_12_0._costDataList then
		for iter_12_0 = 1, #arg_12_0._costDataList do
			local var_12_0 = arg_12_0._costDataList[iter_12_0]

			if ItemModel.instance:getItemQuantity(var_12_0.materilType, var_12_0.materilId) < var_12_0.quantity then
				return false
			end
		end
	end

	return true
end

function var_0_0._onItemShow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:onUpdateMO(arg_13_2)
	arg_13_1:setConsume(true)
	arg_13_1:showStackableNum2()
	arg_13_1:isShowEffect(true)
	arg_13_1:setAutoPlay(true)
	arg_13_1:setCountFontSize(48)
	arg_13_1:setCountText(ItemModel.instance:getItemIsEnoughText(arg_13_2))
end

return var_0_0
