module("modules.logic.defines.ResUrl", package.seeall)

local var_0_0 = _M

function var_0_0.getSummonBanner(arg_1_0)
	return string.format("singlebg/summon/banner/%s.png", arg_1_0)
end

function var_0_0.getSummonBannerLine(arg_2_0)
	return string.format("singlebg/summon/banner/bannerline/%s.png", arg_2_0)
end

function var_0_0.getV2a0SignSingleBg(arg_3_0)
	return string.format("singlebg/v2a0_sign_singlebg/%s.png", arg_3_0)
end

function var_0_0.getV2a0SignSingleBgLang(arg_4_0)
	return string.format("singlebg_lang/txt_v2a0_sign_singlebg/%s.png", arg_4_0)
end

function var_0_0.getShortenActSingleBg(arg_5_0)
	return string.format("singlebg/shortenact_singlebg/%s.png", arg_5_0)
end

function var_0_0.getV3a0WarmUpSingleBg(arg_6_0)
	return string.format("singlebg/v3a0_warmup_singlebg/%s.png", arg_6_0)
end

function var_0_0.getSceneLevelUrl(arg_7_0)
	local var_7_0 = lua_scene_level.configDict[arg_7_0]

	if var_7_0 then
		return string.format("scenes/%s/%s_p.prefab", var_7_0.resName, var_7_0.resName)
	else
		logError("scene level config not exist, levelId = " .. arg_7_0)
	end
end

function var_0_0.getExploreSceneLevelUrl(arg_8_0)
	local var_8_0 = lua_scene_level.configDict[arg_8_0]

	if var_8_0 then
		return string.format("explore/scene/prefab/%s_p.prefab", var_8_0.resName)
	else
		logError("scene level config not exist, levelId = " .. arg_8_0)
	end
end

function var_0_0.getSurvivalSceneLevelUrl(arg_9_0)
	local var_9_0 = lua_scene_level.configDict[arg_9_0]

	if var_9_0 then
		return string.format("survival/common/%s.prefab", var_9_0.resName)
	else
		logError("scene level config not exist, levelId = " .. arg_9_0)
	end
end

function var_0_0.getSceneUrl(arg_10_0)
	return string.format("scenes/%s/%s_p.prefab", arg_10_0, arg_10_0)
end

function var_0_0.getSpineFightPrefab(arg_11_0)
	return var_0_0.getRolesPrefab(arg_11_0, "fight")
end

function var_0_0.getRolesPrefab(arg_12_0, arg_12_1)
	local var_12_0

	if string.find(arg_12_0, "/") then
		var_12_0 = arg_12_0
	else
		var_12_0 = string.format("%s/%s", arg_12_0, arg_12_0)
	end

	return string.format("roles/%s_%s.prefab", var_12_0, arg_12_1)
end

function var_0_0.getRolesBustPrefab(arg_13_0)
	local var_13_0

	if string.find(arg_13_0, "/") then
		var_13_0 = arg_13_0
	else
		var_13_0 = string.format("%s/%s", arg_13_0, arg_13_0)
	end

	return string.format("roles_bust/%s.prefab", var_13_0)
end

function var_0_0.getSpineFightPrefabBySkin(arg_14_0)
	if not arg_14_0 then
		return ""
	end

	local var_14_0

	if string.find(arg_14_0.spine, "/") then
		var_14_0 = arg_14_0.spine
	else
		var_14_0 = string.format("%s/%s", arg_14_0.spine, arg_14_0.spine)
	end

	if arg_14_0.fight_special == 1 then
		return string.format("roles/%s_fight_special.prefab", var_14_0)
	else
		return string.format("roles/%s_fight.prefab", var_14_0)
	end
end

function var_0_0.getRolesPrefabStory(arg_15_0)
	local var_15_0 = string.format("rolesstory/rolesprefab/%s/%s.prefab", SkinConfig.instance:getFolderName(arg_15_0), arg_15_0)

	return AvProMgr.instance:getRolesprefabUrl(var_15_0)
end

function var_0_0.getRolesCgStory(arg_16_0, arg_16_1)
	return string.format("rolesstory/rolescg/%s/%s.prefab", arg_16_1 or SkinConfig.instance:getFolderName(arg_16_0), arg_16_0)
end

function var_0_0.getLightSpine(arg_17_0)
	local var_17_0 = string.format("rolesstory/rolesprefab/%s/%s_light.prefab", SkinConfig.instance:getFolderName(arg_17_0), arg_17_0)

	return AvProMgr.instance:getRolesprefabUrl(var_17_0)
end

function var_0_0.getLightLive2d(arg_18_0)
	return string.format("live2d/roles/%s/%s.prefab", SkinConfig.instance:getFolderName(arg_18_0), arg_18_0)
end

function var_0_0.getLightLive2dFolder(arg_19_0)
	return string.format("live2d/roles/%s/", SkinConfig.instance:getFolderName(arg_19_0))
end

function var_0_0.getRolesPrefabStoryFolder(arg_20_0)
	return string.format("rolesstory/rolesprefab/%s/", SkinConfig.instance:getFolderName(arg_20_0))
end

function var_0_0.getSpineRoomPrefab(arg_21_0)
	return var_0_0.getRolesPrefab(arg_21_0, "room")
end

function var_0_0.getSpineUIPrefab(arg_22_0)
	return var_0_0.getRolesPrefab(arg_22_0, "ui")
end

function var_0_0.getSkillTimeline(arg_23_0)
	return string.format("rolestimeline/%s.playable", arg_23_0)
end

function var_0_0.getRolesTimeline()
	return "rolestimeline"
end

function var_0_0.getLoginBg(arg_25_0)
	return string.format("singlebg/loginbg/%s.png", arg_25_0)
end

function var_0_0.getLoadingBg(arg_26_0)
	return string.format("singlebg/loading/%s.png", arg_26_0)
end

function var_0_0.getMailBg(arg_27_0)
	return string.format("singlebg/mail/%s.png", arg_27_0)
end

function var_0_0.getCommonViewBg(arg_28_0)
	return string.format("singlebg/common/viewbg/%s.jpg", arg_28_0)
end

function var_0_0.getCommonIcon(arg_29_0)
	return string.format("singlebg/common/%s.png", arg_29_0)
end

function var_0_0.getDungeonIcon(arg_30_0)
	return string.format("singlebg/dungeon/%s.png", arg_30_0)
end

function var_0_0.getDungeonChapterBg(arg_31_0)
	return string.format("ui/viewres/dungeon/chapter/bg/%s.prefab", arg_31_0)
end

function var_0_0.getDungeonInteractiveItemBg(arg_32_0)
	return string.format("singlebg/dungeon/interactiveitem/%s.png", arg_32_0)
end

function var_0_0.getDungeonRuleIcon(arg_33_0)
	return string.format("singlebg/dungeon/level_rule/%s.png", arg_33_0)
end

function var_0_0.getDungeonFragmentIcon(arg_34_0)
	return string.format("singlebg/dungeon/fragmenticon/%s.png", arg_34_0)
end

function var_0_0.getFightQuitResultIcon(arg_35_0)
	return string.format("singlebg/fight/result/%s.png", arg_35_0)
end

function var_0_0.getFightGuideIcon(arg_36_0)
	return string.format("singlebg/fight/fightguide/bg_zhiying_%s.png", arg_36_0)
end

function var_0_0.getFightGuideDir()
	return "Assets/ZResourcesLib/singlebg/fight/fightguide"
end

function var_0_0.getBackpackItemIcon(arg_38_0)
	return string.format("singlebg/backpackitem/%s.png", arg_38_0)
end

function var_0_0.getSummonHeroIcon(arg_39_0)
	return string.format("singlebg/summon/hero/%s.png", arg_39_0)
end

function var_0_0.getSummonEquipIcon(arg_40_0)
	return string.format("singlebg/summon/equip/%s.png", arg_40_0)
end

