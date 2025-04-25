module("modules.logic.defines.ResUrl", package.seeall)

slot0 = _M

function slot0.getSummonBanner(slot0)
	return string.format("singlebg/summon/banner/%s.png", slot0)
end

function slot0.getSummonBannerLine(slot0)
	return string.format("singlebg/summon/banner/bannerline/%s.png", slot0)
end

function slot0.getV2a0SignSingleBg(slot0)
	return string.format("singlebg/v2a0_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a0SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v2a0_sign_singlebg/%s.png", slot0)
end

function slot0.getShortenActSingleBg(slot0)
	return string.format("singlebg/shortenact_singlebg/%s.png", slot0)
end

function slot0.getSceneLevelUrl(slot0)
	if lua_scene_level.configDict[slot0] then
		return string.format("scenes/%s/%s_p.prefab", slot1.resName, slot1.resName)
	else
		logError("scene level config not exist, levelId = " .. slot0)
	end
end

function slot0.getExploreSceneLevelUrl(slot0)
	if lua_scene_level.configDict[slot0] then
		return string.format("explore/scene/prefab/%s_p.prefab", slot1.resName)
	else
		logError("scene level config not exist, levelId = " .. slot0)
	end
end

function slot0.getSceneUrl(slot0)
	return string.format("scenes/%s/%s_p.prefab", slot0, slot0)
end

function slot0.getSpineFightPrefab(slot0)
	return uv0.getRolesPrefab(slot0, "fight")
end

function slot0.getRolesPrefab(slot0, slot1)
	slot2 = nil

	return string.format("roles/%s_%s.prefab", string.find(slot0, "/") and slot0 or string.format("%s/%s", slot0, slot0), slot1)
end

function slot0.getRolesBustPrefab(slot0)
	slot1 = nil

	return string.format("roles_bust/%s.prefab", string.find(slot0, "/") and slot0 or string.format("%s/%s", slot0, slot0))
end

function slot0.getSpineFightPrefabBySkin(slot0)
	if not slot0 then
		return ""
	end

	slot1 = nil

	if slot0.fight_special == 1 then
		return string.format("roles/%s_fight_special.prefab", (not string.find(slot0.spine, "/") or slot0.spine) and string.format("%s/%s", slot0.spine, slot0.spine))
	else
		return string.format("roles/%s_fight.prefab", slot1)
	end
end

function slot0.getRolesPrefabStory(slot0)
	return AvProMgr.instance:getRolesprefabUrl(string.format("rolesstory/rolesprefab/%s/%s.prefab", SkinConfig.instance:getFolderName(slot0), slot0))
end

function slot0.getRolesCgStory(slot0, slot1)
	return string.format("rolesstory/rolescg/%s/%s.prefab", slot1 or SkinConfig.instance:getFolderName(slot0), slot0)
end

function slot0.getLightSpine(slot0)
	return AvProMgr.instance:getRolesprefabUrl(string.format("rolesstory/rolesprefab/%s/%s_light.prefab", SkinConfig.instance:getFolderName(slot0), slot0))
end

function slot0.getLightLive2d(slot0)
	return string.format("live2d/roles/%s/%s.prefab", SkinConfig.instance:getFolderName(slot0), slot0)
end

function slot0.getLightLive2dFolder(slot0)
	return string.format("live2d/roles/%s/", SkinConfig.instance:getFolderName(slot0))
end

function slot0.getRolesPrefabStoryFolder(slot0)
	return string.format("rolesstory/rolesprefab/%s/", SkinConfig.instance:getFolderName(slot0))
end

function slot0.getSpineRoomPrefab(slot0)
	return uv0.getRolesPrefab(slot0, "room")
end

function slot0.getSpineUIPrefab(slot0)
	return uv0.getRolesPrefab(slot0, "ui")
end

function slot0.getSkillTimeline(slot0)
	return string.format("rolestimeline/%s.playable", slot0)
end

function slot0.getRolesTimeline()
	return "rolestimeline"
end

function slot0.getLoginBg(slot0)
	return string.format("singlebg/loginbg/%s.png", slot0)
end

function slot0.getLoadingBg(slot0)
	return string.format("singlebg/loading/%s.png", slot0)
end

function slot0.getMailBg(slot0)
	return string.format("singlebg/mail/%s.png", slot0)
end

function slot0.getCommonViewBg(slot0)
	return string.format("singlebg/common/viewbg/%s.jpg", slot0)
end

function slot0.getCommonIcon(slot0)
	return string.format("singlebg/common/%s.png", slot0)
end

function slot0.getDungeonIcon(slot0)
	return string.format("singlebg/dungeon/%s.png", slot0)
end

function slot0.getDungeonChapterBg(slot0)
	return string.format("ui/viewres/dungeon/chapter/bg/%s.prefab", slot0)
end

function slot0.getDungeonInteractiveItemBg(slot0)
	return string.format("singlebg/dungeon/interactiveitem/%s.png", slot0)
end

function slot0.getDungeonRuleIcon(slot0)
	return string.format("singlebg/dungeon/level_rule/%s.png", slot0)
end

function slot0.getDungeonFragmentIcon(slot0)
	return string.format("singlebg/dungeon/fragmenticon/%s.png", slot0)
end

function slot0.getFightQuitResultIcon(slot0)
	return string.format("singlebg/fight/result/%s.png", slot0)
end

function slot0.getFightGuideIcon(slot0)
	return string.format("singlebg/fight/fightguide/bg_zhiying_%s.png", slot0)
end

function slot0.getFightGuideDir()
	return "Assets/ZResourcesLib/singlebg/fight/fightguide"
end

function slot0.getBackpackItemIcon(slot0)
	return string.format("singlebg/backpackitem/%s.png", slot0)
end

function slot0.getSummonHeroIcon(slot0)
	return string.format("singlebg/summon/hero/%s.png", slot0)
end

function slot0.getSummonEquipIcon(slot0)
	return string.format("singlebg/summon/equip/%s.png", slot0)
end

function slot0.getSummonEquipGetIcon(slot0)
	return string.format("singlebg/summon/equipget/%s.png", slot0)
