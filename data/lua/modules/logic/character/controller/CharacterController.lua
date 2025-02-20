module("modules.logic.character.controller.CharacterController", package.seeall)

slot0 = class("CharacterController", BaseController)

function slot0.onInit(slot0)
	slot0._statTalentInfo = nil
end

function slot0.reInit(slot0)
	slot0._statTalentInfo = nil
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0:registerCallback(CharacterEvent.characterFirstToShow, slot0._onCharacterFirstToShow, slot0)
end

function slot0._onCharacterFirstToShow(slot0, slot1)
	CharacterBackpackCardListModel.instance:setFirstShowCharacter(tonumber(slot1))
end

function slot0.openCharacterView(slot0, slot1, slot2, slot3)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Role) then
		CharacterBackpackCardListModel.instance:setCharacterViewDragMOList(slot2)

		CharacterView._externalParam = slot3

		ViewMgr.instance:openView(ViewName.CharacterView, slot1)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Role))
	end
end

function slot0.openCharacterTalentView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterTalentView, slot1)
end

function slot0.openCharacterTalentChessView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterTalentChessView, slot1)
end

function slot0.openCharacterTalentLevelUpView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpView, slot1)
end

function slot0.openCharacterTalentLevelUpResultView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpResultView, slot1)
end

function slot0.openCharacterTalentTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterTalentTipView, slot1)
end

function slot0.openCharacterTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterTipView, slot1)
end

function slot0.openCharacterSkinView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterSkinView, slot1)
end

function slot0.openCharacterSkinTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterSkinTipView, slot1)
end

function slot0.openCharacterSkinGainView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterSkinGainView, slot1)
end

function slot0.openCharacterLevelUpView(slot0, slot1, slot2)
	if slot2 == ViewName.HeroGroupEditView then
		ViewMgr.instance:getSetting(ViewName.CharacterLevelUpView).anim = ViewAnim.CharacterLevelUpView2
	else
		slot3.anim = ViewAnim.CharacterLevelUpView
	end

	ViewMgr.instance:openView(ViewName.CharacterLevelUpView, {
		heroMO = slot1,
		enterViewName = slot2
	})
end

function slot0.openCharacterRankUpView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterRankUpView, slot1)
end

function slot0.openCharacterRankUpResultView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterRankUpResultView, slot1)
end

function slot0.openCharacterSkinFullScreenView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.CharacterSkinFullScreenView, {
		skinCo = slot1,
		showEnum = slot3 or CharacterEnum.ShowSkinEnum.Static
	}, slot2)
end

function slot0.openCharacterDataView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterDataView, slot1)
end

function slot0.openCharacterExSkillView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterExSkillView, slot1)
end

function slot0.openCharacterGetView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterGetView, slot1)
end

function slot0.openCharacterSkinGetDetailView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterSkinGetDetailView, slot1)
end

function slot0.openCharacterTalentStyleView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterTalentStyleView, slot1)
end

function slot0.openCharacterTalentStatView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterTalentStatView, slot1)
end

function slot0.enterCharacterBackpack(slot0, slot1)
	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1.533)
	ViewMgr.instance:openView(ViewName.CharacterBackpackView, {
		jumpTab = slot1
	})
end

function slot0.openCharacterSwitchView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.CharacterSwitchView, slot1, slot2)
end

function slot0.openCharacterFilterView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.CharacterBackpackSearchFilterView, slot1)
end

function slot0.playRoleVoice(slot0, slot1)
	if HeroModel.instance:getVoiceConfig(slot1, CharacterEnum.VoiceType.MainViewNoInteraction) and #slot2 > 0 then
		AudioMgr.instance:trigger(slot2[1].audio)
	end
end

