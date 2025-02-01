module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEnchantBagItem", package.seeall)

slot0 = class("V1a6_CachotEnchantBagItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goscale = gohelper.findChild(slot0.viewGO, "#go_scale")

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
	if slot0:getOrCreateCollectionItem() then
		slot1:onUpdateMO(slot0._mo)
	end
end

function slot0.getOrCreateCollectionItem(slot0)
	if not slot0._bagItem then
		slot0._bagItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst(slot0._view.viewContainer._viewSetting.otherRes[1], slot0._goscale, "collectionitem"), V1a6_CachotCollectionBagItem)

		slot0._bagItem:setClickCallBack(slot0.clikCallBack, slot0)
	end

	return slot0._bagItem
end

function slot0.clikCallBack(slot0)
	V1a6_CachotCollectionEnchantController.instance:onSelectBagItem(slot0._index)
end

function slot0.onSelect(slot0, slot1)
	if slot0._bagItem then
		slot0._bagItem:onSelect(slot1)
	end
end

function slot0.onDestroyView(slot0)
	if slot0._bagItem then
		slot0._bagItem:onDestroyView()

		slot0._bagItem = nil
	end
end

return slot0
