module("modules.logic.versionactivity1_5.act142.define.Activity142Enum", package.seeall)

slot0 = _M
slot0.UI_BlOCK_KEY = "Activity142UIBlock"
slot0.RETURN_CHECK_POINT = "Activity142ReturnCheckPoint"
slot0.RESET_GAME = "Activity142ResetGame"
slot0.FIRING_BALL = "Activity142FiringBall"
slot0.SWITCH_PLAYER = "Activity142PlayerBorn"
slot0.PLAY_MAP_VIEW_ANIM = "Activity142MapViewPlayAnim"
slot0.MAP_ITEM_UNLOCK = "Activity142MapItemUnlock"
slot0.MAP_CATEGORY_UNLOCK = "Activity142CategoryUnlock"
slot0.EPISODE_STAR_UNLOCK = "Activity142EpisodeStarUnlock"
slot0.COLLECTION_UNLOCK = "Activity142CollectionUnlock"
slot0.STORY_REVIEW_UNLOCK = "Activity142StoryReviewUnlock"
slot0.MAX_EPISODE_SINGLE_CHAPTER = 4
slot0.MAX_EPISODE_SINGLE_SP_CHAPTER = 3
slot0.TASK_ALL_RECEIVE_ITEM_EMPTY_ID = -100
slot0.MAX_FIRE_BALL_NUM = 5
slot0.COLLECTION_VIEW_OFFSET = 0.015
slot0.DEFAULT_STAR_NUM = 1
slot0.AUTO_ENTER_EPISODE_ID = 1
slot0.NOT_PLAY_UNLOCK_ANIM_CHAPTER = 1
slot0.OPEN_MAP_VIEW_TIME = 1
slot0.CLOSE_MAP_VIEW_TIME = 0.3
slot0.MAP_VIEW_SWITCH_ANIM = "switch"
slot0.MAP_VIEW_SWITCH_SET_MAP_ITEM_ANIM_TIME = 0.16
slot0.CATEGORY_IDLE_ANIM = "idle"
slot0.CATEGORY_UNLOCK_ANIM = "unlock"
slot0.CATEGORY_CACHE_KEY = "ACT142_CATEGORY_IS_UNLOCK"
slot0.MAP_ITEM_IDLE_ANIM = "idle"
slot0.MAP_ITEM_UNLOCK_ANIM = "unlock"
slot0.MAP_ITEM_CACHE_KEY = "ACT142_MAP_ITEM_IS_UNLOCK"
slot0.MAP_STAR_IDLE_ANIM = "idle"
slot0.MAP_STAR_OPEN_ANIM = "open"
slot0.MAP_STAR_CACHE_KEY = "ACT142_MAP_STAR_IS_UNLOCK"
slot0.COLLECTION_IDLE_ANIM = "idle"
slot0.COLLECTION_UNLOCK_ANIM = "unlock"
slot0.COLLECTION_CACHE_KEY = "ACT142_COLLECTION_IS_UNLOCK"
slot0.STORY_REVIEW_IDLE_ANIM = "idle"
slot0.STORY_REVIEW_UNLOCK_ANIM = "unlock"
slot0.STORY_REVIEW__CACHE_KEY = "ACT142_STORY_REVIEW_IS_UNLOCK"
slot0.PLAYER_SWITCH_TIME = 1.5
slot0.SWITCH_OPEN_ANIM = "swopen"
slot0.SWITCH_CLOSE_ANIM = "swclose"
slot0.GAME_VIEW_CLOSE_EYE_TIME = 0.5
slot0.GAME_VIEW_EYE_CLOSE_ANIM = "open"
slot0.GAME_VIEW_EYE_OPEN_ANIM = "close"
slot0.CanBlockFireBallInteractType = {
	[Va3ChessEnum.InteractType.Player] = true,
	[Va3ChessEnum.InteractType.AssistPlayer] = true,
	[Va3ChessEnum.InteractType.Obstacle] = true,
	[Va3ChessEnum.InteractType.Brazier] = true,
	[Va3ChessEnum.InteractType.BoltLauncher] = true,
	[Va3ChessEnum.InteractType.StandbyTrackEnemy] = true,
	[Va3ChessEnum.InteractType.SentryEnemy] = true,
	[Va3ChessEnum.InteractType.TriggerFail] = true
}
slot0.CanFireKillInteractType = {
	[Va3ChessEnum.InteractType.StandbyTrackEnemy] = true,
	[Va3ChessEnum.InteractType.SentryEnemy] = true,
	[Va3ChessEnum.InteractType.TriggerFail] = true
}
slot0.CanMoveKillInteractType = {
	[Va3ChessEnum.InteractType.SentryEnemy] = true
}
slot0.HorBaffleResPath = {
	[0] = "scenes/v1a5_m_s12_dfw_krd/perefab/stone_a.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_b.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_c.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_d.prefab"
}
slot0.VerBaffleResPath = {
	[0] = "scenes/v1a5_m_s12_dfw_krd/perefab/stone_e.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_f.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_g.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_h.prefab"
}
slot0.BrokenGroundItemPath = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_xianjing.prefab"
slot0.SwitchPlayerEffPath = "scenes/v1a5_m_s12_dfw_krd/perefab/vx_fire.prefab"
slot0.BaffleOffset = {
	baffleOffsetY = 0.44,
	baffleOffsetX = 0.64
}

return slot0
