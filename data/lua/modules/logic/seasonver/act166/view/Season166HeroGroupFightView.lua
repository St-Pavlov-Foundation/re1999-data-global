module("modules.logic.seasonver.act166.view.Season166HeroGroupFightView", package.seeall)

local var_0_0 = class("Season166HeroGroupFightView", BaseView)

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

function var_0_0._onEscapeBtnClick(arg_8_0)
	if not arg_8_0._goruleWindow.activeInHierarchy then
		arg_8_0.viewContainer:_closeCallback()
	end
end

function var_0_0._editableInitView(arg_9_0)
	NavigateMgr.instance:addEscape(ViewName.Season166HeroGroupFightView, arg_9_0._onEscapeBtnClick, arg_9_0)

	arg_9_0._iconGO = arg_9_0:getResInst(arg_9_0.viewContainer:getSetting().otherRes[1], arg_9_0._btncloth.gameObject)

	recthelper.setAnchor(arg_9_0._iconGO.transform, -100, 1)

	arg_9_0.talentSlotTab = arg_9_0:getUserDataTb_()

	for iter_9_0 = 1, 3 do
		local var_9_0 = {
			item = gohelper.findChild(arg_9_0._goEquipSlot, iter_9_0)
		}

		var_9_0.light = gohelper.findChild(var_9_0.item, "light")
		var_9_0.imageLight = gohelper.findChildImage(var_9_0.item, "light")
		var_9_0.lineLight = gohelper.findChild(var_9_0.item, "line_light")
		var_9_0.lineDark = gohelper.findChild(var_9_0.item, "line_dark")
		var_9_0.effect1 = gohelper.findChild(var_9_0.item, "light/qi1")
		var_9_0.effect2 = gohelper.findChild(var_9_0.item, "light/qi2")
		var_9_0.effect3 = gohelper.findChild(var_9_0.item, "light/qi3")
		arg_9_0.talentSlotTab[iter_9_0] = var_9_0
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:initData()
	arg_11_0:_checkFirstPosHasEquip()
	arg_11_0:_checkEquipClothSkill()
	arg_11_0:refreshUI()
	arg_11_0:refreshTalent()
	arg_11_0:refreshTalentReddot()
end

function var_0_0.initData(arg_12_0)
	arg_12_0.actId = arg_12_0.viewParam.actId
	arg_12_0.episodeId = arg_12_0.viewParam.episodeId or Season166HeroGroupModel.instance.episodeId
	arg_12_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_12_0.episodeId)
	arg_12_0.battleId = arg_12_0.viewParam.battleId or arg_12_0.episodeConfig.battleId
	arg_12_0.battleConfig = arg_12_0.battleId and lua_battle.configDict[arg_12_0.episodeConfig.battleId]

	Season166HeroGroupController.instance:onOpenViewInitData(arg_12_0.actId, arg_12_0.episodeId)

	arg_12_0.maxHeroCount = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()
	arg_12_0.isTrainEpisode = Season166HeroGroupModel.instance:isSeason166TrainEpisode(arg_12_0.episodeId)
	arg_12_0.baseSpotTalentId = arg_12_0:getBaseSpotTalentId()
end

function var_0_0.getBaseSpotTalentId(arg_13_0)
	local var_13_0
	local var_13_1 = lua_activity166_base.configList

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		if iter_13_1.episodeId == arg_13_0.episodeId then
			var_13_0 = iter_13_1.talentId
		end
	end

	return var_13_0
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0:refreshCloth()
	arg_14_0:refreshAssistBtn()

	arg_14_0.context = Season166Model.instance:getBattleContext()

	gohelper.setActive(arg_14_0._btntalentTree.gameObject, not arg_14_0.context.teachId)
end

