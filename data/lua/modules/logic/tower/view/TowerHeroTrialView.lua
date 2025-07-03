module("modules.logic.tower.view.TowerHeroTrialView", package.seeall)

local var_0_0 = class("TowerHeroTrialView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseFullView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeFullView")
	arg_1_0._scrollhero = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_hero")
	arg_1_0._goheroContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_hero/Viewport/#go_heroContent")
	arg_1_0._goheroItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_hero/Viewport/#go_heroContent/#go_heroItem")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._godescContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/Viewport/#go_descContent")
	arg_1_0._godescItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem")
	arg_1_0._btnrule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "title/txt/#btn_rule")
	arg_1_0._goruleTip = gohelper.findChild(arg_1_0.viewGO, "#go_ruleTip")
	arg_1_0._btncloseRuleTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ruleTip/#btn_closeRuleTip")
	arg_1_0._txtrule = gohelper.findChildText(arg_1_0.viewGO, "#go_ruleTip/#txt_rule")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._imagefacetsIcon = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/facets/image_facetsIcon")
	arg_1_0._txtfacets = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/facets/txt_facets")
	arg_1_0._gofacetsDesc = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/go_facetsDesc")
	arg_1_0._gofacetsDescItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/go_facetsDesc/txt_facetsDesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseFullView:AddClickListener(arg_2_0._btncloseFullViewOnClick, arg_2_0)
	arg_2_0._btnrule:AddClickListener(arg_2_0._btnruleOnClick, arg_2_0)
	arg_2_0._btncloseRuleTip:AddClickListener(arg_2_0._btncloseRuleTipOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseFullView:RemoveClickListener()
	arg_3_0._btnrule:RemoveClickListener()
	arg_3_0._btncloseRuleTip:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseFullViewOnClick(arg_4_0)
	arg_4_0:_btncloseOnClick()
end

function var_0_0._btnruleOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._goruleTip, true)
end

function var_0_0._btncloseRuleTipOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._goruleTip, false)
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onHeroTrialItemClick(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.HeroItemList) do
		if iter_8_1.trialHeroId == arg_8_1.trialHeroId then
			gohelper.setActive(iter_8_1.goSelect, true)

			arg_8_0.curSelectHeroItem = iter_8_1

			arg_8_0:createOrRefreshDesc()
		else
			gohelper.setActive(iter_8_1.goSelect, false)
		end
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.HeroItemList = arg_9_0:getUserDataTb_()
	arg_9_0.descItemList = arg_9_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	gohelper.setActive(arg_10_0._goruleTip, false)
	gohelper.setActive(arg_10_0._goheroItem, false)
	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0.curSeason = TowerModel.instance:getTrialHeroSeason()
	arg_11_0._txtrule.text = TowerConfig.instance:getTowerConstLangConfig(TowerEnum.ConstId.HeroTrialRule)

	arg_11_0:createOrRefreshTrialHero()
	arg_11_0:createOrRefreshDesc()
end

