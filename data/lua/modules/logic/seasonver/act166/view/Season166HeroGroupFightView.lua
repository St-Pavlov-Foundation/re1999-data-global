module("modules.logic.seasonver.act166.view.Season166HeroGroupFightView", package.seeall)

slot0 = class("Season166HeroGroupFightView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnassist = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/horizontal/#btn_assist")
	slot0._goassist = gohelper.findChild(slot0.viewGO, "btnContain/horizontal/#btn_assist/#go_assist")
	slot0._gocancelAssist = gohelper.findChild(slot0.viewGO, "btnContain/horizontal/#btn_assist/#go_cancelAssist")
	slot0._gofullAssist = gohelper.findChild(slot0.viewGO, "btnContain/horizontal/#btn_assist/#go_fullAssist")
	slot0._btnstartseason = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/horizontal/#btn_startseason")
	slot0._btncloth = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/#btn_cloth")
	slot0._txtclothName = gohelper.findChildText(slot0.viewGO, "btnContain/#btn_cloth/#txt_clothName")
	slot0._txtclothNameEn = gohelper.findChildText(slot0.viewGO, "btnContain/#btn_cloth/#txt_clothName/#txt_clothNameEn")
	slot0._btntalentTree = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/#btn_talentTree")
	slot0._btntalentTreeAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/#btn_talentTreeAdd")
	slot0._imageTalent = gohelper.findChildImage(slot0.viewGO, "btnContain/#btn_talentTree/#image_talen")
	slot0._goEquipSlot = gohelper.findChild(slot0.viewGO, "btnContain/#btn_talentTree/equipslot")
	slot0._gotalentReddot = gohelper.findChild(slot0.viewGO, "btnContain/#btn_talentTree/#go_talentReddot")
	slot0._gomainFrameBg = gohelper.findChild(slot0.viewGO, "frame/#go_mainFrameBg")
	slot0._gohelpFrameBg = gohelper.findChild(slot0.viewGO, "frame/#go_helpFrameBg")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")
	slot0._goruleWindow = gohelper.findChild(slot0.viewGO, "#go_rulewindow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnassist:AddClickListener(slot0._btnassistOnClick, slot0)
	slot0._btnstartseason:AddClickListener(slot0._btnstartseasonOnClick, slot0)
	slot0._btncloth:AddClickListener(slot0._btnclothOnClick, slot0)
	slot0._btntalentTree:AddClickListener(slot0._btntalentTreeOnClick, slot0)
	slot0._btntalentTreeAdd:AddClickListener(slot0._btntalentTreeOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._onModifyHeroGroup, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, slot0._onClickHeroGroupItem, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, slot0._showGuideDragEffect, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.StartFightFailed, slot0.handleStartFightFailed, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnSelectPickAssist, slot0.refreshAssistBtn, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0.refreshAssistBtn, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.SetTalentId, slot0._onTalentChange, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, slot0._onTalentSkillChange, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.checkOneActivityIsEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnassist:RemoveClickListener()
	slot0._btnstartseason:RemoveClickListener()
	slot0._btncloth:RemoveClickListener()
	slot0._btntalentTree:RemoveClickListener()
	slot0._btntalentTreeAdd:RemoveClickListener()
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._onModifyHeroGroup, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, slot0._onClickHeroGroupItem, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, slot0._showGuideDragEffect, slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.StartFightFailed, slot0.handleStartFightFailed, slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.OnSelectPickAssist, slot0.refreshAssistBtn, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0.refreshAssistBtn, slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.SetTalentId, slot0._onTalentChange, slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, slot0._onTalentSkillChange, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.checkOneActivityIsEnd, slot0)
end

function slot0._btnassistOnClick(slot0)
	if slot0.assistMO then
		Season166HeroGroupModel.instance:cleanAssistData()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	elseif slot0.isFullHero then
		GameFacade.showToast(ToastEnum.Season166HeroGroupFull)
	elseif not slot0.isHasAssist then
		Season166Controller.instance:dispatchEvent(Season166Event.OpenPickAssistView)
	end
end

slot0.UIBlock_SeasonFight = "UIBlock_Season166Fight"

function slot0._btnstartseasonOnClick(slot0)
	if not slot0._blockStart then
		slot0._blockStart = true

		slot0:_onClickStart()
	end
end

function slot0._btnclothOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView, {
			groupModel = Season166HeroGroupModel.instance
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function slot0._btntalentTreeOnClick(slot0)
	slot1 = nil

	if Season166HeroGroupModel.instance:isSeason166BaseSpotEpisode(slot0.episodeId) then
		slot1 = slot0.baseSpotTalentId
	end

	ViewMgr.instance:openView(ViewName.Season166TalentView, {
		showEquip = true,
		talentId = slot1
	})
end

function slot0._onEscapeBtnClick(slot0)
	if not slot0._goruleWindow.activeInHierarchy then
		slot0.viewContainer:_closeCallback()
	end
end

function slot0._editableInitView(slot0)
	NavigateMgr.instance:addEscape(ViewName.Season166HeroGroupFightView, slot0._onEscapeBtnClick, slot0)

	slot0._iconGO = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._btncloth.gameObject)
	slot4 = 1

	recthelper.setAnchor(slot0._iconGO.transform, -100, slot4)

	slot0.talentSlotTab = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = {
			item = gohelper.findChild(slot0._goEquipSlot, slot4)
		}
		slot5.light = gohelper.findChild(slot5.item, "light")
		slot5.imageLight = gohelper.findChildImage(slot5.item, "light")
		slot5.lineLight = gohelper.findChild(slot5.item, "line_light")
		slot5.lineDark = gohelper.findChild(slot5.item, "line_dark")
		slot5.effect1 = gohelper.findChild(slot5.item, "light/qi1")
		slot5.effect2 = gohelper.findChild(slot5.item, "light/qi2")
		slot5.effect3 = gohelper.findChild(slot5.item, "light/qi3")
		slot0.talentSlotTab[slot4] = slot5
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:initData()
	slot0:_checkFirstPosHasEquip()
	slot0:_checkEquipClothSkill()
	slot0:refreshUI()
	slot0:refreshTalent()
	slot0:refreshTalentReddot()
end

function slot0.initData(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.episodeId = slot0.viewParam.episodeId or Season166HeroGroupModel.instance.episodeId
	slot0.episodeConfig = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
	slot0.battleId = slot0.viewParam.battleId or slot0.episodeConfig.battleId
	slot0.battleConfig = slot0.battleId and lua_battle.configDict[slot0.episodeConfig.battleId]

	Season166HeroGroupController.instance:onOpenViewInitData(slot0.actId, slot0.episodeId)

	slot0.maxHeroCount = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()
	slot0.isTrainEpisode = Season166HeroGroupModel.instance:isSeason166TrainEpisode(slot0.episodeId)
	slot0.baseSpotTalentId = slot0:getBaseSpotTalentId()
end

function slot0.getBaseSpotTalentId(slot0)
	slot1 = nil

	for slot6, slot7 in pairs(lua_activity166_base.configList) do
		if slot7.episodeId == slot0.episodeId then
			slot1 = slot7.talentId
		end
	end

	return slot1
end

function slot0.refreshUI(slot0)
	slot0:refreshCloth()
	slot0:refreshAssistBtn()

	slot0.context = Season166Model.instance:getBattleContext()

	gohelper.setActive(slot0._btntalentTree.gameObject, not slot0.context.teachId)
end

function slot0.refreshCloth(slot0)
	slot1 = slot0:getShowClothState()

	gohelper.setActive(slot0._btncloth.gameObject, slot1)

	if not slot1 then
		return
	end

	slot4 = PlayerClothModel.instance:getById(Season166HeroGroupModel.instance:getCurGroupMO().clothId)

	gohelper.setActive(slot0._txtclothName.gameObject, slot4)

	if slot4 then
		slot5 = lua_cloth.configDict[slot4.clothId]
		slot6 = slot4.level or 0
		slot0._txtclothName.text = slot5.name
		slot0._txtclothNameEn.text = slot5.enname
	end

	for slot8, slot9 in ipairs(lua_cloth.configList) do
		if not gohelper.isNil(gohelper.findChild(slot0._iconGO, tostring(slot9.id))) then
			gohelper.setActive(slot10, slot9.id == slot3)
		end
	end
end

function slot0.refreshAssistBtn(slot0)
	gohelper.setActive(slot0._btnassist.gameObject, slot0.isTrainEpisode)

	if not slot0.isTrainEpisode then
		return
	end

	slot0.isFullHero = slot0:getCurHeroCount() == slot0.maxHeroCount
	slot0.assistMO = Season166HeroSingleGroupModel.instance.assistMO

	gohelper.setActive(slot0._goassist, not slot0.assistMO and not slot0.isFullHero)
	gohelper.setActive(slot0._gocancelAssist, slot0.assistMO)
	gohelper.setActive(slot0._gofullAssist, not slot0.assistMO and slot0.isFullHero)
end

function slot0.getCurHeroCount(slot0)
	for slot7, slot8 in ipairs(Season166HeroGroupModel.instance:getCurGroupMO().heroList) do
		if slot8 ~= "0" then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getShowClothState(slot0)
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	if slot0.battleConfig and slot0.battleConfig.noClothSkill == 1 then
		return false
	end

	return tabletool.len(PlayerClothModel.instance:getList()) > 0
end

function slot0._onClickStart(slot0)
	if Season166HeroGroupModel.instance.episodeId == 10104 and not DungeonModel.instance:hasPassLevel(slot1) then
		for slot7, slot8 in ipairs(Season166HeroSingleGroupModel.instance:getList()) do
			if not slot8:isEmpty() then
				slot3 = 0 + 1
			end
		end

		if slot3 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			slot0._blockStart = false

			return
		end
	end

	slot0:_enterFight()
end

function slot0._enterFight(slot0)
	if not Season166Model.instance:getBattleContext().talentId then
		GameFacade.showToast(ToastEnum.Season166TalentEmpty)

		slot0._blockStart = false

		return
	end

	if Season166HeroGroupModel.instance.episodeId then
		if slot0:setFightHeroGroup() then
			UIBlockMgr.instance:startBlock(uv0.UIBlock_SeasonFight)

			slot4 = FightModel.instance:getFightParam()

			Season166HeroGroupController.instance:sendStartAct166Battle(Season166HeroGroupModel.instance:getEpisodeConfigId(slot4.episodeId), slot4.chapterId, slot4.episodeId, slot2, slot4, 1)
		end
	else
		logError("没选中关卡，无法开始战斗")

		slot0._blockStart = false
	end
end

function slot0.setFightHeroGroup(slot0)
	if not FightModel.instance:getFightParam() then
		return false
	end

	if not Season166HeroGroupModel.instance:getCurGroupMO() then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		slot0._blockStart = false

		return false
	end

	slot3, slot4 = slot2:getMainList()
	slot5, slot6 = slot2:getSubList()
	slot7 = Season166HeroSingleGroupModel.instance:getList()
	slot8 = slot2:getAllHeroEquips()

	for slot12 = 1, #slot3 do
		if slot3[slot12] ~= slot7[slot12].heroUid then
			slot3[slot12] = "0"
			slot4 = slot4 - 1

			if slot8[slot12] then
				slot8[slot12].heroUid = "0"
			end
		end
	end

	slot12 = #slot7

	for slot12 = #slot3 + 1, math.min(#slot3 + #slot5, slot12) do
		if slot5[slot12 - #slot3] ~= slot7[slot12].heroUid then
			slot5[slot12 - #slot3] = "0"
			slot6 = slot6 - 1

			if slot8[slot12] then
				slot8[slot12].heroUid = "0"
			end
		end
	end

	if (not slot2.aidDict or #slot2.aidDict <= 0) and slot4 + slot6 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		slot0._blockStart = false

		return false
	end

	slot10 = slot1.battleId and lua_battle.configDict[slot9]

	slot1:setMySide(slot10 and slot10.noClothSkill == 0 and slot2.clothId or 0, slot3, slot5, slot2:getAllHeroEquips())

	return true
end

function slot0._checkFirstPosHasEquip(slot0)
	if not Season166HeroGroupModel.instance:getCurGroupMO() then
		return
	end

	slot3 = slot1:getPosEquips(0).equipUid and slot2[1]

	if slot3 and EquipModel.instance:getEquip(slot3) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function slot0._checkEquipClothSkill(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	if PlayerClothModel.instance:getById(Season166HeroGroupModel.instance:getCurGroupMO().clothId) then
		return
	end

	for slot6, slot7 in ipairs(PlayerClothModel.instance:getList()) do
		if PlayerClothModel.instance:hasCloth(slot7.id) then
			Season166HeroGroupModel.instance:replaceCloth(slot7.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			Season166HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function slot0._onOpenFullView(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.EquipInfoTeamShowView then
		slot0:_checkFirstPosHasEquip()
	end

	if slot1 == ViewName.Season166TalentView then
		slot0:refreshTalentReddot()
	end
end

function slot0._onModifyHeroGroup(slot0)
	slot0:refreshCloth()
	slot0:refreshAssistBtn()
end

function slot0._onClickHeroGroupItem(slot0, slot1)
	slot0._param = tabletool.copy(slot0.viewParam)
	slot0._param.singleGroupMOId = slot1
	slot0._param.originalHeroUid = Season166HeroSingleGroupModel.instance:getHeroUid(slot1)
	slot0._param.equips = Season166HeroGroupModel.instance:getCurGroupMO():getPosEquips(slot1 - 1).equipUid

	ViewMgr.instance:openView(ViewName.Season166HeroGroupEditView, slot0._param)
end

function slot0._showGuideDragEffect(slot0, slot1)
	if slot0._dragEffectLoader then
		slot0._dragEffectLoader:dispose()

		slot0._dragEffectLoader = nil
	end

	if tonumber(slot1) == 1 then
		slot0._dragEffectLoader = PrefabInstantiate.Create(slot0.viewGO)

		slot0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function slot0.handleStartFightFailed(slot0)
	slot0._blockStart = false

	UIBlockMgr.instance:endBlock(uv0.UIBlock_SeasonFight)
end

function slot0._onTalentChange(slot0, slot1)
	if Season166Model.instance:getBattleContext() then
		slot2.talentId = slot1
		slot0.newTalentId = slot1

		slot0:_onTalentSkillChange()
	end
end

function slot0._onTalentSkillChange(slot0)
	slot0:refreshTalentReddot()
	slot0:refreshTalent()
end

function slot0.refreshTalent(slot0)
	if not (slot0.baseSpotTalentId or slot0.newTalentId or Season166Model.getPrefsTalent()) then
		gohelper.setActive(slot0._btntalentTreeAdd.gameObject, not slot0.context.teachId)
		gohelper.setActive(slot0._btntalentTree.gameObject, false)

		return
	end

	gohelper.setActive(slot0._btntalentTreeAdd.gameObject, false)
	gohelper.setActive(slot0._btntalentTree.gameObject, not slot0.context.teachId)

	slot2 = Season166Model.instance:getTalentInfo(slot0.actId, slot1)

	UISpriteSetMgr.instance:setSeason166Sprite(slot0._imageTalent, "season166_talentree_btn_talen" .. lua_activity166_talent.configDict[slot0.actId][slot2.config.talentId].sortIndex, true)

	slot6 = #slot2.skillIds

	for slot10, slot11 in ipairs(slot0.talentSlotTab) do
		gohelper.setActive(slot11.item, slot10 <= slot2.config.slot)
		gohelper.setActive(slot11.light, slot10 <= slot6)
		gohelper.setActive(slot11.lineLight, slot10 > 1 and slot10 <= slot6)
		gohelper.setActive(slot11.lineDark, slot10 > 1 and slot6 < slot10)
		UISpriteSetMgr.instance:setSeason166Sprite(slot11.imageLight, "season166_talentree_pointl" .. tostring(slot4.sortIndex))

		for slot15 = 1, 3 do
			gohelper.setActive(slot11["effect" .. slot15], slot4.sortIndex == slot15)
		end
	end
end

function slot0.refreshTalentReddot(slot0)
	RedDotController.instance:addRedDot(slot0._gotalentReddot, RedDotEnum.DotNode.Season166TalentEnter, nil, slot0.checkTalentReddotShow, slot0)
end

function slot0.checkTalentReddotShow(slot0, slot1)
	slot1:defaultRefreshDot()

	if not (slot0.baseSpotTalentId or slot0.newTalentId or Season166Model.getPrefsTalent()) and not slot1.show then
		slot1.show = Season166Model.instance:checkAllHasNewTalent(slot0.actId)

		slot1:showRedDot(RedDotEnum.Style.Green)

		return
	end

	slot1.show = Season166Model.instance:checkHasNewTalent(slot2)

	if slot1.show then
		slot1:showRedDot(RedDotEnum.Style.Green)
	end
end

function slot0.checkOneActivityIsEnd(slot0)
	slot1, slot2 = Season166Controller.instance:getSeasonEnterCloseTimeStamp(slot0.actId)

	if slot1 == 0 or slot2 <= 0 then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
	end
end

function slot0.onClose(slot0)
	if slot0._dragEffectLoader then
		slot0._dragEffectLoader:dispose()

		slot0._dragEffectLoader = nil
	end
end

function slot0.onDestroyView(slot0)
	Season166HeroGroupController.instance:onCloseViewCleanData()
	UIBlockMgr.instance:endBlock(uv0.UIBlock_SeasonFight)
end

return slot0