function var_0_0.getSummonEquipGetIcon(arg_41_0)
	return string.format("singlebg/summon/equipget/%s.png", arg_41_0)
end

function var_0_0.getSummonBannerFullPath(arg_42_0)
	return string.format("singlebg_lang/txt_summon/banner/%s.png", arg_42_0)
end

function var_0_0.getAdventureTaskLangPath(arg_43_0)
	return string.format("singlebg_lang/txt_adventuretask/%s.png", arg_43_0)
end

function var_0_0.getSummonCoverBg(arg_44_0)
	return string.format("singlebg/summon/%s.png", arg_44_0)
end

function var_0_0.getSummonHeroMask(arg_45_0)
	return string.format("singlebg/summon/mask/%s.png", arg_45_0)
end

function var_0_0.getSummonSceneTexture(arg_46_0)
	return string.format("scenes/dynamic/m_s06_summon/%s.png", arg_46_0)
end

function var_0_0.getSignature(arg_47_0, arg_47_1)
	if arg_47_1 then
		return string.format("singlebg/signature/%s/%s.png", arg_47_1, arg_47_0)
	else
		return string.format("singlebg/signature/%s.png", arg_47_0)
	end
end

function var_0_0.getSceneUIPrefab(arg_48_0, arg_48_1)
	return string.format("ui/sceneui/%s/%s.prefab", arg_48_0, arg_48_1)
end

function var_0_0.getCharacterIcon(arg_49_0)
	return string.format("singlebg/character/%s.png", arg_49_0)
end

function var_0_0.getCharacterItemIcon(arg_50_0)
	return string.format("singlebg/characteritem/%s.png", arg_50_0)
end

function var_0_0.getCharacterDataIcon(arg_51_0)
	return string.format("singlebg/characterdata/%s", arg_51_0)
end

function var_0_0.getCharacterExskill(arg_52_0)
	return string.format("singlebg/characterexskill/%s.png", arg_52_0)
end

function var_0_0.getCharacterGetIcon(arg_53_0)
	return string.format("singlebg/characterget/%s.png", arg_53_0)
end

function var_0_0.getCharacterSkinIcon(arg_54_0)
	return string.format("singlebg/characterskin/%s.png", arg_54_0)
end

function var_0_0.getCharacterSkinLive2dBg(arg_55_0)
	return string.format("singlebg/characterskin/live2dbg/%s.png", arg_55_0)
end

function var_0_0.getCharacterSkinStoryBg(arg_56_0)
	return string.format("singlebg/skinhandbook_singlebg/skinhandbook_leftbg_%d.png", arg_56_0)
end

function var_0_0.getCharacterSkinSwitchBg(arg_57_0)
	return string.format("singlebg/characterskin/img_yulan_bg_%d.png", arg_57_0)
end

function var_0_0.getHeadSkinIconMiddle(arg_58_0)
	return string.format("singlebg/headskinicon_middle/%s.png", arg_58_0)
end

function var_0_0.getHeadSkinIconLarge(arg_59_0)
	return string.format("singlebg/headskinicon_large/%s.jpg", arg_59_0)
end

function var_0_0.getSkillEffect(arg_60_0)
	return string.format("singlebg/characteritem/skilleffect/effect_%s.png", arg_60_0)
end

function var_0_0.getCharacterRareBg(arg_61_0)
	return string.format("singlebg/characteritem/jskp_0%d.png", arg_61_0)
end

function var_0_0.getCharacterRareBgNew(arg_62_0)
	return string.format("singlebg/characteritem/jskp_0%d.png", arg_62_0)
end

function var_0_0.getTipsBg(arg_63_0)
	return string.format("singlebg/tips/%s.png", arg_63_0)
end

function var_0_0.getTipsCharacterRareBg(arg_64_0)
	return string.format("singlebg/tips/jskp_0%d.png", arg_64_0)
end

function var_0_0.getTipsCharacterColorBg(arg_65_0)
	return string.format("singlebg/tips/pfkp_00%d.png", arg_65_0)
end

function var_0_0.getPropItemIcon(arg_66_0)
	return string.format("singlebg/propitem/prop/%s.png", arg_66_0)
end

function var_0_0.getPropItemIconSmall(arg_67_0)
	return string.format("singlebg/propitem/prop_small/%s.png", arg_67_0)
end

function var_0_0.getAntiqueIcon(arg_68_0)
	return string.format("singlebg/antique_singlebg/%s.png", arg_68_0)
end

function var_0_0.getSpecialPropItemIcon(arg_69_0)
	return string.format("singlebg/propitem/special/%s.png", arg_69_0)
end

function var_0_0.getCurrencyItemIcon(arg_70_0)
	return string.format("singlebg/currencyitem/%s.png", arg_70_0)
end

function var_0_0.getCritterItemIcon(arg_71_0)
	return string.format("singlebg/propitem/critter/%s.png", arg_71_0)
end

function var_0_0.getEffect(arg_72_0)
	return string.format("effects/prefabs/%s.prefab", arg_72_0)
end

function var_0_0.getStoryPrefabRes(arg_73_0)
	return string.format("ui/viewres/story/%s.prefab", arg_73_0)
end

function var_0_0.getStoryBgEffect(arg_74_0)
	return string.format("ui/viewres/story/bg/%s.prefab", arg_74_0)
end

function var_0_0.getStoryBgMaterial(arg_75_0)
	return string.format("ui/materials/storybg/%s.mat", arg_75_0)
end

function var_0_0.getUIEffect(arg_76_0)
	return string.format("ui/viewres/effect/%s.prefab", arg_76_0)
end

function var_0_0.getSceneEffect(arg_77_0)
	return string.format("effects/prefabs/buff/%s.prefab", arg_77_0)
end

function var_0_0.getFightLoadingIcon(arg_78_0)
	return string.format("singlebg/fight/loading/%s.png", tostring(arg_78_0))
end

function var_0_0.getSkillIcon(arg_79_0)
	if SDKModel.instance:isDmm() and arg_79_0 == 30060121 then
		return "singlebg/fight/skill/30060121_dmm.png"
	else
		return string.format("singlebg/fight/skill/%s.png", tostring(arg_79_0))
	end
end

function var_0_0.getPassiveSkillIcon(arg_80_0)
	return string.format("singlebg/fight/passive/%s.png", tostring(arg_80_0))
end

function var_0_0.getClothSkillIcon(arg_81_0)
	return string.format("singlebg/fight/cloth/%s.png", tostring(arg_81_0))
end

function var_0_0.getAttributeIcon(arg_82_0)
	return string.format("singlebg/fight/attribute/%s.png", tostring(arg_82_0))
end

function var_0_0.getFightCardDescIcon(arg_83_0)
	return string.format("singlebg/fight/carddesc/%s.png", tostring(arg_83_0))
end

function var_0_0.getFightResultcIcon(arg_84_0)
	return string.format("singlebg/fight/result/%s.png", tostring(arg_84_0))
end

function var_0_0.getFightSkillTargetcIcon(arg_85_0)
	return string.format("singlebg/fight/skilltarget/%s.png", tostring(arg_85_0))
end

function var_0_0.getStoryRes(arg_86_0)
	if SDKModel.instance:isDmm() and arg_86_0 == "story_bg/bg/cg_sanrenxing.jpg" then
		return "singlebg/storybg/story_bg/bg/cg_sanrenxing_dmm.jpg"
	else
		return string.format("singlebg/storybg/%s", tostring(arg_86_0))
	end
end

function var_0_0.getStoryBg(arg_87_0)
	return string.format("singlebg/storybg/%s", tostring(arg_87_0))
end

function var_0_0.getStoryPrologueSkip(arg_88_0)
	return string.format("singlebg/storybg/prologueskip/%s.png", tostring(arg_88_0))
end

function var_0_0.getStorySmallBg(arg_89_0)
	return string.format("singlebg/storybg/smallbg/%s", tostring(arg_89_0))
end

