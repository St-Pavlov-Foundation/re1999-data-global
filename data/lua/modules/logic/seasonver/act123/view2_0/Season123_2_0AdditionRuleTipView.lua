module("modules.logic.seasonver.act123.view2_0.Season123_2_0AdditionRuleTipView", package.seeall)

slot0 = class("Season123_2_0AdditionRuleTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._goitem = gohelper.findChild(slot0.viewGO, "content/layout/#go_ruleitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._itemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot4 = {}

	for slot8, slot9 in pairs(Season123Config.instance:getRuleTips(slot0.viewParam.actId, slot0.viewParam.stage)) do
		table.insert(slot4, slot8)
	end

	slot8 = #slot4

	for slot8 = 1, math.max(slot8, #slot0._itemList) do
		slot0:updateItem(slot0:getOrCreateItem(slot8), slot4[slot8])
	end

	NavigateMgr.instance:addEscape(slot0.viewName, slot0.closeThis, slot0)
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0._itemList[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goitem, "item" .. tostring(slot1))
		slot2.icon = gohelper.findChildImage(slot2.go, "mask/icon")
		slot2.txtTag = gohelper.findChildTextMesh(slot2.go, "mask/scroll_tag/Viewport/Content/tag")
		slot0._itemList[slot1] = slot2
	end

	return slot2
end

function slot0.updateItem(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	slot3 = lua_rule.configDict[slot2]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot1.icon, slot3.icon)

	slot1.txtTag.text = slot3.desc
end

function slot0.onClose(slot0)
end

return slot0
