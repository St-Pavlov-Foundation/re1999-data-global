module("modules.ugui.uispriteset.UISpriteSetMgr", package.seeall)

local var_0_0 = class("UISpriteSetMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._spriteSetList = {}
	arg_1_0._dungeon = arg_1_0:newSpriteSetUnit("ui/spriteassets/dungeon.asset")
	arg_1_0._character = arg_1_0:newSpriteSetUnit("ui/spriteassets/character.asset")
	arg_1_0._characterget = arg_1_0:newSpriteSetUnit("ui/spriteassets/characterget.asset")
	arg_1_0._equip = arg_1_0:newSpriteSetUnit("ui/spriteassets/equip.asset")
	arg_1_0._common = arg_1_0:newSpriteSetUnit("ui/spriteassets/common.asset")
	arg_1_0._critter = arg_1_0:newSpriteSetUnit("ui/spriteassets/critter.asset")
	arg_1_0._fight = arg_1_0:newSpriteSetUnit("ui/spriteassets/fight.asset")
	arg_1_0._fightSkillCard = arg_1_0:newSpriteSetUnit("ui/spriteassets/fight_skillcard.asset")
	arg_1_0._fightpassive = arg_1_0:newSpriteSetUnit("ui/spriteassets/fightpassive.asset")
	arg_1_0._explore = arg_1_0:newSpriteSetUnit("ui/spriteassets/explore.asset")
	arg_1_0._weekwalk = arg_1_0:newSpriteSetUnit("ui/spriteassets/weekwalk.asset")
	arg_1_0._herogroup = arg_1_0:newSpriteSetUnit("ui/spriteassets/herogroup.asset")
	arg_1_0._summon = arg_1_0:newSpriteSetUnit("ui/spriteassets/summon.asset")
	arg_1_0._main = arg_1_0:newSpriteSetUnit("ui/spriteassets/main.asset")
	arg_1_0._meilanni = arg_1_0:newSpriteSetUnit("ui/spriteassets/meilanni.asset")
	arg_1_0._room = arg_1_0:newSpriteSetUnit("ui/spriteassets/room.asset")
	arg_1_0._share = arg_1_0:newSpriteSetUnit("ui/spriteassets/share.asset")
	arg_1_0._characterTalent = arg_1_0:newSpriteSetUnit("ui/spriteassets/charactertalentup.asset")
	arg_1_0._handbook = arg_1_0:newSpriteSetUnit("ui/spriteassets/handbook.asset")
	arg_1_0._puzzle = arg_1_0:newSpriteSetUnit("ui/spriteassets/puzzle.asset")
	arg_1_0._teachnote = arg_1_0:newSpriteSetUnit("ui/spriteassets/teachnote.asset")
	arg_1_0._store = arg_1_0:newSpriteSetUnit("ui/spriteassets/store.asset")
	arg_1_0._enemyinfo = arg_1_0:newSpriteSetUnit("ui/spriteassets/enemyinfo.asset")
	arg_1_0._herogroupequipicon = arg_1_0:newSpriteSetUnit("ui/spriteassets/herogroupequipicon.asset")
	arg_1_0._playerrarebg = arg_1_0:newSpriteSetUnit("ui/spriteassets/playerrarebg.asset")
	arg_1_0._currencyitem = arg_1_0:newSpriteSetUnit("ui/spriteassets/currencyitem.asset")
	arg_1_0._equipiconsmall = arg_1_0:newSpriteSetUnit("ui/spriteassets/equipicon_small.asset")
	arg_1_0._toast = arg_1_0:newSpriteSetUnit("ui/spriteassets/toast.asset")
	arg_1_0._buff = arg_1_0:newSpriteSetUnit("ui/spriteassets/buff.asset")
	arg_1_0._activitynovicetask = arg_1_0:newSpriteSetUnit("ui/spriteassets/activitynovicetask.asset")
	arg_1_0._signin = arg_1_0:newSpriteSetUnit("ui/spriteassets/signin.asset")
	arg_1_0._v1a3_bufficon = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a3_bufficon.asset")
	arg_1_0._v1a3_dungeon = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a3_dungeon.asset")
	arg_1_0._v1a3_astrology = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a3_astrology_spriteset.asset")
	arg_1_0._v1a3_store = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a3_store_spriteset.asset")
	arg_1_0._v1a3_enterview = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a3_enterview.asset")
	arg_1_0._v1a3_fairylandcard_spriteset = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a3_fairylandcard_spriteset.asset")
	arg_1_0._dungeonnavigation = arg_1_0:newSpriteSetUnit("ui/spriteassets/dungeon_navigation.asset")
	arg_1_0._dungeonlevelrule = arg_1_0:newSpriteSetUnit("ui/spriteassets/dungeon_levelrule.asset")
	arg_1_0._seasonitem = arg_1_0:newSpriteSetUnit("ui/spriteassets/season.asset")
	arg_1_0._activitywarmup = arg_1_0:newSpriteSetUnit("ui/spriteassets/activitywarmup.asset")
	arg_1_0._versionactivity = arg_1_0:newSpriteSetUnit("ui/spriteassets/versionactivity.asset")
	arg_1_0._activitychessmap = arg_1_0:newSpriteSetUnit("ui/spriteassets/activitychessmap.asset")
	arg_1_0._versionactivitypushbox = arg_1_0:newSpriteSetUnit("ui/spriteassets/versionactivitypushbox.asset")
	arg_1_0._versionactivity114 = arg_1_0:newSpriteSetUnit("ui/spriteassets/versionactivity114_1_2.asset")
	arg_1_0._versionactivitywhitehouse = arg_1_0:newSpriteSetUnit("ui/spriteassets/versionactivitywhitehouse_1_2.asset")
	arg_1_0._versionactivity1_2 = arg_1_0:newSpriteSetUnit("ui/spriteassets/versionactivity_1_2.asset")
	arg_1_0._versionactivity1_2_yaxian = arg_1_0:newSpriteSetUnit("ui/spriteassets/versionactivity_1_2_yaxian.asset")
	arg_1_0._versionactivitytrade_1_2 = arg_1_0:newSpriteSetUnit("ui/spriteassets/versionactivitytrade_1_2.asset")
	arg_1_0._versionactivitydungeon_1_2 = arg_1_0:newSpriteSetUnit("ui/spriteassets/versionactivitydungeon_1_2.asset")
	arg_1_0._versionactivity1_3_jialabona = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a3_role1_spriteset.asset")
	arg_1_0._versionactivity1_3_chess = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a3_role1_spriteset.asset")
	arg_1_0._versionactivity1_3_armpipe = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a3_arm_spriteset.asset")
	arg_1_0._v1a4_shiprepair = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a4_shiprepair.asset")
	arg_1_0._v1a4_collect = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a4_collect_spriteset.asset")
	arg_1_0._v1a4_role37 = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a4_role37_spriteset.asset")
	arg_1_0._mail = arg_1_0:newSpriteSetUnit("ui/spriteassets/mail.asset")
	arg_1_0._v1a4_bossrush = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a4_bossrush_spriteset.asset")
	arg_1_0._v1a4_seasonsum = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a4_season_sum_spriteset.asset")
	arg_1_0._v1a4_enterview = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a4_enterview.asset")
	arg_1_0._v1a5_enterview = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_enterview.asset")
	arg_1_0._v1a5_revivaltask = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_dungeon_explore_spriteset.asset")
	arg_1_0._v1a5_chess = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_kerandian_spriteset.asset")
	arg_1_0._v1a5_aizila = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_aizila_spriteset.asset")
	arg_1_0._v1a5_dungeon_store = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_store_spriteset.asset")
	arg_1_0._v1a5_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_dungeon.asset")
	arg_1_0._v1a5_dungeon_build = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_building_spriteset.asset")
	arg_1_0._v1a5_news = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_news.asset")
	arg_1_0._v1a5_peaceulu = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_peaceulu_spriteset.asset")
	arg_1_0._dialogueChess = arg_1_0:newSpriteSetUnit("ui/spriteassets/dialogue.asset")
	arg_1_0._v1a5_df_sign = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_df_sign_spriteset.asset")
	arg_1_0._v1a5_warmup = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a5_warmup_spriteset.asset")
	arg_1_0._activitypuzzle = arg_1_0:newSpriteSetUnit("ui/spriteassets/versionactivitypuzzle.asset")
	arg_1_0._v1a6_cachot = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a6_cachot.asset")
	arg_1_0._v1a6_enterview = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a6_enterview.asset")
	arg_1_0._v1a6_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a6_dungeon.asset")
	arg_1_0._v1a6_dungeon_store = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a6_store_spriteset.asset")
	arg_1_0._v1a6_dungeon_skill = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a6_talent_spriteset.asset")
	arg_1_0._v1a6_seasonsum = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a6_season_sum_spriteset.asset")
	arg_1_0._v1a7_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a7_mainactivity_spriteset.asset")
	arg_1_0._v1a7_lantern = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a7_lamp_spriteset.asset")
	arg_1_0._season123 = arg_1_0:newSpriteSetUnit("ui/spriteassets/season123.asset")
	arg_1_0._v1a7_v1a2reprint = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a7_v1a2reprint_spriteset.asset")
	arg_1_0._v1a8_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a8_mainactivity_spriteset.asset")
	arg_1_0._v1a8_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a8_dungeon.asset")
	arg_1_0._v1a8_factory_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a8_factory.asset")
	arg_1_0._v1a8_warmup_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a8_warmup.asset")
	arg_1_0._v1a9_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a9_mainactivity_spriteset.asset")
	arg_1_0._toughbattle_role = arg_1_0:newSpriteSetUnit("ui/spriteassets/toughbattle_role_spriteset.asset")
	arg_1_0._toughbattle = arg_1_0:newSpriteSetUnit("ui/spriteassets/toughbattle_spriteset.asset")
	arg_1_0._dragonboat = arg_1_0:newSpriteSetUnit("ui/spriteassets/v1a9_dragonboat_spriteset.asset")
	arg_1_0._rouge = arg_1_0:newSpriteSetUnit("ui/spriteassets/rouge.asset")
	arg_1_0._rouge2 = arg_1_0:newSpriteSetUnit("ui/spriteassets/rouge2.asset")
	arg_1_0._rouge3 = arg_1_0:newSpriteSetUnit("ui/spriteassets/rouge3.asset")
	arg_1_0._rouge4 = arg_1_0:newSpriteSetUnit("ui/spriteassets/rouge4.asset")
	arg_1_0._rouge5 = arg_1_0:newSpriteSetUnit("ui/spriteassets/rouge5.asset")
	arg_1_0._fairyland = arg_1_0:newSpriteSetUnit("ui/spriteassets/fairyland_spriteset.asset")
	arg_1_0._bgmswitch = arg_1_0:newSpriteSetUnit("ui/spriteassets/bgmtoggle.asset")
	arg_1_0._commandstation = arg_1_0:newSpriteSetUnit("ui/spriteassets/sp_commandstation.asset")
	arg_1_0._v2a0_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a0_mainactivity_spriteset.asset")
	arg_1_0._v2a0_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a0_dungeon.asset")
	arg_1_0._v2a0_paint_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a0_paint_spriteset.asset")
	arg_1_0._playerinfo = arg_1_0:newSpriteSetUnit("ui/spriteassets/playerinfo.asset")
	arg_1_0._optionalgift = arg_1_0:newSpriteSetUnit("ui/spriteassets/optionalgift_spriteset.asset")
	arg_1_0._v2a1_aergusi = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a1_aergusi.asset")
	arg_1_0._v2a1_act165 = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a1_act165.asset")
	arg_1_0._v2a1_act165_2 = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a1_act165_2.asset")
	arg_1_0._v2a1_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a1_mainactivity_spriteset.asset")
	arg_1_0._v2a1_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a1_dungeon.asset")
	arg_1_0._v2a1_warmup = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a1_warmup.asset")
	arg_1_0._antique = arg_1_0:newSpriteSetUnit("ui/spriteassets/antique.asset")
	arg_1_0._v2a2_eliminate = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a2_eliminate.asset")
	arg_1_0._v2a2_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a2_mainactivity_spriteset.asset")
	arg_1_0._v2a2_eliminate_point = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a2_eliminate_pointpic.asset")
	arg_1_0._season166 = arg_1_0:newSpriteSetUnit("ui/spriteassets/season166.asset")
	arg_1_0._season166_info = arg_1_0:newSpriteSetUnit("ui/spriteassets/season166_info.asset")
	arg_1_0._v2a2_lopera = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a2_lopera_spriteset.asset")
	arg_1_0._v2a3_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a3_mainactivity_spriteset.asset")
	arg_1_0._v2a3_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a3_dungeon.asset")
	arg_1_0._v2a3_zhixinquaner = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a3_zhixinquaner_spriteset.asset")
	arg_1_0._v2a4_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a4_mainactivity_spriteset.asset")
	arg_1_0._v2a4_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a4_dungeon.asset")
	arg_1_0._v2a4_bakaluoer_spriteset = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a4_bakaluoer_spriteset.asset")
	arg_1_0._tower = arg_1_0:newSpriteSetUnit("ui/spriteassets/tower.asset")
	arg_1_0._tower_permanent = arg_1_0:newSpriteSetUnit("ui/spriteassets/tower_permanent.asset")
	arg_1_0._act174 = arg_1_0:newSpriteSetUnit("ui/spriteassets/act174.asset")
	arg_1_0._act178 = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a4_tutushizi_spriteset.asset")
	arg_1_0._v2a4_wuerlixi_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a4_wuerlixi_spriteset.asset")
	arg_1_0._playercard = arg_1_0:newSpriteSetUnit("ui/spriteassets/playercard.asset")
	arg_1_0._v2a5_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a5_mainactivity_spriteset.asset")
	arg_1_0._v2a5_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a5_dungeon.asset")
	arg_1_0._v2a5_autochess_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a5_autochess_spriteset.asset")
	arg_1_0._v2a5_challenge_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a5_challenge_spriteset.asset")
	arg_1_0._v2a5_liangyue_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a5_liangyue_spriteset.asset")
	arg_1_0._socialskin = arg_1_0:newSpriteSetUnit("ui/spriteassets/social_1.asset")
	arg_1_0._v2a6dicehero = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a6_dicehero_spriteset.asset")
	arg_1_0._v2a6_xugouji = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a6_xugouji_spriteset.asset")
	arg_1_0._v2a6_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a6_mainactivity_spriteset.asset")
	arg_1_0._v2a8_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a8_mainactivity_spriteset.asset")
	arg_1_0._v3a0_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v3a0_mainactivity_spriteset.asset")
	arg_1_0._v2a7_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a7_mainactivity_spriteset.asset")
	arg_1_0._v2a7_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a7_dungeon.asset")
	arg_1_0._v2a7_coopergarland_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a7_coopergarland_spriteset.asset")
	arg_1_0._v2a7_hissabeth_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a7_hissabeth_spriteset.asset")
	arg_1_0._v2a9_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a9_mainactivity_spriteset.asset")
	arg_1_0._v2a9_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a9_dungeon.asset")
	arg_1_0._sp01_odysseydungeon = arg_1_0:newSpriteSetUnit("ui/spriteassets/sp01_odysseydungeon.asset")
	arg_1_0._sp01_odysseydungeonelement = arg_1_0:newSpriteSetUnit("ui/spriteassets/sp01_odysseydungeonelement.asset")
	arg_1_0._sp01_odysseytalent = arg_1_0:newSpriteSetUnit("ui/spriteassets/sp01_odyssey_talenticon.asset")
	arg_1_0._sp01_assassin = arg_1_0:newSpriteSetUnit("ui/spriteassets/assassin2.asset")
	arg_1_0._sp01_talenticon = arg_1_0:newSpriteSetUnit("ui/spriteassets/sp01_odyssey_talenticon.asset")
	arg_1_0._sp01_act205 = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a9_act205_spriteset.asset")
	arg_1_0._survival = arg_1_0:newSpriteSetUnit("ui/spriteassets/survival_spriteset.asset")
	arg_1_0._survival2 = arg_1_0:newSpriteSetUnit("ui/spriteassets/survival_spriteset_2.asset")
	arg_1_0._v2a8_molideer_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v2a8_molideer.asset")
	arg_1_0._skinhandbook_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/skinhandbook_spriteset.asset")
	arg_1_0._v3a0_malianna = arg_1_0:newSpriteSetUnit("ui/spriteassets/v3a0_malianna.asset")
	arg_1_0._v3a0_karong = arg_1_0:newSpriteSetUnit("ui/spriteassets/v3a0_karong.asset")
	arg_1_0._v3a1_main_activity = arg_1_0:newSpriteSetUnit("ui/spriteassets/v3a1_mainactivity_spriteset.asset")
	arg_1_0._v3a1_dungeon_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/v3a1_dungeon.asset")
	arg_1_0._rolestory_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/rolestory.asset")
	arg_1_0._fight_tower_sprite = arg_1_0:newSpriteSetUnit("ui/spriteassets/fight_tower.asset")
	arg_1_0._v3a1_gaosiniao_spriteset = arg_1_0:newSpriteSetUnit("ui/spriteassets/v3a1_gaosiniao_spriteset.asset")
	arg_1_0._nationalgift = arg_1_0:newSpriteSetUnit("ui/spriteassets/optionalgift_spriteset.asset")
end

function var_0_0.newSpriteSetUnit(arg_2_0, arg_2_1)
	local var_2_0 = UISpriteSetUnit.New()

	var_2_0:init(arg_2_1)
	table.insert(arg_2_0._spriteSetList, var_2_0)

	return var_2_0
end

function var_0_0.setUiFBSprite(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._dungeon:setSprite(arg_3_1, arg_3_2, arg_3_3)
end

function var_0_0.getDungeonSprite(arg_4_0)
	return arg_4_0._dungeon
end

function var_0_0.setUiCharacterSprite(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._character:setSprite(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.setCharactergetSprite(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._characterget:setSprite(arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.setEquipSprite(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._equip:setSprite(arg_7_1, arg_7_2, arg_7_3)
end

function var_0_0.setCommonSprite(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0._common:setSprite(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
end

function var_0_0.getCommonSprite(arg_9_0, arg_9_1)
	return arg_9_0._common:getSprite(arg_9_1)
end

function var_0_0.setCritterSprite(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0._critter:setSprite(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
end

function var_0_0.setFightSprite(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._fight:setSprite(arg_11_1, arg_11_2, arg_11_3)
end

function var_0_0.setFightSkillCardSprite(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._fightSkillCard:setSprite(arg_12_1, arg_12_2, arg_12_3)
end

function var_0_0.setFightPassiveSprite(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0._fightpassive:setSprite(arg_13_1, arg_13_2, arg_13_3)
end

function var_0_0.setWeekWalkSprite(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_0._weekwalk:setSprite(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
end

function var_0_0.getWeekWalkSpriteSetUnit(arg_15_0)
	return arg_15_0._weekwalk and arg_15_0._weekwalk:getSpriteSetAsset()
end

function var_0_0.setHeroGroupSprite(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0._herogroup:setSprite(arg_16_1, arg_16_2, arg_16_3)
end

function var_0_0.setSummonSprite(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0._summon:setSprite(arg_17_1, arg_17_2, arg_17_3)
end

function var_0_0.setExploreSprite(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0._explore:setSprite(arg_18_1, arg_18_2, arg_18_3)
end

function var_0_0.setMainSprite(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0._main:setSprite(arg_19_1, arg_19_2, arg_19_3)
end

function var_0_0.setMailSprite(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._mail:setSprite(arg_20_1, arg_20_2, arg_20_3)
end

function var_0_0.setMeilanniSprite(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0._meilanni:setSprite(arg_21_1, arg_21_2, arg_21_3)
end

function var_0_0.setRoomSprite(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0._room:setSprite(arg_22_1, arg_22_2, arg_22_3)
end

function var_0_0.setShareSprite(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0._share:setSprite(arg_23_1, arg_23_2, arg_23_3)
end

function var_0_0.setCharacterTalentSprite(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0._characterTalent:setSprite(arg_24_1, arg_24_2, arg_24_3)
end

function var_0_0.setHandBookCareerSprite(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0._handbook:setSprite(arg_25_1, arg_25_2, arg_25_3)
end

function var_0_0.setPuzzleSprite(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0._puzzle:setSprite(arg_26_1, arg_26_2, arg_26_3)
end

function var_0_0.setTeachNoteSprite(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_0._teachnote:setSprite(arg_27_1, arg_27_2, arg_27_3)
end

function var_0_0.setStoreGoodsSprite(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0._store:setSprite(arg_28_1, arg_28_2, arg_28_3)
end

function var_0_0.setEnemyInfoSprite(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0._enemyinfo:setSprite(arg_29_1, arg_29_2, arg_29_3)
end

function var_0_0.setHerogroupEquipIconSprite(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0._herogroupequipicon:setSprite(arg_30_1, arg_30_2, arg_30_3)
end

function var_0_0.setPlayerRareBgSprite(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_0._playerrarebg:setSprite(arg_31_1, arg_31_2, arg_31_3)
end

function var_0_0.setCurrencyItemSprite(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0._currencyitem:setSprite(arg_32_1, arg_32_2, arg_32_3)
end

function var_0_0.setToastSprite(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0._toast:setSprite(arg_33_1, arg_33_2, arg_33_3)
end

function var_0_0.setBuffSprite(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0._buff:setSprite(arg_34_1, tostring(arg_34_2), arg_34_3)
end

function var_0_0.setActivityNoviceTaskSprite(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0._activitynovicetask:setSprite(arg_35_1, arg_35_2, arg_35_3)
end

function var_0_0.setSignInSprite(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	arg_36_0._signin:setSprite(arg_36_1, arg_36_2, arg_36_3)
end

function var_0_0.setV1a3BuffIconSprite(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_0._v1a3_bufficon:setSprite(arg_37_1, arg_37_2, arg_37_3)
end

function var_0_0.setV1a3AstrologySprite(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	arg_38_0._v1a3_astrology:setSprite(arg_38_1, arg_38_2, arg_38_3, arg_38_4)
end

function var_0_0.setV1a3StoreSprite(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	arg_39_0._v1a3_store:setSprite(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
end

function var_0_0.setV1a3EnterViewSprite(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	arg_40_0._v1a3_enterview:setSprite(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
end

function var_0_0.setV1a4EnterViewSprite(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	arg_41_0._v1a4_enterview:setSprite(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
end

function var_0_0.setV1a5EnterViewSprite(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	arg_42_0._v1a5_enterview:setSprite(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
end

function var_0_0.setV1a3FairyLandCardSprite(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	arg_43_0._v1a3_fairylandcard_spriteset:setSprite(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
end

function var_0_0.setDungeonNavigationSprite(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	arg_44_0._dungeonnavigation:setSprite(arg_44_1, arg_44_2, arg_44_3)
end

function var_0_0.setDungeonLevelRuleSprite(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	arg_45_0._dungeonlevelrule:setSprite(arg_45_1, arg_45_2, arg_45_3)
end

function var_0_0.setSeasonSprite(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	arg_46_0._seasonitem:setSprite(arg_46_1, arg_46_2, arg_46_3)
end

function var_0_0.setActivityWarmUpSprite(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	arg_47_0._activitywarmup:setSprite(arg_47_1, arg_47_2, arg_47_3)
end

function var_0_0.setVersionActivitySprite(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	arg_48_0._versionactivity:setSprite(arg_48_1, arg_48_2, arg_48_3)
end

function var_0_0.setVersionActivity1_3Sprite(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	arg_49_0._v1a3_dungeon:setSprite(arg_49_1, arg_49_2, arg_49_3)
end

function var_0_0.setActivityChessMapSprite(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	arg_50_0._activitychessmap:setSprite(arg_50_1, arg_50_2, arg_50_3)
end

function var_0_0.setPushBoxSprite(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	arg_51_0._versionactivitypushbox:setSprite(arg_51_1, arg_51_2, arg_51_3)
end

function var_0_0.setVersionActivity114Sprite(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	arg_52_0._versionactivity114:setSprite(arg_52_1, arg_52_2, arg_52_3)
end

function var_0_0.setVersionActivitywhitehouseSprite(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	arg_53_0._versionactivitywhitehouse:setSprite(arg_53_1, arg_53_2, arg_53_3)
end

function var_0_0.setVersionActivity1_2Sprite(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	arg_54_0._versionactivity1_2:setSprite(arg_54_1, arg_54_2, arg_54_3)
end

function var_0_0.setYaXianSprite(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	arg_55_0._versionactivity1_2_yaxian:setSprite(arg_55_1, arg_55_2, arg_55_3)
end

function var_0_0.setVersionActivityTrade_1_2Sprite(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	arg_56_0._versionactivitytrade_1_2:setSprite(arg_56_1, arg_56_2, arg_56_3)
end

function var_0_0.setVersionActivityDungeon_1_2Sprite(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	arg_57_0._versionactivitydungeon_1_2:setSprite(arg_57_1, arg_57_2, arg_57_3)
end

function var_0_0.setJiaLaBoNaSprite(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	arg_58_0._versionactivity1_3_jialabona:setSprite(arg_58_1, arg_58_2, arg_58_3)
end

function var_0_0.setActivity1_3ChessSprite(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	arg_59_0._versionactivity1_3_chess:setSprite(arg_59_1, arg_59_2, arg_59_3)
end

function var_0_0.setArmPipeSprite(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	arg_60_0._versionactivity1_3_armpipe:setSprite(arg_60_1, arg_60_2, arg_60_3)
end

function var_0_0.setV1a4ShiprepairSprite(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	arg_61_0._v1a4_shiprepair:setSprite(arg_61_1, arg_61_2, arg_61_3)
end

function var_0_0.setV1a4CollectSprite(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	arg_62_0._v1a4_collect:setSprite(arg_62_1, arg_62_2, arg_62_3)
end

function var_0_0.setV1a4Role37Sprite(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	arg_63_0._v1a4_role37:setSprite(arg_63_1, arg_63_2, arg_63_3)
end

function var_0_0.setV1a4BossRushSprite(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	arg_64_0._v1a4_bossrush:setSprite(arg_64_1, arg_64_2, arg_64_3)
end

function var_0_0.setV1a4SeasonSumSprite(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	arg_65_0._v1a4_seasonsum:setSprite(arg_65_1, arg_65_2, arg_65_3)
end

function var_0_0.setV1a5RevivalTaskSprite(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	arg_66_0._v1a5_revivaltask:setSprite(arg_66_1, arg_66_2, arg_66_3)
end

function var_0_0.setV1a5ChessSprite(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	arg_67_0._v1a5_chess:setSprite(arg_67_1, arg_67_2, arg_67_3)
end

function var_0_0.setV1a5AiZiLaSprite(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	arg_68_0._v1a5_aizila:setSprite(arg_68_1, arg_68_2, arg_68_3)
end

function var_0_0.setV1a5DungeonStoreSprite(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	arg_69_0._v1a5_dungeon_store:setSprite(arg_69_1, arg_69_2, arg_69_3)
end

function var_0_0.setV1a5DungeonSprite(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	arg_70_0._v1a5_dungeon_sprite:setSprite(arg_70_1, arg_70_2, arg_70_3)
end

function var_0_0.setV1a5DungeonBuildSprite(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	arg_71_0._v1a5_dungeon_build:setSprite(arg_71_1, arg_71_2, arg_71_3)
end

function var_0_0.setNewsSprite(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	arg_72_0._v1a5_news:setSprite(arg_72_1, arg_72_2, arg_72_3)
end

function var_0_0.setPeaceUluSprite(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	arg_73_0._v1a5_peaceulu:setSprite(arg_73_1, arg_73_2, arg_73_3)
end

function var_0_0.setDialogueChessSprite(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
	arg_74_0._dialogueChess:setSprite(arg_74_1, arg_74_2, arg_74_3)
end

function var_0_0.setV1a5DfSignSprite(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
	arg_75_0._v1a5_df_sign:setSprite(arg_75_1, arg_75_2, arg_75_3)
end

function var_0_0.setV1a5WarmUpSprite(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	arg_76_0._v1a5_warmup:setSprite(arg_76_1, arg_76_2, arg_76_3)
end

function var_0_0.setV1a6CachotSprite(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	arg_77_0._v1a6_cachot:setSprite(arg_77_1, arg_77_2, arg_77_3)
end

function var_0_0.setV1a6DungeonSprite(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	arg_78_0._v1a6_dungeon_sprite:setSprite(arg_78_1, arg_78_2, arg_78_3)
end

function var_0_0.setV1a6DungeonStoreSprite(arg_79_0, arg_79_1, arg_79_2, arg_79_3)
	arg_79_0._v1a6_dungeon_store:setSprite(arg_79_1, arg_79_2, arg_79_3)
end

function var_0_0.setV1a6DungeonSkillSprite(arg_80_0, arg_80_1, arg_80_2, arg_80_3)
	arg_80_0._v1a6_dungeon_skill:setSprite(arg_80_1, arg_80_2, arg_80_3)
end

function var_0_0.setV1a6EnterSprite(arg_81_0, arg_81_1, arg_81_2, arg_81_3)
	arg_81_0._v1a6_enterview:setSprite(arg_81_1, arg_81_2, arg_81_3)
end

function var_0_0.setV1a7MainActivitySprite(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	arg_82_0._v1a7_main_activity:setSprite(arg_82_1, arg_82_2, arg_82_3)
end

function var_0_0.setV1a7LanternSprite(arg_83_0, arg_83_1, arg_83_2, arg_83_3)
	arg_83_0._v1a7_lantern:setSprite(arg_83_1, arg_83_2, arg_83_3)
end

function var_0_0.setSeason123Sprite(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	arg_84_0._season123:setSprite(arg_84_1, arg_84_2, arg_84_3)
end

function var_0_0.setV1a7ReprintSprite(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	arg_85_0._v1a7_v1a2reprint:setSprite(arg_85_1, arg_85_2, arg_85_3)
end

function var_0_0.setV1a6SeasonSumSprite(arg_86_0, arg_86_1, arg_86_2, arg_86_3)
	arg_86_0._v1a6_seasonsum:setSprite(arg_86_1, arg_86_2, arg_86_3)
end

function var_0_0.setV1a8MainActivitySprite(arg_87_0, arg_87_1, arg_87_2, arg_87_3)
	arg_87_0._v1a8_main_activity:setSprite(arg_87_1, arg_87_2, arg_87_3)
end

function var_0_0.setV1a8DungeonSprite(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	arg_88_0._v1a8_dungeon_sprite:setSprite(arg_88_1, arg_88_2, arg_88_3)
end

function var_0_0.setV1a8FactorySprite(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	arg_89_0._v1a8_factory_sprite:setSprite(arg_89_1, arg_89_2, arg_89_3)
end

function var_0_0.setV1a8WarmUpSprite(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	arg_90_0._v1a8_warmup_sprite:setSprite(arg_90_1, arg_90_2, arg_90_3)
end

function var_0_0.setV1a9MainActivitySprite(arg_91_0, arg_91_1, arg_91_2, arg_91_3)
	arg_91_0._v1a9_main_activity:setSprite(arg_91_1, arg_91_2, arg_91_3)
end

function var_0_0.setToughBattleRoleSprite(arg_92_0, arg_92_1, arg_92_2, arg_92_3)
	arg_92_0._toughbattle_role:setSprite(arg_92_1, arg_92_2, arg_92_3)
end

function var_0_0.setToughBattleSprite(arg_93_0, arg_93_1, arg_93_2, arg_93_3)
	arg_93_0._toughbattle:setSprite(arg_93_1, arg_93_2, arg_93_3)
end

function var_0_0.setDragonBoatSprite(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
	arg_94_0._dragonboat:setSprite(arg_94_1, arg_94_2, arg_94_3)
end

function var_0_0.setRougeSprite(arg_95_0, arg_95_1, arg_95_2, arg_95_3)
	arg_95_0._rouge:setSprite(arg_95_1, arg_95_2, arg_95_3)
end

function var_0_0.setRouge2Sprite(arg_96_0, arg_96_1, arg_96_2, arg_96_3)
	arg_96_0._rouge2:setSprite(arg_96_1, arg_96_2, arg_96_3)
end

function var_0_0.setRouge3Sprite(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	arg_97_0._rouge3:setSprite(arg_97_1, arg_97_2, arg_97_3)
end

function var_0_0.setRouge4Sprite(arg_98_0, arg_98_1, arg_98_2, arg_98_3)
	arg_98_0._rouge4:setSprite(arg_98_1, arg_98_2, arg_98_3)
end

function var_0_0.setRouge5Sprite(arg_99_0, arg_99_1, arg_99_2, arg_99_3)
	arg_99_0._rouge5:setSprite(arg_99_1, arg_99_2, arg_99_3)
end

function var_0_0.setFairyLandSprite(arg_100_0, arg_100_1, arg_100_2, arg_100_3)
	arg_100_0._fairyland:setSprite(arg_100_1, arg_100_2, arg_100_3)
end

function var_0_0.setBgmSwitchToggleSprite(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	arg_101_0._bgmswitch:setSprite(arg_101_1, arg_101_2, arg_101_3)
end

function var_0_0.setCommandStationSprite(arg_102_0, arg_102_1, arg_102_2, arg_102_3)
	arg_102_0._commandstation:setSprite(arg_102_1, arg_102_2, arg_102_3)
end

function var_0_0.setV2a0MainActivitySprite(arg_103_0, arg_103_1, arg_103_2, arg_103_3)
	arg_103_0._v2a0_main_activity:setSprite(arg_103_1, arg_103_2, arg_103_3)
end

function var_0_0.setV2a0DungeonSprite(arg_104_0, arg_104_1, arg_104_2, arg_104_3)
	arg_104_0._v2a0_dungeon_sprite:setSprite(arg_104_1, arg_104_2, arg_104_3)
end

function var_0_0.setV2a0PaintSprite(arg_105_0, arg_105_1, arg_105_2, arg_105_3)
	arg_105_0._v2a0_paint_sprite:setSprite(arg_105_1, arg_105_2, arg_105_3)
end

function var_0_0.setPlayerInfoSprite(arg_106_0, arg_106_1, arg_106_2, arg_106_3)
	arg_106_0._playerinfo:setSprite(arg_106_1, arg_106_2, arg_106_3)
end

function var_0_0.setOptionalGiftSprite(arg_107_0, arg_107_1, arg_107_2, arg_107_3)
	arg_107_0._optionalgift:setSprite(arg_107_1, arg_107_2, arg_107_3)
end

function var_0_0.setV2a2MainActivitySprite(arg_108_0, arg_108_1, arg_108_2, arg_108_3)
	arg_108_0._v2a2_main_activity:setSprite(arg_108_1, arg_108_2, arg_108_3)
end

function var_0_0.setV2a1AergusiSprite(arg_109_0, arg_109_1, arg_109_2, arg_109_3)
	arg_109_0._v2a1_aergusi:setSprite(arg_109_1, arg_109_2, arg_109_3)
end

function var_0_0.setV2a1Act165Sprite(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	arg_110_0._v2a1_act165:setSprite(arg_110_1, arg_110_2, arg_110_3)
end

function var_0_0.setV2a1Act165_2Sprite(arg_111_0, arg_111_1, arg_111_2, arg_111_3)
	arg_111_0._v2a1_act165_2:setSprite(arg_111_1, arg_111_2, arg_111_3)
end

function var_0_0.setV2a1MainActivitySprite(arg_112_0, arg_112_1, arg_112_2, arg_112_3)
	arg_112_0._v2a1_main_activity:setSprite(arg_112_1, arg_112_2, arg_112_3)
end

function var_0_0.setV2a1DungeonSprite(arg_113_0, arg_113_1, arg_113_2, arg_113_3)
	arg_113_0._v2a1_dungeon_sprite:setSprite(arg_113_1, arg_113_2, arg_113_3)
end

function var_0_0.setV2a2EliminateSprite(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	arg_114_0._v2a2_eliminate:setSprite(arg_114_1, arg_114_2, arg_114_3)
end

function var_0_0.setV2a1WarmupSprite(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	arg_115_0._v2a1_warmup:setSprite(arg_115_1, arg_115_2, arg_115_3)
end

function var_0_0.setAntiqueSprite(arg_116_0, arg_116_1, arg_116_2, arg_116_3)
	arg_116_0._antique:setSprite(arg_116_1, arg_116_2, arg_116_3)
end

function var_0_0.setV2a2eliminatePointSprite(arg_117_0, arg_117_1, arg_117_2, arg_117_3)
	arg_117_0._v2a2_eliminate_point:setSprite(arg_117_1, arg_117_2, arg_117_3)
end

function var_0_0.setSeason166Sprite(arg_118_0, arg_118_1, arg_118_2, arg_118_3)
	arg_118_0._season166:setSprite(arg_118_1, arg_118_2, arg_118_3)
end

function var_0_0.setSeason166InfoSprite(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	arg_119_0._season166_info:setSprite(arg_119_1, arg_119_2, arg_119_3)
end

function var_0_0.setLoperaItemSprite(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
	arg_120_0._v2a2_lopera:setSprite(arg_120_1, arg_120_2, arg_120_3)
end

function var_0_0.setV2a3MainActivitySprite(arg_121_0, arg_121_1, arg_121_2, arg_121_3)
	arg_121_0._v2a3_main_activity:setSprite(arg_121_1, arg_121_2, arg_121_3)
end

function var_0_0.setV2a3DungeonSprite(arg_122_0, arg_122_1, arg_122_2, arg_122_3)
	arg_122_0._v2a3_dungeon_sprite:setSprite(arg_122_1, arg_122_2, arg_122_3)
end

function var_0_0.setMusicSprite(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
	arg_123_0._v2a4_bakaluoer_spriteset:setSprite(arg_123_1, arg_123_2, arg_123_3)
end

function var_0_0.setTowerSprite(arg_124_0, arg_124_1, arg_124_2, arg_124_3)
	arg_124_0._tower:setSprite(arg_124_1, arg_124_2, arg_124_3)
end

function var_0_0.setTowerPermanentSprite(arg_125_0, arg_125_1, arg_125_2, arg_125_3)
	arg_125_0._tower_permanent:setSprite(arg_125_1, arg_125_2, arg_125_3)
end

function var_0_0.setAct174Sprite(arg_126_0, arg_126_1, arg_126_2, arg_126_3)
	arg_126_0._act174:setSprite(arg_126_1, arg_126_2, arg_126_3)
end

function var_0_0.setAct178Sprite(arg_127_0, arg_127_1, arg_127_2, arg_127_3, arg_127_4)
	arg_127_0._act178:setSprite(arg_127_1, arg_127_2, arg_127_3, arg_127_4)
end

function var_0_0.setV2a3ZhiXinQuanErSprite(arg_128_0, arg_128_1, arg_128_2, arg_128_3)
	arg_128_0._v2a3_zhixinquaner:setSprite(arg_128_1, arg_128_2, arg_128_3)
end

function var_0_0.setV2a4DungeonSprite(arg_129_0, arg_129_1, arg_129_2, arg_129_3)
	arg_129_0._v2a4_dungeon_sprite:setSprite(arg_129_1, arg_129_2, arg_129_3)
end

function var_0_0.setV2a4MainActivitySprite(arg_130_0, arg_130_1, arg_130_2, arg_130_3)
	arg_130_0._v2a4_main_activity:setSprite(arg_130_1, arg_130_2, arg_130_3)
end

function var_0_0.setV2a4WuErLiXiSprite(arg_131_0, arg_131_1, arg_131_2, arg_131_3)
	arg_131_0._v2a4_wuerlixi_sprite:setSprite(arg_131_1, arg_131_2, arg_131_3)
end

function var_0_0.setPlayerCardSprite(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
	arg_132_0._playercard:setSprite(arg_132_1, arg_132_2, arg_132_3)
end

function var_0_0.setV2a5MainActivitySprite(arg_133_0, arg_133_1, arg_133_2, arg_133_3)
	arg_133_0._v2a5_main_activity:setSprite(arg_133_1, arg_133_2, arg_133_3)
end

function var_0_0.setV2a5DungeonSprite(arg_134_0, arg_134_1, arg_134_2, arg_134_3)
	arg_134_0._v2a5_dungeon_sprite:setSprite(arg_134_1, arg_134_2, arg_134_3)
end

function var_0_0.setAutoChessSprite(arg_135_0, arg_135_1, arg_135_2, arg_135_3)
	arg_135_0._v2a5_autochess_sprite:setSprite(arg_135_1, arg_135_2, arg_135_3)
end

function var_0_0.setChallengeSprite(arg_136_0, arg_136_1, arg_136_2, arg_136_3)
	arg_136_0._v2a5_challenge_sprite:setSprite(arg_136_1, arg_136_2, arg_136_3)
end

function var_0_0.setV2a5LiangYueSprite(arg_137_0, arg_137_1, arg_137_2, arg_137_3)
	arg_137_0._v2a5_liangyue_sprite:setSprite(arg_137_1, arg_137_2, arg_137_3)
end

function var_0_0.setV2a6MainActivitySprite(arg_138_0, arg_138_1, arg_138_2, arg_138_3)
	arg_138_0._v2a6_main_activity:setSprite(arg_138_1, arg_138_2, arg_138_3)
end

function var_0_0.setV2a8MainActivitySprite(arg_139_0, arg_139_1, arg_139_2, arg_139_3)
	arg_139_0._v2a8_main_activity:setSprite(arg_139_1, arg_139_2, arg_139_3)
end

function var_0_0.setV3a0MainActivitySprite(arg_140_0, arg_140_1, arg_140_2, arg_140_3)
	arg_140_0._v3a0_main_activity:setSprite(arg_140_1, arg_140_2, arg_140_3)
end

function var_0_0.setV2a7MainActivitySprite(arg_141_0, arg_141_1, arg_141_2, arg_141_3)
	arg_141_0._v2a7_main_activity:setSprite(arg_141_1, arg_141_2, arg_141_3)
end

function var_0_0.setV2a7DungeonSprite(arg_142_0, arg_142_1, arg_142_2, arg_142_3)
	arg_142_0._v2a7_dungeon_sprite:setSprite(arg_142_1, arg_142_2, arg_142_3)
end

function var_0_0.setV2a7CooperGarlandSprite(arg_143_0, arg_143_1, arg_143_2, arg_143_3)
	arg_143_0._v2a7_coopergarland_sprite:setSprite(arg_143_1, arg_143_2, arg_143_3)
end

function var_0_0.setSocialSkinSprite(arg_144_0, arg_144_1, arg_144_2, arg_144_3)
	arg_144_0._socialskin:setSprite(arg_144_1, arg_144_2, arg_144_3)
end

function var_0_0.setDiceHeroSprite(arg_145_0, arg_145_1, arg_145_2, arg_145_3)
	arg_145_0._v2a6dicehero:setSprite(arg_145_1, arg_145_2, arg_145_3)
end

function var_0_0.setXugoujiSprite(arg_146_0, arg_146_1, arg_146_2, arg_146_3)
	arg_146_0._v2a6_xugouji:setSprite(arg_146_1, arg_146_2, arg_146_3)
end

function var_0_0.setHisSaBethSprite(arg_147_0, arg_147_1, arg_147_2, arg_147_3)
	arg_147_0._v2a7_hissabeth_sprite:setSprite(arg_147_1, arg_147_2, arg_147_3)
end

function var_0_0.setV2a9MainActivitySprite(arg_148_0, arg_148_1, arg_148_2, arg_148_3)
	arg_148_0._v2a9_main_activity:setSprite(arg_148_1, arg_148_2, arg_148_3)
end

function var_0_0.setV2a9DungeonSprite(arg_149_0, arg_149_1, arg_149_2, arg_149_3)
	arg_149_0._v2a9_dungeon_sprite:setSprite(arg_149_1, arg_149_2, arg_149_3)
end

function var_0_0.setSp01OdysseyDungeonSprite(arg_150_0, arg_150_1, arg_150_2, arg_150_3)
	arg_150_0._sp01_odysseydungeon:setSprite(arg_150_1, arg_150_2, arg_150_3)
end

function var_0_0.setSp01OdysseyDungeonElementSprite(arg_151_0, arg_151_1, arg_151_2, arg_151_3)
	arg_151_0._sp01_odysseydungeonelement:setSprite(arg_151_1, arg_151_2, arg_151_3)
end

function var_0_0.setSp01OdysseyTalentSprite(arg_152_0, arg_152_1, arg_152_2, arg_152_3)
	arg_152_0._sp01_odysseytalent:setSprite(arg_152_1, arg_152_2, arg_152_3)
end

function var_0_0.setSp01AssassinSprite(arg_153_0, arg_153_1, arg_153_2, arg_153_3)
	arg_153_0._sp01_assassin:setSprite(arg_153_1, arg_153_2, arg_153_3)
end

function var_0_0.setSp01TalentIconSprite(arg_154_0, arg_154_1, arg_154_2, arg_154_3)
	arg_154_0._sp01_talenticon:setSprite(arg_154_1, arg_154_2, arg_154_3)
end

function var_0_0.setSp01Act205Sprite(arg_155_0, arg_155_1, arg_155_2, arg_155_3)
	arg_155_0._sp01_act205:setSprite(arg_155_1, arg_155_2, arg_155_3)
end

function var_0_0.setSurvivalSprite(arg_156_0, arg_156_1, arg_156_2, arg_156_3)
	arg_156_0._survival:setSprite(arg_156_1, arg_156_2, arg_156_3)
end

function var_0_0.setSurvivalSprite2(arg_157_0, arg_157_1, arg_157_2, arg_157_3)
	arg_157_0._survival2:setSprite(arg_157_1, arg_157_2, arg_157_3)
end

function var_0_0.setMoLiDeErSprite(arg_158_0, arg_158_1, arg_158_2, arg_158_3)
	arg_158_0._v2a8_molideer_sprite:setSprite(arg_158_1, arg_158_2, arg_158_3)
end

function var_0_0.setSkinHandbook(arg_159_0, arg_159_1, arg_159_2, arg_159_3)
	arg_159_0._skinhandbook_sprite:setSprite(arg_159_1, arg_159_2, arg_159_3)
end

function var_0_0.setMaliAnNaSprite(arg_160_0, arg_160_1, arg_160_2, arg_160_3)
	arg_160_0._v3a0_malianna:setSprite(arg_160_1, arg_160_2, arg_160_3)
end

function var_0_0.setV3a0KaRongSprite(arg_161_0, arg_161_1, arg_161_2, arg_161_3)
	arg_161_0._v3a0_karong:setSprite(arg_161_1, arg_161_2, arg_161_3)
end

function var_0_0.setV3a1MainActivitySprite(arg_162_0, arg_162_1, arg_162_2, arg_162_3)
	arg_162_0._v3a1_main_activity:setSprite(arg_162_1, arg_162_2, arg_162_3)
end

function var_0_0.setV3a1DungeonSprite(arg_163_0, arg_163_1, arg_163_2, arg_163_3)
	arg_163_0._v3a1_dungeon_sprite:setSprite(arg_163_1, arg_163_2, arg_163_3)
end

function var_0_0.setRoleStorySprite(arg_164_0, arg_164_1, arg_164_2, arg_164_3)
	arg_164_0._rolestory_sprite:setSprite(arg_164_1, arg_164_2, arg_164_3)
end

function var_0_0.setFightTowerSprite(arg_165_0, arg_165_1, arg_165_2, arg_165_3)
	arg_165_0._fight_tower_sprite:setSprite(arg_165_1, arg_165_2, arg_165_3)
end

function var_0_0.setV3a1GaoSiNiaoSprite(arg_166_0, arg_166_1, arg_166_2, arg_166_3)
	arg_166_0._v3a1_gaosiniao_spriteset:setSprite(arg_166_1, arg_166_2, arg_166_3)
end

function var_0_0.setNationalGiftSprite(arg_167_0, arg_167_1, arg_167_2, arg_167_3)
	arg_167_0._nationalgift:setSprite(arg_167_1, arg_167_2, arg_167_3)
end

function var_0_0.tryDispose(arg_168_0)
	for iter_168_0, iter_168_1 in ipairs(arg_168_0._spriteSetList) do
		iter_168_1:tryDispose()
	end
end

function var_0_0.setActivityPuzzle(arg_169_0, arg_169_1, arg_169_2, arg_169_3)
	arg_169_0._activitypuzzle:setSprite(arg_169_1, arg_169_2, arg_169_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