end

function slot0.getSummonBannerFullPath(slot0)
	return string.format("singlebg_lang/txt_summon/banner/%s.png", slot0)
end

function slot0.getAdventureTaskLangPath(slot0)
	return string.format("singlebg_lang/txt_adventuretask/%s.png", slot0)
end

function slot0.getSummonCoverBg(slot0)
	return string.format("singlebg/summon/%s.png", slot0)
end

function slot0.getSummonHeroMask(slot0)
	return string.format("singlebg/summon/mask/%s.png", slot0)
end

function slot0.getSummonSceneTexture(slot0)
	return string.format("scenes/dynamic/m_s06_summon/%s.png", slot0)
end

function slot0.getSignature(slot0, slot1)
	if slot1 then
		return string.format("singlebg/signature/%s/%s.png", slot1, slot0)
	else
		return string.format("singlebg/signature/%s.png", slot0)
	end
end

function slot0.getSceneUIPrefab(slot0, slot1)
	return string.format("ui/sceneui/%s/%s.prefab", slot0, slot1)
end

function slot0.getCharacterIcon(slot0)
	return string.format("singlebg/character/%s.png", slot0)
end

function slot0.getCharacterItemIcon(slot0)
	return string.format("singlebg/characteritem/%s.png", slot0)
end

function slot0.getCharacterDataIcon(slot0)
	return string.format("singlebg/characterdata/%s", slot0)
end

function slot0.getCharacterExskill(slot0)
	return string.format("singlebg/characterexskill/%s.png", slot0)
end

function slot0.getCharacterGetIcon(slot0)
	return string.format("singlebg/characterget/%s.png", slot0)
end

function slot0.getCharacterSkinIcon(slot0)
	return string.format("singlebg/characterskin/%s.png", slot0)
end

function slot0.getCharacterSkinLive2dBg(slot0)
	return string.format("singlebg/characterskin/live2dbg/%s.png", slot0)
end

function slot0.getHeadSkinIconMiddle(slot0)
	return string.format("singlebg/headskinicon_middle/%s.png", slot0)
end

function slot0.getHeadSkinIconLarge(slot0)
	return string.format("singlebg/headskinicon_large/%s.jpg", slot0)
end

function slot0.getSkillEffect(slot0)
	return string.format("singlebg/characteritem/skilleffect/effect_%s.png", slot0)
end

function slot0.getCharacterRareBg(slot0)
	return string.format("singlebg/characteritem/jskp_0%d.png", slot0)
end

function slot0.getCharacterRareBgNew(slot0)
	return string.format("singlebg/characteritem/jskp_0%d.png", slot0)
end

function slot0.getTipsBg(slot0)
	return string.format("singlebg/tips/%s.png", slot0)
end

function slot0.getTipsCharacterRareBg(slot0)
	return string.format("singlebg/tips/jskp_0%d.png", slot0)
end

function slot0.getTipsCharacterColorBg(slot0)
	return string.format("singlebg/tips/pfkp_00%d.png", slot0)
end

function slot0.getPropItemIcon(slot0)
	return string.format("singlebg/propitem/prop/%s.png", slot0)
end

function slot0.getPropItemIconSmall(slot0)
	return string.format("singlebg/propitem/prop_small/%s.png", slot0)
end

function slot0.getAntiqueIcon(slot0)
	return string.format("singlebg/antique_singlebg/%s.png", slot0)
end

function slot0.getSpecialPropItemIcon(slot0)
	return string.format("singlebg/propitem/special/%s.png", slot0)
end

function slot0.getCurrencyItemIcon(slot0)
	return string.format("singlebg/currencyitem/%s.png", slot0)
end

function slot0.getCritterItemIcon(slot0)
	return string.format("singlebg/propitem/critter/%s.png", slot0)
end

function slot0.getEffect(slot0)
	return string.format("effects/prefabs/%s.prefab", slot0)
end

function slot0.getStoryBgEffect(slot0)
	return string.format("ui/viewres/story/bg/%s.prefab", slot0)
end

function slot0.getStoryBgMaterial(slot0)
	return string.format("ui/materials/storybg/%s.mat", slot0)
end

function slot0.getUIEffect(slot0)
	return string.format("ui/viewres/effect/%s.prefab", slot0)
end

function slot0.getSceneEffect(slot0)
	return string.format("effects/prefabs/buff/%s.prefab", slot0)
end

function slot0.getFightLoadingIcon(slot0)
	return string.format("singlebg/fight/loading/%s.png", tostring(slot0))
end

function slot0.getSkillIcon(slot0)
	if SDKModel.instance:isDmm() and slot0 == 30060121 then
		return "singlebg/fight/skill/30060121_dmm.png"
	else
		return string.format("singlebg/fight/skill/%s.png", tostring(slot0))
	end
end

function slot0.getPassiveSkillIcon(slot0)
	return string.format("singlebg/fight/passive/%s.png", tostring(slot0))
end

function slot0.getClothSkillIcon(slot0)
	return string.format("singlebg/fight/cloth/%s.png", tostring(slot0))
end

function slot0.getAttributeIcon(slot0)
	return string.format("singlebg/fight/attribute/%s.png", tostring(slot0))
end

function slot0.getFightCardDescIcon(slot0)
	return string.format("singlebg/fight/carddesc/%s.png", tostring(slot0))
end

function slot0.getFightResultcIcon(slot0)
	return string.format("singlebg/fight/result/%s.png", tostring(slot0))
end

function slot0.getFightSkillTargetcIcon(slot0)
	return string.format("singlebg/fight/skilltarget/%s.png", tostring(slot0))
end

function slot0.getStoryRes(slot0)
	if SDKModel.instance:isDmm() and slot0 == "story_bg/bg/cg_sanrenxing.jpg" then
		return "singlebg/storybg/story_bg/bg/cg_sanrenxing_dmm.jpg"
	else
		return string.format("singlebg/storybg/%s", tostring(slot0))
	end
end

function slot0.getStoryBg(slot0)
	return string.format("singlebg/storybg/%s", tostring(slot0))
end

