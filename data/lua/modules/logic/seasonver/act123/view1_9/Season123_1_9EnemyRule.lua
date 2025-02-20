module("modules.logic.seasonver.act123.view1_9.Season123_1_9EnemyRule", package.seeall)

slot0 = class("Season123_1_9EnemyRule", BaseView)

function slot0.onInitView(slot0)
	slot0._goadditionRule = gohelper.findChild(slot0.viewGO, "go_rule/#go_additionRule")
	slot0._goruletemp = gohelper.findChild(slot0.viewGO, "go_rule/#go_additionRule/#go_ruletemp")
	slot0._imagetagicon = gohelper.findChildImage(slot0.viewGO, "go_rule/#go_additionRule/#go_ruletemp/#image_tagicon")
	slot0._gorulelist = gohelper.findChild(slot0.viewGO, "go_rule/#go_additionRule/#go_rulelist")
	slot0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_rule/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	slot0._goruledesc = gohelper.findChild(slot0.viewGO, "go_rule/#go_ruledesc")
	slot0._btncloserule = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_rule/#go_ruledesc/#btn_closerule")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "go_rule/#go_ruledesc/bg/#go_ruleitem")
	slot0._goruleDescList = gohelper.findChild(slot0.viewGO, "go_rule/#go_ruledesc/bg/#go_ruleDescList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnadditionRuleclick:AddClickListener(slot0._btnadditionRuleOnClick, slot0)
	slot0._btncloserule:AddClickListener(slot0._btncloseruleOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnadditionRuleclick:RemoveClickListener()
	slot0._btncloserule:RemoveClickListener()
end

function slot0._btncloseruleOnClick(slot0)
	if slot0._ruleItemClick then
		slot0._ruleItemClick = false

		return
	end

	gohelper.setActive(slot0._goruledesc, false)
end

function slot0._btnadditionRuleOnClick(slot0)
	slot0._ruleItemClick = slot0._goruledesc.activeSelf

	gohelper.setActive(slot0._goruledesc, true)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goruleitem, false)
	gohelper.setActive(slot0._goruletemp, false)
	gohelper.setActive(slot0._goruledesc, false)

	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._childGoList = slot0:getUserDataTb_()

	gohelper.addUIClickAudio(slot0._btnadditionRuleclick.gameObject, AudioEnum.UI.play_ui_hero_sign)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if string.nilorempty(DungeonConfig.instance:getBattleAdditionRule(Season123EnemyModel.instance:getSelectBattleId())) then
		gohelper.setActive(slot0._goadditionRule, false)

		return
	end

	slot0:_clear()
	gohelper.setActive(slot0._goadditionRule, true)

	slot7 = "|"
	slot8 = "#"

	for slot7, slot8 in ipairs(GameUtil.splitString2(slot2, true, slot7, slot8)) do
		slot9 = slot8[1]

		if lua_rule.configDict[slot8[2]] then
			slot0:_addRuleItem(slot11, slot9)
			slot0:_setRuleDescItem(slot11, slot9)
		end

		if slot7 == #slot3 then
			gohelper.setActive(slot0._rulesimagelineList[slot7], false)
		end
	end
end

function slot0._addRuleItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	gohelper.setActive(slot3, true)
	table.insert(slot0._childGoList, slot3)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot3, "#image_tagicon"), "wz_" .. slot2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot3, ""), slot1.icon)
end

function slot0._setRuleDescItem(slot0, slot1, slot2)
	slot3 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	slot4 = gohelper.clone(slot0._goruleitem, slot0._goruleDescList, slot1.id)

	table.insert(slot0._childGoList, slot4)
	gohelper.setActive(slot4, true)
	table.insert(slot0._rulesimagelineList, gohelper.findChild(slot4, "line"))
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot4, "icon"), slot1.icon)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot4, "tag"), "wz_" .. slot2)

	gohelper.findChildText(slot4, "desc").text = string.format("<color=%s>[%s]</color>%s%s", slot3[slot2], luaLang("dungeon_add_rule_target_" .. slot2), string.gsub(slot1.desc, "%【(.-)%】", "<color=#6680bd>[%1]</color>"), "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(slot1.desc, slot3[1]))
end

function slot0._clear(slot0)
	for slot4, slot5 in ipairs(slot0._childGoList) do
		gohelper.destroy(slot5)
	end

	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._childGoList = slot0:getUserDataTb_()
end

function slot0.onDestroyView(slot0)
	slot0:_clear()
end

return slot0
