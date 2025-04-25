module("modules.logic.weekwalk.view.WeekWalkEnemyInfoViewRule", package.seeall)

slot0 = class("WeekWalkEnemyInfoViewRule", BaseView)

function slot0.onInitView(slot0)
	slot0._goadditionRule = gohelper.findChild(slot0.viewGO, "go_rule/#go_additionRule")
	slot0._goruletemp = gohelper.findChild(slot0.viewGO, "go_rule/#go_additionRule/#go_ruletemp")
	slot0._imagetagicon = gohelper.findChildImage(slot0.viewGO, "go_rule/#go_additionRule/#go_ruletemp/#image_tagicon")
	slot0._gorulelist = gohelper.findChild(slot0.viewGO, "go_rule/#go_additionRule/#go_rulelist")
	slot0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_rule/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	slot0._goruledesc = gohelper.findChild(slot0.viewGO, "go_rule/#go_ruledesc")

	gohelper.setActive(slot0._goruledesc, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnadditionRuleclick:AddClickListener(slot0._btnadditionRuleOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnadditionRuleclick:RemoveClickListener()
end

function slot0._btncloseruleOnClick(slot0)
	if slot0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
	end
end

function slot0._btnadditionRuleOnClick(slot0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = slot0._ruleList,
		closeCb = slot0._btncloseruleOnClick,
		closeCbObj = slot0
	})

	if slot0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goruleitem, false)
	gohelper.setActive(slot0._goruletemp, false)

	slot0._rulesimageList = slot0:getUserDataTb_()
	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._simageList = slot0:getUserDataTb_()
	slot0._childGoList = slot0:getUserDataTb_()

	gohelper.addUIClickAudio(slot0._btnadditionRuleclick.gameObject, AudioEnum.UI.play_ui_hero_sign)
end

function slot0._addRuleItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	table.insert(slot0._childGoList, slot3)
	gohelper.setActive(slot3, true)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot3, "#image_tagicon"), "wz_" .. slot2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot3, ""), slot1.icon)
end

function slot0.refreshUI(slot0, slot1)
	if string.nilorempty(DungeonConfig.instance:getBattleAdditionRule(slot1)) then
		gohelper.setActive(slot0._goadditionRule, false)

		return
	end

	slot0:_clear()
	gohelper.setActive(slot0._goadditionRule, true)

	slot7 = "#"
	slot3 = GameUtil.splitString2(slot2, true, "|", slot7)
	slot0._ruleList = slot3

	for slot7, slot8 in ipairs(slot3) do
		if lua_rule.configDict[slot8[2]] then
			slot0:_addRuleItem(slot11, slot8[1])
		end

		if slot7 == #slot3 then
			gohelper.setActive(slot0._rulesimagelineList[slot7], false)
		end
	end
end

function slot0._clear(slot0)
	for slot4, slot5 in ipairs(slot0._childGoList) do
		gohelper.destroy(slot5)
	end

	slot0._rulesimageList = slot0:getUserDataTb_()
	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._simageList = slot0:getUserDataTb_()
	slot0._childGoList = slot0:getUserDataTb_()
end

function slot0.onDestroyView(slot0)
	slot0:_clear()
end

return slot0
