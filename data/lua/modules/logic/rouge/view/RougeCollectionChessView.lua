module("modules.logic.rouge.view.RougeCollectionChessView", package.seeall)

slot0 = class("RougeCollectionChessView", RougeBaseDLCViewComp)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gomeshContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer")
	slot0._goeffectContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_effectContainer")
	slot0._gotriggerContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_triggerContainer")
	slot0._gocellModel = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor/#go_cellModel")
	slot0._golineContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor/#go_lineContainer")
	slot0._godragContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer")
	slot0._btnlayout = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_layout")
	slot0._btnclear = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/#btn_clear")
	slot0._btnauto = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/#btn_auto")
	slot0._btnoverview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/#btn_overview")
	slot0._btnhandbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/#btn_handbook")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclear:AddClickListener(slot0._btnclearOnClick, slot0)
	slot0._btnauto:AddClickListener(slot0._btnautoOnClick, slot0)
	slot0._btnoverview:AddClickListener(slot0._btnoverviewOnClick, slot0)
	slot0._btnhandbook:AddClickListener(slot0._btnhandbookOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlayout:RemoveClickListener()
	slot0._btnclear:RemoveClickListener()
	slot0._btnauto:RemoveClickListener()
	slot0._btnoverview:RemoveClickListener()
	slot0._btnhandbook:RemoveClickListener()
end

function slot0._btnclearOnClick(slot0)
	if not RougeCollectionHelper.isCanDragCollection() then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.ClearTmpCollection)
	RougeCollectionChessController.instance:onKeyClearCollectionSlotArea()
	AudioMgr.instance:trigger(AudioEnum.UI.OneKeyClearSlotArea)
end

function slot0._btnautoOnClick(slot0)
	if not RougeCollectionHelper.isCanDragCollection() then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.ClearTmpCollection)
	RougeCollectionChessController.instance:onKeyPlaceCollection2SlotArea()
	AudioMgr.instance:trigger(AudioEnum.UI.OneKeyPlaceSlotArea)
end

function slot0._btnoverviewOnClick(slot0)
	RougeController.instance:openRougeCollectionOverView()
end

function slot0._btnhandbookOnClick(slot0)
	RougeController.instance:openRougeCollectionHandBookView()
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0:initAllContainerPosition()
	slot0:checkAndSetHandBookIconVisible()
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:startCheckCollectionCfgs()
	RougeCollectionChessController.instance:onOpen()
	RougeStatController.instance:startAdjustBackPack()
end

function slot0.onClose(slot0)
	RougeStatController.instance:endAdjustBackPack()
end

function slot0.startCheckCollectionCfgs(slot0)
	RougeCollectionDebugHelper.checkCollectionStaticItmeCfgs()
	RougeCollectionDebugHelper.checkCollectionDescCfgs()
end

function slot0.initAllContainerPosition(slot0)
	slot1 = RougeCollectionHelper.CollectionSlotCellSize

	for slot10, slot11 in pairs({
		slot0._gomeshContainer,
		slot0._goeffectContainer,
		slot0._gotriggerContainer,
		slot0._gocellModel,
		slot0._golineContainer,
		slot0._godragContainer
	}) do
		recthelper.setSize(slot11.transform, slot1.x, slot1.y)
		recthelper.setAnchor(slot11.transform, slot1.x / 2, -slot1.y / 2)

		slot11.transform.anchorMin = Vector2(0, 1)
		slot11.transform.anchorMax = Vector2(0, 1)
	end
end

function slot0.checkAndSetHandBookIconVisible(slot0)
	slot2 = false

	if RougeOutsideModel.instance:getRougeGameRecord() then
		slot2 = slot1:passLayerId(lua_rouge_const.configDict[RougeEnum.Const.CompositeEntryVisible] and tonumber(slot3.value) or 0)
	end

	gohelper.setActive(slot0._btnhandbook.gameObject, slot2)
end

return slot0
