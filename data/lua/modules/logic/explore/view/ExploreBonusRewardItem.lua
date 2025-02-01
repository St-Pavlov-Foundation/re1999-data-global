module("modules.logic.explore.view.ExploreBonusRewardItem", package.seeall)

slot0 = class("ExploreBonusRewardItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._num = gohelper.findChildText(slot1, "label/#txt_num")
	slot0._lightIcon = gohelper.findChild(slot1, "label/icon_light")
	slot0._normalIcon = gohelper.findChild(slot1, "label/icon_normal")
	slot0._rewardItem = gohelper.findChild(slot1, "go_rewarditem")
	slot0._itemParent = gohelper.findChild(slot1, "label/icons")
	slot0._goline = gohelper.findChild(slot1, "label/line1")
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._num.text = string.format("%02d", slot0._index)
	slot0._isGet = ExploreSimpleModel.instance:getBonusIsGet(lua_explore_scene.configDict[slot1.chapterId][slot1.episodeId].id, slot1.id)

	ZProj.UGUIHelper.SetColorAlpha(slot0._num, slot0._isGet and 0.3 or 1)
	gohelper.setActive(slot0._lightIcon, slot0._isGet)
	gohelper.setActive(slot0._normalIcon, not slot0._isGet)

	slot0._items = slot0._items or {}

	gohelper.CreateObjList(slot0, slot0._setRewardItem, GameUtil.splitString2(slot1.bonus, true), slot0._itemParent, slot0._rewardItem)
	gohelper.setActive(slot0._goline, #ExploreTaskModel.instance:getTaskList(0):getList() ~= slot0._index)
end

function slot0._setRewardItem(slot0, slot1, slot2, slot3)
	slot0._items[slot3] = slot0._items[slot3] or {}
	slot6 = slot0._items[slot3].item or IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot1, "go_icon"))
	slot0._items[slot3].item = slot6

	slot6:setMOValue(slot2[1], slot2[2], slot2[3], nil, true)
	slot6:setCountFontSize(46)
	slot6:SetCountBgHeight(31)
	gohelper.setActive(gohelper.findChild(slot1, "go_receive"), slot0._isGet)
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, #slot0._items do
		slot0._items[slot4].item:onDestroy()
	end
end

return slot0