function var_0_0.createOrRefreshTrialHero(arg_12_0)
	local var_12_0 = TowerConfig.instance:getHeroTrialConfig(arg_12_0.curSeason)
	local var_12_1 = string.splitToNumber(var_12_0.heroIds, "|")

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = arg_12_0.HeroItemList[iter_12_0]

		if not var_12_2 then
			var_12_2 = {
				go = gohelper.clone(arg_12_0._goheroItem, arg_12_0._goheroContent, iter_12_1)
			}
			var_12_2.rare = gohelper.findChildImage(var_12_2.go, "role/rare")
			var_12_2.heroIcon = gohelper.findChildSingleImage(var_12_2.go, "role/heroicon")
			var_12_2.career = gohelper.findChildImage(var_12_2.go, "role/career")
			var_12_2.name = gohelper.findChildText(var_12_2.go, "role/name")
			var_12_2.nameEn = gohelper.findChildText(var_12_2.go, "role/name/nameEn")
			var_12_2.goSelect = gohelper.findChild(var_12_2.go, "go_select")
			var_12_2.btnClick = gohelper.findChildButtonWithAudio(var_12_2.go, "btn_click")

			var_12_2.btnClick:AddClickListener(arg_12_0.onHeroTrialItemClick, arg_12_0, var_12_2)

			arg_12_0.HeroItemList[iter_12_0] = var_12_2
		end

		gohelper.setActive(var_12_2.go, true)

		var_12_2.trialHeroId = iter_12_1
		var_12_2.trialConfig = lua_hero_trial.configDict[iter_12_1][0]

		local var_12_3 = HeroConfig.instance:getHeroCO(var_12_2.trialConfig.heroId)
		local var_12_4 = SkinConfig.instance:getSkinCo(var_12_2.trialConfig.skin)

		var_12_2.heroIcon:LoadImage(ResUrl.getRoomHeadIcon(var_12_4.headIcon))

		var_12_2.name.text = var_12_3.name
		var_12_2.nameEn.text = var_12_3.nameEng

		UISpriteSetMgr.instance:setCommonSprite(var_12_2.career, "lssx_" .. var_12_3.career)
		UISpriteSetMgr.instance:setCommonSprite(var_12_2.rare, "bgequip" .. CharacterEnum.Color[var_12_3.rare])
	end

	for iter_12_2 = #var_12_1 + 1, #arg_12_0.HeroItemList do
		gohelper.setActive(arg_12_0.HeroItemList[iter_12_2].go, false)
	end

	if not arg_12_0.curSelectHeroItem then
		arg_12_0.curSelectHeroItem = arg_12_0.HeroItemList[1]

		gohelper.setActive(arg_12_0.curSelectHeroItem.goSelect, true)
	end
end

function var_0_0.createOrRefreshDesc(arg_13_0)
	local var_13_0 = arg_13_0.curSelectHeroItem.trialConfig.facetsId
	local var_13_1 = arg_13_0.curSelectHeroItem.trialConfig.facetslevel
	local var_13_2 = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(var_13_0)

	if not var_13_2 then
		logError(arg_13_0.curSelectHeroItem.trialConfig.id .. "角色命石消耗表中狂想配置不存在，请检查： " .. var_13_0)

		return
	end

	local var_13_3 = CharacterDestinyEnum.SlotTend[var_13_2.tend]
	local var_13_4 = var_13_3.TitleIconName

	UISpriteSetMgr.instance:setUiCharacterSprite(arg_13_0._imagefacetsIcon, var_13_4)

	arg_13_0._txtfacets.color = GameUtil.parseColor(var_13_3.TitleColor)
	arg_13_0._txtfacets.text = var_13_2.name

	local var_13_5 = {}

	for iter_13_0 = 1, var_13_1 do
		local var_13_6 = CharacterDestinyConfig.instance:getDestinyFacets(var_13_0, iter_13_0)

		table.insert(var_13_5, var_13_6)
	end

	gohelper.CreateObjList(arg_13_0, arg_13_0.showFacetsDescItem, var_13_5, arg_13_0._gofacetsDesc, arg_13_0._gofacetsDescItem)
end

function var_0_0.showFacetsDescItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.txtdesc = arg_14_1:GetComponent(gohelper.Type_TextMesh)
	var_14_0.txtdesc.text = arg_14_2.desc
	var_14_0.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(arg_14_1, SkillDescComp)

	var_14_0.skillDesc:updateInfo(var_14_0.txtdesc, arg_14_2.desc, arg_14_0.curSelectHeroItem.trialConfig.heroId)
	var_14_0.skillDesc:setTipParam(0, Vector2(-200, 100))
end

function var_0_0.onClose(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.HeroItemList) do
		iter_15_1.btnClick:RemoveClickListener()
		iter_15_1.heroIcon:UnLoadImage()
	end
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
