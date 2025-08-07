module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupView", package.seeall)

local var_0_0 = class("OdysseyHeroGroupView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosemult = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closemult")
	arg_1_0._btnenemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_enemy")
	arg_1_0._btntalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_talent")
	arg_1_0._gotalentLocked = gohelper.findChild(arg_1_0.viewGO, "#btn_talent/locked")
	arg_1_0._gotalentUnlock = gohelper.findChild(arg_1_0.viewGO, "#btn_talent/unlock")
	arg_1_0._gotalentReddot = gohelper.findChild(arg_1_0.viewGO, "#btn_talent/unlock/#go_talentReddot")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._gotopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_topbtns")
	arg_1_0._btnRestraintInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_topbtns/#btn_RestraintInfo")
	arg_1_0._btnchangename = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/#btn_changename")
	arg_1_0._btncloth = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/btnCloth")
	arg_1_0._txtclothName = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	arg_1_0._txtclothNameEn = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	arg_1_0._scrollSuit = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Suit")
	arg_1_0._gosuit = gohelper.findChild(arg_1_0.viewGO, "#scroll_Suit/Viewport/Content/#go_suit")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scroll_Suit/Viewport/Content/#go_suit/#btn_click")
	arg_1_0._btnunpowerstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerStart")
	arg_1_0._btnrecommend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_topbtns/btn_recommend")
	arg_1_0._dropherogroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	arg_1_0._simagefullBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_fullbg")

	arg_1_0._dropherogroup:AddOnValueChanged(arg_1_0._groupDropValueChanged, arg_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_2_0._onModifyHeroGroup, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_2_0.onClickHeroGroupItem, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnStartDungeonExtraParams, arg_2_0.onEnterFightSetParams, arg_2_0)
	arg_2_0:addEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_2_0._onModifyHeroGroup, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnRefreshReddot, arg_2_0.refreshReddot, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_2_0._respBeginFight, arg_2_0)
	arg_2_0._btnclosemult:AddClickListener(arg_2_0._btnclosemultOnClick, arg_2_0)
	arg_2_0._btnenemy:AddClickListener(arg_2_0._btnenemyOnClick, arg_2_0)
	arg_2_0._btntalent:AddClickListener(arg_2_0._btntalentOnClick, arg_2_0)
	arg_2_0._btnRestraintInfo:AddClickListener(arg_2_0._btnRestraintInfoOnClick, arg_2_0)
	arg_2_0._btnchangename:AddClickListener(arg_2_0._btnchangenameOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnunpowerstart:AddClickListener(arg_2_0._btnunpowerstartOnClick, arg_2_0)
	arg_2_0._btnrecommend:AddClickListener(arg_2_0._btnrecommendOnClick, arg_2_0)
	arg_2_0._btncloth:AddClickListener(arg_2_0._btnclothOnClock, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_3_0.onClickHeroGroupItem, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_3_0._onModifyHeroGroup, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnStartDungeonExtraParams, arg_3_0.onEnterFightSetParams, arg_3_0)
	arg_3_0:removeEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_3_0._onModifyHeroGroup, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnRefreshReddot, arg_3_0.refreshReddot, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.RespBeginFight, arg_3_0._respBeginFight, arg_3_0)
	arg_3_0._btnclosemult:RemoveClickListener()
	arg_3_0._btnenemy:RemoveClickListener()
	arg_3_0._btntalent:RemoveClickListener()
	arg_3_0._btnRestraintInfo:RemoveClickListener()
	arg_3_0._btnchangename:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnunpowerstart:RemoveClickListener()
	arg_3_0._btnrecommend:RemoveClickListener()
	arg_3_0._btncloth:RemoveClickListener()
end

function var_0_0._btnclosemultOnClick(arg_4_0)
	return
end

