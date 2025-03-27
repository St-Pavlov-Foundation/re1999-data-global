module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionLossLeftItem", package.seeall)

slot0 = class("RougeMapCollectionLossLeftItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.go)
	slot0.goGrid = gohelper.findChild(slot0.go, "#go_grid")
	slot0.goGridItem = gohelper.findChild(slot0.go, "#go_grid/#go_griditem")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.go, "#simage_icon")
	slot0.txtName = gohelper.findChildText(slot0.go, "right/#txt_name")
	slot0.txtDesc = gohelper.findChildText(slot0.go, "right/Scroll View/Viewport/Content/#txt_desc")
	slot0.click = gohelper.findChildClickWithDefaultAudio(slot0.go, "#btn_click")

	slot0.click:AddClickListener(slot0.onClickSelf, slot0)

	slot0.goIconAbandon = gohelper.findChild(slot0.go, "right/right_icon/#go_icon_abandon")
	slot0.goIconExchange = gohelper.findChild(slot0.go, "right/right_icon/#go_icon_exchange")
	slot0.goIconStorage = gohelper.findChild(slot0.go, "right/right_icon/#go_icon_storage")
	slot0.gridItemList = slot0:getUserDataTb_()

	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
end

function slot0.onClickSelf(slot0)
	if not RougeLossCollectionListModel.instance:checkCanSelect() then
		return
	end

	gohelper.setActive(slot0.go, false)
	slot0._view.viewContainer:getListRemoveComp():removeByIndex(slot0._index, slot0.onRemoveAnimDone, slot0)
end

function slot0.onRemoveAnimDone(slot0)
	RougeLossCollectionListModel.instance:selectMo(slot0.mo)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0.collectionId = slot0.mo.collectionId
	slot0.uid = slot0.mo.uid

	gohelper.setActive(slot0.go, true)
	RougeCollectionHelper.loadShapeGrid(slot0.collectionId, slot0.goGrid, slot0.goGridItem, slot0.gridItemList)
	slot0.simageIcon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0.collectionId))

	slot0.txtName.text = RougeCollectionConfig.instance:getCollectionName(slot0.collectionId)

	slot0:refreshIcon()
	slot0:refreshDesc()
end

function slot0.refreshIcon(slot0)
	gohelper.setActive(slot0.goIconAbandon, RougeLossCollectionListModel.instance:getLossType() == RougeMapEnum.LossType.Abandon or slot1 == RougeMapEnum.LossType.Copy)
	gohelper.setActive(slot0.goIconExchange, slot1 == RougeMapEnum.LossType.Exchange)
	gohelper.setActive(slot0.goIconStorage, slot1 == RougeMapEnum.LossType.Storage)
end

function slot0.refreshDesc(slot0)
	RougeCollectionDescHelper.setCollectionDescInfos3(slot0.collectionId, nil, slot0.txtDesc, RougeCollectionDescHelper.getShowDescTypesWithoutText())
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refreshDesc()
end

function slot0.onDestroy(slot0)
	slot0.click:RemoveClickListener()
	slot0.simageIcon:UnLoadImage()
end

return slot0
