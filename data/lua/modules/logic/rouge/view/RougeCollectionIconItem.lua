module("modules.logic.rouge.view.RougeCollectionIconItem", package.seeall)

slot0 = class("RougeCollectionIconItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.viewGO = slot1
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._gogridcontainer = gohelper.findChild(slot0.viewGO, "#go_gridcontainer")
	slot0._gogrid = gohelper.findChild(slot0.viewGO, "#go_gridcontainer/#go_grid")
	slot0._goholetool = gohelper.findChild(slot0.viewGO, "#go_holetool")
	slot0._goholeitem = gohelper.findChild(slot0.viewGO, "#go_holetool/#go_holeitem")
	slot0._gridList = slot0:getUserDataTb_()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = 46
slot2 = 46

function slot0.onUpdateMO(slot0, slot1)
	slot0._collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(slot1)

	slot0._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot1))
	RougeCollectionHelper.loadShapeGrid(slot1, slot0._gogridcontainer, slot0._gogrid, slot0._gridList)
	gohelper.setActive(slot0.viewGO, true)
end

function slot0.setPerCellSize(slot0, slot1, slot2)
	RougeCollectionHelper.computeAndSetCollectionIconScale(slot0._collectionCfg.id, slot0._simageicon.transform, slot1, slot2)

	slot0._perCellWidth = slot1 or uv0
	slot0._perCellHeight = slot2 or uv1
end

function slot0.setCollectionIconSize(slot0, slot1, slot2)
	recthelper.setSize(slot0._simageicon.transform, slot1, slot2)
end

function slot0.setHolesVisible(slot0, slot1)
	gohelper.setActive(slot0._goholetool, slot1)
end

function slot0.destroy(slot0)
	slot0._simageicon:UnLoadImage()
	slot0:__onDispose(slot0)
end

return slot0