function slot0.getStoryPrologueSkip(slot0)
	return string.format("singlebg/storybg/prologueskip/%s.png", tostring(slot0))
end

function slot0.getStorySmallBg(slot0)
	return string.format("singlebg/storybg/smallbg/%s", tostring(slot0))
end

function slot0.getStoryEpisodeIcon(slot0)
	return string.format("ui/viewres/storynavigate/%s", tostring(slot0))
end

function slot0.getStoryItem(slot0)
	slot2 = string.format("singlebg/storybg/item/%s", tostring(slot0))
	slot3 = string.format("singlebg_lang/txt_story/%s", tostring(slot0))
	slot4 = false

	for slot8, slot9 in pairs({
		"1_2tanchuang",
		"v2a5_liangyue_story"
	}) do
		if string.match(slot0, slot9) then
			slot4 = true

			break
		end
	end

	return slot4 and slot3 or slot2
end

function slot0.getStoryLangPath(slot0)
	return string.format("singlebg_lang/txt_story/%s.png", tostring(slot0))
end

function slot0.getCameraAnim(slot0)
	return string.format("effects/cameraanim/%s.controller", slot0)
end

function slot0.getCameraAnimABUrl()
	return "effects/cameraanim"
end

function slot0.getEntityAnim(slot0)
	return string.format("effects/entityanim/%s.anim", slot0)
end

function slot0.getEntityAnimABUrl()
	return "effects/entityanim"
end

function slot0.getHeadIconSmall(slot0)
	return string.format("singlebg/headicon_small/%s.png", slot0)
end

function slot0.getEquipIconSmall(slot0)
	return string.format("scenes/dynamic/m_s03_xx/equipicon_small/%s.png", slot0)
end

function slot0.getHeadIconNew(slot0)
	return string.format("singlebg/propitem/hero/%s.png", slot0)
end

function slot0.getHeroSkinPropIcon(slot0)
	return string.format("singlebg/propitem/heroskin/%s.png", slot0)
end

function slot0.getHeadIconMiddle(slot0)
	return string.format("singlebg/headicon_middle/%s.png", slot0)
end

function slot0.getHeadIconLarge(slot0)
	return string.format("singlebg/headicon_large/%s.png", slot0)
end

function slot0.getHeadIconImg(slot0)
	return string.format("singlebg/headicon_img/%s.png", slot0)
end

function slot0.getHeadSkinSmall(slot0)
	return string.format("singlebg/headskinicon_small/%s.png", slot0)
end

function slot0.getCharacterDataPic(slot0)
	return string.format("singlebg/data_pic/%s.png", slot0)
end

function slot0.getHeroGroupBg(slot0)
	return string.format("singlebg/herogroup/%s.png", slot0)
end

function slot0.getHeroDefaultEquipIcon(slot0)
	return string.format("singlebg/equip_defaulticon/%s.png", slot0)
end

function slot0.getTaskBg(slot0)
	return string.format("singlebg/task/%s.png", slot0)
end

function slot0.getEquipRareIcon(slot0)
	return string.format("singlebg/equipment/rare/%s.png", slot0)
end

function slot0.getEquipIcon(slot0)
	return string.format("singlebg/equipment/icon/%s.png", slot0)
end

function slot0.getEquipSuit(slot0)
	return string.format("singlebg/equipment/suit/%s.png", slot0)
end

function slot0.getEquipRes(slot0)
	return string.format("singlebg/equipment/%s.png", slot0)
end

function slot0.getHelpItem(slot0, slot1)
	return string.format("singlebg/help/%s.png", slot0)
end

function slot0.getVersionActivityHelpItem(slot0, slot1)
	return string.format("singlebg/versionactivityhelp/%s.png", slot0)
end

function slot0.getBannerIcon(slot0)
	return string.format("singlebg/banner/%s.png", slot0)
end

function slot0.getRoleSpineMat(slot0)
	return string.format("rolesbuff/%s.mat", slot0)
end

function slot0.getRoleSpineMatTex(slot0)
	return string.format("rolesbuff/%s.png", slot0)
end

function slot0.getSettingsBg(slot0)
	return string.format("singlebg/settings/%s", slot0)
end

function slot0.getAdventureBg(slot0)
	return string.format("singlebg/adventure/%s.png", slot0)
end

function slot0.getExploreBg(slot0)
	return string.format("singlebg/explore/%s.png", slot0)
end

function slot0.getAdventureIcon(slot0)
	return string.format("singlebg/adventure/iconnew/%s.png", slot0)
end

function slot0.getAdventureEntrance(slot0)
	return string.format("singlebg/adventure/entrance/%s.png", slot0)
end

function slot0.getAdventureTarotIcon(slot0)
	return string.format("singlebg/adventure/tarot/%s.png", slot0)
end

function slot0.getAdventureTarotSmallIcon(slot0)
	return string.format("singlebg/adventure/tarotsmall/%s.png", slot0)
end

function slot0.getAdventureMagicIcon(slot0, slot1)
	return string.format("singlebg/adventure/magic/%s/%s.png", slot0, slot1)
end

function slot0.getAdventureTarotQuality(slot0)
	return string.format("singlebg/adventure/tarot_quality/tarot_quality_%s.png", slot0)
end

function slot0.getAdventureTask(slot0)
	return string.format("singlebg/adventure/task/%s.png", slot0)
end

function slot0.getPlayerClothIcon(slot0)
	return string.format("singlebg/player/cloth/%s.png", slot0)
end

function slot0.getPlayerBg(slot0)
	return string.format("singlebg/player/%s.png", slot0)
end

function slot0.getPlayerCardIcon(slot0)
	return string.format("singlebg/playercard/%s.png", slot0)
end

function slot0.getStoreBottomBgIcon(slot0)
	return string.format("singlebg/store/%s.png", slot0)
end

function slot0.getStoreGiftPackBg(slot0)
	return string.format("singlebg/store/giftpacksview/%s.png", slot0)
end

function slot0.getStorePackageIcon(slot0)
	if string.nilorempty(slot0) then
		return uv0.getCurrencyItemIcon(201)
	else
		return string.format("singlebg/store/package/%s.png", slot0)
	end