function var_0_0.refreshCloth(arg_15_0)
	local var_15_0 = arg_15_0:getShowClothState()

	gohelper.setActive(arg_15_0._btncloth.gameObject, var_15_0)

	if not var_15_0 then
		return
	end

	local var_15_1 = Season166HeroGroupModel.instance:getCurGroupMO().clothId
	local var_15_2 = PlayerClothModel.instance:getById(var_15_1)

	gohelper.setActive(arg_15_0._txtclothName.gameObject, var_15_2)

	if var_15_2 then
		local var_15_3 = lua_cloth.configDict[var_15_2.clothId]

		if not var_15_2.level then
			local var_15_4 = 0
		end

		arg_15_0._txtclothName.text = var_15_3.name
		arg_15_0._txtclothNameEn.text = var_15_3.enname
	end

	for iter_15_0, iter_15_1 in ipairs(lua_cloth.configList) do
		local var_15_5 = gohelper.findChild(arg_15_0._iconGO, tostring(iter_15_1.id))

		if not gohelper.isNil(var_15_5) then
			gohelper.setActive(var_15_5, iter_15_1.id == var_15_1)
		end
	end
end

function var_0_0.refreshAssistBtn(arg_16_0)
	gohelper.setActive(arg_16_0._btnassist.gameObject, arg_16_0.isTrainEpisode)

	if not arg_16_0.isTrainEpisode then
		return
	end

	arg_16_0.isFullHero = arg_16_0:getCurHeroCount() == arg_16_0.maxHeroCount
	arg_16_0.assistMO = Season166HeroSingleGroupModel.instance.assistMO

	gohelper.setActive(arg_16_0._goassist, not arg_16_0.assistMO and not arg_16_0.isFullHero)
	gohelper.setActive(arg_16_0._gocancelAssist, arg_16_0.assistMO)
	gohelper.setActive(arg_16_0._gofullAssist, not arg_16_0.assistMO and arg_16_0.isFullHero)
end

function var_0_0.getCurHeroCount(arg_17_0)
	local var_17_0 = 0
	local var_17_1 = Season166HeroGroupModel.instance:getCurGroupMO().heroList

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if iter_17_1 ~= "0" then
			var_17_0 = var_17_0 + 1
		end
	end

	return var_17_0
end

function var_0_0.getShowClothState(arg_18_0)
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	if arg_18_0.battleConfig and arg_18_0.battleConfig.noClothSkill == 1 then
		return false
	end

	local var_18_0 = PlayerClothModel.instance:getList()

	return tabletool.len(var_18_0) > 0
end

function var_0_0._onClickStart(arg_19_0)
	local var_19_0 = 10104

	if Season166HeroGroupModel.instance.episodeId == var_19_0 and not DungeonModel.instance:hasPassLevel(var_19_0) then
		local var_19_1 = Season166HeroSingleGroupModel.instance:getList()
		local var_19_2 = 0

		for iter_19_0, iter_19_1 in ipairs(var_19_1) do
			if not iter_19_1:isEmpty() then
				var_19_2 = var_19_2 + 1
			end
		end

		if var_19_2 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			arg_19_0._blockStart = false

			return
		end
	end

	arg_19_0:_enterFight()
end

function var_0_0._enterFight(arg_20_0)
	local var_20_0 = Season166Model.instance:getBattleContext().talentId

	if not var_20_0 then
		GameFacade.showToast(ToastEnum.Season166TalentEmpty)

		arg_20_0._blockStart = false

		return
	end

	if Season166HeroGroupModel.instance.episodeId then
		if arg_20_0:setFightHeroGroup() then
			UIBlockMgr.instance:startBlock(var_0_0.UIBlock_SeasonFight)

			local var_20_1 = FightModel.instance:getFightParam()
			local var_20_2 = Season166HeroGroupModel.instance:getEpisodeConfigId(var_20_1.episodeId)

			Season166HeroGroupController.instance:sendStartAct166Battle(var_20_2, var_20_1.chapterId, var_20_1.episodeId, var_20_0, var_20_1, 1)
		end
	else
		logError("没选中关卡，无法开始战斗")

		arg_20_0._blockStart = false
	end
end

