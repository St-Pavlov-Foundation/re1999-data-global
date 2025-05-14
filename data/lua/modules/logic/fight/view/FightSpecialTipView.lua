module("modules.logic.fight.view.FightSpecialTipView", package.seeall)

local var_0_0 = class("FightSpecialTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_bg")
	arg_1_0._goBossRushLayer4 = gohelper.findChild(arg_1_0.viewGO, "content/#simage_bg/#go_BossRushLayer4")
	arg_1_0._gospecialTip = gohelper.findChild(arg_1_0.viewGO, "content/#go_specialTip")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "content/#go_specialTip/#txt_desc")
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "content/layout")
	arg_1_0._goadditionTip = gohelper.findChild(arg_1_0.viewGO, "content/layout/#go_additionTip/Viewport/#go_layoutContent/#go_Content")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "content/layout/#go_additionTip/Viewport/#go_layoutContent/#go_Content/#go_ruleitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goadditionTip2 = gohelper.findChild(arg_1_0.viewGO, "content/layout/#go_additionTip")
	arg_1_0.additionTipLayout = arg_1_0._goadditionTip2:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	arg_1_0.additionTipLayoutElement = arg_1_0._goadditionTip2:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	arg_1_0.goViewPort = gohelper.findChild(arg_1_0.viewGO, "content/layout/#go_additionTip/Viewport")
	arg_1_0.viewPortLayout = arg_1_0.goViewPort:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	arg_1_0.viewPortTrans = arg_1_0.goViewPort:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.goLayoutContent = gohelper.findChild(arg_1_0.viewGO, "content/layout/#go_additionTip/Viewport/#go_layoutContent")
	arg_1_0.layoutContentTrans = arg_1_0.goLayoutContent:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.layoutContentSizeFilter = arg_1_0.goLayoutContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnPlayVideo, arg_2_0._onPlayVideo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnPlayVideo, arg_3_0._onPlayVideo, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goruleitem, false)

	arg_4_0._additionTips = arg_4_0:getUserDataTb_()
	arg_4_0._ruleItems = arg_4_0:getUserDataTb_()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0._anim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(arg_5_0._closeView, arg_5_0, 0.133)
end

function var_0_0._onOpenView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.GuideView or arg_6_1 == ViewName.StoryView then
		arg_6_0:closeThis()
	end
end

function var_0_0._onPlayVideo(arg_7_0, arg_7_1)
	arg_7_0:closeThis()
end

function var_0_0._closeView(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_jump)
	arg_9_0._simagebg:LoadImage(ResUrl.getFightSpecialTipIcon("img_tishi_bg.png"))

	local var_9_0 = FightModel.instance:getFightParam()
	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0.episodeId)
	local var_9_2

	if var_9_1 and not string.nilorempty(var_9_1.battleDesc) then
		var_9_2 = FightEnum.FightSpecialTipsType.Special
		arg_9_0._txtdesc.text = var_9_1.battleDesc
	end

	local var_9_3 = var_9_1 and var_9_1.type
	local var_9_4 = lua_battle.configDict[var_9_0.battleId]

	if var_9_3 == DungeonEnum.EpisodeType.Rouge then
		local var_9_5 = RougeMapModel.instance:getCurNode()
		local var_9_6 = var_9_5 and var_9_5.eventMo
		local var_9_7 = var_9_6 and var_9_6:getSurpriseAttackList()
		local var_9_8 = var_9_4.additionRule
		local var_9_9

		if not string.nilorempty(var_9_4.additionRule) then
			var_9_9 = GameUtil.splitString2(var_9_8, true, "|", "#")
		end

		if var_9_7 then
			var_9_9 = var_9_9 or {}

			for iter_9_0, iter_9_1 in ipairs(var_9_7) do
				local var_9_10 = lua_rouge_surprise_attack.configDict[iter_9_1].additionRule

				if not string.nilorempty(var_9_10) then
					table.insert(var_9_9, string.splitToNumber(var_9_10, "#"))
				end
			end
		end

		if var_9_9 and #var_9_9 > 0 then
			if #var_9_9 > 2 and #var_9_9 % 2 == 1 then
				table.insert(var_9_9, {})
			end

			gohelper.CreateObjList(arg_9_0, arg_9_0._onRuleItemShow, var_9_9, arg_9_0._goadditionTip, arg_9_0._goruleitem)
		end

		var_9_2 = FightEnum.FightSpecialTipsType.Addition

		gohelper.setActive(arg_9_0._gospecialTip, var_9_2 == FightEnum.FightSpecialTipsType.Special)
		gohelper.setActive(arg_9_0._golayout, var_9_2 == FightEnum.FightSpecialTipsType.Addition)

		return
	end

	local var_9_11

	if var_9_4 and not string.nilorempty(var_9_4.additionRule) then
		var_9_2 = FightEnum.FightSpecialTipsType.Addition

		local var_9_12 = var_9_4.additionRule

		var_9_11 = GameUtil.splitString2(var_9_12, true, "|", "#")

		local var_9_13 = var_9_1 and var_9_1.type

		if Activity104Model.instance:isSeasonEpisodeType(var_9_13) then
			var_9_11 = SeasonConfig.instance:filterRule(var_9_11)
		elseif Season123Controller.isSeason123EpisodeType(var_9_13) then
			local var_9_14 = Season123Model.instance:getBattleContext()

			if var_9_14 then
				var_9_11 = Season123HeroGroupModel.filterRule(var_9_14.actId, var_9_11)

				if var_9_14.stage then
					var_9_11 = Season123Config.instance:filterRule(var_9_11, var_9_14.stage)
				end
			end
		end
	end

	local var_9_15 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183]

	if var_9_15 then
		local var_9_16 = cjson.decode(var_9_15)

		if var_9_16.currRules then
			var_9_11 = var_9_11 or {}

			for iter_9_2, iter_9_3 in ipairs(var_9_16.currRules) do
				local var_9_17 = GameUtil.splitString2(iter_9_3, true, "|", "#")

				tabletool.addValues(var_9_11, var_9_17)
			end
		end

		if var_9_16.transferRules then
			var_9_11 = var_9_11 or {}

			for iter_9_4, iter_9_5 in ipairs(var_9_16.transferRules) do
				local var_9_18 = GameUtil.splitString2(iter_9_5, true, "|", "#")

				tabletool.addValues(var_9_11, var_9_18)
			end
		end
	end

	if var_9_11 and #var_9_11 > 0 then
		var_9_2 = FightEnum.FightSpecialTipsType.Addition

		if var_9_3 == DungeonEnum.EpisodeType.Meilanni then
			var_9_11 = HeroGroupFightViewRule.meilanniExcludeRules(var_9_11)
		end

		if #var_9_11 > 2 and #var_9_11 % 2 == 1 then
			table.insert(var_9_11, {})
		end

		gohelper.CreateObjList(arg_9_0, arg_9_0._onRuleItemShow, var_9_11, arg_9_0._goadditionTip, arg_9_0._goruleitem)
	end

	gohelper.setActive(arg_9_0._gospecialTip, var_9_2 == FightEnum.FightSpecialTipsType.Special)
	gohelper.setActive(arg_9_0._golayout, var_9_2 == FightEnum.FightSpecialTipsType.Addition)

	local var_9_19 = BossRushModel.instance:isSpecialLayerCurBattle()

	gohelper.setActive(arg_9_0._goBossRushLayer4, var_9_19)
	arg_9_0:setTipLayout(var_9_11)