function var_0_0._btnenemyOnClick(arg_5_0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(HeroGroupModel.instance.battleId)
end

function var_0_0._btntalentOnClick(arg_6_0)
	if OdysseyTalentModel.instance:isTalentUnlock() == false then
		return
	end

	OdysseyController.instance:openTalentTreeView()
end

function var_0_0._btnRestraintInfoOnClick(arg_7_0)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._btnchangenameOnClick(arg_8_0)
	return
end

function var_0_0._btnclickOnClick(arg_9_0)
	return
end

function var_0_0._btnunpowerstartOnClick(arg_10_0)
	if arg_10_0._heroGroupType == OdysseyEnum.HeroGroupType.Prepare then
		logError("编队模式不能进入战斗")

		return
	end

	if HeroGroupModel.instance.episodeId then
		if OdysseyDungeonController.instance:setFightHeroGroup() then
			local var_10_0 = FightModel.instance:getFightParam()

			var_10_0.isReplay = false
			var_10_0.multiplication = 1

			DungeonFightController.instance:sendStartDungeonRequest(var_10_0.chapterId, var_10_0.episodeId, var_10_0, 1)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function var_0_0._btnrecommendOnClick(arg_11_0)
	return
end

function var_0_0._btnclothOnClock(arg_12_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function var_0_0._respBeginFight(arg_13_0)
	gohelper.setActive(arg_13_0._gomask, true)
end

function var_0_0.onClickHeroGroupItem(arg_14_0, arg_14_1)
	local var_14_0 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_14_1 - 1).equipUid
	local var_14_1 = {
		fight_param = FightParam.New(),
		singleGroupMOId = arg_14_1,
		originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(arg_14_1),
		equips = var_14_0
	}

	ViewMgr.instance:openView(ViewName.OdysseyHeroGroupEditView, var_14_1)
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0._gomask = gohelper.findChild(arg_15_0.viewGO, "#go_container2/#go_mask")
	arg_15_0._goherogroupcontain = gohelper.findChild(arg_15_0.viewGO, "herogroupcontain")
	arg_15_0._iconGO = arg_15_0:getResInst(arg_15_0.viewContainer:getSetting().otherRes[1], arg_15_0._btncloth.gameObject)

	recthelper.setAnchor(arg_15_0._iconGO.transform, -100, 1)
	gohelper.setActive(arg_15_0._gomask, false)
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	local var_17_0 = arg_17_0.viewParam
	local var_17_1

	if var_17_0 == nil then
		var_17_1 = OdysseyEnum.HeroGroupType.Fight
		arg_17_0._episodeId = HeroGroupModel.instance.episodeId
		arg_17_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_17_0._episodeId)
		arg_17_0._chapterConfig = DungeonConfig.instance:getChapterCO(arg_17_0.episodeConfig.chapterId)
		var_17_1 = OdysseyEnum.HeroGroupType.Fight
	else
		var_17_1 = var_17_0.heroGroupType ~= nil and var_17_0.heroGroupType or OdysseyEnum.HeroGroupType.Prepare
	end

	arg_17_0._heroGroupType = var_17_1

	HeroGroupModel.instance:setHeroGroupType(var_17_1)

	local var_17_2 = HeroGroupModel.instance:getCurGroupMO()

	HeroGroupTrialModel.instance:setTrialByOdysseyGroupMo(var_17_2)
	arg_17_0:initState()
	arg_17_0:_initFightGroupDrop()
	arg_17_0:_refreshCloth()
	arg_17_0:_refreshTalentState()
	arg_17_0:refreshReddot()
	OdysseyStatHelper.instance:initViewStartTime()
	NavigateMgr.instance:addEscape(arg_17_0.viewName, arg_17_0._onEscapeBtnClick, arg_17_0)
end

function var_0_0.initState(arg_18_0)
	local var_18_0 = arg_18_0._heroGroupType == OdysseyEnum.HeroGroupType.Fight

	gohelper.setActive(arg_18_0._btnenemy, var_18_0)
	gohelper.setActive(arg_18_0._btnrecommend, false)
	gohelper.setActive(arg_18_0._btnunpowerstart, var_18_0)
	gohelper.setActive(arg_18_0._btnRestraintInfo, false)
	gohelper.setActive(arg_18_0._simagefullBg, not var_18_0)
end

function var_0_0._refreshTalentState(arg_19_0)
	local var_19_0 = OdysseyTalentModel.instance:isTalentUnlock()

	gohelper.setActive(arg_19_0._btntalent.gameObject, var_19_0)
	gohelper.setActive(arg_19_0._gotalentLocked, not var_19_0)
	gohelper.setActive(arg_19_0._gotalentUnlock, var_19_0)
end

