module("modules.ugui.uispriteset.UISpriteSetMgr", package.seeall)

slot0 = class("UISpriteSetMgr")

function slot0.ctor(slot0)
	slot0._spriteSetList = {}
	slot0._dungeon = slot0:newSpriteSetUnit("ui/spriteassets/dungeon.asset")
	slot0._character = slot0:newSpriteSetUnit("ui/spriteassets/character.asset")
	slot0._characterget = slot0:newSpriteSetUnit("ui/spriteassets/characterget.asset")
	slot0._equip = slot0:newSpriteSetUnit("ui/spriteassets/equip.asset")
	slot0._common = slot0:newSpriteSetUnit("ui/spriteassets/common.asset")
	slot0._critter = slot0:newSpriteSetUnit("ui/spriteassets/critter.asset")
	slot0._fight = slot0:newSpriteSetUnit("ui/spriteassets/fight.asset")
	slot0._fightpassive = slot0:newSpriteSetUnit("ui/spriteassets/fightpassive.asset")
	slot0._explore = slot0:newSpriteSetUnit("ui/spriteassets/explore.asset")
	slot0._weekwalk = slot0:newSpriteSetUnit("ui/spriteassets/weekwalk.asset")
	slot0._herogroup = slot0:newSpriteSetUnit("ui/spriteassets/herogroup.asset")
	slot0._summon = slot0:newSpriteSetUnit("ui/spriteassets/summon.asset")
	slot0._main = slot0:newSpriteSetUnit("ui/spriteassets/main.asset")
	slot0._meilanni = slot0:newSpriteSetUnit("ui/spriteassets/meilanni.asset")
	slot0._room = slot0:newSpriteSetUnit("ui/spriteassets/room.asset")
	slot0._share = slot0:newSpriteSetUnit("ui/spriteassets/share.asset")
	slot0._characterTalent = slot0:newSpriteSetUnit("ui/spriteassets/charactertalentup.asset")
	slot0._handbook = slot0:newSpriteSetUnit("ui/spriteassets/handbook.asset")
	slot0._puzzle = slot0:newSpriteSetUnit("ui/spriteassets/puzzle.asset")
	slot0._teachnote = slot0:newSpriteSetUnit("ui/spriteassets/teachnote.asset")
	slot0._store = slot0:newSpriteSetUnit("ui/spriteassets/store.asset")
	slot0._enemyinfo = slot0:newSpriteSetUnit("ui/spriteassets/enemyinfo.asset")
	slot0._herogroupequipicon = slot0:newSpriteSetUnit("ui/spriteassets/herogroupequipicon.asset")
	slot0._playerrarebg = slot0:newSpriteSetUnit("ui/spriteassets/playerrarebg.asset")
	slot0._currencyitem = slot0:newSpriteSetUnit("ui/spriteassets/currencyitem.asset")
	slot0._equipiconsmall = slot0:newSpriteSetUnit("ui/spriteassets/equipicon_small.asset")
	slot0._toast = slot0:newSpriteSetUnit("ui/spriteassets/toast.asset")
	slot0._buff = slot0:newSpriteSetUnit("ui/spriteassets/buff.asset")
	slot0._activitynovicetask = slot0:newSpriteSetUnit("ui/spriteassets/activitynovicetask.asset")
	slot0._signin = slot0:newSpriteSetUnit("ui/spriteassets/signin.asset")
	slot0._v1a3_bufficon = slot0:newSpriteSetUnit("ui/spriteassets/v1a3_bufficon.asset")
	slot0._v1a3_dungeon = slot0:newSpriteSetUnit("ui/spriteassets/v1a3_dungeon.asset")
	slot0._v1a3_astrology = slot0:newSpriteSetUnit("ui/spriteassets/v1a3_astrology_spriteset.asset")
	slot0._v1a3_store = slot0:newSpriteSetUnit("ui/spriteassets/v1a3_store_spriteset.asset")
	slot0._v1a3_enterview = slot0:newSpriteSetUnit("ui/spriteassets/v1a3_enterview.asset")
	slot0._v1a3_fairylandcard_spriteset = slot0:newSpriteSetUnit("ui/spriteassets/v1a3_fairylandcard_spriteset.asset")
	slot0._dungeonnavigation = slot0:newSpriteSetUnit("ui/spriteassets/dungeon_navigation.asset")
	slot0._dungeonlevelrule = slot0:newSpriteSetUnit("ui/spriteassets/dungeon_levelrule.asset")
	slot0._seasonitem = slot0:newSpriteSetUnit("ui/spriteassets/season.asset")
	slot0._activitywarmup = slot0:newSpriteSetUnit("ui/spriteassets/activitywarmup.asset")
	slot0._versionactivity = slot0:newSpriteSetUnit("ui/spriteassets/versionactivity.asset")
	slot0._activitychessmap = slot0:newSpriteSetUnit("ui/spriteassets/activitychessmap.asset")
	slot0._versionactivitypushbox = slot0:newSpriteSetUnit("ui/spriteassets/versionactivitypushbox.asset")
	slot0._versionactivity114 = slot0:newSpriteSetUnit("ui/spriteassets/versionactivity114_1_2.asset")
	slot0._versionactivitywhitehouse = slot0:newSpriteSetUnit("ui/spriteassets/versionactivitywhitehouse_1_2.asset")
	slot0._versionactivity1_2 = slot0:newSpriteSetUnit("ui/spriteassets/versionactivity_1_2.asset")
	slot0._versionactivity1_2_yaxian = slot0:newSpriteSetUnit("ui/spriteassets/versionactivity_1_2_yaxian.asset")
	slot0._versionactivitytrade_1_2 = slot0:newSpriteSetUnit("ui/spriteassets/versionactivitytrade_1_2.asset")
	slot0._versionactivitydungeon_1_2 = slot0:newSpriteSetUnit("ui/spriteassets/versionactivitydungeon_1_2.asset")
	slot0._versionactivity1_3_jialabona = slot0:newSpriteSetUnit("ui/spriteassets/v1a3_role1_spriteset.asset")
	slot0._versionactivity1_3_chess = slot0:newSpriteSetUnit("ui/spriteassets/v1a3_role1_spriteset.asset")
	slot0._versionactivity1_3_armpipe = slot0:newSpriteSetUnit("ui/spriteassets/v1a3_arm_spriteset.asset")
	slot0._v1a4_shiprepair = slot0:newSpriteSetUnit("ui/spriteassets/v1a4_shiprepair.asset")
	slot0._v1a4_collect = slot0:newSpriteSetUnit("ui/spriteassets/v1a4_collect_spriteset.asset")
	slot0._v1a4_role37 = slot0:newSpriteSetUnit("ui/spriteassets/v1a4_role37_spriteset.asset")
	slot0._mail = slot0:newSpriteSetUnit("ui/spriteassets/mail.asset")
	slot0._v1a4_bossrush = slot0:newSpriteSetUnit("ui/spriteassets/v1a4_bossrush_spriteset.asset")
	slot0._v1a4_seasonsum = slot0:newSpriteSetUnit("ui/spriteassets/v1a4_season_sum_spriteset.asset")
	slot0._v1a4_enterview = slot0:newSpriteSetUnit("ui/spriteassets/v1a4_enterview.asset")
	slot0._v1a5_enterview = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_enterview.asset")
	slot0._v1a5_revivaltask = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_dungeon_explore_spriteset.asset")
	slot0._v1a5_chess = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_kerandian_spriteset.asset")
	slot0._v1a5_aizila = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_aizila_spriteset.asset")
	slot0._v1a5_dungeon_store = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_store_spriteset.asset")
	slot0._v1a5_dungeon_sprite = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_dungeon.asset")
	slot0._v1a5_dungeon_build = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_building_spriteset.asset")
	slot0._v1a5_news = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_news.asset")
	slot0._v1a5_peaceulu = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_peaceulu_spriteset.asset")
	slot0._dialogueChess = slot0:newSpriteSetUnit("ui/spriteassets/dialogue.asset")
	slot0._v1a5_df_sign = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_df_sign_spriteset.asset")
	slot0._v1a5_warmup = slot0:newSpriteSetUnit("ui/spriteassets/v1a5_warmup_spriteset.asset")
	slot0._activitypuzzle = slot0:newSpriteSetUnit("ui/spriteassets/versionactivitypuzzle.asset")
	slot0._v1a6_cachot = slot0:newSpriteSetUnit("ui/spriteassets/v1a6_cachot.asset")
	slot0._v1a6_enterview = slot0:newSpriteSetUnit("ui/spriteassets/v1a6_enterview.asset")
	slot0._v1a6_dungeon_sprite = slot0:newSpriteSetUnit("ui/spriteassets/v1a6_dungeon.asset")
	slot0._v1a6_dungeon_store = slot0:newSpriteSetUnit("ui/spriteassets/v1a6_store_spriteset.asset")
	slot0._v1a6_dungeon_skill = slot0:newSpriteSetUnit("ui/spriteassets/v1a6_talent_spriteset.asset")
	slot0._v1a6_seasonsum = slot0:newSpriteSetUnit("ui/spriteassets/v1a6_season_sum_spriteset.asset")
	slot0._v1a7_main_activity = slot0:newSpriteSetUnit("ui/spriteassets/v1a7_mainactivity_spriteset.asset")
	slot0._v1a7_lantern = slot0:newSpriteSetUnit("ui/spriteassets/v1a7_lamp_spriteset.asset")
	slot0._season123 = slot0:newSpriteSetUnit("ui/spriteassets/season123.asset")
	slot0._v1a7_v1a2reprint = slot0:newSpriteSetUnit("ui/spriteassets/v1a7_v1a2reprint_spriteset.asset")
	slot0._v1a8_main_activity = slot0:newSpriteSetUnit("ui/spriteassets/v1a8_mainactivity_spriteset.asset")
	slot0._v1a8_dungeon_sprite = slot0:newSpriteSetUnit("ui/spriteassets/v1a8_dungeon.asset")
	slot0._v1a8_factory_sprite = slot0:newSpriteSetUnit("ui/spriteassets/v1a8_factory.asset")
	slot0._v1a8_warmup_sprite = slot0:newSpriteSetUnit("ui/spriteassets/v1a8_warmup.asset")
	slot0._v1a9_main_activity = slot0:newSpriteSetUnit("ui/spriteassets/v1a9_mainactivity_spriteset.asset")
	slot0._toughbattle_role = slot0:newSpriteSetUnit("ui/spriteassets/toughbattle_role_spriteset.asset")
	slot0._toughbattle = slot0:newSpriteSetUnit("ui/spriteassets/toughbattle_spriteset.asset")
	slot0._dragonboat = slot0:newSpriteSetUnit("ui/spriteassets/v1a9_dragonboat_spriteset.asset")
	slot0._rouge = slot0:newSpriteSetUnit("ui/spriteassets/rouge.asset")
	slot0._rouge2 = slot0:newSpriteSetUnit("ui/spriteassets/rouge2.asset")
	slot0._rouge3 = slot0:newSpriteSetUnit("ui/spriteassets/rouge3.asset")
	slot0._rouge4 = slot0:newSpriteSetUnit("ui/spriteassets/rouge4.asset")
	slot0._fairyland = slot0:newSpriteSetUnit("ui/spriteassets/fairyland_spriteset.asset")
	slot0._bgmswitch = slot0:newSpriteSetUnit("ui/spriteassets/bgmtoggle.asset")
	slot0._v2a0_main_activity = slot0:newSpriteSetUnit("ui/spriteassets/v2a0_mainactivity_spriteset.asset")
	slot0._v2a0_dungeon_sprite = slot0:newSpriteSetUnit("ui/spriteassets/v2a0_dungeon.asset")
	slot0._v2a0_paint_sprite = slot0:newSpriteSetUnit("ui/spriteassets/v2a0_paint_spriteset.asset")
	slot0._playerinfo = slot0:newSpriteSetUnit("ui/spriteassets/playerinfo.asset")
	slot0._optionalgift = slot0:newSpriteSetUnit("ui/spriteassets/optionalgift_spriteset.asset")
	slot0._v2a1_aergusi = slot0:newSpriteSetUnit("ui/spriteassets/v2a1_aergusi.asset")
	slot0._v2a1_act165 = slot0:newSpriteSetUnit("ui/spriteassets/v2a1_act165.asset")
	slot0._v2a1_act165_2 = slot0:newSpriteSetUnit("ui/spriteassets/v2a1_act165_2.asset")
	slot0._v2a1_main_activity = slot0:newSpriteSetUnit("ui/spriteassets/v2a1_mainactivity_spriteset.asset")
	slot0._v2a1_dungeon_sprite = slot0:newSpriteSetUnit("ui/spriteassets/v2a1_dungeon.asset")
	slot0._v2a1_warmup = slot0:newSpriteSetUnit("ui/spriteassets/v2a1_warmup.asset")
	slot0._antique = slot0:newSpriteSetUnit("ui/spriteassets/antique.asset")
	slot0._v2a2_eliminate = slot0:newSpriteSetUnit("ui/spriteassets/v2a2_eliminate.asset")
	slot0._v2a2_chess = slot0:newSpriteSetUnit("ui/spriteassets/v2a2_chess_spriteset.asset")
	slot0._v2a2_main_activity = slot0:newSpriteSetUnit("ui/spriteassets/v2a2_mainactivity_spriteset.asset")
	slot0._v2a2_eliminate_point = slot0:newSpriteSetUnit("ui/spriteassets/v2a2_eliminate_pointpic.asset")
	slot0._season166 = slot0:newSpriteSetUnit("ui/spriteassets/season166.asset")
	slot0._season166_info = slot0:newSpriteSetUnit("ui/spriteassets/season166_info.asset")
	slot0._v2a2_lopera = slot0:newSpriteSetUnit("ui/spriteassets/v2a2_lopera_spriteset.asset")
	slot0._v2a3_main_activity = slot0:newSpriteSetUnit("ui/spriteassets/v2a3_mainactivity_spriteset.asset")
	slot0._v2a3_dungeon_sprite = slot0:newSpriteSetUnit("ui/spriteassets/v2a3_dungeon.asset")
	slot0._v2a3_zhixinquaner = slot0:newSpriteSetUnit("ui/spriteassets/v2a3_zhixinquaner_spriteset.asset")
	slot0._tower = slot0:newSpriteSetUnit("ui/spriteassets/tower.asset")
	slot0._tower_permanent = slot0:newSpriteSetUnit("ui/spriteassets/tower_permanent.asset")
	slot0._act174 = slot0:newSpriteSetUnit("ui/spriteassets/act174.asset")