end

function var_0_0.setTipLayout(arg_10_0, arg_10_1)
	local var_10_0 = 720

	if arg_10_1 and #arg_10_1 > 6 then
		arg_10_0.additionTipLayout.enabled = false
		arg_10_0.additionTipLayoutElement.enabled = true
		arg_10_0.viewPortLayout.enabled = false
		arg_10_0.layoutContentSizeFilter.enabled = true

		recthelper.setHeight(arg_10_0.viewPortTrans, var_10_0)

		local var_10_1 = Vector2(0, 1)

		arg_10_0.viewPortTrans.pivot = var_10_1
		arg_10_0.viewPortTrans.anchorMin = var_10_1
		arg_10_0.viewPortTrans.anchorMax = var_10_1
		arg_10_0.layoutContentTrans.pivot = var_10_1
		arg_10_0.layoutContentTrans.anchorMin = var_10_1
		arg_10_0.layoutContentTrans.anchorMax = var_10_1

		recthelper.setAnchorY(arg_10_0.viewPortTrans, 0)
		recthelper.setAnchorY(arg_10_0.layoutContentTrans, 0)
	end
end

function var_0_0._onRuleItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {
		"#5283ca",
		"#de4d4d",
		"#dd9446",
		"#ff0000"
	}

	gohelper.setActive(arg_11_1, true)

	local var_11_1 = arg_11_1.transform
	local var_11_2 = var_11_1:Find("scroll_tag")
	local var_11_3 = var_11_1:Find("scroll_tag/Viewport/Content/tag"):GetComponent(gohelper.Type_TextMesh)
	local var_11_4 = var_11_1:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_11_5 = string.nilorempty(arg_11_2[2])

	gohelper.setActive(var_11_2.gameObject, not var_11_5)
	gohelper.setActive(var_11_4.gameObject, not var_11_5)

	if var_11_5 then
		return
	end

	local var_11_6 = lua_rule.configDict[arg_11_2[2]]
	local var_11_7 = arg_11_2[1]

	SkillHelper.addHyperLinkClick(var_11_3)

	local var_11_8 = var_11_6.desc
	local var_11_9 = SkillHelper.buildDesc(var_11_8, nil, "#5283ca")
	local var_11_10 = luaLang("dungeon_add_rule_target_" .. var_11_7)
	local var_11_11 = var_11_0[var_11_7]

	var_11_3.text = SkillConfig.instance:fmtTagDescColor(var_11_10, var_11_9, var_11_11)

	var_11_3:ForceMeshUpdate(true, true)

	local var_11_12 = var_11_3:GetRenderedValues()

	recthelper.setHeight(var_11_3.transform, var_11_12.y)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_11_4, var_11_6.icon)
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._closeView, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagebg:UnLoadImage()
end

return var_0_0
