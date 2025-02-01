module("modules.logic.room.view.critter.summon.RoomCritterSummonView", package.seeall)

slot0 = class("RoomCritterSummonView", BaseView)

function slot0.onInitView(slot0)
	slot0.root = gohelper.findChild(slot0.viewGO, "root")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "root/top/#simage_title")
	slot0._gocritterSub = gohelper.findChild(slot0.viewGO, "root/right/#go_critterSub")
	slot0._gocritteritem = gohelper.findChild(slot0.viewGO, "root/right/#go_critterSub/#go_critteritem")
	slot0._scrollcritter = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#go_critterSub/#scroll_critter")
	slot0._btnrefresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#btn_refresh")
	slot0._btnsummon = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/bottom/#btn_summon")
	slot0._simagecurrency = gohelper.findChildSingleImage(slot0.viewGO, "root/bottom/#btn_summon/currency/#simage_currency")
	slot0._txtcurrency = gohelper.findChildText(slot0.viewGO, "root/bottom/#btn_summon/currency/#txt_currency")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "root/#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrefresh:AddClickListener(slot0._btnrefreshOnClick, slot0)
	slot0._btnsummon:AddClickListener(slot0._btnsummonOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrefresh:RemoveClickListener()
	slot0._btnsummon:RemoveClickListener()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, slot0._onStartSummon, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, slot0._onCloseGetCritter, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onResetSummon, slot0._onResetSummon, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onRefreshBtn, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onRefreshBtn, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, slot0._onStartSummon, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, slot0._onCloseGetCritter, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onResetSummon, slot0._onResetSummon, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onRefreshBtn, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onRefreshBtn, slot0)
end

function slot0._btnrefreshOnClick(slot0)
	slot0:_refreshPool()
end

function slot0._btnsummonOnClick(slot0)
	slot1, slot2 = CritterSummonModel.instance:notSummonToast(slot0._poolId)

	if string.nilorempty(slot1) then
		CritterRpc.instance:sendSummonCritterRequest(slot0._poolId, slot0._summonCount)
	else
		GameFacade.showToast(slot1, slot2)
	end
end

function slot0._editableInitView(slot0)
	slot0._canvasGroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0._poolId = CritterSummonModel.instance:getSummonPoolId()
	slot0._summonCount = CritterSummonModel.instance:getSummonCount()

	gohelper.setActive(slot0._gocritteritem, false)
	CritterRpc.instance:sendSummonCritterInfoRequest(slot0.onRefresh, slot0)
	slot0:_refreshSingleCost()
end

function slot0.onClose(slot0)
	slot0:_removeEvents()
end

function slot0.onDestroyView(slot0)
	slot0._simagecurrency:UnLoadImage()
end

function slot0.onRefresh(slot0)
	slot0:_onRefreshCritter()
	slot0:_onRefreshBtn()
end

function slot0._onRefreshBtn(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnsummon.gameObject, not string.nilorempty(CritterSummonModel.instance:notSummonToast(slot0._poolId)))
end

function slot0._onRefreshCritter(slot0)
	CritterSummonModel.instance:setSummonPoolList(slot0._poolId)

	if CritterSummonModel.instance:isNullPool(slot0._poolId) then
		slot0:_refreshPool()
	end
end

function slot0._refreshPool(slot0)
	if CritterSummonModel.instance:isFullPool(slot0._poolId) then
		GameFacade.showToast(ToastEnum.RoomCritterPoolNeweast)

		return
	end

	if CritterSummonModel.instance:isNullPool(slot0._poolId) then
		slot0:_refreshPoolRequest()
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterPoolRefresh, MsgBoxEnum.BoxType.Yes_No, slot0._refreshPoolRequest, nil, , slot0)
	end
end

function slot0._refreshPoolRequest(slot0)
	CritterRpc.instance:sendResetSummonCritterPoolRequest(slot0._poolId)
end

function slot0._refreshSingleCost(slot0)
	slot1, slot0._txtcurrency.text, slot3 = CritterSummonModel.instance:getPoolCurrency(slot0._poolId)

	slot0._simagecurrency:LoadImage(slot1)
end

function slot0._onStartSummon(slot0, slot1)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
	CritterSummonController.instance:openSummonView(slot0.viewContainer:getContainerViewBuilding(), slot1)

	if slot0.root then
		gohelper.setActive(slot0.root, false)
	end
end

function slot0._onCloseGetCritter(slot0)
	if slot0.root then
		gohelper.setActive(slot0.root, true)
	end

	slot0:onRefresh()
end

function slot0._onResetSummon(slot0, slot1)
	slot0._poolId = slot1

	GameFacade.showToast(ToastEnum.RoomCritterPoolRefresh)
	CritterSummonController.instance:refreshSummon(slot1, slot0.onRefresh, slot0)
end

return slot0