end

function slot0.newSpriteSetUnit(slot0, slot1)
	slot2 = UISpriteSetUnit.New()

	slot2:init(slot1)
	table.insert(slot0._spriteSetList, slot2)

	return slot2
end

function slot0.setUiFBSprite(slot0, slot1, slot2, slot3)
	slot0._dungeon:setSprite(slot1, slot2, slot3)
end

function slot0.getDungeonSprite(slot0)
	return slot0._dungeon
end

function slot0.setUiCharacterSprite(slot0, slot1, slot2, slot3)
	slot0._character:setSprite(slot1, slot2, slot3)
end

function slot0.setCharactergetSprite(slot0, slot1, slot2, slot3)
	slot0._characterget:setSprite(slot1, slot2, slot3)
end

function slot0.setEquipSprite(slot0, slot1, slot2, slot3)
	slot0._equip:setSprite(slot1, slot2, slot3)
end

function slot0.setCommonSprite(slot0, slot1, slot2, slot3, slot4)
	slot0._common:setSprite(slot1, slot2, slot3, slot4)
end

function slot0.getCommonSprite(slot0, slot1)
	return slot0._common:getSprite(slot1)
end

function slot0.setCritterSprite(slot0, slot1, slot2, slot3, slot4)
	slot0._critter:setSprite(slot1, slot2, slot3, slot4)