function slot0.SetAttriIcon(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setCommonSprite(slot1, "icon_att_" .. tostring(slot2))

	gohelper.onceAddComponent(slot1.gameObject, typeof(UnityEngine.UI.Image)).color = slot3 or CharacterEnum.AttrLightColor
end

function slot0.dailyRefresh(slot0)
	HeroRpc.instance:sendHeroInfoListRequest()
end

function slot0.statCharacterData(slot0, slot1, slot2, slot3, slot4, slot5)
	if not HeroConfig.instance:getHeroCO(slot2) then
		return
	end

	if slot1 == StatEnum.EventName.PlayerVoice then
		slot12, slot13, slot14 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot2)
		slot15 = GameConfig:GetCurVoiceShortcut()
	elseif slot1 == StatEnum.EventName.ReadHeroItem then
		-- Nothing
	elseif slot1 == StatEnum.EventName.ReadHeroCulture then
		slot11[StatEnum.EventProperties.CultureId] = tostring(slot3 or "")
	end

	if slot4 then
		slot11[StatEnum.EventProperties.Time] = slot4
	end

	StatController.instance:track(slot1, {
		[StatEnum.EventProperties.HeroId] = tonumber(slot2),
		[StatEnum.EventProperties.HeroName] = slot6.name,
		[StatEnum.EventProperties.Faith] = HeroConfig.instance:getFaithPercent(HeroModel.instance:getByHeroId(slot2) and slot7.faith or 0) and slot9[1] * 100 or 0,
		[StatEnum.EventProperties.Entrance] = slot5 and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal"),
		[StatEnum.EventProperties.VoiceId] = tostring(slot3 or ""),
		[StatEnum.EventProperties.CharVoiceLang] = slot14 and slot15 or slot13,
		[StatEnum.EventProperties.GlobalVoiceLang] = slot15
	})
end

function slot0.statCharacterSkinVideoData(slot0, slot1, slot2, slot3, slot4)
	StatController.instance:track(StatEnum.EventName.ClickSkinVideoInlet, {
		[StatEnum.EventProperties.HeroId] = slot1,
		[StatEnum.EventProperties.HeroName] = slot2,
		[StatEnum.EventProperties.skinId] = slot3,
		[StatEnum.EventProperties.skinName] = slot4
	})
end

function slot0.showCharacterGetToast(slot0, slot1, slot2)
	slot3 = HeroConfig.instance:getHeroCO(slot1)
	slot4 = {}
	slot5 = nil

	if not string.nilorempty((slot2 > 0 or slot3.firstItem) and (slot2 < CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount) - 1 or slot3.duplicateItem2) and slot3.duplicateItem) then
		for slot10, slot11 in ipairs(string.split(slot5, "|")) do
			slot12 = string.splitToNumber(slot11, "#")
			slot17, slot18 = ItemModel.instance:getItemConfigAndIcon(slot12[1], slot12[2])

			table.insert(slot4, {
				icon = slot18,
				config = slot17,
				quantity = slot12[3],
				desc = slot2 <= 0 and luaLang("character_first_tips") or luaLang("character_duplicate_tips")
			})
		end
	end

	slot6, slot7 = nil

	if GameConfig:GetCurLangType() == LangSettings.en then
		slot6 = "\n"
		slot7 = " "
	elseif GameConfig:GetCurLangType() == LangSettings.kr then
		slot6 = " "
		slot7 = ""
	else
		slot6 = ""
		slot7 = ""
	end

	for slot11, slot12 in ipairs(slot4) do
		slot14 = string.format("%s%s%s\n%s%s%s%s", slot12.desc, slot6, slot3.name, slot12.config.name, slot7, luaLang("multiple"), slot12.quantity)

		if GameConfig:GetCurLangType() == LangSettings.jp and slot2 > 0 then
			slot14 = string.format("%s%s\n%s%s%s", slot3.name, slot12.desc, slot12.config.name, luaLang("multiple"), slot12.quantity)
		end

		GameFacade.showToastWithIcon(ToastEnum.IconId, slot12.icon, slot14)
	end
end

function slot0.showCharacterGetTicket(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, slot2)
	slot5 = HeroConfig.instance:getHeroCO(slot1)

	GameFacade.showToastWithIcon(ToastEnum.IconId, slot4, string.format(luaLang("summon_limit_ticket_gain"), slot3.name))