end

function slot0.getStoreTagIcon(slot0)
	return string.format("singlebg/store/tag_%s.png", slot0)
end

function slot0.getStoreRecommend(slot0)
	return string.format("singlebg/store/recommend/%s.png", slot0)
end

function slot0.getStoreWildness(slot0)
	return string.format("singlebg/store/wildness/%s.png", slot0)
end

function slot0.getStoreSkin(slot0)
	return string.format("singlebg/store/skin/%s.png", slot0)
end

function slot0.getNoticeBg(slot0)
	return string.format("singlebg/notice/%s.png", slot0)
end

function slot0.getNoticeContentIcon(slot0, slot1)
	return string.format("singlebg/notice/hd_%d_%d.png", slot0, slot1)
end

function slot0.getSignInBg(slot0)
	return string.format("singlebg/signin/%s.png", slot0)
end

function slot0.getActivityBg(slot0)
	return string.format("singlebg/activity/%s.png", slot0)
end

function slot0.getActivityMapBg(slot0)
	return string.format("singlebg/activity/%s", slot0)
end

function slot0.getPowerBuyBg(slot0)
	return string.format("singlebg/powerbuy/%s.png", slot0)
end

function slot0.getEquipBg(slot0)
	return string.format("singlebg/equip/%s", slot0)
end

function slot0.getMessageIcon(slot0)
	return string.format("singlebg/message/%s.png", slot0)
end

function slot0.getSocialIcon(slot0)
	return string.format("singlebg/social/%s", slot0)
end

function slot0.getFightIcon(slot0)
	return string.format("singlebg/fight/icon/%s", slot0)
end

function slot0.getFightImage(slot0)
	return string.format("singlebg/fight/%s", slot0)
end

function slot0.getFightSpecialTipIcon(slot0)
	return string.format("singlebg/fight/specialtip/%s", slot0)
end

function slot0.getNickNameIcon(slot0)
	return string.format("singlebg/nickname/%s.png", slot0)
end

function slot0.getRoomRes(slot0)
	return string.format("scenes/m_s07_xiaowu/prefab/%s.prefab", slot0)
end

function slot0.getRoomResAB(slot0)
	return string.format("scenes/m_s07_xiaowu/prefab/%s", slot0)
end

function slot0.getRoomGetIcon(slot0)
	return string.format("singlebg/roomget/%s.png", slot0)
end

function slot0.getRoomBlockPackageRewardIcon(slot0)
	return string.format("singlebg/roomget/blockpackage/%s.jpg", slot0)
end

function slot0.getRoomBuildingRewardIcon(slot0)
	return string.format("singlebg/roomget/building/%s.jpg", slot0)
end

function slot0.getRoomThemeRewardIcon(slot0)
	return string.format("singlebg/roomget/theme/%s.jpg", slot0)
end

function slot0.getSpineBxhyPrefab(slot0)
	return uv0.getRolesPrefab(slot0, "room")
end

function slot0.getSpineUIBxhyPrefab(slot0)
	return uv0.getRolesPrefab(slot0, "ui")
end

function slot0.getSpineBxhyMaterial(slot0)
	slot1 = nil

	return string.format("roles/%s_bxhy_material.mat", string.find(slot0, "/") and slot0 or string.format("%s/%s", slot0, slot0))
end

function slot0.getSceneRes(slot0)
	return string.format("scenes/%s/%s_p.prefab", slot0, slot0)
end

function slot0.getDungeonMapRes(slot0)
	return string.format("scenes/%s.prefab", slot0)
end

function slot0.getRoomImage(slot0)
	return string.format("singlebg/room/%s.png", slot0)
end

function slot0.getMainImage(slot0)
	return string.format("singlebg/main/%s.png", slot0)
end

function slot0.getMainActivityIcon(slot0)
	return string.format("singlebg_lang/txt_main/%s.png", slot0)
end

function slot0.getHandbookBg(slot0)
	return string.format("singlebg/handbook/%s.png", slot0)
end

function slot0.getHandbookCharacterIcon(slot0)
	return string.format("singlebg/handbook/character/%s.png", slot0)
end

function slot0.getHandbookheroIcon(slot0)
	return string.format("singlebg/handbookheroicon/%s.png", slot0)
end

function slot0.getHandbookEquipImage(slot0)
	return string.format("singlebg/handbook/equip/%s.png", slot0)
end

function slot0.getCharacterTalentUpIcon(slot0)
	return string.format("singlebg/charactertalentup/%s.png", slot0)
end

function slot0.getWeekWalkBg(slot0)
	return string.format("singlebg/weekwalk/%s", slot0)
end

function slot0.getWeekWalkIcon(slot0)
	return string.format("singlebg/weekwalk/%s.png", slot0)
end

function slot0.getVideo(slot0)
	return string.format("videos/%s.mp4", slot0)
end

function slot0.getCharacterTalentUpTexture(slot0)
	return string.format("singlebg/textures/charactertalentup/%s.png", slot0)
end

function slot0.getWeatherEffect(slot0)
	return string.format("effects/prefabs/roleeffects/%s.prefab", slot0)
end

function slot0.getPlayerViewTexture(slot0)
	return string.format("singlebg/textures/playerview/%s.png", slot0)
end

function slot0.getCommonitemEffect(slot0)
	return string.format("ui/viewres/common/effect/%s.prefab", slot0)
end

function slot0.getDungeonPuzzleBg(slot0)
	return string.format("singlebg/dungeon/puzzle/%s.png", slot0)
end

function slot0.getUIMaskTexture(slot0)
	return string.format("singlebg/textures/uimask/%s.png", slot0)
end

function slot0.getRoomTexture(slot0)
	return string.format("singlebg/textures/room/%s", slot0)
end

function slot0.getActivityTexture(slot0)
	return string.format("singlebg/textures/activity/%s", slot0)
end

function slot0.getTeachNoteImage(slot0)
	return string.format("singlebg/teachnote/%s", slot0)
end

function slot0.getWeekWalkTarotIcon(slot0)
	return string.format("singlebg/weekwalk/tarot/%s.png", slot0)