end

function slot0.setFightSprite(slot0, slot1, slot2, slot3)
	slot0._fight:setSprite(slot1, slot2, slot3)
end

function slot0.setFightPassiveSprite(slot0, slot1, slot2, slot3)
	slot0._fightpassive:setSprite(slot1, slot2, slot3)
end

function slot0.setWeekWalkSprite(slot0, slot1, slot2, slot3, slot4)
	slot0._weekwalk:setSprite(slot1, slot2, slot3, slot4)
end

function slot0.getWeekWalkSpriteSetUnit(slot0)
	return slot0._weekwalk and slot0._weekwalk:getSpriteSetAsset()
end

function slot0.setHeroGroupSprite(slot0, slot1, slot2, slot3)
	slot0._herogroup:setSprite(slot1, slot2, slot3)
end

function slot0.setSummonSprite(slot0, slot1, slot2, slot3)
	slot0._summon:setSprite(slot1, slot2, slot3)
end

function slot0.setExploreSprite(slot0, slot1, slot2, slot3)
	slot0._explore:setSprite(slot1, slot2, slot3)
end

function slot0.setMainSprite(slot0, slot1, slot2, slot3)
	slot0._main:setSprite(slot1, slot2, slot3)
end

function slot0.setMailSprite(slot0, slot1, slot2, slot3)
	slot0._mail:setSprite(slot1, slot2, slot3)
