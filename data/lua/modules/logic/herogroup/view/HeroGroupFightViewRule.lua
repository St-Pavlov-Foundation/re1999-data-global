module("modules.logic.herogroup.view.HeroGroupFightViewRule", package.seeall)

slot0 = class("HeroGroupFightViewRule", BaseView)

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
	slot0._goruledesc = gohelper.findChild(slot0.viewGO, "#go_container2/#go_ruledesc")

	gohelper.setActive(slot0._goruledesc, false)

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
	gohelper.setActive(slot0._goruletemp, false)

	slot0._rulesimageList = slot0:getUserDataTb_()
	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._simageList = slot0:getUserDataTb_()
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

		slot0._txtBalanceRoleLv.text = HeroConfig.instance:getCommonLevelDisplay(slot3)
		slot0._txtBalanceEquipLv.text = luaLang("level") .. slot5
		slot0._txtBalanceTalent.text = luaLang("level") .. slot4
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
		slot9 = uv0.meilanniExcludeRules(FightStrUtil.instance:getSplitString2Cache(lua_battle.configDict[slot0._battleId] and slot7.additionRule or "", true, "|", "#"))
	end

	if not slot9 or #slot9 == 0 then
		gohelper.setActive(slot0._goadditionRule, false)

		return
	end

	slot0._cloneRuleGos = slot0._cloneRuleGos or slot0:getUserDataTb_()

	slot0:_clearRules()

	slot0._ruleList = slot9

	gohelper.setActive(slot0._goadditionRule, true)

	for slot13, slot14 in ipairs(slot9) do
		if lua_rule.configDict[slot14[2]] then
			slot0:_addRuleItem(slot17, slot14[1])
		end

		if slot13 == #slot9 then
			gohelper.setActive(slot0._rulesimagelineList[slot13], false)
		end
	end
end

function slot0._addRuleItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	gohelper.setActive(slot3, true)
	table.insert(slot0._cloneRuleGos, slot3)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot3, "#image_tagicon"), "wz_" .. slot2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot3, ""), slot1.icon)
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
