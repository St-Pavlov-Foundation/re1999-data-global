module("modules.logic.rouge.map.view.store.RougeStoreGoodsViewContainer", package.seeall)

slot0 = class("RougeStoreGoodsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeStoreGoodsView.New())
	table.insert(slot1, RougeMapCoinView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_rougemapdetailcontainer"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return slot0