end

function slot0.getFightTechniqueGuide(slot0, slot1)
	if slot1 then
		return string.format("singlebg/versionactivitytechniqueguide/%s.png", slot0)
	else
		return string.format("singlebg/fight/techniqueguide/%s.png", slot0)
	end
end

function slot0.getFightEquipFloatIcon(slot0)
	return string.format("singlebg/fight/equipeffect/%s.png", slot0)
end

function slot0.getFightGuideLangIcon(slot0)
	return string.format("singlebg_lang/txt_fightguide/bg_zhiying_%s.png", slot0)
end

function slot0.getFightGuideLangDir()
	return "Assets/ZResourcesLib/singlebg_lang/txt_fightguide"
end

function slot0.getLoginBgLangIcon(slot0)
	return string.format("singlebg_lang/txt_loginbg/%s.png", slot0)
end

function slot0.getTechniqueLangIcon(slot0, slot1)
	if slot1 then
		return string.format("singlebg_lang/txt_fighttechniquetips/%s.png", slot0)
	else
		return string.format("singlebg/fighttechniquetips/%s.png", slot0)
	end
end

function slot0.getTechniqueBg(slot0)
	return string.format("singlebg/fight/techniquetips/%s.png", slot0)
end

function slot0.getHandbookCharacterImage(slot0)
	return string.format("singlebg_lang/txt_handbook/%s.png", slot0)
end

function slot0.getFightBattleDialogBg(slot0)
	return string.format("singlebg/fight/battledialog/%s.png", slot0)
end

function slot0.getBpBg(slot0)
	return string.format("singlebg/battlepass/%s.png", slot0)
end

function slot0.getAct114Image(slot0)
	return string.format("singlebg_lang/txt_versionactivity114_1_2/%s.png", slot0)
end

function slot0.getDreamTailImage(slot0)
	return string.format("singlebg/versionactivitydreamtail_1_2/%s.png", slot0)
end

function slot0.getAct114MeetIcon(slot0)
	return string.format("singlebg/versionactivity114_1_2/meet/%s.png", slot0)
end

function slot0.getAct114Icon(slot0)
	return string.format("singlebg/versionactivity114_1_2/%s.png", slot0)
end

function slot0.getYaXianImage(slot0)
	return string.format("singlebg/versionactivitytooth_1_2/%s.png", slot0)
end

function slot0.getFightDiceBg(slot0)
	return string.format("singlebg/fight/fightdice/%s.png", slot0)
end

function slot0.getWeekWalkLayerIcon(slot0)
	return string.format("singlebg/weekwalk/layer/%s.png", slot0)
end

function slot0.getRoomCharacterPlaceIcon(slot0)
	return string.format("singlebg/room/characterplace/%s.png", slot0)
end

function slot0.getRoomHeadIcon(slot0)
	return string.format("singlebg/room/headicon/%s.png", slot0)
end

function slot0.getRoomBlockPackagePropIcon(slot0)
	return string.format("singlebg/propitem/blockpackage/%s.png", slot0)
end

function slot0.getRoomBlockPropIcon(slot0)
	return string.format("singlebg/propitem/block/%s.png", slot0)
end

function slot0.getRoomBuildingPropIcon(slot0)
	return string.format("singlebg/propitem/building/%s.png", slot0)
end

function slot0.getRoomThemePropIcon(slot0)
	return string.format("singlebg/propitem/roomtheme/%s.png", slot0)
end

function slot0.getRoomTaskBonusIcon(slot0)
	return string.format("singlebg/room/taskbonus/%s.png", slot0)
end

function slot0.getRoomFunctionIcon(slot0)
	return string.format("singlebg/room/function/%s.png", slot0)
end

function slot0.getRoomProductline(slot0)
	return string.format("singlebg/room/productline/%s.png", slot0)
end

function slot0.getSeasonIcon(slot0)
	return string.format("singlebg/season/%s", slot0)
end

function slot0.getV1A2SeasonIcon(slot0)
	return string.format("singlebg/v1a2_season/%s", slot0)
end

function slot0.getV1A3SeasonIcon(slot0)
	return string.format("singlebg/v1a3_season/%s", slot0)
end

function slot0.getV1A3DungeonIcon(slot0)
	return string.format("singlebg/v1a3_dungeon_singlebg/%s.png", slot0)
end

function slot0.getToastIcon(slot0)
	return string.format("singlebg/toast/%s.png", slot0)
end

function slot0.getSdkIcon(slot0)
	return string.format("singlebg/sdk/%s.png", slot0)
end

function slot0.getPlayerHeadIcon(slot0)
	return string.format("singlebg/playerheadicon/%s.png", slot0)
end

function slot0.getVersionActivityIcon(slot0)
	return string.format("singlebg/versionactivity/%s.png", slot0)
end

function slot0.getVersionActivityEnter1_2Icon(slot0)
	return string.format("singlebg/versionactivityenter_1_2/%s.png", slot0)
end

function slot0.getVersionActivityEnter1_2LangIcon(slot0)
	return string.format("singlebg_lang/txt_versionactivityenter_1_2/%s.png", slot0)
end

function slot0.getMeilanniIcon(slot0)
	return string.format("singlebg/versionactivitymeilanni/%s.png", slot0)
end

function slot0.getMeilanniLangIcon(slot0)
	return string.format("singlebg_lang/txt_versionactivitymeilanni/%s.png", slot0)
end

function slot0.getActivityWarmUpBg(slot0)
	return string.format("singlebg/activitywarmup/%s.png", slot0)
end

function slot0.getPushBoxPre(slot0)
	return string.format("scenes/m_s11_txz/prefab/%s.prefab", slot0)
end

function slot0.getPushBoxResultIcon(slot0)
	return string.format("singlebg_lang/txt_versionactivitypushbox/%s.png", slot0)
end

function slot0.getVersionactivitychessIcon(slot0)
	return string.format("singlebg/versionactivitychess/%s.png", slot0)
end

function slot0.gettxt_versionactivitychessIcon(slot0)
	return string.format("singlebg_lang/txt_versionactivitychess/%s.png", slot0)
