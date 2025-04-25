module("modules.logic.rouge.view.RougeHeroGroupFightViewRule", package.seeall)

slot0 = class("RougeHeroGroupFightViewRule", BaseView)

function slot0.onInitView(slot0)
	slot0._goadditionRule = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	slot0._goruletemp = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	slot0._imagetagicon = gohelper.findChildImage(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	slot0._gorulelist = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	slot0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	slot0._gobalance = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_balance")
	slot0._txtBalanceRoleLv = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/roleLvTxtbg/roleLvTxt/#txt_roleLv")
	slot0._txtBalanceEquipLv = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/equipLvTxtbg/equipLvTxt/#txt_equipLv")
	slot0._txtBalanceTalent = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/talentTxtbg/talentTxt/#txt_talent")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnadditionRuleclick:AddClickListener(slot0._btnadditionRuleOnClick, slot0)
	slot0:addEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnadditionRuleclick:RemoveClickListener()
	slot0:removeEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._refreshUI, slot0)
end

function slot0._btncloseruleOnClick(slot0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
end

function slot0._btnadditionRuleOnClick(slot0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = slot0._ruleList,
		closeCb = slot0._btncloseruleOnClick,
		closeCbObj = slot0
	})
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goruleitem, false)
	gohelper.setActive(slot0._goruletemp, false)
	gohelper.setActive(slot0._goruledesc, false)

	slot0._rulesimageList = slot0:getUserDataTb_()
	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._simageList = slot0:getUserDataTb_()
end

slot1 = "#E6E6E6"
slot2 = "#C86A6A"

function slot0._addRuleItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	gohelper.setActive(slot4, true)
	table.insert(slot0._cloneRuleGos, slot4)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot4, "#image_tagicon"), "wz_" .. slot2)

	slot6 = gohelper.findChildImage(slot4, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot6, slot1.icon)
	SLFramework.UGUI.GuiHelper.SetColor(slot6, slot3 and uv0 or uv1)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0._episodeId = HeroGroupModel.instance.episodeId
	slot0._battleId = HeroGroupModel.instance.battleId
	slot2 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot0._episodeId).chapterId)
	slot3, slot4, slot5 = HeroGroupBalanceHelper.getBalanceLv()

	if slot3 then
		gohelper.setActive(slot0._gobalance, true)
	else
		gohelper.setActive(slot0._gobalance, false)
	end

	slot0._isHardMode = slot2.type == DungeonEnum.ChapterType.Hard
	slot6 = slot2.type == DungeonEnum.ChapterType.WeekWalk

	if slot2.type == DungeonEnum.ChapterType.Normal then
		gohelper.setActive(slot0._goadditionRule, false)

		return
	end

	if slot1.type == DungeonEnum.EpisodeType.Meilanni then
		slot9 = uv0.meilanniExcludeRules(GameUtil.splitString2(lua_battle.configDict[slot0._battleId] and slot7.additionRule or "", true, "|", "#"))
	end

	slot10 = slot9 and #slot9 or 0

	if not slot0:_addRougeSurpriseAdditionRules(slot9) or #slot9 == 0 then
		gohelper.setActive(slot0._goadditionRule, false)

		return
	end

	slot0._cloneRuleGos = slot0._cloneRuleGos or slot0:getUserDataTb_()

	slot0:_clearRules()
	gohelper.setActive(slot0._goadditionRule, true)

	slot0._ruleList = slot9

	for slot14, slot15 in ipairs(slot9) do
		if lua_rule.configDict[slot15[2]] then
			slot0:_addRuleItem(slot18, slot15[1], slot10 < slot14)
		end

		if slot14 == #slot9 then
			gohelper.setActive(slot0._rulesimagelineList[slot14], false)
		end
	end
end

function slot0._addRougeSurpriseAdditionRules(slot0, slot1)
	slot1 = slot1 or {}
	slot3 = RougeMapModel.instance:getCurNode() and slot2.eventMo

	if slot3 and slot3:getSurpriseAttackList() then
		for slot8, slot9 in ipairs(slot4) do
			if lua_rouge_surprise_attack.configDict[slot9] and not string.nilorempty(slot10.additionRule) then
				tabletool.addValues(slot1, GameUtil.splitString2(slot10.additionRule, true, "|", "#"))
			end
		end
	end

	return slot1
end

function slot0._clearRules(slot0)
	for slot4 = #slot0._cloneRuleGos, 1, -1 do
		gohelper.destroy(slot0._cloneRuleGos[slot4])

		slot0._cloneRuleGos[slot4] = nil
	end
end

function slot0.meilanniExcludeRules(slot0)
	if not slot0 or #slot0 == 0 then
		return
	end

	slot2 = MeilanniModel.instance:getCurMapId() and MeilanniModel.instance:getMapInfo(slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0) do
		if slot2 and not slot2:isExcludeRule(slot8[2]) then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.onDestroyView(slot0)
end

return slot0