function var_0_0.getStoryEpisodeIcon(arg_90_0)
	return string.format("ui/viewres/storynavigate/%s", tostring(arg_90_0))
end

function var_0_0.getStoryItem(arg_91_0)
	local var_91_0 = {
		"1_2tanchuang",
		"v2a5_liangyue_story"
	}
	local var_91_1 = string.format("singlebg/storybg/item/%s", tostring(arg_91_0))
	local var_91_2 = string.format("singlebg_lang/txt_story/%s", tostring(arg_91_0))
	local var_91_3 = false

	for iter_91_0, iter_91_1 in pairs(var_91_0) do
		if string.match(arg_91_0, iter_91_1) then
			var_91_3 = true

			break
		end
	end

	return var_91_3 and var_91_2 or var_91_1
end

function var_0_0.getStoryLangPath(arg_92_0)
	return string.format("singlebg_lang/txt_story/%s.png", tostring(arg_92_0))
end

function var_0_0.getCameraAnim(arg_93_0)
	return string.format("effects/cameraanim/%s.controller", arg_93_0)
end

function var_0_0.getCameraAnimABUrl()
	return "effects/cameraanim"
end

function var_0_0.getEntityAnim(arg_95_0)
	return string.format("effects/entityanim/%s.anim", arg_95_0)
end

function var_0_0.getEntityAnimABUrl()
	return "effects/entityanim"
end

function var_0_0.getHeadIconSmall(arg_97_0)
	return string.format("singlebg/headicon_small/%s.png", arg_97_0)
end

function var_0_0.getEquipIconSmall(arg_98_0)
	return string.format("scenes/dynamic/m_s03_xx/equipicon_small/%s.png", arg_98_0)
end

function var_0_0.getHeadIconNew(arg_99_0)
	return string.format("singlebg/propitem/hero/%s.png", arg_99_0)
end

function var_0_0.getHeroSkinPropIcon(arg_100_0)
	return string.format("singlebg/propitem/heroskin/%s.png", arg_100_0)
end

function var_0_0.getHeadIconMiddle(arg_101_0)
	return string.format("singlebg/headicon_middle/%s.png", arg_101_0)
end

function var_0_0.getHeadIconLarge(arg_102_0)
	return string.format("singlebg/headicon_large/%s.png", arg_102_0)
end

function var_0_0.getHeadIconImg(arg_103_0)
	return string.format("singlebg/headicon_img/%s.png", arg_103_0)
end

function var_0_0.getHeadSkinSmall(arg_104_0)
	return string.format("singlebg/headskinicon_small/%s.png", arg_104_0)
end

function var_0_0.getCharacterDataPic(arg_105_0)
	return string.format("singlebg/data_pic/%s.png", arg_105_0)
end

function var_0_0.getHeroGroupBg(arg_106_0)
	return string.format("singlebg/herogroup/%s.png", arg_106_0)
end

function var_0_0.getHeroDefaultEquipIcon(arg_107_0)
	return string.format("singlebg/equip_defaulticon/%s.png", arg_107_0)
end

function var_0_0.getTaskBg(arg_108_0)
	return string.format("singlebg/task/%s.png", arg_108_0)
end

function var_0_0.getEquipRareIcon(arg_109_0)
	return string.format("singlebg/equipment/rare/%s.png", arg_109_0)
end

function var_0_0.getEquipIcon(arg_110_0)
	return string.format("singlebg/equipment/icon/%s.png", arg_110_0)
end

function var_0_0.getEquipSuit(arg_111_0)
	return string.format("singlebg/equipment/suit/%s.png", arg_111_0)
end

function var_0_0.getEquipRes(arg_112_0)
	return string.format("singlebg/equipment/%s.png", arg_112_0)
end

function var_0_0.getHelpItem(arg_113_0, arg_113_1)
	return string.format("singlebg/help/%s.png", arg_113_0)
end

function var_0_0.getVersionActivityHelpItem(arg_114_0, arg_114_1)
	return string.format("singlebg/versionactivityhelp/%s.png", arg_114_0)
end

function var_0_0.getBannerIcon(arg_115_0)
	return string.format("singlebg/banner/%s.png", arg_115_0)
end

function var_0_0.getRoleSpineMat(arg_116_0)
	return string.format("rolesbuff/%s.mat", arg_116_0)
end

function var_0_0.getRoleSpineMatTex(arg_117_0)
	return string.format("rolesbuff/%s.png", arg_117_0)
end

function var_0_0.getSettingsBg(arg_118_0)
	return string.format("singlebg/settings/%s", arg_118_0)
end

function var_0_0.getAdventureBg(arg_119_0)
	return string.format("singlebg/adventure/%s.png", arg_119_0)
end

function var_0_0.getExploreBg(arg_120_0)
	return string.format("singlebg/explore/%s.png", arg_120_0)
end

function var_0_0.getAdventureIcon(arg_121_0)
	return string.format("singlebg/adventure/iconnew/%s.png", arg_121_0)
end

function var_0_0.getAdventureEntrance(arg_122_0)
	return string.format("singlebg/adventure/entrance/%s.png", arg_122_0)
end

function var_0_0.getAdventureTarotIcon(arg_123_0)
	return string.format("singlebg/adventure/tarot/%s.png", arg_123_0)
end

function var_0_0.getAdventureTarotSmallIcon(arg_124_0)
	return string.format("singlebg/adventure/tarotsmall/%s.png", arg_124_0)
end

function var_0_0.getAdventureMagicIcon(arg_125_0, arg_125_1)
	return string.format("singlebg/adventure/magic/%s/%s.png", arg_125_0, arg_125_1)
end

function var_0_0.getAdventureTarotQuality(arg_126_0)
	return string.format("singlebg/adventure/tarot_quality/tarot_quality_%s.png", arg_126_0)
end

function var_0_0.getAdventureTask(arg_127_0)
	return string.format("singlebg/adventure/task/%s.png", arg_127_0)
end

function var_0_0.getPlayerClothIcon(arg_128_0)
	return string.format("singlebg/player/cloth/%s.png", arg_128_0)
end

function var_0_0.getPlayerBg(arg_129_0)
	return string.format("singlebg/player/%s.png", arg_129_0)
end

function var_0_0.getPlayerCardIcon(arg_130_0)
	return string.format("singlebg/playercard/%s.png", arg_130_0)
end

function var_0_0.getStoreBottomBgIcon(arg_131_0)
	return string.format("singlebg/store/%s.png", arg_131_0)
end

function var_0_0.getStoreGiftPackBg(arg_132_0)
	return string.format("singlebg/store/giftpacksview/%s.png", arg_132_0)
end

function var_0_0.getStorePackageIcon(arg_133_0)
	if string.nilorempty(arg_133_0) then
		return var_0_0.getCurrencyItemIcon(201)
	else
		return string.format("singlebg/store/package/%s.png", arg_133_0)
	end
end

function var_0_0.getStoreTagIcon(arg_134_0)
	return string.format("singlebg/store/tag_%s.png", arg_134_0)
end

function var_0_0.getStoreRecommend(arg_135_0)
	return string.format("singlebg/store/recommend/%s.png", arg_135_0)
end

function var_0_0.getStoreWildness(arg_136_0)
	return string.format("singlebg/store/wildness/%s.png", arg_136_0)
end

function var_0_0.getStoreSkin(arg_137_0)
	return string.format("singlebg/store/skin/%s.png", arg_137_0)
end

function var_0_0.getNoticeBg(arg_138_0)
	return string.format("singlebg/notice/%s.png", arg_138_0)
end

function var_0_0.getNoticeContentIcon(arg_139_0, arg_139_1)
	return string.format("singlebg/notice/hd_%d_%d.png", arg_139_0, arg_139_1)
end

function var_0_0.getSignInBg(arg_140_0)
	return string.format("singlebg/signin/%s.png", arg_140_0)
end

function var_0_0.getActivityBg(arg_141_0)
	return string.format("singlebg/activity/%s.png", arg_141_0)
end

