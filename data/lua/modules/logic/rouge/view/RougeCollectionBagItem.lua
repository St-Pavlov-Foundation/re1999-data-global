module("modules.logic.rouge.view.RougeCollectionBagItem", package.seeall)

slot0 = class("RougeCollectionBagItem", UserDataDispose)

function slot0.onInitView(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.parentViewInst = slot1
	slot0.viewGO = slot2
	slot0._gopos = gohelper.findChild(slot0.viewGO, "go_pos")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "right/txt_name")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "right/Scroll View/Viewport/Content/txt_desc")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_detail")
	slot0._btnequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_equip")
	slot0._goselectframe = gohelper.findChild(slot0.viewGO, "#go_selectframe")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0:AddDragListeners()
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnequip:AddClickListener(slot0._btnequipOnClick, slot0)

	slot0._canvasgroup = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_CanvasGroup)

	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, slot0.failed2PlaceSlotCollection, slot0)
	slot0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, slot0._updateCollectionEnchant, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateCollectionAttr, slot0.updateCollectionAttr, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.SelectCollection, slot0._selectCollection, slot0)
end

function slot0.AddDragListeners(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0.viewGO)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0.releaseDragListeners(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()
		slot0._drag:RemoveDragListener()

		slot0._drag = nil
	end
end

function slot0._btndetailOnClick(slot0)
	RougeController.instance:openRougeCollectionTipView({
		useCloseBtn = false,
		collectionId = slot0._mo.id,
		viewPosition = RougeEnum.CollectionTipPos.Bag,
		source = RougeEnum.OpenCollectionTipSource.BagArea
	})
	RougeCollectionChessController.instance:selectCollection(slot0._mo.id)
end

function slot0._btnequipOnClick(slot0)
	RougeCollectionChessController.instance:autoPlaceCollection2SlotArea(slot0._mo.id)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot3 = RougeCollectionHelper.isCanDragCollection()
	slot0._isDraging = slot3

	if not slot3 then
		return
	end

	slot0:setCanvasGroupVisible(false)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnBeginDragCollection, slot0._mo, slot2)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnDragCollection, slot2)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if not slot0._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnEndDragCollection, slot2)
end

slot1 = 160
slot2 = 160

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if not slot0._itemIcon then
		slot0._itemIcon = RougeCollectionEnchantIconItem.New(slot0.parentViewInst:getResInst(ViewMgr.instance:getSetting(ViewName.RougeCollectionChessView).otherRes[1], slot0._gopos, "itemicon"))

		slot0._itemIcon:setCollectionIconSize(uv0, uv1)
	end

	slot0._itemIcon:onUpdateMO(slot0._mo)

	slot0._txtname.text = RougeCollectionConfig.instance:getCollectionName(slot0._mo.cfgId, slot0._mo:getAllEnchantCfgId())

	slot0:refreshCollectionDesc()
	gohelper.setActive(slot0._goselectframe, false)
	slot0:setItemVisible(true)
end

function slot0.refreshCollectionDesc(slot0)
	if not slot0._mo then
		return
	end

	RougeCollectionDescHelper.setCollectionDescInfos4(slot0._mo.id, slot0._txtdesc, RougeCollectionDescHelper.getShowDescTypesWithoutText(), RougeCollectionDescHelper.getExtraParams_KeepAllActive())
end

function slot0.setItemVisible(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
	slot0:setCanvasGroupVisible(slot1)
end

function slot0.setCanvasGroupVisible(slot0, slot1)
	slot0._canvasgroup.alpha = slot1 and 1 or 0
	slot0._canvasgroup.interactable = slot1
	slot0._canvasgroup.blocksRaycasts = slot1
end

function slot0.failed2PlaceSlotCollection(slot0, slot1)
	if slot0._mo and slot0._mo.id == slot1 then
		slot0:setItemVisible(true)
	end
end

function slot0._selectCollection(slot0)
	gohelper.setActive(slot0._goselectframe, RougeCollectionBagListModel.instance:isCollectionSelect(slot0._mo and slot0._mo.id))
end

function slot0.updateCollectionAttr(slot0, slot1)
	if (slot0._mo and slot0._mo.id) == slot1 then
		slot0:refreshCollectionDesc()
	end
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refreshCollectionDesc()
end

function slot0._updateCollectionEnchant(slot0, slot1)
	if not slot0._mo or slot0._mo.id ~= slot1 then
		return
	end

	slot0:refreshCollectionDesc()
end

function slot0.reset(slot0)
	slot0._mo = nil
	slot0._isDraging = false

	slot0:setItemVisible(false)
end

function slot0.destroy(slot0)
	slot0:releaseDragListeners()

	if slot0._itemIcon then
		slot0._itemIcon:destroy()

		slot0._itemIcon = nil
	end

	slot0._btndetail:RemoveClickListener()
	slot0._btnequip:RemoveClickListener()
	slot0:__onDispose()
end

return slot0
