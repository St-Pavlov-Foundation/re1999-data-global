module("modules.logic.voyage.view.ActivityGiftForTheVoyageItemBase", package.seeall)

slot0 = class("ActivityGiftForTheVoyageItemBase", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
	slot0:addEvents()
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:onRefresh()
end

function slot0._refreshRewardList(slot0, slot1)
	IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onRewardItemShow, ItemModel.instance:getItemDataListByConfigStr(VoyageConfig.instance:getRewardStr(slot0._mo.id)), slot1)
end

function slot0._onRewardItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
	slot1:showStackableNum2()
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onRefresh(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:removeEvents()
end

return slot0