function var_0_0.getActivityMapBg(arg_142_0)
	return string.format("singlebg/activity/%s", arg_142_0)
end

function var_0_0.getPowerBuyBg(arg_143_0)
	return string.format("singlebg/powerbuy/%s.png", arg_143_0)
end

function var_0_0.getEquipBg(arg_144_0)
	return string.format("singlebg/equip/%s", arg_144_0)
end

function var_0_0.getMessageIcon(arg_145_0)
	return string.format("singlebg/message/%s.png", arg_145_0)
end

function var_0_0.getSocialIcon(arg_146_0)
	return string.format("singlebg/social/%s", arg_146_0)
end

function var_0_0.getFightIcon(arg_147_0)
	return string.format("singlebg/fight/icon/%s", arg_147_0)
end

function var_0_0.getFightImage(arg_148_0)
	return string.format("singlebg/fight/%s", arg_148_0)
end

function var_0_0.getFightSpecialTipIcon(arg_149_0)
	return string.format("singlebg/fight/specialtip/%s", arg_149_0)
end

function var_0_0.getNickNameIcon(arg_150_0)
	return string.format("singlebg/nickname/%s.png", arg_150_0)
end

function var_0_0.getRoomRes(arg_151_0)
	return string.format("scenes/m_s07_xiaowu/prefab/%s.prefab", arg_151_0)
end

function var_0_0.getRoomResAB(arg_152_0)
	return string.format("scenes/m_s07_xiaowu/prefab/%s", arg_152_0)
end

function var_0_0.getRoomGetIcon(arg_153_0)
	return string.format("singlebg/roomget/%s.png", arg_153_0)
end

function var_0_0.getRoomBlockPackageRewardIcon(arg_154_0)
	return string.format("singlebg/roomget/blockpackage/%s.jpg", arg_154_0)
end

function var_0_0.getRoomBuildingRewardIcon(arg_155_0)
	return string.format("singlebg/roomget/building/%s.jpg", arg_155_0)
end

function var_0_0.getRoomThemeRewardIcon(arg_156_0)
	return string.format("singlebg/roomget/theme/%s.jpg", arg_156_0)
end

function var_0_0.getSpineBxhyPrefab(arg_157_0)
	return var_0_0.getRolesPrefab(arg_157_0, "room")
end

function var_0_0.getSpineUIBxhyPrefab(arg_158_0)
	return var_0_0.getRolesPrefab(arg_158_0, "ui")
end

function var_0_0.getSpineBxhyMaterial(arg_159_0)
	local var_159_0

	if string.find(arg_159_0, "/") then
		var_159_0 = arg_159_0
	else
		var_159_0 = string.format("%s/%s", arg_159_0, arg_159_0)
	end

	return string.format("roles/%s_bxhy_material.mat", var_159_0)
end

function var_0_0.getSceneRes(arg_160_0)
	return string.format("scenes/%s/%s_p.prefab", arg_160_0, arg_160_0)
end

function var_0_0.getDungeonMapRes(arg_161_0)
	return string.format("scenes/%s.prefab", arg_161_0)
end

function var_0_0.getRoomImage(arg_162_0)
	return string.format("singlebg/room/%s.png", arg_162_0)
end

function var_0_0.getMainImage(arg_163_0)
	return string.format("singlebg/main/%s.png", arg_163_0)
end

function var_0_0.getMainActivityIcon(arg_164_0)
	return string.format("singlebg_lang/txt_main/%s.png", arg_164_0)
end

function var_0_0.getHandbookBg(arg_165_0)
	return string.format("singlebg/handbook/%s.png", arg_165_0)
end

function var_0_0.getHandbookCharacterIcon(arg_166_0)
	return string.format("singlebg/handbook/character/%s.png", arg_166_0)
end

function var_0_0.getHandbookheroIcon(arg_167_0)
	return string.format("singlebg/handbookheroicon/%s.png", arg_167_0)
end

function var_0_0.getHandbookEquipImage(arg_168_0)
	return string.format("singlebg/handbook/equip/%s.png", arg_168_0)
end

function var_0_0.getCharacterTalentUpIcon(arg_169_0)
	return string.format("singlebg/charactertalentup/%s.png", arg_169_0)
end

function var_0_0.getWeekWalkBg(arg_170_0)
	return string.format("singlebg/weekwalk/%s", arg_170_0)
end

function var_0_0.getWeekWalkIcon(arg_171_0)
	return string.format("singlebg/weekwalk/%s.png", arg_171_0)
end

function var_0_0.getVideo(arg_172_0)
	return string.format("videos/%s.mp4", arg_172_0)
end

function var_0_0.getCharacterTalentUpTexture(arg_173_0)
	return string.format("singlebg/textures/charactertalentup/%s.png", arg_173_0)
end

function var_0_0.getWeatherEffect(arg_174_0)
	return string.format("effects/prefabs/roleeffects/%s.prefab", arg_174_0)
end

function var_0_0.getPlayerViewTexture(arg_175_0)
	return string.format("singlebg/textures/playerview/%s.png", arg_175_0)
end

function var_0_0.getCommonitemEffect(arg_176_0)
	return string.format("ui/viewres/common/effect/%s.prefab", arg_176_0)
end

function var_0_0.getDungeonPuzzleBg(arg_177_0)
	return string.format("singlebg/dungeon/puzzle/%s.png", arg_177_0)
end

function var_0_0.getUIMaskTexture(arg_178_0)
	return string.format("singlebg/textures/uimask/%s.png", arg_178_0)
end

function var_0_0.getRoomTexture(arg_179_0)
	return string.format("singlebg/textures/room/%s", arg_179_0)
end

function var_0_0.getActivityTexture(arg_180_0)
	return string.format("singlebg/textures/activity/%s", arg_180_0)
end

function var_0_0.getTeachNoteImage(arg_181_0)
	return string.format("singlebg/teachnote/%s", arg_181_0)
end

function var_0_0.getWeekWalkTarotIcon(arg_182_0)
	return string.format("singlebg/weekwalk/tarot/%s.png", arg_182_0)
end

function var_0_0.getFightTechniqueGuide(arg_183_0, arg_183_1)
	if arg_183_1 then
		return string.format("singlebg/versionactivitytechniqueguide/%s.png", arg_183_0)
	else
		return string.format("singlebg/fight/techniqueguide/%s.png", arg_183_0)
	end
end

function var_0_0.getFightEquipFloatIcon(arg_184_0)
	return string.format("singlebg/fight/equipeffect/%s.png", arg_184_0)
end

function var_0_0.getFightGuideLangIcon(arg_185_0)
	return string.format("singlebg_lang/txt_fightguide/bg_zhiying_%s.png", arg_185_0)
end

function var_0_0.getFightGuideLangDir()
	return "Assets/ZResourcesLib/singlebg_lang/txt_fightguide"
end

function var_0_0.getLoginBgLangIcon(arg_187_0)
	return string.format("singlebg_lang/txt_loginbg/%s.png", arg_187_0)
end

function var_0_0.getTechniqueLangIcon(arg_188_0, arg_188_1)
	if arg_188_1 then
		return string.format("singlebg_lang/txt_fighttechniquetips/%s.png", arg_188_0)
	else
		return string.format("singlebg/fighttechniquetips/%s.png", arg_188_0)
	end
end

function var_0_0.getTechniqueBg(arg_189_0)
	return string.format("singlebg/fight/techniquetips/%s.png", arg_189_0)
end

function var_0_0.getHandbookCharacterImage(arg_190_0)
	return string.format("singlebg_lang/txt_handbook/%s.png", arg_190_0)
end

function var_0_0.getFightBattleDialogBg(arg_191_0)
	return string.format("singlebg/fight/battledialog/%s.png", arg_191_0)
end

function var_0_0.getBpBg(arg_192_0)
	return string.format("singlebg/battlepass/%s.png", arg_192_0)
end

function var_0_0.getAct114Image(arg_193_0)
	return string.format("singlebg_lang/txt_versionactivity114_1_2/%s.png", arg_193_0)
