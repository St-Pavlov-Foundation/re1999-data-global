module("modules.logic.character.view.recommed.CharacterRecommedView", package.seeall)

local var_0_0 = class("CharacterRecommedView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bgimg")
	arg_1_0._goheroinfo = gohelper.findChild(arg_1_0.viewGO, "left/bottom/#go_heroinfo")
	arg_1_0._txtheroname = gohelper.findChildText(arg_1_0.viewGO, "left/bottom/#go_heroinfo/#txt_heroname")
	arg_1_0._golv = gohelper.findChild(arg_1_0.viewGO, "left/bottom/#go_heroinfo/#go_lv")
	arg_1_0._imagelvicon = gohelper.findChildImage(arg_1_0.viewGO, "left/bottom/#go_heroinfo/#go_lv/lv/#image_lvicon")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "left/bottom/#go_heroinfo/#go_lv/lv/#txt_lv")
	arg_1_0._imagetalenticon = gohelper.findChildImage(arg_1_0.viewGO, "left/bottom/#go_heroinfo/#go_lv/talent/#image_talenticon")
	arg_1_0._txttalentlv = gohelper.findChildText(arg_1_0.viewGO, "left/bottom/#go_heroinfo/#go_lv/talent/#txt_talentlv")
	arg_1_0._btnchangehero = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/bottom/#btn_changehero")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "left/#go_spine")
	arg_1_0._gochangehero = gohelper.findChild(arg_1_0.viewGO, "#go_changehero")
	arg_1_0._btnchangeheroclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_changehero/#btn_changeheroclose")
	arg_1_0._gotab1 = gohelper.findChild(arg_1_0.viewGO, "right/top/#go_tab1")
	arg_1_0._gotab2 = gohelper.findChild(arg_1_0.viewGO, "right/top/#go_tab2")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "right/#go_scroll")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchangehero:AddClickListener(arg_2_0._btnchangeheroOnClick, arg_2_0)
	arg_2_0._btnchangeheroclose:AddClickListener(arg_2_0._btnchangeherocloseOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnChangeHero, arg_2_0._cuthHero, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_2_0._refreshHeroInfo, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_2_0._refreshHeroInfo, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_2_0._refreshHeroInfo, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, arg_2_0._onJumpView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchangehero:RemoveClickListener()
	arg_3_0._btnchangeheroclose:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnChangeHero, arg_3_0._cuthHero, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_3_0._refreshHeroInfo, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_3_0._refreshHeroInfo, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_3_0._refreshHeroInfo, arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, arg_3_0._onJumpView, arg_3_0)
end

function var_0_0._btnchangeherocloseOnClick(arg_4_0)
	arg_4_0:playChangeHeroAnimPlayer(CharacterRecommedEnum.AnimName.Close, arg_4_0._hideChageHero, arg_4_0)
end

function var_0_0._btnchangeheroOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gochangehero.gameObject, true)
	arg_5_0:playChangeHeroAnimPlayer(CharacterRecommedEnum.AnimName.Open, nil, arg_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0._hideChageHero(arg_8_0)
	gohelper.setActive(arg_8_0._gochangehero.gameObject, false)
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._selectTab = arg_9_0.viewParam.defaultTabId or CharacterRecommedEnum.TabSubType.RecommedGroup

	arg_9_0:_initTab()
	arg_9_0:_refreshHero(arg_9_0.viewParam.heroId)
	arg_9_0:_hideChageHero()
	arg_9_0:playViewAnimPlayer(CharacterRecommedEnum.AnimName.Open, nil, arg_9_0)
end

function var_0_0._onJumpView(arg_10_0, arg_10_1)
	if arg_10_1 ~= CharacterRecommedEnum.JumpView.Dungeon then
		arg_10_0:closeThis()
	end
end

function var_0_0._refreshHero(arg_11_0, arg_11_1)
	if arg_11_0._heroId == arg_11_1 then
		return
	end

	arg_11_0._heroId = arg_11_1

	arg_11_0:_refreshHeroInfo()
end

function var_0_0._cuthHero(arg_12_0, arg_12_1)
	if arg_12_0._heroId == arg_12_1 then
		return
	end

	arg_12_0._heroId = arg_12_1

	arg_12_0:playViewAnim(CharacterRecommedEnum.AnimName.Switch, 0, 0)
	TaskDispatcher.cancelTask(arg_12_0._cuthHeroCb, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0._cuthHeroCb, arg_12_0, 0.16)
end

function var_0_0._cuthHeroCb(arg_13_0)
	arg_13_0:_refreshHeroInfo()
	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnCutHeroAnimCB, arg_13_0._heroId)
end

