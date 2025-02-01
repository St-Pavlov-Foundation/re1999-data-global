module("modules.logic.activity.view.LinkageActivity_PageBase", package.seeall)

slot0 = class("LinkageActivity_PageBase", RougeSimpleItemBase)

function slot0.ctor(slot0, ...)
	slot0:__onInit()
	uv0.super.ctor(slot0, ...)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

function slot0.actId(slot0)
	return slot0:_assetGetParent():actId()
end

function slot0.actCO(slot0)
	return slot0:_assetGetParent():actCO()
end

function slot0.getLinkageActivityCO(slot0)
	return slot0:_assetGetParent():getLinkageActivityCO()
end

function slot0.getDataList(slot0)
	return slot0:_assetGetParent():getDataList()
end

function slot0.getTempDataList(slot0)
	return slot0:_assetGetParent():getTempDataList()
end

function slot0.selectedPage(slot0, slot1)
	return slot0:_assetGetParent():selectedPage(slot1)
end

function slot0.getDurationTimeStr(slot0)
	return StoreController.instance:getRecommendStoreTime(slot0:getLinkageActivityCO())
end

function slot0.jump(slot0)
	GameFacade.jumpByAdditionParam(slot0:getLinkageActivityCO().systemJumpCode or "10173")
end

function slot0.getLinkageActivityCO_item(slot0, slot1)
	return slot0:getLinkageActivityCO()["item" .. slot1]
end

function slot0.getLinkageActivityCO_res_video(slot0, slot1)
	return slot0:getLinkageActivityCO()["res_video" .. slot1]
end

function slot0.getLinkageActivityCO_desc(slot0, slot1)
	return slot0:getLinkageActivityCO()["desc" .. slot1]
end

function slot0.getItemIconResUrl(slot0, slot1)
	slot3 = slot0:_assetGetViewContainer()

	return slot3:getItemIconResUrl(slot3:itemCo2TIQ(slot0:getLinkageActivityCO_item(slot1)))
end

function slot0.getItemConfig(slot0, slot1)
	slot3 = slot0:_assetGetViewContainer()

	return slot3:getItemConfig(slot3:itemCo2TIQ(slot0:getLinkageActivityCO_item(slot1)))
end

function slot0.itemCo2TIQ(slot0, slot1)
	return slot0:_assetGetViewContainer():itemCo2TIQ(slot0:getLinkageActivityCO_item(slot1))
end

function slot0.onPostSelectedPage(slot0, slot1, slot2)
end

return slot0