end

function var_0_0.getDreamTailImage(arg_194_0)
	return string.format("singlebg/versionactivitydreamtail_1_2/%s.png", arg_194_0)
end

function var_0_0.getAct114MeetIcon(arg_195_0)
	return string.format("singlebg/versionactivity114_1_2/meet/%s.png", arg_195_0)
end

function var_0_0.getAct114Icon(arg_196_0)
	return string.format("singlebg/versionactivity114_1_2/%s.png", arg_196_0)
end

function var_0_0.getYaXianImage(arg_197_0)
	return string.format("singlebg/versionactivitytooth_1_2/%s.png", arg_197_0)
end

function var_0_0.getFightDiceBg(arg_198_0)
	return string.format("singlebg/fight/fightdice/%s.png", arg_198_0)
end

function var_0_0.getWeekWalkLayerIcon(arg_199_0)
	return string.format("singlebg/weekwalk/layer/%s.png", arg_199_0)
end

function var_0_0.getRoomCharacterPlaceIcon(arg_200_0)
	return string.format("singlebg/room/characterplace/%s.png", arg_200_0)
end

function var_0_0.getRoomHeadIcon(arg_201_0)
	return string.format("singlebg/room/headicon/%s.png", arg_201_0)
end

function var_0_0.getRoomBlockPackagePropIcon(arg_202_0)
	return string.format("singlebg/propitem/blockpackage/%s.png", arg_202_0)
end

function var_0_0.getRoomBlockPropIcon(arg_203_0)
	return string.format("singlebg/propitem/block/%s.png", arg_203_0)
end

function var_0_0.getRoomBuildingPropIcon(arg_204_0)
	return string.format("singlebg/propitem/building/%s.png", arg_204_0)
end

function var_0_0.getRoomThemePropIcon(arg_205_0)
	return string.format("singlebg/propitem/roomtheme/%s.png", arg_205_0)
end

function var_0_0.getRoomTaskBonusIcon(arg_206_0)
	return string.format("singlebg/room/taskbonus/%s.png", arg_206_0)
end

function var_0_0.getRoomFunctionIcon(arg_207_0)
	return string.format("singlebg/room/function/%s.png", arg_207_0)
end

function var_0_0.getRoomProductline(arg_208_0)
	return string.format("singlebg/room/productline/%s.png", arg_208_0)
end

function var_0_0.getSeasonIcon(arg_209_0)
	return string.format("singlebg/season/%s", arg_209_0)
end

function var_0_0.getV1A2SeasonIcon(arg_210_0)
	return string.format("singlebg/v1a2_season/%s", arg_210_0)
end

function var_0_0.getV1A3SeasonIcon(arg_211_0)
	return string.format("singlebg/v1a3_season/%s", arg_211_0)
end

function var_0_0.getV1A3DungeonIcon(arg_212_0)
	return string.format("singlebg/v1a3_dungeon_singlebg/%s.png", arg_212_0)
end

function var_0_0.getToastIcon(arg_213_0)
	return string.format("singlebg/toast/%s.png", arg_213_0)
end

function var_0_0.getSdkIcon(arg_214_0)
	return string.format("singlebg/sdk/%s.png", arg_214_0)
end

function var_0_0.getPlayerHeadIcon(arg_215_0)
	return string.format("singlebg/playerheadicon/%s.png", arg_215_0)
end

function var_0_0.getVersionActivityIcon(arg_216_0)
	return string.format("singlebg/versionactivity/%s.png", arg_216_0)
end

function var_0_0.getVersionActivityEnter1_2Icon(arg_217_0)
	return string.format("singlebg/versionactivityenter_1_2/%s.png", arg_217_0)
end

function var_0_0.getVersionActivityEnter1_2LangIcon(arg_218_0)
	return string.format("singlebg_lang/txt_versionactivityenter_1_2/%s.png", arg_218_0)
end

function var_0_0.getMeilanniIcon(arg_219_0)
	return string.format("singlebg/versionactivitymeilanni/%s.png", arg_219_0)
end

function var_0_0.getMeilanniLangIcon(arg_220_0)
	return string.format("singlebg_lang/txt_versionactivitymeilanni/%s.png", arg_220_0)
end

function var_0_0.getActivityWarmUpBg(arg_221_0)
	return string.format("singlebg/activitywarmup/%s.png", arg_221_0)
end

function var_0_0.getPushBoxPre(arg_222_0)
	return string.format("scenes/m_s11_txz/prefab/%s.prefab", arg_222_0)
end

function var_0_0.getPushBoxResultIcon(arg_223_0)
	return string.format("singlebg_lang/txt_versionactivitypushbox/%s.png", arg_223_0)
end

function var_0_0.getVersionactivitychessIcon(arg_224_0)
	return string.format("singlebg/versionactivitychess/%s.png", arg_224_0)
end

function var_0_0.gettxt_versionactivitychessIcon(arg_225_0)
	return string.format("singlebg_lang/txt_versionactivitychess/%s.png", arg_225_0)
end

function var_0_0.getVersionActivityExchangeIcon(arg_226_0)
	return string.format("singlebg/versionactivityexchange/%s.png", arg_226_0)
end

function var_0_0.getVersionActivityDungeonIcon(arg_227_0)
	return string.format("singlebg/versionactivitydungeon/%s.png", arg_227_0)
end

function var_0_0.getBattlePassBg(arg_228_0)
	return string.format("singlebg/battlepass/%s.png", arg_228_0)
end

function var_0_0.getVersionActivityWhiteHouse_1_2_Bg(arg_229_0)
	return string.format("singlebg/versionactivitywhitehouse_1_2/%s", arg_229_0)
end

function var_0_0.getVersionTradeBargainBg(arg_230_0)
	return string.format("singlebg/versionactivitytrade_1_2/%s.png", arg_230_0)
end

function var_0_0.getVersionActivity1_2TaskImage(arg_231_0)
	return string.format("singlebg/versionactivitytask_1_2/%s.png", arg_231_0)
end

function var_0_0.getRoomIconLangPath(arg_232_0)
	return string.format("singlebg_lang/txt_room/%s.png", arg_232_0)
end

function var_0_0.getWeekWalkIconLangPath(arg_233_0)
	return string.format("singlebg_lang/txt_weekwalk/%s.png", arg_233_0)
end

function var_0_0.getExploreEffectPath(arg_234_0)
	return string.format("effects/scenes/mishi_prefabs/%s.prefab", arg_234_0)
end

function var_0_0.getSeasonCelebrityCard(arg_235_0)
	return string.format("singlebg/seasoncelebritycard/%s.png", arg_235_0)
end

function var_0_0.getSeasonMarketIcon(arg_236_0)
	return string.format("singlebg/season/market/%s.png", arg_236_0)
end

function var_0_0.getActivityChapterLangPath(arg_237_0)
	return string.format("singlebg_lang/txt_versionactivityopen/%s.png", arg_237_0)
end

function var_0_0.getVersionActivityOpenPath(arg_238_0)
	return string.format("singlebg/versionactivityopen/%s.png", arg_238_0)
end

function var_0_0.getVersionActivityStoryCollect_1_2(arg_239_0)
	return string.format("singlebg/versionactivitystorycollect_1_2/%s.png", arg_239_0)
end

function var_0_0.getActivityWarmUpLangIcon(arg_240_0)
	return string.format("singlebg_lang/txt_activitywarmup/%s.png", arg_240_0)
end

function var_0_0.getVersionActivityDungeon_1_2(arg_241_0)
	return string.format("singlebg/versionactivitydungeon_1_2/%s.png", arg_241_0)
end

function var_0_0.getRadioIcon_1_3(arg_242_0)
	return string.format("singlebg/v1a3_radio_singlebg/%s.png", arg_242_0)
end

function var_0_0.getVersionActivityTrip_1_2(arg_243_0)
	return string.format("singlebg/versionactivitytrip_1_2/%s.png", arg_243_0)
