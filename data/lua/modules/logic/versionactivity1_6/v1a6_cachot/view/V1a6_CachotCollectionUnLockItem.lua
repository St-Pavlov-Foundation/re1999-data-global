module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionUnLockItem", package.seeall)

slot0 = class("V1a6_CachotCollectionUnLockItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_collection")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "top/#txt_name")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot0._mo.id) then
		slot0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot1.icon))

		slot0._txtname.text = tostring(slot1.name)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagecollection:UnLoadImage()
end

return slot0
