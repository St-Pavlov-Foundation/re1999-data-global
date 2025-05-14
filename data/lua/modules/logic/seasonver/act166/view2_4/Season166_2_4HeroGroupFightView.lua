module("modules.logic.seasonver.act166.view2_4.Season166_2_4HeroGroupFightView", package.seeall)

local var_0_0 = class("Season166_2_4HeroGroupFightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnassist = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/horizontal/#btn_assist")
	arg_1_0._goassist = gohelper.findChild(arg_1_0.viewGO, "btnContain/horizontal/#btn_assist/#go_assist")
	arg_1_0._gocancelAssist = gohelper.findChild(arg_1_0.viewGO, "btnContain/horizontal/#btn_assist/#go_cancelAssist")
	arg_1_0._gofullAssist = gohelper.findChild(arg_1_0.viewGO, "btnContain/horizontal/#btn_assist/#go_fullAssist")
	arg_1_0._btnstartseason = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/horizontal/#btn_startseason")
	arg_1_0._btncloth = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/#btn_cloth")
	arg_1_0._txtclothName = gohelper.findChildText(arg_1_0.viewGO, "btnContain/#btn_cloth/#txt_clothName")
	arg_1_0._txtclothNameEn = gohelper.findChildText(arg_1_0.viewGO, "btnContain/#btn_cloth/#txt_clothName/#txt_clothNameEn")
	arg_1_0._btntalentTree = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/#btn_talentTree")
	arg_1_0._btntalentInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/#btn_talentTree/#btn_talentInfo")
	arg_1_0._btntalentTreeAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/#btn_talentTreeAdd")
	arg_1_0._imageTalent = gohelper.findChildImage(arg_1_0.viewGO, "btnContain/#btn_talentTree/#image_talen")
	arg_1_0._goEquipSlot = gohelper.findChild(arg_1_0.viewGO, "btnContain/#btn_talentTree/equipslot")
	arg_1_0._gotalentReddot = gohelper.findChild(arg_1_0.viewGO, "btnContain/#btn_talentTree/#go_talentReddot")
	arg_1_0._gomainFrameBg = gohelper.findChild(arg_1_0.viewGO, "frame/#go_mainFrameBg")
	arg_1_0._gohelpFrameBg = gohelper.findChild(arg_1_0.viewGO, "frame/#go_helpFrameBg")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._goruleWindow = gohelper.findChild(arg_1_0.viewGO, "#go_rulewindow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnassist:AddClickListener(arg_2_0._btnassistOnClick, arg_2_0)
	arg_2_0._btnstartseason:AddClickListener(arg_2_0._btnstartseasonOnClick, arg_2_0)
	arg_2_0._btncloth:AddClickListener(arg_2_0._btnclothOnClick, arg_2_0)
	arg_2_0._btntalentTree:AddClickListener(arg_2_0._btntalentTreeOnClick, arg_2_0)
	arg_2_0._btntalentTreeAdd:AddClickListener(arg_2_0._btntalentTreeOnClick, arg_2_0)
	arg_2_0._btntalentInfo:AddClickListener(arg_2_0._btntalentInfoOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_2_0._onOpenFullView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_2_0._onModifyHeroGroup, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_2_0._onClickHeroGroupItem, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, arg_2_0._showGuideDragEffect, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.StartFightFailed, arg_2_0.handleStartFightFailed, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnSelectPickAssist, arg_2_0.refreshAssistBtn, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_2_0.refreshAssistBtn, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.SetTalentId, arg_2_0._onTalentChange, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, arg_2_0._onTalentSkillChange, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.checkOneActivityIsEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnassist:RemoveClickListener()
	arg_3_0._btnstartseason:RemoveClickListener()
	arg_3_0._btncloth:RemoveClickListener()
	arg_3_0._btntalentTree:RemoveClickListener()
	arg_3_0._btntalentTreeAdd:RemoveClickListener()
	arg_3_0._btntalentInfo:RemoveClickListener()
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_3_0._onOpenFullView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_3_0._onModifyHeroGroup, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_3_0._onClickHeroGroupItem, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, arg_3_0._showGuideDragEffect, arg_3_0)
	arg_3_0:removeEventCb(Season166Controller.instance, Season166Event.StartFightFailed, arg_3_0.handleStartFightFailed, arg_3_0)
	arg_3_0:removeEventCb(Season166Controller.instance, Season166Event.OnSelectPickAssist, arg_3_0.refreshAssistBtn, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_3_0.refreshAssistBtn, arg_3_0)
	arg_3_0:removeEventCb(Season166Controller.instance, Season166Event.SetTalentId, arg_3_0._onTalentChange, arg_3_0)
	arg_3_0:removeEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, arg_3_0._onTalentSkillChange, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.checkOneActivityIsEnd, arg_3_0)