end

function var_0_0.getActivityLangIcon(arg_244_0)
	return string.format("singlebg_lang/txt_activity/%s.png", arg_244_0)
end

function var_0_0.getActivityFullBg(arg_245_0)
	return string.format("singlebg/activity/full/%s.png", arg_245_0)
end

function var_0_0.getActivitiy119Icon(arg_246_0)
	return string.format("singlebg/v1a3_bookview_singlebg/%s.png", arg_246_0)
end

function var_0_0.getActivity1_3BuffIcon(arg_247_0)
	return string.format("singlebg/v1a3_buffview_singlebg/%s.png", arg_247_0)
end

function var_0_0.getJiaLaBoNaIcon(arg_248_0)
	return string.format("singlebg/v1a3_role1_singlebg/%s.png", arg_248_0)
end

function var_0_0.getJiaLaBoNaRoleModsIcon(arg_249_0)
	return string.format("singlebg/v1a3_role1_mods_singlebg/%s.png", arg_249_0)
end

function var_0_0.getFairyLandIcon(arg_250_0)
	return string.format("singlebg/v1a3_fairyland_singlebg/%s.png", arg_250_0)
end

function var_0_0.get1_3ChessMapIcon(arg_251_0)
	return string.format("singlebg/v1a3_role2_singlebg/%s.png", arg_251_0)
end

function var_0_0.getActivity1_3EnterIcon(arg_252_0)
	return string.format("singlebg/v1a3_enterview_singlebg/%s.png", arg_252_0)
end

function var_0_0.getV1a3TaskViewSinglebg(arg_253_0)
	return string.format("singlebg/v1a3_taskview_singlebg/%s.png", arg_253_0)
end

function var_0_0.getV1a3ArmSinglebg(arg_254_0)
	return string.format("singlebg/v1a3_arm_singlebg/%s.png", arg_254_0)
end

function var_0_0.getV1a3AstrologySinglebg(arg_255_0)
	return string.format("singlebg/v1a3_astrology_singlebg/%s.png", arg_255_0)
end

function var_0_0.getActivity133Icon(arg_256_0)
	return string.format("singlebg/v1a4_shiprepair/%s.png", arg_256_0)
end

function var_0_0.getRoleStoryIcon(arg_257_0)
	return string.format("singlebg/dungeon/rolestory_singlebg/%s.png", arg_257_0)
end

function var_0_0.getRoleStoryPhotoIcon(arg_258_0)
	return string.format("singlebg/dungeon/rolestory_photo_singlebg/%s.png", arg_258_0)
end

function var_0_0.getTurnbackIcon(arg_259_0)
	return string.format("singlebg/turnback/%s.png", arg_259_0)
end

function var_0_0.getV1a4BossRushSinglebg(arg_260_0)
	return string.format("singlebg/v1a4_bossrush_singlebg/%s.png", arg_260_0)
end

function var_0_0.getV1a4BossRushIcon(arg_261_0)
	return string.format("singlebg/v1a4_bossrush_bossicon_singlebg/%s.png", arg_261_0)
end

function var_0_0.getV1a4BossRushLangPath(arg_262_0)
	return string.format("singlebg_lang/txt_v1a4_bossrush_singlebg/%s.png", arg_262_0)
end

function var_0_0.getV1a4BossRushAssessIcon(arg_263_0)
	return string.format("singlebg/bossrush_assess_singlebg/%s.png", arg_263_0)
end

function var_0_0.getBossRushSinglebg(arg_264_0)
	return string.format("singlebg/bossrush/%s.png", arg_264_0)
end

function var_0_0.getV1a4Role37SingleBg(arg_265_0)
	return string.format("singlebg/v1a4_role37_singlebg/%s.png", arg_265_0)
end

function var_0_0.getV1a4Role6SingleBg(arg_266_0)
	return string.format("singlebg/v1a4_role37_singlebg/%s.png", arg_266_0)
end

function var_0_0.getV1a4DustRecordsIcon(arg_267_0)
	return string.format("singlebg/v1a4_dustyrecordsview/%s.png", arg_267_0)
end

function var_0_0.getV1Aa4DailyAllowanceIcon(arg_268_0)
	return string.format("singlebg/v1a4_gold_singlebg/%s.png", arg_268_0)
end

function var_0_0.getV1a5DungeonSingleBg(arg_269_0)
	return string.format("singlebg/v1a5_dungeon_singlebg/%s.png", arg_269_0)
end

function var_0_0.getV1a5EnterSingleBg(arg_270_0)
	return string.format("singlebg/v1a5_enterview_singlebg/%s.png", arg_270_0)
end

function var_0_0.getV1a5RevivalTaskSingleBg(arg_271_0)
	return string.format("singlebg/v1a5_revival_singlebg/%s.png", arg_271_0)
end

function var_0_0.getV1a5BuildSingleBg(arg_272_0)
	return string.format("singlebg/v1a5_building_singlebg/%s.png", arg_272_0)
end

function var_0_0.getDialogueSingleBg(arg_273_0)
	return string.format("singlebg/dialogue/%s.png", arg_273_0)
end

function var_0_0.getSummonFreeButton()
	return "ui/viewres/summon/summonfreebutton.prefab"
end

function var_0_0.getAchievementIcon(arg_275_0)
	return string.format("singlebg/achievement/%s.png", arg_275_0)
end

function var_0_0.getAchievementLangIcon(arg_276_0)
	return string.format("singlebg_lang/txt_achievement/%s.png", arg_276_0)
end

function var_0_0.getV1a4SignSingleBg(arg_277_0)
	return string.format("singlebg/v1a4_sign_singlebg/%s.png", arg_277_0)
end

function var_0_0.getV1a4SignSingleBgLang(arg_278_0)
	return string.format("singlebg_lang/txt_v1a4_sign_singlebg/%s.png", arg_278_0)
end

function var_0_0.getSummonBanner(arg_279_0)
	return string.format("singlebg/summon/banner/%s.png", arg_279_0)
end

function var_0_0.getSummonBannerLine(arg_280_0)
	return string.format("singlebg/summon/banner/bannerline/%s.png", arg_280_0)
end

function var_0_0.getV1a5News(arg_281_0)
	return string.format("singlebg/v1a5_news_singlebg/%s.png", arg_281_0)
end

function var_0_0.getV1a5SignSingleBg(arg_282_0)
	return string.format("singlebg/v1a5_sign_singlebg/%s.png", arg_282_0)
end

function var_0_0.getV1a5SignSingleBgLang(arg_283_0)
	return string.format("singlebg_lang/txt_v1a5_sign_singlebg/%s.png", arg_283_0)
end

function var_0_0.getV1a5AiZiLaItemIcon(arg_284_0)
	return string.format("singlebg/v1a5_aizila_icon/%s.png", arg_284_0)
end

function var_0_0.getV1a6DungeonSingleBg(arg_285_0)
	return string.format("singlebg/v1a6_dungeon_singlebg/%s.png", arg_285_0)
end

function var_0_0.getV1a6CachotIcon(arg_286_0)
	return string.format("singlebg/v1a6_cachot_singlebg/%s.png", arg_286_0)
end

function var_0_0.getV1a6SignSingleBg(arg_287_0)
	return string.format("singlebg/v1a6_sign_singlebg/%s.png", arg_287_0)
end

function var_0_0.getV1a6SignSingleBgLang(arg_288_0)
	return string.format("singlebg_lang/txt_v1a6_sign_singlebg/%s.png", arg_288_0)
end

function var_0_0.getV1a7SignSingleBg(arg_289_0)
	return string.format("singlebg/v1a7_signinview/%s.png", arg_289_0)
end

function var_0_0.getV1a7SignSingleBgLang(arg_290_0)
	return string.format("singlebg_lang/txt_v1a7_sign_singlebg/%s.png", arg_290_0)
end