function var_0_0._refreshHeroInfo(arg_14_0)
	local var_14_0 = CharacterRecommedModel.instance:getHeroRecommendMo(arg_14_0._heroId)
	local var_14_1 = var_14_0:getHeroConfig()

	arg_14_0._txtheroname.text = CharacterRecommedModel.instance:getHeroName(var_14_1.name, 52)

	local var_14_2 = var_14_0:getHeroLevel()
	local var_14_3 = var_14_0:getHeroRank()
	local var_14_4 = var_14_0:getTalentLevel()
	local var_14_5 = HeroConfig.instance:getShowLevel(var_14_2)

	arg_14_0._txtlv.text = string.format("Lv.%s", var_14_5)

	if var_14_3 > 1 then
		UISpriteSetMgr.instance:setUiCharacterSprite(arg_14_0._imagelvicon, "character_recommend_targeticon" .. var_14_3 + 3, true)
		gohelper.setActive(arg_14_0._imagelvicon.gameObject, true)
	else
		gohelper.setActive(arg_14_0._imagelvicon.gameObject, false)
	end

	arg_14_0._txttalentlv.text = string.format("Lv.%s", var_14_4)

	UISpriteSetMgr.instance:setUiCharacterSprite(arg_14_0._imagetalenticon, "character_recommend_targeticon3", true)
	gohelper.setActive(arg_14_0._btnchangehero.gameObject, var_14_0:isOwnHero())

	local var_14_6 = var_14_0:isShowTeam() or var_14_0:isShowEquip()

	gohelper.setActive(arg_14_0._gotab1, var_14_6)
end

function var_0_0._initTab(arg_15_0)
	if arg_15_0._tabItems then
		return
	end

	arg_15_0._tabItems = arg_15_0:getUserDataTb_()

	for iter_15_0, iter_15_1 in pairs(CharacterRecommedEnum.TabSubType) do
		local var_15_0 = arg_15_0:_getTabItem(iter_15_1)

		gohelper.setActive(var_15_0.goselect, iter_15_1 == arg_15_0._selectTab)
	end
end

function var_0_0._getTabItem(arg_16_0, arg_16_1)
	if arg_16_0._tabItems[arg_16_1] then
		return arg_16_0._tabItems[arg_16_1]
	end

	local var_16_0 = gohelper.findChild(arg_16_0.viewGO, "right/top/#go_tab" .. arg_16_1)

	if not var_16_0 then
		logError("缺少这个页签:" .. arg_16_1)

		return
	end

	local var_16_1 = arg_16_0:getUserDataTb_()

	var_16_1.go = var_16_0
	var_16_1.goselect = gohelper.findChild(var_16_0, "#go_select")
	var_16_1.btntab = gohelper.findChildButtonWithAudio(var_16_0, "#btn_tab")

	var_16_1.btntab:AddClickListener(arg_16_0._onClickTab, arg_16_0, arg_16_1)

	arg_16_0._tabItems[arg_16_1] = var_16_1

	return var_16_1
end

function var_0_0._onClickTab(arg_17_0, arg_17_1)
	if arg_17_0._selectTab == arg_17_1 then
		return
	end

	arg_17_0._selectTab = arg_17_1

	arg_17_0.viewContainer:cutTab(arg_17_1)
	arg_17_0:_onRefreshTab()
end

function var_0_0._onRefreshTab(arg_18_0)
	if arg_18_0._tabItems then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._tabItems) do
			gohelper.setActive(iter_18_1.goselect, iter_18_0 == arg_18_0._selectTab)
		end
	end
end

function var_0_0.playViewAnim(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_0._viewAnim then
		arg_19_0._viewAnim = arg_19_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_19_0._viewAnim then
		arg_19_0._viewAnim.enabled = true

		arg_19_0._viewAnim:Play(arg_19_1, arg_19_2, arg_19_3)
	end
end

function var_0_0.playViewAnimPlayer(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not arg_20_0._viewAnimPlayer then
		arg_20_0._viewAnimPlayer = SLFramework.AnimatorPlayer.Get(arg_20_0.viewGO)
	end

	if arg_20_0._viewAnimPlayer then
		arg_20_0._viewAnimPlayer:Play(arg_20_1, arg_20_2, arg_20_3)
	end
end

function var_0_0.playChangeHeroAnimPlayer(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if not arg_21_0._changeHeroAnimPlayer then
		arg_21_0._changeHeroAnimPlayer = SLFramework.AnimatorPlayer.Get(arg_21_0._gochangehero)
	end

	if arg_21_0._changeHeroAnimPlayer then
		arg_21_0._changeHeroAnimPlayer:Play(arg_21_1, arg_21_2, arg_21_3)
	end
end

function var_0_0.onClose(arg_22_0)
	if arg_22_0._tabItems then
		for iter_22_0, iter_22_1 in pairs(arg_22_0._tabItems) do
			iter_22_1.btntab:RemoveClickListener()
		end
	end

	TaskDispatcher.cancelTask(arg_22_0._cuthHeroCb, nil)
end

function var_0_0.onDestroyView(arg_23_0)
	return
end

return var_0_0
