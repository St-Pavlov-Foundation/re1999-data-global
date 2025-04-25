module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossRuleView", package.seeall)

slot0 = class("VersionActivity1_6_BossRuleView", BaseView)

function slot0.onInitView(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "Left/Rule")
	slot0._goadditionRule = gohelper.findChild(slot1, "#scroll_ConditionIcons")
	slot0._goruletemp = gohelper.findChild(slot1, "#scroll_ConditionIcons/#go_ruletemp")
	slot0._imagetagicon = gohelper.findChildImage(slot0._goruletemp, "#image_tagicon")
	slot0._gorulelist = gohelper.findChild(slot0._goadditionRule, "Viewport/content")
	slot0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(slot0._goadditionRule, "#btn_additionRuleclick")
	slot0._goruledesc = gohelper.findChild(slot1, "Tips")
	slot0._goruleitem = gohelper.findChild(slot0._goruledesc, "image_TipsBG/#go_Item1")
	slot0._goExtraRuleitem = gohelper.findChild(slot0._goruledesc, "image_TipsBG/#go_Item2")
	slot0._goruleDescList = gohelper.findChild(slot0._goruledesc, "bg/#go_ruleDescList")
	slot0._nextBossTitle = gohelper.findChildText(slot0.viewGO, "Left/Rule/Tips/image_TipsBG/#go_Item2/#txt_Descr/#txt_Title")
	slot0._nextBossDay = gohelper.findChildText(slot0.viewGO, "Left/Rule/Tips/image_TipsBG/#go_Item2/#txt_Descr/#txt_Title/#txt_dayNum")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnadditionRuleclick:AddClickListener(slot0._btnRuleAreaOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnadditionRuleclick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goruleitem, false)
	gohelper.setActive(slot0._goExtraRuleitem, false)
	gohelper.setActive(slot0._goruletemp, false)
	gohelper.setActive(slot0._goruledesc, false)
	gohelper.addUIClickAudio(slot0._btnadditionRuleclick.gameObject, AudioEnum.UI.play_ui_hero_sign)

	slot0._normalRuleItemList = {}
	slot0._extraRuleItemList = {}
end

function slot0.refreshUI(slot0, slot1, slot2)
	gohelper.setActive(slot0._goruleitem, false)
	gohelper.setActive(slot0._goExtraRuleitem, false)
	slot0:addNormalRuleItem(slot1, slot2 and slot2 ~= 0)

	if slot2 and slot2 ~= 0 then
		slot0:AddExtraRuleItem(slot2)
	end
end

function slot0.addNormalRuleItem(slot0, slot1, slot2)
	if string.nilorempty(DungeonConfig.instance:getBattleAdditionRule(slot1)) then
		gohelper.setActive(slot0._goadditionRule, false)

		return
	end

	slot0:_clear()
	gohelper.setActive(slot0._goadditionRule, true)
	gohelper.setActive(slot0._goruleitem, true)

	slot8 = "#"
	slot4 = GameUtil.splitString2(slot3, true, "|", slot8)
	slot0._ruleList = slot4

	for slot8, slot9 in ipairs(slot4) do
		slot10 = slot9[1]

		if lua_rule.configDict[slot9[2]] then
			slot13 = slot0:_addRuleItem(slot9, false, slot2)
			slot13.battleId = slot1
			slot0._normalRuleItemList[#slot0._normalRuleItemList + 1] = slot13
		end
	end
end

function slot0.AddExtraRuleItem(slot0, slot1)
	slot3 = VersionActivity1_6DungeonBossModel.instance

	if not DungeonConfig.instance:getBattleAdditionRule(slot1) then
		return
	end

	slot8 = "#"

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot2, true, "|", slot8)) do
		slot10 = slot9[1]

		if lua_rule.configDict[slot9[2]] then
			slot13 = slot0:_addRuleItem(slot9, true)
			slot13.battleId = slot1
			slot0._extraRuleItemList[#slot0._extraRuleItemList + 1] = slot13

			table.insert(slot0._ruleList, slot9)

			slot0._nextBossTitle.text = string.format(luaLang("p_v1a6_activityboss_help_3_txt_3"), slot3:getCurBossEpisodeRemainDay())
			slot0._nextBossDay.text = ""
		end
	end
end

function slot0._addRuleItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.targetId = slot1[1]
	slot4.ruleId = slot1[2]
	slot4.ruleCfg = lua_rule.configDict[slot4.ruleId]
	slot5 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot4.ruleCfg.id)
	slot4.go = slot5

	gohelper.setActive(slot5, true)

	if gohelper.onceAddComponent(slot5, typeof(UnityEngine.CanvasGroup)) then
		slot6.alpha = slot2 and 0.5 or 1
	end

	slot7 = slot3 and 1.3 or 1

	transformhelper.setLocalScale(slot5.transform, slot7, slot7, 1)

	slot8 = gohelper.findChildImage(slot5, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(slot8, "wz_" .. slot4.targetId)

	slot9 = gohelper.findChildImage(slot5, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot9, slot4.ruleCfg.icon)

	slot8.maskable = true
	slot9.maskable = true

	return slot4
end

function slot0._btnRuleAreaOnClick(slot0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = slot0._ruleList
	})
end

function slot0._clear(slot0)
	for slot4, slot5 in ipairs(slot0._normalRuleItemList) do
		gohelper.destroy(slot5.go)
	end

	for slot4, slot5 in ipairs(slot0._extraRuleItemList) do
		gohelper.destroy(slot5.go)
	end

	slot0._normalRuleItemList = {}
	slot0._extraRuleItemList = {}
end

function slot0.onDestroyView(slot0)
	slot0:_clear()
end

return slot0