function var_0_0._refreshCloth(arg_20_0)
	local var_20_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local var_20_1 = HeroGroupModel.instance:getCurGroupMO().clothId

	var_20_1 = PlayerClothModel.instance:getSpEpisodeClothID() or var_20_1

	local var_20_2 = PlayerClothModel.instance:getById(var_20_1)

	gohelper.setActive(arg_20_0._txtclothName.gameObject, var_20_2)

	if var_20_2 then
		local var_20_3 = lua_cloth.configDict[var_20_2.clothId]

		if not var_20_2.level then
			local var_20_4 = 0
		end

		arg_20_0._txtclothName.text = var_20_3.name
		arg_20_0._txtclothNameEn.text = var_20_3.enname
	end

	for iter_20_0, iter_20_1 in ipairs(lua_cloth.configList) do
		local var_20_5 = gohelper.findChild(arg_20_0._iconGO, tostring(iter_20_1.id))

		if not gohelper.isNil(var_20_5) then
			gohelper.setActive(var_20_5, iter_20_1.id == var_20_1)
		end
	end

	gohelper.setActive(arg_20_0._btncloth.gameObject, var_0_0.showCloth())
end

function var_0_0._getEpisodeConfigAndBattleConfig()
	local var_21_0 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_21_1

	if HeroGroupModel.instance.battleId and HeroGroupModel.instance.battleId > 0 then
		var_21_1 = lua_battle.configDict[HeroGroupModel.instance.battleId]
	else
		var_21_1 = DungeonConfig.instance:getBattleCo(HeroGroupModel.instance.episodeId)
	end

	return var_21_0, var_21_1
end

function var_0_0.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	local var_22_0, var_22_1 = var_0_0._getEpisodeConfigAndBattleConfig()

	if var_22_1 and var_22_1.noClothSkill == 1 then
		return false
	end

	local var_22_2 = HeroGroupModel.instance:getCurGroupMO()
	local var_22_3 = PlayerClothModel.instance:getById(var_22_2.clothId)
	local var_22_4 = PlayerClothModel.instance:getList()
	local var_22_5 = false

	for iter_22_0, iter_22_1 in ipairs(var_22_4) do
		var_22_5 = true

		break
	end

	return var_22_5
end

function var_0_0._checkEquipClothSkill(arg_23_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local var_23_0 = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(var_23_0.clothId) then
		return
	end

	local var_23_1 = PlayerClothModel.instance:getList()

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if PlayerClothModel.instance:hasCloth(iter_23_1.id) then
			HeroGroupModel.instance:replaceCloth(iter_23_1.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function var_0_0._onEscapeBtnClick(arg_24_0)
	if not arg_24_0._gomask.gameObject.activeInHierarchy then
		arg_24_0.viewContainer:_closeCallback()
	end
end

function var_0_0._initFightGroupDrop(arg_25_0)
	local var_25_0 = {}

	for iter_25_0 = 1, 4 do
		var_25_0[iter_25_0] = OdysseyHeroGroupModel.instance:getCommonGroupName(iter_25_0)
	end

	local var_25_1 = OdysseyHeroGroupModel.instance:getCurIndex()

	gohelper.setActive(arg_25_0._btnchangename, false)
	arg_25_0._dropherogroup:ClearOptions()
	arg_25_0._dropherogroup:AddOptions(var_25_0)
	arg_25_0._dropherogroup:SetValue(var_25_1 - 1)
end

function var_0_0._groupDropValueChanged(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1 + 1

	if OdysseyHeroGroupModel.instance:canSwitchHeroGroupSelectIndex(var_26_0) then
		OdysseyHeroGroupController.instance:switchHeroGroup(var_26_0, arg_26_0.onSwitchHeroGroup, arg_26_0)
	end
end

function var_0_0.onSwitchHeroGroup(arg_27_0)
	GameFacade.showToast(arg_27_0._changeToastId or ToastEnum.SeasonGroupChanged)
	HeroGroupModel.instance:setHeroGroupSelectIndex()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	gohelper.setActive(arg_27_0._goherogroupcontain, false)
	gohelper.setActive(arg_27_0._goherogroupcontain, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
end

function var_0_0._onModifyHeroGroup(arg_28_0)
	arg_28_0:_refreshCloth()
end

function var_0_0.onEnterFightSetParams(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_2 and arg_29_2.type == DungeonEnum.EpisodeType.Odyssey then
		arg_29_1.params = tostring(OdysseyDungeonModel.instance:getCurInElementId())
	end
end

function var_0_0.refreshReddot(arg_30_0)
	local var_30_0 = OdysseyTalentModel.instance:checkHasNotUsedTalentPoint()

	gohelper.setActive(arg_30_0._gotalentReddot, var_30_0)
end

function var_0_0.onClose(arg_31_0)
	arg_31_0._dropherogroup:RemoveOnValueChanged()
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyHeroGroupView")
end

function var_0_0.onDestroyView(arg_32_0)
	return
end

return var_0_0
