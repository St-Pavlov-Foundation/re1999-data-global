module("modules.logic.room.view.manufacture.RoomManufacturePlaceCostView", package.seeall)

slot0 = class("RoomManufacturePlaceCostView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "go_normalroot/#txt_title")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "go_normalroot/#txt_name")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "go_normalroot/#txt_desc")
	slot0._btninform = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/#btn_inform")
	slot0._scrollcost = gohelper.findChildScrollRect(slot0.viewGO, "go_normalroot/#scroll_cost")
	slot0._gocosts = gohelper.findChild(slot0.viewGO, "go_normalroot/#scroll_cost/Viewport/#go_costs")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "go_normalroot/#simage_icon")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btninform:AddClickListener(slot0._btninformOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btninform:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btninformOnClick(slot0)
	if not RoomMapBuildingModel.instance:getTempBuildingMO() or tonumber(slot1.id) > 0 then
		slot0:closeThis()
	elseif slot0:_checkCost() then
		RoomBuildingController.instance:sendBuyManufactureBuildingRpc(slot1.buildingId)
	else
		GameFacade.showToast(ToastEnum.RoomPlaceCostItemSufficient)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if not RoomMapBuildingModel.instance:getTempBuildingMO() then
		slot0:closeThis()

		return
	end

	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	slot0._simageicon:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshUI(slot0)
	if not RoomMapBuildingModel.instance:getTempBuildingMO() then
		return
	end

	if not ManufactureConfig.instance:getManufactureBuildingCfg(slot1.buildingId) then
		return
	end

	slot3 = slot1.config
	slot0._txtname.text = slot3.name
	slot0._txtdesc.text = slot3.desc
	slot0._txttitle.text = slot3.useDesc

	slot0._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. slot1:getIcon()))

	slot0._costDataList = ItemModel.instance:getItemDataListByConfigStr(slot2.placeCost)

	IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onItemShow, slot0._costDataList, slot0._gocosts)
end

function slot0._checkCost(slot0)
	if slot0._costDataList then
		for slot4 = 1, #slot0._costDataList do
			slot5 = slot0._costDataList[slot4]

			if ItemModel.instance:getItemQuantity(slot5.materilType, slot5.materilId) < slot5.quantity then
				return false
			end
		end
	end

	return true
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
	slot1:setCountText(ItemModel.instance:getItemIsEnoughText(slot2))
end

return slot0