end

function slot0.setMeilanniSprite(slot0, slot1, slot2, slot3)
	slot0._meilanni:setSprite(slot1, slot2, slot3)
end

function slot0.setRoomSprite(slot0, slot1, slot2, slot3)
	slot0._room:setSprite(slot1, slot2, slot3)
end

function slot0.setShareSprite(slot0, slot1, slot2, slot3)
	slot0._share:setSprite(slot1, slot2, slot3)
end

function slot0.setCharacterTalentSprite(slot0, slot1, slot2, slot3)
	slot0._characterTalent:setSprite(slot1, slot2, slot3)
end

function slot0.setHandBookCareerSprite(slot0, slot1, slot2, slot3)
	slot0._handbook:setSprite(slot1, slot2, slot3)
end

function slot0.setPuzzleSprite(slot0, slot1, slot2, slot3)
	slot0._puzzle:setSprite(slot1, slot2, slot3)
end

function slot0.setTeachNoteSprite(slot0, slot1, slot2, slot3)
	slot0._teachnote:setSprite(slot1, slot2, slot3)
end

function slot0.setStoreGoodsSprite(slot0, slot1, slot2, slot3)
	slot0._store:setSprite(slot1, slot2, slot3)
end

function slot0.setEnemyInfoSprite(slot0, slot1, slot2, slot3)
	slot0._enemyinfo:setSprite(slot1, slot2, slot3)
