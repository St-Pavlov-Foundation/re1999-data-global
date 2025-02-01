module("modules.logic.dungeon.view.DungeonRewardTipView", package.seeall)

slot0 = class("DungeonRewardTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "scrollTips/Viewport/Content/#txt_info")
	slot0._gorewardContentItem = gohelper.findChild(slot0.viewGO, "scrollTips/Viewport/Content/#go_rewardContentItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorewardContentItem, false)

	slot1 = lua_helppage.configDict[10801]
	slot0._txttitle.text = slot1.title
	slot0._txtinfo.text = slot1.text

	if not GameUtil.splitString2(slot1.iconText) or #slot3 == 0 then
		return
	end

	for slot7, slot8 in ipairs(slot3) do
		slot0:_addReward(slot8[1], tonumber(slot8[2]))
	end
end

function slot0._addReward(slot0, slot1, slot2)
	slot3 = gohelper.cloneInPlace(slot0._gorewardContentItem)

	gohelper.setActive(slot3, true)

	gohelper.findChildText(slot3, "opentitle").text = slot1
	slot6 = gohelper.findChild(slot3, "scroll_reward/Viewport/Content")

	for slot11, slot12 in ipairs(DungeonModel.instance:getEpisodeRewardDisplayList(slot2)) do
		slot13 = gohelper.cloneInPlace(gohelper.findChild(slot3, "scroll_reward/Viewport/Content/commonitemicon"))

		gohelper.setActive(slot13, true)

		slot14 = IconMgr.instance:getCommonPropItemIcon(slot13)

		slot14:setMOValue(slot12[1], slot12[2], slot12[3])
		slot14:hideEquipLvAndBreak(true)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