function var_0_0.getSeason123Scene(arg_291_0, arg_291_1)
	return string.format("scenes/%s/scene_prefab/%s.prefab", arg_291_0, arg_291_1)
end

function var_0_0.getSeason123LayerDetailBg(arg_292_0, arg_292_1)
	return string.format("singlebg/%s/level/%s.png", arg_292_0, arg_292_1)
end

function var_0_0.getV1a8SignSingleBg(arg_293_0)
	return string.format("singlebg/v1a8_signinview/%s.png", arg_293_0)
end

function var_0_0.getV1a8DungeonSingleBg(arg_294_0)
	return string.format("singlebg/v1a8_dungeon_singlebg/%s.png", arg_294_0)
end

function var_0_0.getV1a8SignSingleBgLang(arg_295_0)
	return string.format("singlebg_lang/txt_v1a8_sign_singlebg/%s.png", arg_295_0)
end

function var_0_0.getSeason123RetailPrefab(arg_296_0, arg_296_1)
	return string.format("scenes/%s/prefab/%s.prefab", arg_296_0, arg_296_1)
end

function var_0_0.getSeason123ResetStageIcon(arg_297_0, arg_297_1)
	return string.format("singlebg/%s/reset/area/pic_%s.png", arg_297_0, arg_297_1)
end

function var_0_0.getSeason123EpisodeIcon(arg_298_0, arg_298_1)
	return string.format("singlebg/%s/loading/%s.png", arg_298_0, arg_298_1)
end

function var_0_0.getSeason123Icon(arg_299_0, arg_299_1)
	return string.format("singlebg/%s/%s.png", arg_299_0, arg_299_1)
end

function var_0_0.getTurnbackRecommendLangPath(arg_300_0)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_turnbackrecommend/%s.png", arg_300_0)
end

function var_0_0.getV1a9SignSingleBg(arg_301_0)
	return string.format("singlebg/v1a9_sign_singlebg/%s.png", arg_301_0)
end

function var_0_0.getV1a9LogoSingleBg(arg_302_0)
	return string.format("singlebg/v1a9_logo_singlebg/%s.png", arg_302_0)
end

function var_0_0.getV1a9WarmUpSingleBg(arg_303_0)
	return string.format("singlebg/v1a9_warmup_singlebg/v1a9_warmup_day%s.png", arg_303_0)
end

function var_0_0.getPermanentSingleBg(arg_304_0)
	return string.format("singlebg/dungeon/reappear/%s.png", arg_304_0)
end

function var_0_0.getMainSceneSwitchIcon(arg_305_0)
	return string.format("singlebg/mainsceneswitch_singlebg/%s.png", arg_305_0)
end

function var_0_0.getMainSceneSwitchLangIcon(arg_306_0)
	return string.format("singlebg_lang/txt_mainsceneswitch_singlebg/%s.png", arg_306_0)
end

function var_0_0.getRougeIcon(arg_307_0)
	return string.format("singlebg/rouge/%s.png", arg_307_0)
end

function var_0_0.getRougeBattleRoleIcon(arg_308_0)
	return string.format("singlebg/toughbattle_singlebg/role/%s.png", arg_308_0)
end

function var_0_0.getRougeSingleBgCollection(arg_309_0)
	return string.format("singlebg/rouge/collection/%s.png", arg_309_0)
end

function var_0_0.getRougeSingleBgDLC(arg_310_0)
	return string.format("singlebg/rouge/dlc/%s.png", arg_310_0)
end

function var_0_0.getRougeDLCLangImage(arg_311_0)
	return string.format("singlebg_lang/txt_rouge/dlc/%s.png", arg_311_0)
end

function var_0_0.getGraffitiIcon(arg_312_0)
	return string.format("singlebg/v2a0_graffiti_singlebg/%s.png", arg_312_0)
end

function var_0_0.getV2a0SignSingleBg(arg_313_0)
	return string.format("singlebg/v2a0_sign_singlebg/%s.png", arg_313_0)
end

function var_0_0.getV2a0SignSingleBgLang(arg_314_0)
	return string.format("singlebg_lang/txt_v2a0_sign_singlebg/%s.png", arg_314_0)
end

function var_0_0.getV2a0WarmUpSingleBg(arg_315_0)
	return string.format("singlebg/v2a0_warmup_singlebg/%s.png", arg_315_0)
end

function var_0_0.getV2a1SignSingleBg(arg_316_0)
	return string.format("singlebg/v2a1_sign_singlebg/%s.png", arg_316_0)
end

function var_0_0.getV2a1SignSingleBgLang(arg_317_0)
	return string.format("singlebg_lang/txt_v2a1_sign_singlebg/%s.png", arg_317_0)
end

function var_0_0.getV2a1AergusiSingleBg(arg_318_0)
	return string.format("singlebg/v2a1_aergusi_singlebg/%s.png", arg_318_0)
end

function var_0_0.getV2a1MoonFestivalSignSingleBg(arg_319_0)
	return string.format("singlebg/v2a1_moonfestival_singlebg/%s.png", arg_319_0)
end

function var_0_0.getV2a1MoonFestivalSignSingleBgLang(arg_320_0)
	return string.format("singlebg_lang/txt_v2a1_moonfestival_singlebg/%s.png", arg_320_0)
end

function var_0_0.getV2a1WarmUpSingleBg(arg_321_0)
	return string.format("singlebg/v2a1_warmup_singlebg/%s.png", arg_321_0)
end

function var_0_0.getV2a2SignSingleBg(arg_322_0)
	return string.format("singlebg/v2a2_sign_singlebg/%s.png", arg_322_0)
end

function var_0_0.getV2a2SignSingleBgLang(arg_323_0)
	return string.format("singlebg_lang/txt_v2a2_logo/%s.png", arg_323_0)
end

function var_0_0.getV2a2RedLeafFestivalSignSingleBg(arg_324_0)
	return string.format("singlebg/v2a2_redleaffestival_singlebg/%s.png", arg_324_0)
end

function var_0_0.getV2a2RedLeafFestivalSignSingleBgLang(arg_325_0)
	return string.format("singlebg_lang/txt_v2a2_redleaffestival_singlebg/%s.png", arg_325_0)
end

function var_0_0.getV2a3SignSingleBg(arg_326_0)
	return string.format("singlebg/v2a3_sign_singlebg/%s.png", arg_326_0)
end

function var_0_0.getV2a3SignSingleBgLang(arg_327_0)
	return string.format("singlebg_lang/txt_v2a3_sign_singlebg/%s.png", arg_327_0)
end

function var_0_0.getV2a3WarmUpSingleBg(arg_328_0)
	return string.format("singlebg/v2a3_warmup_singlebg/%s.png", arg_328_0)
end

function var_0_0.getV2a4SignSingleBg(arg_329_0)
	return string.format("singlebg/v2a4_sign_singlebg/%s.png", arg_329_0)
end

function var_0_0.getV2a4SignSingleBgLang(arg_330_0)
	return string.format("singlebg_lang/txt_v2a4_sign_singlebg/%s.png", arg_330_0)
end

function var_0_0.getChessDialogueSingleBg(arg_331_0)
	return string.format("singlebg/dialogue/chess/%s.png", arg_331_0)
end

function var_0_0.getV2a5SignSingleBg(arg_332_0)
	return string.format("singlebg/v2a5_sign_singlebg/%s.png", arg_332_0)
end

function var_0_0.getV2a5SignSingleBgLang(arg_333_0)
	return string.format("singlebg_lang/txt_v2a5_sign_singlebg/%s.png", arg_333_0)
end

local var_0_1 = "Assets/ZResourcesLib/"
local var_0_2 = string.len(var_0_1)

function var_0_0.getPathWithoutAssetLib(arg_334_0)
	local var_334_0 = string.find(arg_334_0, var_0_1)

	if var_334_0 then
		return string.sub(arg_334_0, var_334_0 + var_0_2)
	end

	return arg_334_0
end