end

function slot0.setHerogroupEquipIconSprite(slot0, slot1, slot2, slot3)
	slot0._herogroupequipicon:setSprite(slot1, slot2, slot3)
end

function slot0.setPlayerRareBgSprite(slot0, slot1, slot2, slot3)
	slot0._playerrarebg:setSprite(slot1, slot2, slot3)
end

function slot0.setCurrencyItemSprite(slot0, slot1, slot2, slot3)
	slot0._currencyitem:setSprite(slot1, slot2, slot3)
end

function slot0.setToastSprite(slot0, slot1, slot2, slot3)
	slot0._toast:setSprite(slot1, slot2, slot3)
end

function slot0.setBuffSprite(slot0, slot1, slot2, slot3)
	slot0._buff:setSprite(slot1, tostring(slot2), slot3)
end

function slot0.setActivityNoviceTaskSprite(slot0, slot1, slot2, slot3)
	slot0._activitynovicetask:setSprite(slot1, slot2, slot3)
end

function slot0.setSignInSprite(slot0, slot1, slot2, slot3)
	slot0._signin:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a3BuffIconSprite(slot0, slot1, slot2, slot3)
	slot0._v1a3_bufficon:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a3AstrologySprite(slot0, slot1, slot2, slot3, slot4)
	slot0._v1a3_astrology:setSprite(slot1, slot2, slot3, slot4)
end