end

function slot0.getVersionActivityExchangeIcon(slot0)
	return string.format("singlebg/versionactivityexchange/%s.png", slot0)
end

function slot0.getVersionActivityDungeonIcon(slot0)
	return string.format("singlebg/versionactivitydungeon/%s.png", slot0)
end

function slot0.getBattlePassBg(slot0)
	return string.format("singlebg/battlepass/%s.png", slot0)
end

function slot0.getVersionActivityWhiteHouse_1_2_Bg(slot0)
	return string.format("singlebg/versionactivitywhitehouse_1_2/%s", slot0)
end

function slot0.getVersionTradeBargainBg(slot0)
	return string.format("singlebg/versionactivitytrade_1_2/%s.png", slot0)
end

function slot0.getVersionActivity1_2TaskImage(slot0)
	return string.format("singlebg/versionactivitytask_1_2/%s.png", slot0)
end

function slot0.getRoomIconLangPath(slot0)
	return string.format("singlebg_lang/txt_room/%s.png", slot0)
end

function slot0.getWeekWalkIconLangPath(slot0)
	return string.format("singlebg_lang/txt_weekwalk/%s.png", slot0)
end

function slot0.getExploreEffectPath(slot0)
	return string.format("effects/scenes/mishi_prefabs/%s.prefab", slot0)
end

function slot0.getSeasonCelebrityCard(slot0)
	return string.format("singlebg/seasoncelebritycard/%s.png", slot0)
end

function slot0.getSeasonMarketIcon(slot0)
	return string.format("singlebg/season/market/%s.png", slot0)
end

function slot0.getActivityChapterLangPath(slot0)
	return string.format("singlebg_lang/txt_versionactivityopen/%s.png", slot0)
end

function slot0.getVersionActivityOpenPath(slot0)
	return string.format("singlebg/versionactivityopen/%s.png", slot0)
end

function slot0.getVersionActivityStoryCollect_1_2(slot0)
	return string.format("singlebg/versionactivitystorycollect_1_2/%s.png", slot0)
end

function slot0.getActivityWarmUpLangIcon(slot0)
	return string.format("singlebg_lang/txt_activitywarmup/%s.png", slot0)
end

function slot0.getVersionActivityDungeon_1_2(slot0)
	return string.format("singlebg/versionactivitydungeon_1_2/%s.png", slot0)
end

function slot0.getRadioIcon_1_3(slot0)
	return string.format("singlebg/v1a3_radio_singlebg/%s.png", slot0)
end

function slot0.getVersionActivityTrip_1_2(slot0)
	return string.format("singlebg/versionactivitytrip_1_2/%s.png", slot0)
end

function slot0.getActivityLangIcon(slot0)
	return string.format("singlebg_lang/txt_activity/%s.png", slot0)
end

function slot0.getActivityFullBg(slot0)
	return string.format("singlebg/activity/full/%s.png", slot0)
end

function slot0.getActivitiy119Icon(slot0)
	return string.format("singlebg/v1a3_bookview_singlebg/%s.png", slot0)
end

function slot0.getActivity1_3BuffIcon(slot0)
	return string.format("singlebg/v1a3_buffview_singlebg/%s.png", slot0)
end

function slot0.getJiaLaBoNaIcon(slot0)
	return string.format("singlebg/v1a3_role1_singlebg/%s.png", slot0)
end

function slot0.getJiaLaBoNaRoleModsIcon(slot0)
	return string.format("singlebg/v1a3_role1_mods_singlebg/%s.png", slot0)
end

function slot0.getFairyLandIcon(slot0)
	return string.format("singlebg/v1a3_fairyland_singlebg/%s.png", slot0)
end

function slot0.get1_3ChessMapIcon(slot0)
	return string.format("singlebg/v1a3_role2_singlebg/%s.png", slot0)
end

function slot0.getActivity1_3EnterIcon(slot0)
	return string.format("singlebg/v1a3_enterview_singlebg/%s.png", slot0)
end

function slot0.getV1a3TaskViewSinglebg(slot0)
	return string.format("singlebg/v1a3_taskview_singlebg/%s.png", slot0)
end

function slot0.getV1a3ArmSinglebg(slot0)
	return string.format("singlebg/v1a3_arm_singlebg/%s.png", slot0)
end

function slot0.getV1a3AstrologySinglebg(slot0)
	return string.format("singlebg/v1a3_astrology_singlebg/%s.png", slot0)
end

function slot0.getActivity133Icon(slot0)
	return string.format("singlebg/v1a4_shiprepair/%s.png", slot0)
end

function slot0.getRoleStoryIcon(slot0)
	return string.format("singlebg/dungeon/rolestory_singlebg/%s.png", slot0)
end

function slot0.getRoleStoryPhotoIcon(slot0)
	return string.format("singlebg/dungeon/rolestory_photo_singlebg/%s.png", slot0)
end

function slot0.getTurnbackIcon(slot0)
	return string.format("singlebg/turnback/%s.png", slot0)
end

function slot0.getV1a4BossRushSinglebg(slot0)
	return string.format("singlebg/v1a4_bossrush_singlebg/%s.png", slot0)
end

function slot0.getV1a4BossRushIcon(slot0)
	return string.format("singlebg/v1a4_bossrush_bossicon_singlebg/%s.png", slot0)
end

function slot0.getV1a4BossRushLangPath(slot0)
	return string.format("singlebg_lang/txt_v1a4_bossrush_singlebg/%s.png", slot0)
end

function slot0.getV1a4BossRushAssessIcon(slot0)
	return string.format("singlebg/bossrush_assess_singlebg/%s.png", slot0)
end

function slot0.getBossRushSinglebg(slot0)
	return string.format("singlebg/bossrush/%s.png", slot0)
end

function slot0.getV1a4Role37SingleBg(slot0)
	return string.format("singlebg/v1a4_role37_singlebg/%s.png", slot0)
end

function slot0.getV1a4Role6SingleBg(slot0)
	return string.format("singlebg/v1a4_role37_singlebg/%s.png", slot0)
end