function var_0_0.getV2a1Act165SingleBgLang(arg_335_0)
	return string.format("singlebg/v2a1_strangetale_singlebg/%s.png", arg_335_0)
end

function var_0_0.monsterHeadIcon(arg_336_0)
	return string.format("singlebg/headicon_monster/%s.png", tostring(arg_336_0))
end

function var_0_0.roomHeadIcon(arg_337_0)
	return string.format("singlebg/headicon_room/%s.png", tostring(arg_337_0))
end

function var_0_0.getCritterHedaIcon(arg_338_0)
	return string.format("singlebg/headicon_critter/%s.png", tostring(arg_338_0))
end

function var_0_0.getCritterLargeIcon(arg_339_0)
	return string.format("singlebg/largeicon_critter/%s.png", tostring(arg_339_0))
end

function var_0_0.getRoomCritterIcon(arg_340_0)
	return string.format("singlebg/room/critter/%s.png", tostring(arg_340_0))
end

function var_0_0.getRoomCritterEggPrefab(arg_341_0)
	return string.format("ui/viewres/room/critter/egg/%s.prefab", arg_341_0)
end

function var_0_0.getBgmEggIcon(arg_342_0)
	return string.format("singlebg/bgmtoggle_singlebg/%s.png", tostring(arg_342_0))
end

function var_0_0.getTowerIcon(arg_343_0)
	return string.format("singlebg/tower_singlebg/%s.png", tostring(arg_343_0))
end

function var_0_0.getAct174BadgeIcon(arg_344_0, arg_344_1)
	return string.format("singlebg/act174/badgeicon/%s_%s.png", arg_344_0, arg_344_1)
end

function var_0_0.getAct174BuffIcon(arg_345_0)
	return string.format("singlebg/act174/bufficon/%s.png", arg_345_0)
end

function var_0_0.getV2a4WuErLiXiIcon(arg_346_0)
	return string.format("singlebg/v2a4_wuerlixi_singlebg/%s.png", arg_346_0)
end

function var_0_0.getAutoChessIcon(arg_347_0, arg_347_1)
	if arg_347_1 then
		return string.format("singlebg/v2a5_autochess_singlebg/%s/%s.png", arg_347_1, arg_347_0)
	else
		return string.format("singlebg/v2a5_autochess_singlebg/%s.png", arg_347_0)
	end
end

function var_0_0.getChallengeIcon(arg_348_0)
	return string.format("singlebg/v2a5_challenge_singlebg/%s.png", arg_348_0)
end

function var_0_0.getAct184LanternIcon(arg_349_0)
	return string.format("singlebg/v2a5_lanternfestival_singlebg/%s.png", arg_349_0)
end

function var_0_0.getV2a5FeiLinShiDuoBg(arg_350_0)
	return string.format("singlebg/v2a5_feilinshiduo_singlebg/%s.png", arg_350_0)
end

function var_0_0.getLiveHeadIconPrefab(arg_351_0)
	return (string.format("ui/viewres/dynamichead/%s.prefab", tostring(arg_351_0)))
end

function var_0_0.getAntiqueEffect(arg_352_0)
	return (string.format("ui/viewres/antique/effect/%s.prefab", tostring(arg_352_0)))
end

function var_0_0.getDestinyIcon(arg_353_0)
	return (string.format("singlebg/characterdestiny/stone/%s.png", tostring(arg_353_0)))
end

function var_0_0.getV2a4WarmUpSingleBg(arg_354_0)
	return string.format("singlebg/v2a4_warmup_singlebg/%s.png", arg_354_0)
end

function var_0_0.getDecorateStoreImg(arg_355_0)
	return (string.format("singlebg/store/decorate/%s.png", tostring(arg_355_0)))
end

function var_0_0.getV2a5LiangYueImg(arg_356_0)
	return (string.format("singlebg_lang/txt_v2a5_liangyue_singlebg/%s.png", tostring(arg_356_0)))
end

function var_0_0.getShortenActSingleBg(arg_357_0)
	return string.format("singlebg/shortenact_singlebg/%s.png", arg_357_0)
end

function var_0_0.getAct191SingleBg(arg_358_0)
	return string.format("singlebg/act191/%s.png", arg_358_0)
end

function var_0_0.getV2a7WarmUpSingleBg(arg_359_0)
	return string.format("singlebg/v2a7_warmup_singlebg/%s.png", arg_359_0)
end

function var_0_0.getSurvivalItemIcon(arg_360_0)
	return string.format("singlebg/survival_singlebg/collection/%s.png", arg_360_0)
end

function var_0_0.getSurvivalTalentIcon(arg_361_0)
	return string.format("singlebg/survival_singlebg/talent/%s.png", arg_361_0)
end

function var_0_0.getSurvivalMapIcon(arg_362_0)
	return string.format("singlebg/survival_singlebg/map/%s.png", arg_362_0)
end

function var_0_0.getSurvivalNpcIcon(arg_363_0)
	return string.format("singlebg/survival_singlebg/npc/%s.png", arg_363_0)
end

function var_0_0.getSurvivalEquipIcon(arg_364_0)
	return string.format("singlebg/survival_singlebg/equip/icon/%s.png", arg_364_0)
end

function var_0_0.getNuoDiKaSingleBg(arg_365_0)
	return string.format("singlebg/v2a8_nuodika_singlebg/%s.png", arg_365_0)
end

function var_0_0.getNuoDiKaItemIcon(arg_366_0)
	return string.format("singlebg/v2a8_nuodika_singlebg/item/%s.png", arg_366_0)
end

function var_0_0.getNuoDiKaMonsterIcon(arg_367_0)
	return string.format("singlebg/v2a8_nuodika_singlebg/monster/%s.png", arg_367_0)
end

function var_0_0.getActivity2ndTakePhotoSingleBg(arg_368_0)
	return string.format("singlebg/v2a8_gift_singlebg/%s", arg_368_0)
end

function var_0_0.getDecorateStoreBuyBannerFullPath(arg_369_0)
	return string.format("singlebg_lang/txt_playercard_singlebg/%s.png", arg_369_0)
end

function var_0_0.getV2a8WarmUpSingleBg(arg_370_0)
	return string.format("singlebg/v2a8_warmup_singlebg/%s.png", arg_370_0)
end

function var_0_0.getCommandStationPaperIcon(arg_371_0)
	return string.format("singlebg/commandstation/paper/%s.png", arg_371_0)
end

function var_0_0.getV3a0WarmUpSingleBg(arg_372_0)
	return string.format("singlebg/v3a0_warmup_singlebg/%s.png", arg_372_0)
end

function var_0_0.getSp01AssassinSingleBg(arg_373_0)
	return string.format("singlebg/assassin2_singlebg/%s.png", arg_373_0)
end

function var_0_0.getSp01OdysseySingleBg(arg_374_0)
	return string.format("singlebg/odyssey_singlebg/%s.png", arg_374_0)
end

function var_0_0.getSp01OdysseyItemSingleBg(arg_375_0)
	return string.format("singlebg/odyssey_singlebg/equip/%s.png", arg_375_0)
end

function var_0_0.getV2a9VersionSummonSingleBg(arg_376_0)
	return string.format("singlebg/v2a9_versionsummon_singlebg/%s.png", arg_376_0)
end

function var_0_0.getV2a9VersionSummonSingleBgLang(arg_377_0)
	return string.format("singlebg_lang/txt_v2a9_versionsummon_singlebg/%s.png", arg_377_0)
end

function var_0_0.getV2a9ActSingleBg(arg_378_0)
	return string.format("singlebg/v2a9_act_singlebg/%s.png", arg_378_0)
end

function var_0_0.getV2a9ActOceanSingleBg(arg_379_0)
	return string.format("singlebg/v2a9_act_singlebg/ocean/%s.png", arg_379_0)
end

function var_0_0.getV2a9WarmUpSingleBg(arg_380_0)
	return string.format("singlebg/v2a9_warmup_singlebg/%s.png", arg_380_0)
end

return var_0_0