end

function slot0.setTalentHeroId(slot0, slot1)
	slot0._talentHeroId = slot1
end

function slot0.getTalentHeroId(slot0)
	return slot0._talentHeroId
end

function slot0.statTalentStart(slot0, slot1)
	slot0._statTalentInfo = slot0:getStatTalentInfo(slot1)
end

function slot0.getStatTalentInfo(slot0, slot1)
	slot2 = {}

	if not (HeroModel.instance:getByHeroId(slot1) and slot3.talentCubeInfos) then
		return nil
	end

	slot2.heroId = slot1
	slot2.talent = slot3.talent
	slot2.dataDict = {}

	for slot8, slot9 in ipairs(slot4.data_list) do
		if slot9.cubeId == slot4.own_main_cube_id then
			slot10 = slot3:getHeroUseStyleCubeId()
		end

		slot2.dataDict[string.format("%d_%d_%d_%d", slot10, slot9.direction, slot9.posX, slot9.posY)] = true
	end

	return slot2
end

function slot0.hasStatTalentInfoChanged(slot0, slot1, slot2)
	if slot1.talent ~= slot2.talent then
		return true
	end

	for slot6, slot7 in pairs(slot1.dataDict) do
		if not slot2.dataDict[slot6] then
			return true
		end
	end

	for slot6, slot7 in pairs(slot2.dataDict) do
		if not slot1.dataDict[slot6] then
			return true
		end
	end

	return false
end

function slot0.statTalentEnd(slot0, slot1)
	slot0._statTalentInfo = nil

	if not slot0._statTalentInfo or slot2.heroId ~= slot1 then
		return
	end

	if not slot0:getStatTalentInfo(slot1) then
		return
	end

	if not slot0:hasStatTalentInfoChanged(slot2, slot3) then
		return
	end

	slot0:stateTalent(slot1)
end

function slot0.stateTalent(slot0, slot1)
	if not HeroModel.instance:getByHeroId(slot1) then
		return
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot2.talentCubeInfos.own_cube_dic) do
		if slot9.id == slot3.own_main_cube_id then
			slot10 = slot2:getHeroUseStyleCubeId()
		end

		table.insert(slot4, {
			ruens_id = slot10,
			ruens_num = slot9.use,
			ruens_hold_num = slot9.own + slot9.use
		})
	end

	slot5 = {}

	for slot9, slot10 in ipairs(slot3.data_list) do
		if slot10.cubeId == slot3.own_main_cube_id then
			slot11 = slot2:getHeroUseStyleCubeId()
		end

		table.insert(slot5, slot11)
	end

	StatController.instance:track(StatEnum.EventName.TalentRuensPreserve, {
		[StatEnum.EventProperties.HeroName] = slot2.config.name,
		[StatEnum.EventProperties.TalentLevel] = slot2.talent,
		[StatEnum.EventProperties.RuensStateArray] = slot4,
		[StatEnum.EventProperties.RuensStateGroup] = slot5
	})
end

function slot0.tryStatAllTalent(slot0)
	for slot5, slot6 in ipairs(HeroModel.instance:getList()) do
		if CharacterEnum.TalentRank <= slot6.rank then
			slot0:stateTalent(slot6.heroId)
		end
	end
end

function slot0.trackInteractiveSkinDetails(slot0, slot1, slot2, slot3)
	if not HeroConfig.instance:getHeroCO(slot1) then
		return
	end

	if not SkinConfig.instance:getSkinCo(slot2) then
		return
	end

	StatController.instance:track(StatEnum.EventName.InteractiveSkinDetails, {
		[StatEnum.EventProperties.HeroId] = tonumber(slot1),
		[StatEnum.EventProperties.HeroName] = slot4.name,
		[StatEnum.EventProperties.skinId] = slot2,
		[StatEnum.EventProperties.skinName] = slot5.characterSkin,
		[StatEnum.EventProperties.clickType] = slot3
	})
end

slot0.instance = slot0.New()

return slot0
