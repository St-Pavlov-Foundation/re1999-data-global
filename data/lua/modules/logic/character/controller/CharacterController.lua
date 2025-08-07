module("modules.logic.character.controller.CharacterController", package.seeall)

local var_0_0 = class("CharacterController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._statTalentInfo = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._statTalentInfo = nil
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_4_0.dailyRefresh, arg_4_0)
	arg_4_0:registerCallback(CharacterEvent.characterFirstToShow, arg_4_0._onCharacterFirstToShow, arg_4_0)
end

function var_0_0._onCharacterFirstToShow(arg_5_0, arg_5_1)
	CharacterBackpackCardListModel.instance:setFirstShowCharacter(tonumber(arg_5_1))
end

function var_0_0.openCharacterView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Role) then
		CharacterBackpackCardListModel.instance:setCharacterViewDragMOList(arg_6_2)

		CharacterView._externalParam = arg_6_3

		ViewMgr.instance:openView(ViewName.CharacterView, arg_6_1)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Role))
	end
end

function var_0_0.openCharacterTalentView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.CharacterTalentView, arg_7_1)
end

function var_0_0.openCharacterTalentChessView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.CharacterTalentChessView, arg_8_1)
end

function var_0_0.openCharacterTalentLevelUpView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpView, arg_9_1)
end

function var_0_0.openCharacterTalentLevelUpResultView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpResultView, arg_10_1)
end

function var_0_0.openCharacterTalentTipView(arg_11_0, arg_11_1)
	ViewMgr.instance:openView(ViewName.CharacterTalentTipView, arg_11_1)
end

function var_0_0.openCharacterTipView(arg_12_0, arg_12_1)
	ViewMgr.instance:openView(ViewName.CharacterTipView, arg_12_1)
end

function var_0_0.openCharacterSkinView(arg_13_0, arg_13_1)
	ViewMgr.instance:openView(ViewName.CharacterSkinView, arg_13_1)
end

function var_0_0.openCharacterSkinTipView(arg_14_0, arg_14_1)
	ViewMgr.instance:openView(ViewName.CharacterSkinTipView, arg_14_1)
end

function var_0_0.openCharacterSkinGainView(arg_15_0, arg_15_1)
	ViewMgr.instance:openView(ViewName.CharacterSkinGainView, arg_15_1)
end