function slot0.getV1a4DustRecordsIcon(slot0)
	return string.format("singlebg/v1a4_dustyrecordsview/%s.png", slot0)
end

function slot0.getV1Aa4DailyAllowanceIcon(slot0)
	return string.format("singlebg/v1a4_gold_singlebg/%s.png", slot0)
end

function slot0.getV1a5DungeonSingleBg(slot0)
	return string.format("singlebg/v1a5_dungeon_singlebg/%s.png", slot0)
end

function slot0.getV1a5EnterSingleBg(slot0)
	return string.format("singlebg/v1a5_enterview_singlebg/%s.png", slot0)
end

function slot0.getV1a5RevivalTaskSingleBg(slot0)
	return string.format("singlebg/v1a5_revival_singlebg/%s.png", slot0)
end

function slot0.getV1a5BuildSingleBg(slot0)
	return string.format("singlebg/v1a5_building_singlebg/%s.png", slot0)
end

function slot0.getDialogueSingleBg(slot0)
	return string.format("singlebg/dialogue/%s.png", slot0)
end

function slot0.getSummonFreeButton()
	return "ui/viewres/summon/summonfreebutton.prefab"
end

function slot0.getAchievementIcon(slot0)
	return string.format("singlebg/achievement/%s.png", slot0)
end

function slot0.getAchievementLangIcon(slot0)
	return string.format("singlebg_lang/txt_achievement/%s.png", slot0)
end

function slot0.getV1a4SignSingleBg(slot0)
	return string.format("singlebg/v1a4_sign_singlebg/%s.png", slot0)
end

function slot0.getV1a4SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v1a4_sign_singlebg/%s.png", slot0)
end

function slot0.getSummonBanner(slot0)
	return string.format("singlebg/summon/banner/%s.png", slot0)
end

function slot0.getSummonBannerLine(slot0)
	return string.format("singlebg/summon/banner/bannerline/%s.png", slot0)
end

function slot0.getV1a5News(slot0)
	return string.format("singlebg/v1a5_news_singlebg/%s.png", slot0)
end

function slot0.getV1a5SignSingleBg(slot0)
	return string.format("singlebg/v1a5_sign_singlebg/%s.png", slot0)
end

function slot0.getV1a5SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v1a5_sign_singlebg/%s.png", slot0)
end

function slot0.getV1a5AiZiLaItemIcon(slot0)
	return string.format("singlebg/v1a5_aizila_icon/%s.png", slot0)
end

function slot0.getV1a6DungeonSingleBg(slot0)
	return string.format("singlebg/v1a6_dungeon_singlebg/%s.png", slot0)
end

function slot0.getV1a6CachotIcon(slot0)
	return string.format("singlebg/v1a6_cachot_singlebg/%s.png", slot0)
end

function slot0.getV1a6SignSingleBg(slot0)
	return string.format("singlebg/v1a6_sign_singlebg/%s.png", slot0)
end

function slot0.getV1a6SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v1a6_sign_singlebg/%s.png", slot0)
end

function slot0.getV1a7SignSingleBg(slot0)
	return string.format("singlebg/v1a7_signinview/%s.png", slot0)
end

function slot0.getV1a7SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v1a7_sign_singlebg/%s.png", slot0)
end

function slot0.getSeason123Scene(slot0, slot1)
	return string.format("scenes/%s/scene_prefab/%s.prefab", slot0, slot1)
end

function slot0.getSeason123LayerDetailBg(slot0, slot1)
	return string.format("singlebg/%s/level/%s.png", slot0, slot1)
end

function slot0.getV1a8SignSingleBg(slot0)
	return string.format("singlebg/v1a8_signinview/%s.png", slot0)
end

function slot0.getV1a8DungeonSingleBg(slot0)
	return string.format("singlebg/v1a8_dungeon_singlebg/%s.png", slot0)
end

function slot0.getV1a8SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v1a8_sign_singlebg/%s.png", slot0)
end

function slot0.getSeason123RetailPrefab(slot0, slot1)
	return string.format("scenes/%s/prefab/%s.prefab", slot0, slot1)
end

function slot0.getSeason123ResetStageIcon(slot0, slot1)
	return string.format("singlebg/%s/reset/area/pic_%s.png", slot0, slot1)
end

function slot0.getSeason123EpisodeIcon(slot0, slot1)
	return string.format("singlebg/%s/loading/%s.png", slot0, slot1)
end

function slot0.getSeason123Icon(slot0, slot1)
	return string.format("singlebg/%s/%s.png", slot0, slot1)
end

function slot0.getTurnbackRecommendLangPath(slot0)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_turnbackrecommend/%s.png", slot0)
end

function slot0.getV1a9SignSingleBg(slot0)
	return string.format("singlebg/v1a9_sign_singlebg/%s.png", slot0)
end

function slot0.getV1a9LogoSingleBg(slot0)
	return string.format("singlebg/v1a9_logo_singlebg/%s.png", slot0)
end

function slot0.getV1a9WarmUpSingleBg(slot0)
	return string.format("singlebg/v1a9_warmup_singlebg/v1a9_warmup_day%s.png", slot0)
end

function slot0.getPermanentSingleBg(slot0)
	return string.format("singlebg/dungeon/reappear/%s.png", slot0)
end

function slot0.getMainSceneSwitchIcon(slot0)
	return string.format("singlebg/mainsceneswitch_singlebg/%s.png", slot0)
end

function slot0.getRougeIcon(slot0)
	return string.format("singlebg/rouge/%s.png", slot0)
end

function slot0.getRougeBattleRoleIcon(slot0)
	return string.format("singlebg/toughbattle_singlebg/role/%s.png", slot0)
end

function slot0.getRougeSingleBgCollection(slot0)
	return string.format("singlebg/rouge/collection/%s.png", slot0)
end

function slot0.getRougeSingleBgDLC(slot0)
	return string.format("singlebg/rouge/dlc/%s.png", slot0)
end

function slot0.getRougeDLCLangImage(slot0)
	return string.format("singlebg_lang/txt_rouge/dlc/%s.png", slot0)
end