function slot0.setV1a3StoreSprite(slot0, slot1, slot2, slot3, slot4)
	slot0._v1a3_store:setSprite(slot1, slot2, slot3, slot4)
end

function slot0.setV1a3EnterViewSprite(slot0, slot1, slot2, slot3, slot4)
	slot0._v1a3_enterview:setSprite(slot1, slot2, slot3, slot4)
end

function slot0.setV1a4EnterViewSprite(slot0, slot1, slot2, slot3, slot4)
	slot0._v1a4_enterview:setSprite(slot1, slot2, slot3, slot4)
end

function slot0.setV1a5EnterViewSprite(slot0, slot1, slot2, slot3, slot4)
	slot0._v1a5_enterview:setSprite(slot1, slot2, slot3, slot4)
end

function slot0.setV1a3FairyLandCardSprite(slot0, slot1, slot2, slot3, slot4)
	slot0._v1a3_fairylandcard_spriteset:setSprite(slot1, slot2, slot3, slot4)
end

function slot0.setDungeonNavigationSprite(slot0, slot1, slot2, slot3)
	slot0._dungeonnavigation:setSprite(slot1, slot2, slot3)
end

function slot0.setDungeonLevelRuleSprite(slot0, slot1, slot2, slot3)
	slot0._dungeonlevelrule:setSprite(slot1, slot2, slot3)
end

function slot0.setSeasonSprite(slot0, slot1, slot2, slot3)
	slot0._seasonitem:setSprite(slot1, slot2, slot3)
end

function slot0.setActivityWarmUpSprite(slot0, slot1, slot2, slot3)
	slot0._activitywarmup:setSprite(slot1, slot2, slot3)
end

function slot0.setVersionActivitySprite(slot0, slot1, slot2, slot3)
	slot0._versionactivity:setSprite(slot1, slot2, slot3)
end

function slot0.setVersionActivity1_3Sprite(slot0, slot1, slot2, slot3)
	slot0._v1a3_dungeon:setSprite(slot1, slot2, slot3)
end

function slot0.setActivityChessMapSprite(slot0, slot1, slot2, slot3)
	slot0._activitychessmap:setSprite(slot1, slot2, slot3)
end

function slot0.setPushBoxSprite(slot0, slot1, slot2, slot3)
	slot0._versionactivitypushbox:setSprite(slot1, slot2, slot3)
end

function slot0.setVersionActivity114Sprite(slot0, slot1, slot2, slot3)
	slot0._versionactivity114:setSprite(slot1, slot2, slot3)
end

function slot0.setVersionActivitywhitehouseSprite(slot0, slot1, slot2, slot3)
	slot0._versionactivitywhitehouse:setSprite(slot1, slot2, slot3)
end

function slot0.setVersionActivity1_2Sprite(slot0, slot1, slot2, slot3)
	slot0._versionactivity1_2:setSprite(slot1, slot2, slot3)
end

function slot0.setYaXianSprite(slot0, slot1, slot2, slot3)
	slot0._versionactivity1_2_yaxian:setSprite(slot1, slot2, slot3)
end

function slot0.setVersionActivityTrade_1_2Sprite(slot0, slot1, slot2, slot3)
	slot0._versionactivitytrade_1_2:setSprite(slot1, slot2, slot3)
end

function slot0.setVersionActivityDungeon_1_2Sprite(slot0, slot1, slot2, slot3)
	slot0._versionactivitydungeon_1_2:setSprite(slot1, slot2, slot3)
end

function slot0.setJiaLaBoNaSprite(slot0, slot1, slot2, slot3)
	slot0._versionactivity1_3_jialabona:setSprite(slot1, slot2, slot3)
end

function slot0.setActivity1_3ChessSprite(slot0, slot1, slot2, slot3)
	slot0._versionactivity1_3_chess:setSprite(slot1, slot2, slot3)
end

