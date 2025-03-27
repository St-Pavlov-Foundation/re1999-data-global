module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionLossRightItem", package.seeall)

slot0 = class("RougeMapCollectionLossRightItem", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.tr = slot1:GetComponent(gohelper.Type_RectTransform)

	slot0:_editableInitView()
end

function slot0._editableInitView(slot0)
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.go)
	slot0.goGrid = gohelper.findChild(slot0.go, "#go_grid")
	slot0.goGridItem = gohelper.findChild(slot0.go, "#go_grid/#go_griditem")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.go, "#simage_icon")
	slot0.txtName = gohelper.findChildText(slot0.go, "right/#txt_name")
	slot0.txtDesc = gohelper.findChildText(slot0.go, "right/Scroll View/Viewport/Content/#txt_desc")
	slot0.click = gohelper.findChildClickWithDefaultAudio(slot0.go, "#btn_click")

	slot0.click:AddClickListener(slot0.onClickSelf, slot0)

	slot0.gridItemList = slot0:getUserDataTb_()

	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
end

function slot0.onClickSelf(slot0)
	RougeLossCollectionListModel.instance:deselectMo(slot0.mo)
end

function slot0.update(slot0, slot1, slot2)
	slot0.mo = slot2
	slot0.collectionId = slot0.mo.collectionId

	RougeCollectionHelper.loadShapeGrid(slot0.collectionId, slot0.goGrid, slot0.goGridItem, slot0.gridItemList)
	slot0.simageIcon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0.collectionId))

	slot0.txtName.text = RougeCollectionConfig.instance:getCollectionName(slot0.collectionId)

	slot0:refreshDesc()
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.show(slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.refreshDesc(slot0)
	RougeCollectionDescHelper.setCollectionDescInfos3(slot0.collectionId, nil, slot0.txtDesc, RougeCollectionDescHelper.getShowDescTypesWithoutText())
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refreshDesc()
end

function slot0.destroy(slot0)
	slot0.click:RemoveClickListener()
	slot0.simageIcon:UnLoadImage()
	slot0:__onDispose()
end

return slot0
