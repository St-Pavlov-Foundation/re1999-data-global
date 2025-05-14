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

function var_0_0.enterCharacterBackpack(arg_26_0, arg_26_1)
	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1.533)

	local var_26_0 = {
		jumpTab = arg_26_1
	}

	ViewMgr.instance:openView(ViewName.CharacterBackpackView, var_26_0)
end

function var_0_0.openCharacterSwitchView(arg_27_0, arg_27_1, arg_27_2)
	ViewMgr.instance:openView(ViewName.CharacterSwitchView, arg_27_1, arg_27_2)
end

function var_0_0.openCharacterFilterView(arg_28_0, arg_28_1)
	ViewMgr.instance:openView(ViewName.CharacterBackpackSearchFilterView, arg_28_1)
end

function var_0_0.playRoleVoice(arg_29_0, arg_29_1)
	local var_29_0 = HeroModel.instance:getVoiceConfig(arg_29_1, CharacterEnum.VoiceType.MainViewNoInteraction)

	if var_29_0 and #var_29_0 > 0 then
		local var_29_1 = var_29_0[1].audio

		AudioMgr.instance:trigger(var_29_1)
	end
end

function var_0_0.SetAttriIcon(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	UISpriteSetMgr.instance:setCommonSprite(arg_30_1, "icon_att_" .. tostring(arg_30_2))

	gohelper.onceAddComponent(arg_30_1.gameObject, typeof(UnityEngine.UI.Image)).color = arg_30_3 or CharacterEnum.AttrLightColor
end

function var_0_0.dailyRefresh(arg_31_0)
	HeroRpc.instance:sendHeroInfoListRequest()
end

function var_0_0.statCharacterData(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	local var_32_0 = HeroConfig.instance:getHeroCO(arg_32_2)

	if not var_32_0 then
		return
	end

	local var_32_1 = HeroModel.instance:getByHeroId(arg_32_2)
	local var_32_2 = var_32_1 and var_32_1.faith or 0
	local var_32_3 = HeroConfig.instance:getFaithPercent(var_32_2)
	local var_32_4 = var_32_3 and var_32_3[1] * 100 or 0
	local var_32_5 = {
		[StatEnum.EventProperties.HeroId] = tonumber(arg_32_2),
		[StatEnum.EventProperties.HeroName] = var_32_0.name,
		[StatEnum.EventProperties.Faith] = var_32_4,
		[StatEnum.EventProperties.Entrance] = arg_32_5 and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal")
	}

	if arg_32_1 == StatEnum.EventName.PlayerVoice then
		local var_32_6, var_32_7, var_32_8 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(arg_32_2)
		local var_32_9 = GameConfig:GetCurVoiceShortcut()

		var_32_5[StatEnum.EventProperties.VoiceId] = tostring(arg_32_3 or "")
		var_32_5[StatEnum.EventProperties.CharVoiceLang] = var_32_8 and var_32_9 or var_32_7
		var_32_5[StatEnum.EventProperties.GlobalVoiceLang] = var_32_9
	elseif arg_32_1 == StatEnum.EventName.ReadHeroItem then
		-- block empty
	elseif arg_32_1 == StatEnum.EventName.ReadHeroCulture then
		var_32_5[StatEnum.EventProperties.CultureId] = tostring(arg_32_3 or "")
	end

	if arg_32_4 then
		var_32_5[StatEnum.EventProperties.Time] = arg_32_4
	end

	StatController.instance:track(arg_32_1, var_32_5)
end

function var_0_0.statCharacterSkinVideoData(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = StatEnum.EventName.ClickSkinVideoInlet
	local var_33_1 = {
		[StatEnum.EventProperties.HeroId] = arg_33_1,
		[StatEnum.EventProperties.HeroName] = arg_33_2,
		[StatEnum.EventProperties.skinId] = arg_33_3,
		[StatEnum.EventProperties.skinName] = arg_33_4
	}

	StatController.instance:track(var_33_0, var_33_1)
end

function var_0_0.showCharacterGetToast(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = HeroConfig.instance:getHeroCO(arg_34_1)
	local var_34_1 = {}
	local var_34_2

	if arg_34_2 <= 0 then
		var_34_2 = var_34_0.firstItem
	elseif arg_34_2 >= CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount) - 1 then
		var_34_2 = var_34_0.duplicateItem2
	else
		var_34_2 = var_34_0.duplicateItem
	end

	if not string.nilorempty(var_34_2) then
		local var_34_3 = string.split(var_34_2, "|")

		for iter_34_0, iter_34_1 in ipairs(var_34_3) do
			local var_34_4 = string.splitToNumber(iter_34_1, "#")
			local var_34_5 = var_34_4[1]
			local var_34_6 = var_34_4[2]
			local var_34_7 = var_34_4[3]
			local var_34_8 = {}

			var_34_8.config, var_34_8.icon = ItemModel.instance:getItemConfigAndIcon(var_34_5, var_34_6)
			var_34_8.quantity = var_34_7
			var_34_8.desc = arg_34_2 <= 0 and luaLang("character_first_tips") or luaLang("character_duplicate_tips")

			table.insert(var_34_1, var_34_8)
		end
	end

	local var_34_9
	local var_34_10
	local var_34_11

	if GameConfig:GetCurLangType() == LangSettings.en then
		var_34_9 = "\n"
		var_34_11 = " "
	elseif GameConfig:GetCurLangType() == LangSettings.kr then
		var_34_9 = " "
		var_34_11 = ""
	else
		var_34_9 = ""
		var_34_11 = ""
	end

	for iter_34_2, iter_34_3 in ipairs(var_34_1) do
		local var_34_12 = "%s%s%s\n%s%s%s%s"
		local var_34_13 = string.format(var_34_12, iter_34_3.desc, var_34_9, var_34_0.name, iter_34_3.config.name, var_34_11, luaLang("multiple"), iter_34_3.quantity)

		if GameConfig:GetCurLangType() == LangSettings.jp and arg_34_2 > 0 then
			var_34_13 = string.format("%s%s\n%s%s%s", var_34_0.name, iter_34_3.desc, iter_34_3.config.name, luaLang("multiple"), iter_34_3.quantity)
		end

		GameFacade.showToastWithIcon(ToastEnum.IconId, iter_34_3.icon, var_34_13)
	end
end

function var_0_0.showCharacterGetTicket(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_2 then
		return
	end

	local var_35_0, var_35_1 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, arg_35_2)
	local var_35_2 = HeroConfig.instance:getHeroCO(arg_35_1)

	GameFacade.showToastWithIcon(ToastEnum.IconId, var_35_1, string.format(luaLang("summon_limit_ticket_gain"), var_35_0.name))
end

function var_0_0.setTalentHeroId(arg_36_0, arg_36_1)
	arg_36_0._talentHeroId = arg_36_1
end

function var_0_0.getTalentHeroId(arg_37_0)
	return arg_37_0._talentHeroId
end

function var_0_0.statTalentStart(arg_38_0, arg_38_1)
	arg_38_0._statTalentInfo = arg_38_0:getStatTalentInfo(arg_38_1)
end

function var_0_0.getStatTalentInfo(arg_39_0, arg_39_1)
	local var_39_0 = {}
	local var_39_1 = HeroModel.instance:getByHeroId(arg_39_1)
	local var_39_2 = var_39_1 and var_39_1.talentCubeInfos

	if not var_39_2 then
		return nil
	end

	var_39_0.heroId = arg_39_1
	var_39_0.talent = var_39_1.talent
	var_39_0.dataDict = {}

	for iter_39_0, iter_39_1 in ipairs(var_39_2.data_list) do
		local var_39_3 = iter_39_1.cubeId

		if var_39_3 == var_39_2.own_main_cube_id then
			var_39_3 = var_39_1:getHeroUseStyleCubeId()
		end

		var_39_0.dataDict[string.format("%d_%d_%d_%d", var_39_3, iter_39_1.direction, iter_39_1.posX, iter_39_1.posY)] = true
	end

	return var_39_0
end

function var_0_0.hasStatTalentInfoChanged(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1.talent ~= arg_40_2.talent then
		return true
	end

	for iter_40_0, iter_40_1 in pairs(arg_40_1.dataDict) do
		if not arg_40_2.dataDict[iter_40_0] then
			return true
		end
	end

	for iter_40_2, iter_40_3 in pairs(arg_40_2.dataDict) do
		if not arg_40_1.dataDict[iter_40_2] then
			return true
		end
	end

	return false
end

function var_0_0.statTalentEnd(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0._statTalentInfo

	arg_41_0._statTalentInfo = nil

	if not var_41_0 or var_41_0.heroId ~= arg_41_1 then
		return
	end

	local var_41_1 = arg_41_0:getStatTalentInfo(arg_41_1)

	if not var_41_1 then
		return
	end

	if not arg_41_0:hasStatTalentInfoChanged(var_41_0, var_41_1) then
		return
	end

	arg_41_0:stateTalent(arg_41_1)
end

function var_0_0.stateTalent(arg_42_0, arg_42_1)
	local var_42_0 = HeroModel.instance:getByHeroId(arg_42_1)

	if not var_42_0 then
		return
	end

	local var_42_1 = var_42_0.talentCubeInfos
	local var_42_2 = {}

	for iter_42_0, iter_42_1 in pairs(var_42_1.own_cube_dic) do
		local var_42_3 = iter_42_1.id

		if var_42_3 == var_42_1.own_main_cube_id then
			var_42_3 = var_42_0:getHeroUseStyleCubeId()
		end

		table.insert(var_42_2, {
			ruens_id = var_42_3,
			ruens_num = iter_42_1.use,
			ruens_hold_num = iter_42_1.own + iter_42_1.use
		})
	end

	local var_42_4 = {}

	for iter_42_2, iter_42_3 in ipairs(var_42_1.data_list) do
		local var_42_5 = iter_42_3.cubeId

		if var_42_5 == var_42_1.own_main_cube_id then
			var_42_5 = var_42_0:getHeroUseStyleCubeId()
		end

		table.insert(var_42_4, var_42_5)
	end

	StatController.instance:track(StatEnum.EventName.TalentRuensPreserve, {
		[StatEnum.EventProperties.HeroName] = var_42_0.config.name,
		[StatEnum.EventProperties.TalentLevel] = var_42_0.talent,
		[StatEnum.EventProperties.RuensStateArray] = var_42_2,
		[StatEnum.EventProperties.RuensStateGroup] = var_42_4
	})
end

function var_0_0.tryStatAllTalent(arg_43_0)
	local var_43_0 = HeroModel.instance:getList()

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if iter_43_1.rank >= CharacterEnum.TalentRank then
			arg_43_0:stateTalent(iter_43_1.heroId)
		end
	end
end

function var_0_0.trackInteractiveSkinDetails(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = HeroConfig.instance:getHeroCO(arg_44_1)

	if not var_44_0 then
		return
	end

	local var_44_1 = SkinConfig.instance:getSkinCo(arg_44_2)

	if not var_44_1 then
		return
	end

	local var_44_2 = {
		[StatEnum.EventProperties.HeroId] = tonumber(arg_44_1),
		[StatEnum.EventProperties.HeroName] = var_44_0.name,
		[StatEnum.EventProperties.skinId] = arg_44_2,
		[StatEnum.EventProperties.skinName] = var_44_1.characterSkin,
		[StatEnum.EventProperties.clickType] = arg_44_3
	}

	StatController.instance:track(StatEnum.EventName.InteractiveSkinDetails, var_44_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