function var_0_0.setFightHeroGroup(arg_21_0)
	local var_21_0 = FightModel.instance:getFightParam()

	if not var_21_0 then
		return false
	end

	local var_21_1 = Season166HeroGroupModel.instance:getCurGroupMO()

	if not var_21_1 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		arg_21_0._blockStart = false

		return false
	end

	local var_21_2, var_21_3 = var_21_1:getMainList()
	local var_21_4, var_21_5 = var_21_1:getSubList()
	local var_21_6 = Season166HeroSingleGroupModel.instance:getList()
	local var_21_7 = var_21_1:getAllHeroEquips()

	for iter_21_0 = 1, #var_21_2 do
		if var_21_2[iter_21_0] ~= var_21_6[iter_21_0].heroUid then
			var_21_2[iter_21_0] = "0"
			var_21_3 = var_21_3 - 1

			if var_21_7[iter_21_0] then
				var_21_7[iter_21_0].heroUid = "0"
			end
		end
	end

	for iter_21_1 = #var_21_2 + 1, math.min(#var_21_2 + #var_21_4, #var_21_6) do
		if var_21_4[iter_21_1 - #var_21_2] ~= var_21_6[iter_21_1].heroUid then
			var_21_4[iter_21_1 - #var_21_2] = "0"
			var_21_5 = var_21_5 - 1

			if var_21_7[iter_21_1] then
				var_21_7[iter_21_1].heroUid = "0"
			end
		end
	end

	if (not var_21_1.aidDict or #var_21_1.aidDict <= 0) and var_21_3 + var_21_5 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		arg_21_0._blockStart = false

		return false
	end

	local var_21_8 = var_21_0.battleId
	local var_21_9 = var_21_8 and lua_battle.configDict[var_21_8]
	local var_21_10 = var_21_9 and var_21_9.noClothSkill == 0 and var_21_1.clothId or 0

	var_21_0:setMySide(var_21_10, var_21_2, var_21_4, var_21_1:getAllHeroEquips())

	return true
end

function var_0_0._checkFirstPosHasEquip(arg_22_0)
	local var_22_0 = Season166HeroGroupModel.instance:getCurGroupMO()

	if not var_22_0 then
		return
	end

	local var_22_1 = var_22_0:getPosEquips(0).equipUid
	local var_22_2 = var_22_1 and var_22_1[1]

	if var_22_2 and EquipModel.instance:getEquip(var_22_2) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function var_0_0._checkEquipClothSkill(arg_23_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local var_23_0 = Season166HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(var_23_0.clothId) then
		return
	end

	local var_23_1 = PlayerClothModel.instance:getList()

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if PlayerClothModel.instance:hasCloth(iter_23_1.id) then
			Season166HeroGroupModel.instance:replaceCloth(iter_23_1.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			Season166HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function var_0_0._onOpenFullView(arg_24_0, arg_24_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function var_0_0._onCloseView(arg_25_0, arg_25_1)
	if arg_25_1 == ViewName.EquipInfoTeamShowView then
		arg_25_0:_checkFirstPosHasEquip()
	end

	if arg_25_1 == ViewName.Season166TalentView then
		arg_25_0:refreshTalentReddot()
	end
end

function var_0_0._onModifyHeroGroup(arg_26_0)
	arg_26_0:refreshCloth()
	arg_26_0:refreshAssistBtn()
end

function var_0_0._onClickHeroGroupItem(arg_27_0, arg_27_1)
	local var_27_0 = Season166HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_27_1 - 1).equipUid

	arg_27_0._param = tabletool.copy(arg_27_0.viewParam)
	arg_27_0._param.singleGroupMOId = arg_27_1
	arg_27_0._param.originalHeroUid = Season166HeroSingleGroupModel.instance:getHeroUid(arg_27_1)
	arg_27_0._param.equips = var_27_0

	ViewMgr.instance:openView(ViewName.Season166HeroGroupEditView, arg_27_0._param)
end

function var_0_0._showGuideDragEffect(arg_28_0, arg_28_1)
	if arg_28_0._dragEffectLoader then
		arg_28_0._dragEffectLoader:dispose()

		arg_28_0._dragEffectLoader = nil
	end

	if tonumber(arg_28_1) == 1 then
		arg_28_0._dragEffectLoader = PrefabInstantiate.Create(arg_28_0.viewGO)

		arg_28_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function var_0_0.handleStartFightFailed(arg_29_0)
	arg_29_0._blockStart = false

	UIBlockMgr.instance:endBlock(var_0_0.UIBlock_SeasonFight)
end

function var_0_0._onTalentChange(arg_30_0, arg_30_1)
	local var_30_0 = Season166Model.instance:getBattleContext()

	if var_30_0 then
		var_30_0.talentId = arg_30_1
		arg_30_0.newTalentId = arg_30_1

		arg_30_0:_onTalentSkillChange()
	end
end

function var_0_0._onTalentSkillChange(arg_31_0)
	arg_31_0:refreshTalentReddot()
	arg_31_0:refreshTalent()
end

function var_0_0.refreshTalent(arg_32_0)
	local var_32_0 = arg_32_0.baseSpotTalentId or arg_32_0.newTalentId or Season166Model.getPrefsTalent()

	if not var_32_0 then
		gohelper.setActive(arg_32_0._btntalentTreeAdd.gameObject, not arg_32_0.context.teachId)
		gohelper.setActive(arg_32_0._btntalentTree.gameObject, false)

		return
	end

	gohelper.setActive(arg_32_0._btntalentTreeAdd.gameObject, false)
	gohelper.setActive(arg_32_0._btntalentTree.gameObject, not arg_32_0.context.teachId)

	local var_32_1 = Season166Model.instance:getTalentInfo(arg_32_0.actId, var_32_0)
	local var_32_2 = var_32_1.config.talentId
	local var_32_3 = lua_activity166_talent.configDict[arg_32_0.actId][var_32_2]

	UISpriteSetMgr.instance:setSeason166Sprite(arg_32_0._imageTalent, "season166_talentree_btn_talen" .. var_32_3.sortIndex, true)

	local var_32_4 = var_32_1.config.slot
	local var_32_5 = #var_32_1.skillIds

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.talentSlotTab) do
		gohelper.setActive(iter_32_1.item, iter_32_0 <= var_32_4)
		gohelper.setActive(iter_32_1.light, iter_32_0 <= var_32_5)
		gohelper.setActive(iter_32_1.lineLight, iter_32_0 > 1 and iter_32_0 <= var_32_5)
		gohelper.setActive(iter_32_1.lineDark, iter_32_0 > 1 and var_32_5 < iter_32_0)
		UISpriteSetMgr.instance:setSeason166Sprite(iter_32_1.imageLight, "season166_talentree_pointl" .. tostring(var_32_3.sortIndex))

		for iter_32_2 = 1, 3 do
			gohelper.setActive(iter_32_1["effect" .. iter_32_2], var_32_3.sortIndex == iter_32_2)
		end
	end
end

function var_0_0.refreshTalentReddot(arg_33_0)
	RedDotController.instance:addRedDot(arg_33_0._gotalentReddot, RedDotEnum.DotNode.Season166TalentEnter, nil, arg_33_0.checkTalentReddotShow, arg_33_0)
end

function var_0_0.checkTalentReddotShow(arg_34_0, arg_34_1)
	arg_34_1:defaultRefreshDot()

	local var_34_0 = arg_34_0.baseSpotTalentId or arg_34_0.newTalentId or Season166Model.getPrefsTalent()

	if not var_34_0 and not arg_34_1.show then
		arg_34_1.show = Season166Model.instance:checkAllHasNewTalent(arg_34_0.actId)

		arg_34_1:showRedDot(RedDotEnum.Style.Green)

		return
	end

	arg_34_1.show = Season166Model.instance:checkHasNewTalent(var_34_0)

	if arg_34_1.show then
		arg_34_1:showRedDot(RedDotEnum.Style.Green)
	end
end

function var_0_0.checkOneActivityIsEnd(arg_35_0)
	local var_35_0, var_35_1 = Season166Controller.instance:getSeasonEnterCloseTimeStamp(arg_35_0.actId)

	if var_35_0 == 0 or var_35_1 <= 0 then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
	end
end

function var_0_0.onClose(arg_36_0)
	if arg_36_0._dragEffectLoader then
		arg_36_0._dragEffectLoader:dispose()

		arg_36_0._dragEffectLoader = nil
	end
end

function var_0_0.onDestroyView(arg_37_0)
	Season166HeroGroupController.instance:onCloseViewCleanData()
	UIBlockMgr.instance:endBlock(var_0_0.UIBlock_SeasonFight)
end

return var_0_0
