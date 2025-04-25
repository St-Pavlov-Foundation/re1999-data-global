module("modules.logic.fight.view.FightSpecialTipView", package.seeall)

slot0 = class("FightSpecialTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_bg")
	slot0._goBossRushLayer4 = gohelper.findChild(slot0.viewGO, "content/#simage_bg/#go_BossRushLayer4")
	slot0._gospecialTip = gohelper.findChild(slot0.viewGO, "content/#go_specialTip")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "content/#go_specialTip/#txt_desc")
	slot0._golayout = gohelper.findChild(slot0.viewGO, "content/layout")
	slot0._goadditionTip = gohelper.findChild(slot0.viewGO, "content/layout/#go_additionTip/Viewport/#go_layoutContent/#go_Content")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "content/layout/#go_additionTip/Viewport/#go_layoutContent/#go_Content/#go_ruleitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goadditionTip2 = gohelper.findChild(slot0.viewGO, "content/layout/#go_additionTip")
	slot0.additionTipLayout = slot0._goadditionTip2:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	slot0.additionTipLayoutElement = slot0._goadditionTip2:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	slot0.goViewPort = gohelper.findChild(slot0.viewGO, "content/layout/#go_additionTip/Viewport")
	slot0.viewPortLayout = slot0.goViewPort:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	slot0.viewPortTrans = slot0.goViewPort:GetComponent(gohelper.Type_RectTransform)
	slot0.goLayoutContent = gohelper.findChild(slot0.viewGO, "content/layout/#go_additionTip/Viewport/#go_layoutContent")
	slot0.layoutContentTrans = slot0.goLayoutContent:GetComponent(gohelper.Type_RectTransform)
	slot0.layoutContentSizeFilter = slot0.goLayoutContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayVideo, slot0._onPlayVideo, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnPlayVideo, slot0._onPlayVideo, slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goruleitem, false)

	slot0._additionTips = slot0:getUserDataTb_()
	slot0._ruleItems = slot0:getUserDataTb_()
end

function slot0._btncloseOnClick(slot0)
	slot0._anim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(slot0._closeView, slot0, 0.133)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.GuideView or slot1 == ViewName.StoryView then
		slot0:closeThis()
	end
end

function slot0._onPlayVideo(slot0, slot1)
	slot0:closeThis()
end

