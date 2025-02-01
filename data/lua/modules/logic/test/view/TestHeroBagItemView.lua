module("modules.logic.test.view.TestHeroBagItemView", package.seeall)

slot0 = class("TestHeroBagItemView", BaseViewExtended)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
end

function slot0.onScrollItemRefreshData(slot0, slot1)
	slot0._data = slot1

	if slot0._heroItem then
		slot0._heroItem:onUpdateMO(slot0._data)
	end
end

function slot0.onOpen(slot0)
	slot0:com_loadAsset("ui/viewres/common/item/commonheroitemnew.prefab", slot0._loaded)
end

function slot0._loaded(slot0, slot1)
	slot0._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot1:GetResource(), slot0.viewGO), CommonHeroItem)

	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)
end

function slot0._onItemClick(slot0)
	logError("点击了英雄id:" .. slot0._data.heroId)
end

function slot0.onClose(slot0)
	if slot0._heroItem then
		slot0._heroItem:onDestroy()

		slot0._heroItem = nil
	end
end

return slot0