end

function var_0_0._btnassistOnClick(arg_4_0)
	if arg_4_0.assistMO then
		Season166HeroGroupModel.instance:cleanAssistData()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	elseif arg_4_0.isFullHero then
		GameFacade.showToast(ToastEnum.Season166HeroGroupFull)
	elseif not arg_4_0.isHasAssist then
		Season166Controller.instance:dispatchEvent(Season166Event.OpenPickAssistView)
	end
end

var_0_0.UIBlock_SeasonFight = "UIBlock_Season166Fight"

function var_0_0._btnstartseasonOnClick(arg_5_0)
	if not arg_5_0._blockStart then
		arg_5_0._blockStart = true

		arg_5_0:_onClickStart()
	end
end

function var_0_0._btnclothOnClick(arg_6_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView, {
			groupModel = Season166HeroGroupModel.instance
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function var_0_0._btntalentTreeOnClick(arg_7_0)
	local var_7_0

	if Season166HeroGroupModel.instance:isSeason166BaseSpotEpisode(arg_7_0.episodeId) then
		var_7_0 = arg_7_0.baseSpotTalentId
	end

	local var_7_1 = {
		showEquip = true,
		talentId = var_7_0
	}

	ViewMgr.instance:openView(ViewName.Season166TalentView, var_7_1)
end

function var_0_0._btntalentInfoOnClick(arg_8_0)
	Season166Controller.instance:openTalentInfoView()
end

function var_0_0._onEscapeBtnClick(arg_9_0)
	if not arg_9_0._goruleWindow.activeInHierarchy then
		arg_9_0.viewContainer:_closeCallback()
	end
end

function var_0_0._editableInitView(arg_10_0)
	NavigateMgr.instance:addEscape(ViewName.Season166HeroGroupFightView, arg_10_0._onEscapeBtnClick, arg_10_0)

	arg_10_0._iconGO = arg_10_0:getResInst(arg_10_0.viewContainer:getSetting().otherRes[1], arg_10_0._btncloth.gameObject)

	recthelper.setAnchor(arg_10_0._iconGO.transform, -100, 1)

	arg_10_0.talentSlotTab = arg_10_0:getUserDataTb_()

	for iter_10_0 = 1, 3 do
		local var_10_0 = {
			item = gohelper.findChild(arg_10_0._goEquipSlot, iter_10_0)
		}

		var_10_0.light = gohelper.findChild(var_10_0.item, "light")
		var_10_0.imageLight = gohelper.findChildImage(var_10_0.item, "light")
		var_10_0.lineLight = gohelper.findChild(var_10_0.item, "line_light")
		var_10_0.lineDark = gohelper.findChild(var_10_0.item, "line_dark")
		var_10_0.effect1 = gohelper.findChild(var_10_0.item, "light/qi1")
		var_10_0.effect2 = gohelper.findChild(var_10_0.item, "light/qi2")
		var_10_0.effect3 = gohelper.findChild(var_10_0.item, "light/qi3")
		arg_10_0.talentSlotTab[iter_10_0] = var_10_0
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:initData()
	arg_12_0:_checkFirstPosHasEquip()
	arg_12_0:_checkEquipClothSkill()
	arg_12_0:refreshUI()
	arg_12_0:refreshTalent()
	arg_12_0:refreshTalentReddot()
	arg_12_0:setFightTalentParam()
end

function var_0_0.initData(arg_13_0)
	arg_13_0.actId = arg_13_0.viewParam.actId
	arg_13_0.episodeId = arg_13_0.viewParam.episodeId or Season166HeroGroupModel.instance.episodeId
	arg_13_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_13_0.episodeId)
	arg_13_0.battleId = arg_13_0.viewParam.battleId or arg_13_0.episodeConfig.battleId
	arg_13_0.battleConfig = arg_13_0.battleId and lua_battle.configDict[arg_13_0.episodeConfig.battleId]

	Season166HeroGroupController.instance:onOpenViewInitData(arg_13_0.actId, arg_13_0.episodeId)

	arg_13_0.maxHeroCount = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()
	arg_13_0.isTrainEpisode = Season166HeroGroupModel.instance:isSeason166TrainEpisode(arg_13_0.episodeId)
	arg_13_0.baseSpotTalentId = arg_13_0:getBaseSpotTalentId()
end

function var_0_0.getBaseSpotTalentId(arg_14_0)
	local var_14_0
	local var_14_1 = lua_activity166_base.configList

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		if iter_14_1.episodeId == arg_14_0.episodeId then
			var_14_0 = iter_14_1.talentId
		end
	end

	return var_14_0
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0:refreshCloth()
	arg_15_0:refreshAssistBtn()

	arg_15_0.context = Season166Model.instance:getBattleContext()

	gohelper.setActive(arg_15_0._btntalentTree.gameObject, not arg_15_0.context.teachId)
end

function var_0_0.refreshCloth(arg_16_0)
	local var_16_0 = arg_16_0:getShowClothState()

	gohelper.setActive(arg_16_0._btncloth.gameObject, var_16_0)

	if not var_16_0 then
		return
	end

	local var_16_1 = Season166HeroGroupModel.instance:getCurGroupMO().clothId
	local var_16_2 = PlayerClothModel.instance:getById(var_16_1)

	gohelper.setActive(arg_16_0._txtclothName.gameObject, var_16_2)

	if var_16_2 then
		local var_16_3 = lua_cloth.configDict[var_16_2.clothId]

		if not var_16_2.level then
			local var_16_4 = 0
		end

		arg_16_0._txtclothName.text = var_16_3.name
		arg_16_0._txtclothNameEn.text = var_16_3.enname
	end

	for iter_16_0, iter_16_1 in ipairs(lua_cloth.configList) do
		local var_16_5 = gohelper.findChild(arg_16_0._iconGO, tostring(iter_16_1.id))

		if not gohelper.isNil(var_16_5) then
			gohelper.setActive(var_16_5, iter_16_1.id == var_16_1)
		end
	end
end

function var_0_0.refreshAssistBtn(arg_17_0)
	gohelper.setActive(arg_17_0._btnassist.gameObject, arg_17_0.isTrainEpisode)

	if not arg_17_0.isTrainEpisode then
		return
	end

	arg_17_0.isFullHero = arg_17_0:getCurHeroCount() == arg_17_0.maxHeroCount
	arg_17_0.assistMO = Season166HeroSingleGroupModel.instance.assistMO

	gohelper.setActive(arg_17_0._goassist, not arg_17_0.assistMO and not arg_17_0.isFullHero)
	gohelper.setActive(arg_17_0._gocancelAssist, arg_17_0.assistMO)
	gohelper.setActive(arg_17_0._gofullAssist, not arg_17_0.assistMO and arg_17_0.isFullHero)
end

function var_0_0.getCurHeroCount(arg_18_0)
	local var_18_0 = 0
	local var_18_1 = Season166HeroGroupModel.instance:getCurGroupMO().heroList

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if iter_18_1 ~= "0" then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0
end

function var_0_0.getShowClothState(arg_19_0)
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	if arg_19_0.battleConfig and arg_19_0.battleConfig.noClothSkill == 1 then
		return false
	end

	local var_19_0 = PlayerClothModel.instance:getList()

	return tabletool.len(var_19_0) > 0
end

function var_0_0._onClickStart(arg_20_0)
	local var_20_0 = 10104

	if Season166HeroGroupModel.instance.episodeId == var_20_0 and not DungeonModel.instance:hasPassLevel(var_20_0) then
		local var_20_1 = Season166HeroSingleGroupModel.instance:getList()
		local var_20_2 = 0

		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			if not iter_20_1:isEmpty() then
				var_20_2 = var_20_2 + 1
			end
		end

		if var_20_2 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			arg_20_0._blockStart = false

			return
		end
	end

	arg_20_0:_enterFight()
end

function var_0_0._enterFight(arg_21_0)
	local var_21_0 = Season166Model.instance:getBattleContext().talentId

	if not var_21_0 then
		GameFacade.showToast(ToastEnum.Season166TalentEmpty)

		arg_21_0._blockStart = false

		return
	end

	if Season166HeroGroupModel.instance.episodeId then
		if arg_21_0:setFightHeroGroup() then
			UIBlockMgr.instance:startBlock(var_0_0.UIBlock_SeasonFight)

			local var_21_1 = FightModel.instance:getFightParam()
			local var_21_2 = Season166HeroGroupModel.instance:getEpisodeConfigId(var_21_1.episodeId)

			Season166HeroGroupController.instance:sendStartAct166Battle(var_21_2, var_21_1.chapterId, var_21_1.episodeId, var_21_0, var_21_1, 1)
		end
	else
		logError("没选中关卡，无法开始战斗")

		arg_21_0._blockStart = false
	end
end

function var_0_0.setFightHeroGroup(arg_22_0)
	local var_22_0 = FightModel.instance:getFightParam()

	if not var_22_0 then
		return false
	end

	local var_22_1 = Season166HeroGroupModel.instance:getCurGroupMO()

	if not var_22_1 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		arg_22_0._blockStart = false

		return false
	end

	local var_22_2, var_22_3 = var_22_1:getMainList()
	local var_22_4, var_22_5 = var_22_1:getSubList()
	local var_22_6 = Season166HeroSingleGroupModel.instance:getList()
	local var_22_7 = var_22_1:getAllHeroEquips()

	for iter_22_0 = 1, #var_22_2 do
		if var_22_2[iter_22_0] ~= var_22_6[iter_22_0].heroUid then
			var_22_2[iter_22_0] = "0"
			var_22_3 = var_22_3 - 1

			if var_22_7[iter_22_0] then
				var_22_7[iter_22_0].heroUid = "0"
			end
		end
	end

	for iter_22_1 = #var_22_2 + 1, math.min(#var_22_2 + #var_22_4, #var_22_6) do
		if var_22_4[iter_22_1 - #var_22_2] ~= var_22_6[iter_22_1].heroUid then
			var_22_4[iter_22_1 - #var_22_2] = "0"
			var_22_5 = var_22_5 - 1

			if var_22_7[iter_22_1] then
				var_22_7[iter_22_1].heroUid = "0"
			end
		end
	end

	if (not var_22_1.aidDict or #var_22_1.aidDict <= 0) and var_22_3 + var_22_5 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		arg_22_0._blockStart = false

		return false
	end

	local var_22_8 = var_22_0.battleId
	local var_22_9 = var_22_8 and lua_battle.configDict[var_22_8]
	local var_22_10 = var_22_9 and var_22_9.noClothSkill == 0 and var_22_1.clothId or 0

	var_22_0:setMySide(var_22_10, var_22_2, var_22_4, var_22_1:getAllHeroEquips())

	return true
end

function var_0_0._checkFirstPosHasEquip(arg_23_0)
	local var_23_0 = Season166HeroGroupModel.instance:getCurGroupMO()

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0:getPosEquips(0).equipUid
	local var_23_2 = var_23_1 and var_23_1[1]

	if var_23_2 and EquipModel.instance:getEquip(var_23_2) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function var_0_0._checkEquipClothSkill(arg_24_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local var_24_0 = Season166HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(var_24_0.clothId) then
		return
	end

	local var_24_1 = PlayerClothModel.instance:getList()

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		if PlayerClothModel.instance:hasCloth(iter_24_1.id) then
			Season166HeroGroupModel.instance:replaceCloth(iter_24_1.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			Season166HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function var_0_0._onOpenFullView(arg_25_0, arg_25_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function var_0_0._onCloseView(arg_26_0, arg_26_1)
	if arg_26_1 == ViewName.EquipInfoTeamShowView then
		arg_26_0:_checkFirstPosHasEquip()
	end

	if arg_26_1 == ViewName.Season166TalentView then
		arg_26_0:refreshTalentReddot()
	end
end

function var_0_0._onModifyHeroGroup(arg_27_0)
	arg_27_0:refreshCloth()
	arg_27_0:refreshAssistBtn()
end

function var_0_0._onClickHeroGroupItem(arg_28_0, arg_28_1)
	local var_28_0 = Season166HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_28_1 - 1).equipUid

	arg_28_0._param = tabletool.copy(arg_28_0.viewParam)
	arg_28_0._param.singleGroupMOId = arg_28_1
	arg_28_0._param.originalHeroUid = Season166HeroSingleGroupModel.instance:getHeroUid(arg_28_1)
	arg_28_0._param.equips = var_28_0

	ViewMgr.instance:openView(ViewName.Season166HeroGroupEditView, arg_28_0._param)
end

function var_0_0._showGuideDragEffect(arg_29_0, arg_29_1)
	if arg_29_0._dragEffectLoader then
		arg_29_0._dragEffectLoader:dispose()

		arg_29_0._dragEffectLoader = nil
	end

	if tonumber(arg_29_1) == 1 then
		arg_29_0._dragEffectLoader = PrefabInstantiate.Create(arg_29_0.viewGO)

		arg_29_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function var_0_0.handleStartFightFailed(arg_30_0)
	arg_30_0._blockStart = false

	UIBlockMgr.instance:endBlock(var_0_0.UIBlock_SeasonFight)
end

function var_0_0._onTalentChange(arg_31_0, arg_31_1)
	local var_31_0 = Season166Model.instance:getBattleContext()

	if var_31_0 then
		var_31_0.talentId = arg_31_1
		arg_31_0.newTalentId = arg_31_1

		arg_31_0:_onTalentSkillChange()
	end
end

function var_0_0._onTalentSkillChange(arg_32_0)
	arg_32_0:refreshTalentReddot()
	arg_32_0:refreshTalent()
	arg_32_0:setFightTalentParam()
end

function var_0_0.refreshTalent(arg_33_0)
	local var_33_0 = arg_33_0.baseSpotTalentId or arg_33_0.newTalentId or Season166Model.getPrefsTalent()

	if not var_33_0 then
		gohelper.setActive(arg_33_0._btntalentTreeAdd.gameObject, not arg_33_0.context.teachId)
		gohelper.setActive(arg_33_0._btntalentTree.gameObject, false)

		return
	end

	gohelper.setActive(arg_33_0._btntalentTreeAdd.gameObject, false)
	gohelper.setActive(arg_33_0._btntalentTree.gameObject, not arg_33_0.context.teachId)

	local var_33_1 = Season166Model.instance:getTalentInfo(arg_33_0.actId, var_33_0)
	local var_33_2 = var_33_1.config.talentId
	local var_33_3 = lua_activity166_talent.configDict[arg_33_0.actId][var_33_2]

	UISpriteSetMgr.instance:setSeason166Sprite(arg_33_0._imageTalent, "season166_talentree_btn_talen" .. var_33_3.sortIndex, true)

	local var_33_4 = var_33_1.config.slot
	local var_33_5 = #var_33_1.skillIds

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.talentSlotTab) do
		gohelper.setActive(iter_33_1.item, iter_33_0 <= var_33_4)
		gohelper.setActive(iter_33_1.light, iter_33_0 <= var_33_5)
		gohelper.setActive(iter_33_1.lineLight, iter_33_0 > 1 and iter_33_0 <= var_33_5)
		gohelper.setActive(iter_33_1.lineDark, iter_33_0 > 1 and var_33_5 < iter_33_0)
		UISpriteSetMgr.instance:setSeason166Sprite(iter_33_1.imageLight, "season166_talentree_pointl" .. tostring(var_33_3.sortIndex))

		for iter_33_2 = 1, 3 do
			gohelper.setActive(iter_33_1["effect" .. iter_33_2], var_33_3.sortIndex == iter_33_2)
		end
	end
end

function var_0_0.setFightTalentParam(arg_34_0)
	local var_34_0 = arg_34_0.baseSpotTalentId or arg_34_0.newTalentId or Season166Model.getPrefsTalent()

	if not var_34_0 then
		return
	end

	gohelper.setActive(arg_34_0._btntalentInfo.gameObject, var_34_0 and var_34_0 > 0)

	local var_34_1 = Season166Model.instance:getTalentInfo(arg_34_0.actId, var_34_0)
	local var_34_2 = var_34_1 and var_34_1.skillIds or {}
	local var_34_3 = var_34_1 and var_34_1.level or 1

	Season166Model.instance:setFightTalentParam(var_34_0, var_34_2, var_34_3)
end

function var_0_0.refreshTalentReddot(arg_35_0)
	RedDotController.instance:addRedDot(arg_35_0._gotalentReddot, RedDotEnum.DotNode.Season166TalentEnter, nil, arg_35_0.checkTalentReddotShow, arg_35_0)
end

function var_0_0.checkTalentReddotShow(arg_36_0, arg_36_1)
	arg_36_1:defaultRefreshDot()

	local var_36_0 = arg_36_0.baseSpotTalentId or arg_36_0.newTalentId or Season166Model.getPrefsTalent()

	if not var_36_0 and not arg_36_1.show then
		arg_36_1.show = Season166Model.instance:checkAllHasNewTalent(arg_36_0.actId)

		arg_36_1:showRedDot(RedDotEnum.Style.Green)

		return
	end

	arg_36_1.show = Season166Model.instance:checkHasNewTalent(var_36_0)

	if arg_36_1.show then
		arg_36_1:showRedDot(RedDotEnum.Style.Green)
	end
end

function var_0_0.checkOneActivityIsEnd(arg_37_0)
	local var_37_0, var_37_1 = Season166Controller.instance:getSeasonEnterCloseTimeStamp(arg_37_0.actId)

	if var_37_0 == 0 or var_37_1 <= 0 then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
	end
end

function var_0_0.onClose(arg_38_0)
	if arg_38_0._dragEffectLoader then
		arg_38_0._dragEffectLoader:dispose()

		arg_38_0._dragEffectLoader = nil
	end
end

function var_0_0.onDestroyView(arg_39_0)
	Season166HeroGroupController.instance:onCloseViewCleanData()
	UIBlockMgr.instance:endBlock(var_0_0.UIBlock_SeasonFight)
end

return var_0_0