function slot0.setArmPipeSprite(slot0, slot1, slot2, slot3)
	slot0._versionactivity1_3_armpipe:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a4ShiprepairSprite(slot0, slot1, slot2, slot3)
	slot0._v1a4_shiprepair:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a4CollectSprite(slot0, slot1, slot2, slot3)
	slot0._v1a4_collect:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a4Role37Sprite(slot0, slot1, slot2, slot3)
	slot0._v1a4_role37:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a4BossRushSprite(slot0, slot1, slot2, slot3)
	slot0._v1a4_bossrush:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a4SeasonSumSprite(slot0, slot1, slot2, slot3)
	slot0._v1a4_seasonsum:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a5RevivalTaskSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_revivaltask:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a5ChessSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_chess:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a5AiZiLaSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_aizila:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a5DungeonStoreSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_dungeon_store:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a5DungeonSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_dungeon_sprite:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a5DungeonBuildSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_dungeon_build:setSprite(slot1, slot2, slot3)
end

function slot0.setNewsSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_news:setSprite(slot1, slot2, slot3)
end

function slot0.setPeaceUluSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_peaceulu:setSprite(slot1, slot2, slot3)
end

function slot0.setDialogueChessSprite(slot0, slot1, slot2, slot3)
	slot0._dialogueChess:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a5DfSignSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_df_sign:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a5WarmUpSprite(slot0, slot1, slot2, slot3)
	slot0._v1a5_warmup:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a6CachotSprite(slot0, slot1, slot2, slot3)
	slot0._v1a6_cachot:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a6DungeonSprite(slot0, slot1, slot2, slot3)
	slot0._v1a6_dungeon_sprite:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a6DungeonStoreSprite(slot0, slot1, slot2, slot3)
	slot0._v1a6_dungeon_store:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a6DungeonSkillSprite(slot0, slot1, slot2, slot3)
	slot0._v1a6_dungeon_skill:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a6EnterSprite(slot0, slot1, slot2, slot3)
	slot0._v1a6_enterview:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a7MainActivitySprite(slot0, slot1, slot2, slot3)
	slot0._v1a7_main_activity:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a7LanternSprite(slot0, slot1, slot2, slot3)
	slot0._v1a7_lantern:setSprite(slot1, slot2, slot3)
end

function slot0.setSeason123Sprite(slot0, slot1, slot2, slot3)
	slot0._season123:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a7ReprintSprite(slot0, slot1, slot2, slot3)
	slot0._v1a7_v1a2reprint:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a6SeasonSumSprite(slot0, slot1, slot2, slot3)
	slot0._v1a6_seasonsum:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a8MainActivitySprite(slot0, slot1, slot2, slot3)
	slot0._v1a8_main_activity:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a8DungeonSprite(slot0, slot1, slot2, slot3)
	slot0._v1a8_dungeon_sprite:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a8FactorySprite(slot0, slot1, slot2, slot3)
	slot0._v1a8_factory_sprite:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a8WarmUpSprite(slot0, slot1, slot2, slot3)
	slot0._v1a8_warmup_sprite:setSprite(slot1, slot2, slot3)
end

function slot0.setV1a9MainActivitySprite(slot0, slot1, slot2, slot3)
	slot0._v1a9_main_activity:setSprite(slot1, slot2, slot3)
end

function slot0.setToughBattleRoleSprite(slot0, slot1, slot2, slot3)
	slot0._toughbattle_role:setSprite(slot1, slot2, slot3)
end

function slot0.setToughBattleSprite(slot0, slot1, slot2, slot3)
	slot0._toughbattle:setSprite(slot1, slot2, slot3)
end

function slot0.setDragonBoatSprite(slot0, slot1, slot2, slot3)
	slot0._dragonboat:setSprite(slot1, slot2, slot3)
end

function slot0.setRougeSprite(slot0, slot1, slot2, slot3)
	slot0._rouge:setSprite(slot1, slot2, slot3)
end

function slot0.setRouge2Sprite(slot0, slot1, slot2, slot3)
	slot0._rouge2:setSprite(slot1, slot2, slot3)
end

function slot0.setRouge3Sprite(slot0, slot1, slot2, slot3)
	slot0._rouge3:setSprite(slot1, slot2, slot3)
end