function var_0_0.openCharacterLevelUpView(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = ViewMgr.instance:getSetting(ViewName.CharacterLevelUpView)

	if arg_16_2 == ViewName.HeroGroupEditView then
		var_16_0.anim = ViewAnim.CharacterLevelUpView2
	else
		var_16_0.anim = ViewAnim.CharacterLevelUpView
	end

	ViewMgr.instance:openView(ViewName.CharacterLevelUpView, {
		heroMO = arg_16_1,
		enterViewName = arg_16_2
	})
end

function var_0_0.openCharacterRankUpView(arg_17_0, arg_17_1)
	ViewMgr.instance:openView(ViewName.CharacterRankUpView, arg_17_1)
end

function var_0_0.openCharacterRankUpResultView(arg_18_0, arg_18_1)
	ViewMgr.instance:openView(ViewName.CharacterRankUpResultView, arg_18_1)
end

function var_0_0.openCharacterSkinFullScreenView(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	ViewMgr.instance:openView(ViewName.CharacterSkinFullScreenView, {
		skinCo = arg_19_1,
		showEnum = arg_19_3 or CharacterEnum.ShowSkinEnum.Static
	}, arg_19_2)
end

function var_0_0.openCharacterDataView(arg_20_0, arg_20_1)
	ViewMgr.instance:openView(ViewName.CharacterDataView, arg_20_1)
end

function var_0_0.openCharacterExSkillView(arg_21_0, arg_21_1)
	ViewMgr.instance:openView(ViewName.CharacterExSkillView, arg_21_1)
end

function var_0_0.openCharacterGetView(arg_22_0, arg_22_1)
	ViewMgr.instance:openView(ViewName.CharacterGetView, arg_22_1)
end

function var_0_0.openCharacterSkinGetDetailView(arg_23_0, arg_23_1)
	ViewMgr.instance:openView(ViewName.CharacterSkinGetDetailView, arg_23_1)
end

function var_0_0.openCharacterTalentStyleView(arg_24_0, arg_24_1)
	ViewMgr.instance:openView(ViewName.CharacterTalentStyleView, arg_24_1)
end

function var_0_0.openCharacterTalentStatView(arg_25_0, arg_25_1)
	ViewMgr.instance:openView(ViewName.CharacterTalentStatView, arg_25_1)
end

function var_0_0.openCharacterSkillTalentView(arg_26_0, arg_26_1)
	if arg_26_1.trialCo then
		OdysseyTalentModel.instance:setTrialCassandraTreeInfo()
		ViewMgr.instance:openView(ViewName.OdysseyTrialCharacterTalentView, arg_26_1)
	else
		ViewMgr.instance:openView(ViewName.CharacterSkillTalentView, arg_26_1)
	end
end

function var_0_0.openCharacterWeaponView(arg_27_0, arg_27_1)
	ViewMgr.instance:openView(ViewName.CharacterWeaponView, arg_27_1)
end

function var_0_0.openCharacterWeaponEffectView(arg_28_0, arg_28_1)
	ViewMgr.instance:openView(ViewName.CharacterWeaponEffectView, arg_28_1)
end

function var_0_0.enterCharacterBackpack(arg_29_0, arg_29_1)
	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1.533)

	local var_29_0 = {
		jumpTab = arg_29_1
	}

	ViewMgr.instance:openView(ViewName.CharacterBackpackView, var_29_0)
end

function var_0_0.openCharacterSwitchView(arg_30_0, arg_30_1, arg_30_2)
	ViewMgr.instance:openView(ViewName.CharacterSwitchView, arg_30_1, arg_30_2)
end

function var_0_0.openCharacterFilterView(arg_31_0, arg_31_1)
	ViewMgr.instance:openView(ViewName.CharacterBackpackSearchFilterView, arg_31_1)
end

function var_0_0.playRoleVoice(arg_32_0, arg_32_1)
	local var_32_0 = HeroModel.instance:getVoiceConfig(arg_32_1, CharacterEnum.VoiceType.MainViewNoInteraction)

	if var_32_0 and #var_32_0 > 0 then
		local var_32_1 = var_32_0[1].audio

		AudioMgr.instance:trigger(var_32_1)
	end
end

function var_0_0.SetAttriIcon(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	UISpriteSetMgr.instance:setCommonSprite(arg_33_1, "icon_att_" .. tostring(arg_33_2))

	gohelper.onceAddComponent(arg_33_1.gameObject, typeof(UnityEngine.UI.Image)).color = arg_33_3 or CharacterEnum.AttrLightColor
end

function var_0_0.dailyRefresh(arg_34_0)
	HeroRpc.instance:sendHeroInfoListRequest()
end

function var_0_0.statCharacterData(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5)
	local var_35_0 = HeroConfig.instance:getHeroCO(arg_35_2)

	if not var_35_0 then
		return
	end

	local var_35_1 = HeroModel.instance:getByHeroId(arg_35_2)
	local var_35_2 = var_35_1 and var_35_1.faith or 0
	local var_35_3 = HeroConfig.instance:getFaithPercent(var_35_2)
	local var_35_4 = var_35_3 and var_35_3[1] * 100 or 0
	local var_35_5 = {
		[StatEnum.EventProperties.HeroId] = tonumber(arg_35_2),
		[StatEnum.EventProperties.HeroName] = var_35_0.name,
		[StatEnum.EventProperties.Faith] = var_35_4,
		[StatEnum.EventProperties.Entrance] = arg_35_5 and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal")
	}

	if arg_35_1 == StatEnum.EventName.PlayerVoice then
		local var_35_6, var_35_7, var_35_8 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(arg_35_2)
		local var_35_9 = GameConfig:GetCurVoiceShortcut()

		var_35_5[StatEnum.EventProperties.VoiceId] = tostring(arg_35_3 or "")
		var_35_5[StatEnum.EventProperties.CharVoiceLang] = var_35_8 and var_35_9 or var_35_7
		var_35_5[StatEnum.EventProperties.GlobalVoiceLang] = var_35_9
	elseif arg_35_1 == StatEnum.EventName.ReadHeroItem then
		-- block empty
	elseif arg_35_1 == StatEnum.EventName.ReadHeroCulture then
		var_35_5[StatEnum.EventProperties.CultureId] = tostring(arg_35_3 or "")
	end

	if arg_35_4 then
		var_35_5[StatEnum.EventProperties.Time] = arg_35_4
	end

	StatController.instance:track(arg_35_1, var_35_5)
end

function var_0_0.statCharacterSkinVideoData(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = StatEnum.EventName.ClickSkinVideoInlet
	local var_36_1 = {
		[StatEnum.EventProperties.HeroId] = arg_36_1,
		[StatEnum.EventProperties.HeroName] = arg_36_2,
		[StatEnum.EventProperties.skinId] = arg_36_3,
		[StatEnum.EventProperties.skinName] = arg_36_4
	}

	StatController.instance:track(var_36_0, var_36_1)
end

function var_0_0.showCharacterGetToast(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = HeroConfig.instance:getHeroCO(arg_37_1)
	local var_37_1 = {}
	local var_37_2

	if arg_37_2 <= 0 then
		var_37_2 = var_37_0.firstItem
	elseif arg_37_2 >= CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount) - 1 then
		var_37_2 = var_37_0.duplicateItem2
	else
		var_37_2 = var_37_0.duplicateItem
	end

	if not string.nilorempty(var_37_2) then
		local var_37_3 = string.split(var_37_2, "|")

		for iter_37_0, iter_37_1 in ipairs(var_37_3) do
			local var_37_4 = string.splitToNumber(iter_37_1, "#")
			local var_37_5 = var_37_4[1]
			local var_37_6 = var_37_4[2]
			local var_37_7 = var_37_4[3]
			local var_37_8 = {}

			var_37_8.config, var_37_8.icon = ItemModel.instance:getItemConfigAndIcon(var_37_5, var_37_6)
			var_37_8.quantity = var_37_7
			var_37_8.desc = arg_37_2 <= 0 and luaLang("character_first_tips") or luaLang("character_duplicate_tips")

			table.insert(var_37_1, var_37_8)
		end
	end

	local var_37_9
	local var_37_10
	local var_37_11

	if GameConfig:GetCurLangType() == LangSettings.en then
		var_37_9 = "\n"
		var_37_11 = " "
	elseif GameConfig:GetCurLangType() == LangSettings.kr then
		var_37_9 = " "
		var_37_11 = ""
	else
		var_37_9 = ""
		var_37_11 = ""
	end

	for iter_37_2, iter_37_3 in ipairs(var_37_1) do
		local var_37_12 = "%s%s%s\n%s%s%s%s"
		local var_37_13 = string.format(var_37_12, iter_37_3.desc, var_37_9, var_37_0.name, iter_37_3.config.name, var_37_11, luaLang("multiple"), iter_37_3.quantity)

		if GameConfig:GetCurLangType() == LangSettings.jp and arg_37_2 > 0 then
			var_37_13 = string.format("%s%s\n%s%s%s", var_37_0.name, iter_37_3.desc, iter_37_3.config.name, luaLang("multiple"), iter_37_3.quantity)
		end

		GameFacade.showToastWithIcon(ToastEnum.IconId, iter_37_3.icon, var_37_13)
	end
end

function var_0_0.showCharacterGetTicket(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_2 then
		return
	end

	local var_38_0, var_38_1 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, arg_38_2)
	local var_38_2 = HeroConfig.instance:getHeroCO(arg_38_1)

	GameFacade.showToastWithIcon(ToastEnum.IconId, var_38_1, string.format(luaLang("summon_limit_ticket_gain"), var_38_0.name))
end

function var_0_0.setTalentHeroId(arg_39_0, arg_39_1)
	arg_39_0._talentHeroId = arg_39_1
end

function var_0_0.getTalentHeroId(arg_40_0)
	return arg_40_0._talentHeroId
end

function var_0_0.statTalentStart(arg_41_0, arg_41_1)
	arg_41_0._statTalentInfo = arg_41_0:getStatTalentInfo(arg_41_1)
end

function var_0_0.getStatTalentInfo(arg_42_0, arg_42_1)
	local var_42_0 = {}
	local var_42_1 = HeroModel.instance:getByHeroId(arg_42_1)
	local var_42_2 = var_42_1 and var_42_1.talentCubeInfos

	if not var_42_2 then
		return nil
	end

	var_42_0.heroId = arg_42_1
	var_42_0.talent = var_42_1.talent
	var_42_0.dataDict = {}

	for iter_42_0, iter_42_1 in ipairs(var_42_2.data_list) do
		local var_42_3 = iter_42_1.cubeId

		if var_42_3 == var_42_2.own_main_cube_id then
			var_42_3 = var_42_1:getHeroUseStyleCubeId()
		end

		var_42_0.dataDict[string.format("%d_%d_%d_%d", var_42_3, iter_42_1.direction, iter_42_1.posX, iter_42_1.posY)] = true
	end

	return var_42_0
end

function var_0_0.hasStatTalentInfoChanged(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_1.talent ~= arg_43_2.talent then
		return true
	end

	for iter_43_0, iter_43_1 in pairs(arg_43_1.dataDict) do
		if not arg_43_2.dataDict[iter_43_0] then
			return true
		end
	end

	for iter_43_2, iter_43_3 in pairs(arg_43_2.dataDict) do
		if not arg_43_1.dataDict[iter_43_2] then
			return true
		end
	end

	return false
end

function var_0_0.statTalentEnd(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0._statTalentInfo

	arg_44_0._statTalentInfo = nil

	if not var_44_0 or var_44_0.heroId ~= arg_44_1 then
		return
	end

	local var_44_1 = arg_44_0:getStatTalentInfo(arg_44_1)

	if not var_44_1 then
		return
	end

	if not arg_44_0:hasStatTalentInfoChanged(var_44_0, var_44_1) then
		return
	end

	arg_44_0:stateTalent(arg_44_1)
end

function var_0_0.stateTalent(arg_45_0, arg_45_1)
	local var_45_0 = HeroModel.instance:getByHeroId(arg_45_1)

	if not var_45_0 then
		return
	end

	local var_45_1 = var_45_0.talentCubeInfos
	local var_45_2 = {}

	for iter_45_0, iter_45_1 in pairs(var_45_1.own_cube_dic) do
		local var_45_3 = iter_45_1.id

		if var_45_3 == var_45_1.own_main_cube_id then
			var_45_3 = var_45_0:getHeroUseStyleCubeId()
		end

		table.insert(var_45_2, {
			ruens_id = var_45_3,
			ruens_num = iter_45_1.use,
			ruens_hold_num = iter_45_1.own + iter_45_1.use
		})
	end

	local var_45_4 = {}

	for iter_45_2, iter_45_3 in ipairs(var_45_1.data_list) do
		local var_45_5 = iter_45_3.cubeId

		if var_45_5 == var_45_1.own_main_cube_id then
			var_45_5 = var_45_0:getHeroUseStyleCubeId()
		end

		table.insert(var_45_4, var_45_5)
	end

	StatController.instance:track(StatEnum.EventName.TalentRuensPreserve, {
		[StatEnum.EventProperties.HeroName] = var_45_0.config.name,
		[StatEnum.EventProperties.TalentLevel] = var_45_0.talent,
		[StatEnum.EventProperties.RuensStateArray] = var_45_2,
		[StatEnum.EventProperties.RuensStateGroup] = var_45_4
	})
end

function var_0_0.tryStatAllTalent(arg_46_0)
	local var_46_0 = HeroModel.instance:getList()

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		if iter_46_1.rank >= CharacterEnum.TalentRank then
			arg_46_0:stateTalent(iter_46_1.heroId)
		end
	end
end

function var_0_0.trackInteractiveSkinDetails(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = HeroConfig.instance:getHeroCO(arg_47_1)

	if not var_47_0 then
		return
	end

	local var_47_1 = SkinConfig.instance:getSkinCo(arg_47_2)

	if not var_47_1 then
		return
	end

	local var_47_2 = {
		[StatEnum.EventProperties.HeroId] = tonumber(arg_47_1),
		[StatEnum.EventProperties.HeroName] = var_47_0.name,
		[StatEnum.EventProperties.skinId] = arg_47_2,
		[StatEnum.EventProperties.skinName] = var_47_1.characterSkin,
		[StatEnum.EventProperties.clickType] = arg_47_3
	}

	StatController.instance:track(StatEnum.EventName.InteractiveSkinDetails, var_47_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