function slot0._closeView(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_jump)
	slot0._simagebg:LoadImage(ResUrl.getFightSpecialTipIcon("img_tishi_bg.png"))

	slot3 = nil

	if DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightParam().episodeId) and not string.nilorempty(slot2.battleDesc) then
		slot3 = FightEnum.FightSpecialTipsType.Special
		slot0._txtdesc.text = slot2.battleDesc
	end

	slot5 = lua_battle.configDict[slot1.battleId]

	if (slot2 and slot2.type) == DungeonEnum.EpisodeType.Rouge then
		slot7 = RougeMapModel.instance:getCurNode() and slot6.eventMo
		slot8 = slot7 and slot7:getSurpriseAttackList()
		slot10 = nil

		if not string.nilorempty(slot5.additionRule) then
			slot10 = GameUtil.splitString2(slot5.additionRule, true, "|", "#")
		end

		if slot8 then
			for slot14, slot15 in ipairs(slot8) do
				if not string.nilorempty(lua_rouge_surprise_attack.configDict[slot15].additionRule) then
					table.insert(slot10 or {}, string.splitToNumber(slot17, "#"))
				end
			end
		end

		if slot10 and #slot10 > 0 then
			if #slot10 > 2 and #slot10 % 2 == 1 then
				table.insert(slot10, {})
			end

			gohelper.CreateObjList(slot0, slot0._onRuleItemShow, slot10, slot0._goadditionTip, slot0._goruleitem)
		end

		gohelper.setActive(slot0._gospecialTip, FightEnum.FightSpecialTipsType.Addition == FightEnum.FightSpecialTipsType.Special)
		gohelper.setActive(slot0._golayout, slot3 == FightEnum.FightSpecialTipsType.Addition)

		return
	end

	slot6 = nil

	if slot5 and not string.nilorempty(slot5.additionRule) then
		slot3 = FightEnum.FightSpecialTipsType.Addition

		if Activity104Model.instance:isSeasonEpisodeType(slot2 and slot2.type) then
			slot6 = SeasonConfig.instance:filterRule(GameUtil.splitString2(slot5.additionRule, true, "|", "#"))
		elseif Season123Controller.isSeason123EpisodeType(slot8) and Season123Model.instance:getBattleContext() then
			if slot9.stage then
				slot6 = Season123Config.instance:filterRule(Season123HeroGroupModel.filterRule(slot9.actId, slot6), slot9.stage)
			end
		end
	end

	if FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183] then
		if cjson.decode(slot7).currRules then
			for slot12, slot13 in ipairs(slot8.currRules) do
				tabletool.addValues(slot6 or {}, GameUtil.splitString2(slot13, true, "|", "#"))
			end
		end

		if slot8.transferRules then
			for slot12, slot13 in ipairs(slot8.transferRules) do
				tabletool.addValues(slot6 or {}, GameUtil.splitString2(slot13, true, "|", "#"))
			end
		end
	end

	if slot6 and #slot6 > 0 then
		slot3 = FightEnum.FightSpecialTipsType.Addition

		if slot4 == DungeonEnum.EpisodeType.Meilanni then
			slot6 = HeroGroupFightViewRule.meilanniExcludeRules(slot6)
		end

		if #slot6 > 2 and #slot6 % 2 == 1 then
			table.insert(slot6, {})
		end

		gohelper.CreateObjList(slot0, slot0._onRuleItemShow, slot6, slot0._goadditionTip, slot0._goruleitem)
	end

	gohelper.setActive(slot0._gospecialTip, slot3 == FightEnum.FightSpecialTipsType.Special)
	gohelper.setActive(slot0._golayout, slot3 == FightEnum.FightSpecialTipsType.Addition)
	gohelper.setActive(slot0._goBossRushLayer4, BossRushModel.instance:isSpecialLayerCurBattle())
	slot0:setTipLayout(slot6)
end

function slot0.setTipLayout(slot0, slot1)
	if slot1 and #slot1 > 6 then
		slot0.additionTipLayout.enabled = false
		slot0.additionTipLayoutElement.enabled = true
		slot0.viewPortLayout.enabled = false
		slot0.layoutContentSizeFilter.enabled = true

		recthelper.setHeight(slot0.viewPortTrans, 720)

		slot3 = Vector2(0, 1)
		slot0.viewPortTrans.pivot = slot3
		slot0.viewPortTrans.anchorMin = slot3
		slot0.viewPortTrans.anchorMax = slot3
		slot0.layoutContentTrans.pivot = slot3
		slot0.layoutContentTrans.anchorMin = slot3
		slot0.layoutContentTrans.anchorMax = slot3

		recthelper.setAnchorY(slot0.viewPortTrans, 0)
		recthelper.setAnchorY(slot0.layoutContentTrans, 0)
	end
end

function slot0._onRuleItemShow(slot0, slot1, slot2, slot3)
	slot4 = {
		"#5283ca",
		"#de4d4d",
		"#dd9446",
		"#ff0000"
	}

	gohelper.setActive(slot1, true)

	slot5 = slot1.transform
	slot7 = slot5:Find("scroll_tag/Viewport/Content/tag"):GetComponent(gohelper.Type_TextMesh)
	slot9 = string.nilorempty(slot2[2])

	gohelper.setActive(slot5:Find("scroll_tag").gameObject, not slot9)
	gohelper.setActive(slot5:Find("icon"):GetComponent(gohelper.Type_Image).gameObject, not slot9)

	if slot9 then
		return
	end

	slot10 = lua_rule.configDict[slot2[2]]
	slot11 = slot2[1]

	SkillHelper.addHyperLinkClick(slot7)

	slot7.text = SkillConfig.instance:fmtTagDescColor(luaLang("dungeon_add_rule_target_" .. slot11), SkillHelper.buildDesc(slot10.desc, nil, "#5283ca"), slot4[slot11])

	slot7:ForceMeshUpdate(true, true)
	recthelper.setHeight(slot7.transform, slot7:GetRenderedValues().y)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot8, slot10.icon)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._closeView, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
