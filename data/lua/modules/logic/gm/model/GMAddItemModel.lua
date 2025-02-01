module("modules.logic.gm.model.GMAddItemModel", package.seeall)

slot0 = class("GMAddItemModel", ListScrollModel)

function slot0.setFastAddHeroView(slot0, slot1)
	slot0.fastAddHeroView = slot1
end

function slot0.onOnClickItem(slot0, slot1)
	if slot0.fastAddHeroView then
		slot0.fastAddHeroView:onAddItemOnClick(slot1)
	end
end

slot0.instance = slot0.New()

return slot0