function slot0.getGraffitiIcon(slot0)
	return string.format("singlebg/v2a0_graffiti_singlebg/%s.png", slot0)
end

function slot0.getV2a0SignSingleBg(slot0)
	return string.format("singlebg/v2a0_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a0SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v2a0_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a0WarmUpSingleBg(slot0)
	return string.format("singlebg/v2a0_warmup_singlebg/%s.png", slot0)
end

function slot0.getV2a1SignSingleBg(slot0)
	return string.format("singlebg/v2a1_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a1SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v2a1_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a1AergusiSingleBg(slot0)
	return string.format("singlebg/v2a1_aergusi_singlebg/%s.png", slot0)
end

function slot0.getV2a1MoonFestivalSignSingleBg(slot0)
	return string.format("singlebg/v2a1_moonfestival_singlebg/%s.png", slot0)
end

function slot0.getV2a1MoonFestivalSignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v2a1_moonfestival_singlebg/%s.png", slot0)
end

function slot0.getV2a1WarmUpSingleBg(slot0)
	return string.format("singlebg/v2a1_warmup_singlebg/%s.png", slot0)
end

function slot0.getV2a2SignSingleBg(slot0)
	return string.format("singlebg/v2a2_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a2SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v2a2_logo/%s.png", slot0)
end

function slot0.getV2a2RedLeafFestivalSignSingleBg(slot0)
	return string.format("singlebg/v2a2_redleaffestival_singlebg/%s.png", slot0)
end

function slot0.getV2a2RedLeafFestivalSignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v2a2_redleaffestival_singlebg/%s.png", slot0)
end

function slot0.getV2a3SignSingleBg(slot0)
	return string.format("singlebg/v2a3_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a3SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v2a3_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a3WarmUpSingleBg(slot0)
	return string.format("singlebg/v2a3_warmup_singlebg/%s.png", slot0)
end

function slot0.getV2a4SignSingleBg(slot0)
	return string.format("singlebg/v2a4_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a4SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v2a4_sign_singlebg/%s.png", slot0)
end

function slot0.getChessDialogueSingleBg(slot0)
	return string.format("singlebg/dialogue/chess/%s.png", slot0)
end

function slot0.getV2a5SignSingleBg(slot0)
	return string.format("singlebg/v2a5_sign_singlebg/%s.png", slot0)
end

function slot0.getV2a5SignSingleBgLang(slot0)
	return string.format("singlebg_lang/txt_v2a5_sign_singlebg/%s.png", slot0)
end

slot2 = string.len("Assets/ZResourcesLib/")

function slot0.getPathWithoutAssetLib(slot0)
	if string.find(slot0, uv0) then
		return string.sub(slot0, slot1 + uv1)
	end

	return slot0
end

function slot0.getV2a1Act165SingleBgLang(slot0)
	return string.format("singlebg/v2a1_strangetale_singlebg/%s.png", slot0)
end

function slot0.monsterHeadIcon(slot0)
	return string.format("singlebg/headicon_monster/%s.png", tostring(slot0))
end

function slot0.roomHeadIcon(slot0)
	return string.format("singlebg/headicon_room/%s.png", tostring(slot0))
end

function slot0.getCritterHedaIcon(slot0)
	return string.format("singlebg/headicon_critter/%s.png", tostring(slot0))
end

function slot0.getCritterLargeIcon(slot0)
	return string.format("singlebg/largeicon_critter/%s.png", tostring(slot0))
end

function slot0.getRoomCritterIcon(slot0)
	return string.format("singlebg/room/critter/%s.png", tostring(slot0))
end

function slot0.getRoomCritterEggPrefab(slot0)
	return string.format("ui/viewres/room/critter/egg/%s.prefab", slot0)
end

function slot0.getBgmEggIcon(slot0)
	return string.format("singlebg/bgmtoggle_singlebg/%s.png", tostring(slot0))
end

function slot0.getTowerIcon(slot0)
	return string.format("singlebg/tower_singlebg/%s.png", tostring(slot0))
end

function slot0.getAct174BadgeIcon(slot0, slot1)
	return string.format("singlebg/act174/badgeicon/%s_%s.png", slot0, slot1)
end

function slot0.getAct174BuffIcon(slot0)
	return string.format("singlebg/act174/bufficon/%s.png", slot0)
end

function slot0.getV2a4WuErLiXiIcon(slot0)
	return string.format("singlebg/v2a4_wuerlixi_singlebg/%s.png", slot0)
end

function slot0.getAutoChessIcon(slot0, slot1)
	if slot1 then
		return string.format("singlebg/v2a5_autochess_singlebg/%s/%s.png", slot1, slot0)
	else
		return string.format("singlebg/v2a5_autochess_singlebg/%s.png", slot0)
	end
end

function slot0.getChallengeIcon(slot0)
	return string.format("singlebg/v2a5_challenge_singlebg/%s.png", slot0)
end

function slot0.getAct184LanternIcon(slot0)
	return string.format("singlebg/v2a5_lanternfestival_singlebg/%s.png", slot0)
end

function slot0.getV2a5FeiLinShiDuoBg(slot0)
	return string.format("singlebg/v2a5_feilinshiduo_singlebg/%s.png", slot0)
end

function slot0.getLiveHeadIconPrefab(slot0)
	return string.format("ui/viewres/dynamichead/%s.prefab", tostring(slot0))
end

function slot0.getAntiqueEffect(slot0)
	return string.format("ui/viewres/antique/effect/%s.prefab", tostring(slot0))
end

function slot0.getDestinyIcon(slot0)
	return string.format("singlebg/characterdestiny/stone/%s.png", tostring(slot0))
end

function slot0.getV2a4WarmUpSingleBg(slot0)
	return string.format("singlebg/v2a4_warmup_singlebg/%s.png", slot0)
end

function slot0.getDecorateStoreImg(slot0)
	return string.format("singlebg/store/decorate/%s.png", tostring(slot0))
end

function slot0.getV2a5LiangYueImg(slot0)
	return string.format("singlebg_lang/txt_v2a5_liangyue_singlebg/%s.png", tostring(slot0))
end

return slot0