function slot0.setRouge4Sprite(slot0, slot1, slot2, slot3)
	slot0._rouge4:setSprite(slot1, slot2, slot3)
end

function slot0.setFairyLandSprite(slot0, slot1, slot2, slot3)
	slot0._fairyland:setSprite(slot1, slot2, slot3)
end

function slot0.setBgmSwitchToggleSprite(slot0, slot1, slot2, slot3)
	slot0._bgmswitch:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a0MainActivitySprite(slot0, slot1, slot2, slot3)
	slot0._v2a0_main_activity:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a0DungeonSprite(slot0, slot1, slot2, slot3)
	slot0._v2a0_dungeon_sprite:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a0PaintSprite(slot0, slot1, slot2, slot3)
	slot0._v2a0_paint_sprite:setSprite(slot1, slot2, slot3)
end

function slot0.setPlayerInfoSprite(slot0, slot1, slot2, slot3)
	slot0._playerinfo:setSprite(slot1, slot2, slot3)
end

function slot0.setOptionalGiftSprite(slot0, slot1, slot2, slot3)
	slot0._optionalgift:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a2MainActivitySprite(slot0, slot1, slot2, slot3)
	slot0._v2a2_main_activity:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a1AergusiSprite(slot0, slot1, slot2, slot3)
	slot0._v2a1_aergusi:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a1Act165Sprite(slot0, slot1, slot2, slot3)
	slot0._v2a1_act165:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a1Act165_2Sprite(slot0, slot1, slot2, slot3)
	slot0._v2a1_act165_2:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a1MainActivitySprite(slot0, slot1, slot2, slot3)
	slot0._v2a1_main_activity:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a1DungeonSprite(slot0, slot1, slot2, slot3)
	slot0._v2a1_dungeon_sprite:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a2EliminateSprite(slot0, slot1, slot2, slot3)
	slot0._v2a2_eliminate:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a1WarmupSprite(slot0, slot1, slot2, slot3)
	slot0._v2a1_warmup:setSprite(slot1, slot2, slot3)
end

function slot0.setAntiqueSprite(slot0, slot1, slot2, slot3)
	slot0._antique:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a2ChessSprite(slot0, slot1, slot2, slot3)
	slot0._v2a2_chess:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a2eliminatePointSprite(slot0, slot1, slot2, slot3)
	slot0._v2a2_eliminate_point:setSprite(slot1, slot2, slot3)
end

function slot0.setSeason166Sprite(slot0, slot1, slot2, slot3)
	slot0._season166:setSprite(slot1, slot2, slot3)
end

function slot0.setSeason166InfoSprite(slot0, slot1, slot2, slot3)
	slot0._season166_info:setSprite(slot1, slot2, slot3)
end

function slot0.setLoperaItemSprite(slot0, slot1, slot2, slot3)
	slot0._v2a2_lopera:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a3MainActivitySprite(slot0, slot1, slot2, slot3)
	slot0._v2a3_main_activity:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a3DungeonSprite(slot0, slot1, slot2, slot3)
	slot0._v2a3_dungeon_sprite:setSprite(slot1, slot2, slot3)
end

function slot0.setTowerSprite(slot0, slot1, slot2, slot3)
	slot0._tower:setSprite(slot1, slot2, slot3)
end

function slot0.setTowerPermanentSprite(slot0, slot1, slot2, slot3)
	slot0._tower_permanent:setSprite(slot1, slot2, slot3)
end

function slot0.setAct174Sprite(slot0, slot1, slot2, slot3)
	slot0._act174:setSprite(slot1, slot2, slot3)
end

function slot0.setV2a3ZhiXinQuanErSprite(slot0, slot1, slot2, slot3)
	slot0._v2a3_zhixinquaner:setSprite(slot1, slot2, slot3)
end

function slot0.tryDispose(slot0)
	for slot4, slot5 in ipairs(slot0._spriteSetList) do
		slot5:tryDispose()
	end
end

function slot0.setActivityPuzzle(slot0, slot1, slot2, slot3)
	slot0._activitypuzzle:setSprite(slot1, slot2, slot3)
end

slot0.instance = slot0.New()

return slot0
