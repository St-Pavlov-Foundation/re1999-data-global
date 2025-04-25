module("modules.logic.herogroup.view.HeroGroupFightRuleDescView", package.seeall)

slot0 = class("HeroGroupFightRuleDescView", BaseView)

function slot0.onInitView(slot0)
	slot0._btncloserule = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closerule")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "bg")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "bg/#go_ruleitem")
	slot0._goruleDescList = gohelper.findChild(slot0.viewGO, "bg/#go_ruleDescList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloserule:AddClickListener(slot0._btncloseruleOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloserule:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._cloneRuleGos = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goruleitem, false)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0._btncloseruleOnClick(slot0)
	slot0:closeThis()

	if slot0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
	end
end

function slot0._refreshUI(slot0)
	slot1 = slot0.viewParam.ruleList

	if slot0.viewParam.offSet then
		recthelper.setAnchor(slot0._gobg.transform, slot0.viewParam.offSet[1], slot0.viewParam.offSet[2])
	end

	if slot0.viewParam.pivot then
		slot0._gobg.transform.pivot = slot0.viewParam.pivot
	end

	for slot5, slot6 in ipairs(slot1) do
		if lua_rule.configDict[slot6[2]] then
			slot0:_setRuleDescItem(slot9, slot6[1])
		end

		if slot5 == #slot1 then
			gohelper.setActive(slot0._rulesimagelineList[slot5], false)
		end
	end
end

function slot0._setRuleDescItem(slot0, slot1, slot2)
	slot4 = gohelper.clone(slot0._goruleitem, slot0._goruleDescList, slot1.id)

	gohelper.setActive(slot4, true)
	table.insert(slot0._cloneRuleGos, slot4)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot4, "icon"), slot1.icon)
	table.insert(slot0._rulesimagelineList, gohelper.findChild(slot4, "line"))
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot4, "tag"), "wz_" .. slot2)

	slot8 = gohelper.findChildText(slot4, "desc")

	SkillHelper.addHyperLinkClick(slot8)

	slot8.text = formatLuaLang("fight_rule_desc", ({
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	})[slot2], luaLang("dungeon_add_rule_target_" .. slot2), SkillHelper.buildDesc(slot1.desc, nil, "#6680bd"))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
