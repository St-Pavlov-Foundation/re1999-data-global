module("modules.logic.versionactivity1_5.act142.define.Activity142Enum", package.seeall)

local var_0_0 = _M

var_0_0.UI_BlOCK_KEY = "Activity142UIBlock"
var_0_0.RETURN_CHECK_POINT = "Activity142ReturnCheckPoint"
var_0_0.RESET_GAME = "Activity142ResetGame"
var_0_0.FIRING_BALL = "Activity142FiringBall"
var_0_0.SWITCH_PLAYER = "Activity142PlayerBorn"
var_0_0.PLAY_MAP_VIEW_ANIM = "Activity142MapViewPlayAnim"
var_0_0.MAP_ITEM_UNLOCK = "Activity142MapItemUnlock"
var_0_0.MAP_CATEGORY_UNLOCK = "Activity142CategoryUnlock"
var_0_0.EPISODE_STAR_UNLOCK = "Activity142EpisodeStarUnlock"
var_0_0.COLLECTION_UNLOCK = "Activity142CollectionUnlock"
var_0_0.STORY_REVIEW_UNLOCK = "Activity142StoryReviewUnlock"
var_0_0.MAX_EPISODE_SINGLE_CHAPTER = 4
var_0_0.MAX_EPISODE_SINGLE_SP_CHAPTER = 3
var_0_0.TASK_ALL_RECEIVE_ITEM_EMPTY_ID = -100
var_0_0.MAX_FIRE_BALL_NUM = 5
var_0_0.COLLECTION_VIEW_OFFSET = 0.015
var_0_0.DEFAULT_STAR_NUM = 1
var_0_0.AUTO_ENTER_EPISODE_ID = 1
var_0_0.NOT_PLAY_UNLOCK_ANIM_CHAPTER = 1
var_0_0.OPEN_MAP_VIEW_TIME = 1
var_0_0.CLOSE_MAP_VIEW_TIME = 0.3
var_0_0.MAP_VIEW_SWITCH_ANIM = "switch"
var_0_0.MAP_VIEW_SWITCH_SET_MAP_ITEM_ANIM_TIME = 0.16
var_0_0.CATEGORY_IDLE_ANIM = "idle"
var_0_0.CATEGORY_UNLOCK_ANIM = "unlock"
var_0_0.CATEGORY_CACHE_KEY = "ACT142_CATEGORY_IS_UNLOCK"
var_0_0.MAP_ITEM_IDLE_ANIM = "idle"
var_0_0.MAP_ITEM_UNLOCK_ANIM = "unlock"
var_0_0.MAP_ITEM_CACHE_KEY = "ACT142_MAP_ITEM_IS_UNLOCK"
var_0_0.MAP_STAR_IDLE_ANIM = "idle"
var_0_0.MAP_STAR_OPEN_ANIM = "open"
var_0_0.MAP_STAR_CACHE_KEY = "ACT142_MAP_STAR_IS_UNLOCK"
var_0_0.COLLECTION_IDLE_ANIM = "idle"
var_0_0.COLLECTION_UNLOCK_ANIM = "unlock"
var_0_0.COLLECTION_CACHE_KEY = "ACT142_COLLECTION_IS_UNLOCK"
var_0_0.STORY_REVIEW_IDLE_ANIM = "idle"
var_0_0.STORY_REVIEW_UNLOCK_ANIM = "unlock"
var_0_0.STORY_REVIEW__CACHE_KEY = "ACT142_STORY_REVIEW_IS_UNLOCK"
var_0_0.PLAYER_SWITCH_TIME = 1.5
var_0_0.SWITCH_OPEN_ANIM = "swopen"
var_0_0.SWITCH_CLOSE_ANIM = "swclose"
var_0_0.GAME_VIEW_CLOSE_EYE_TIME = 0.5
var_0_0.GAME_VIEW_EYE_CLOSE_ANIM = "open"
var_0_0.GAME_VIEW_EYE_OPEN_ANIM = "close"
var_0_0.CanBlockFireBallInteractType = {
	[Va3ChessEnum.InteractType.Player] = true,
	[Va3ChessEnum.InteractType.AssistPlayer] = true,
	[Va3ChessEnum.InteractType.Obstacle] = true,
	[Va3ChessEnum.InteractType.Brazier] = true,
	[Va3ChessEnum.InteractType.BoltLauncher] = true,
	[Va3ChessEnum.InteractType.StandbyTrackEnemy] = true,
	[Va3ChessEnum.InteractType.SentryEnemy] = true,
	[Va3ChessEnum.InteractType.TriggerFail] = true
}
var_0_0.CanFireKillInteractType = {
	[Va3ChessEnum.InteractType.StandbyTrackEnemy] = true,
	[Va3ChessEnum.InteractType.SentryEnemy] = true,
	[Va3ChessEnum.InteractType.TriggerFail] = true
}
var_0_0.CanMoveKillInteractType = {
	[Va3ChessEnum.InteractType.SentryEnemy] = true
}
var_0_0.HorBaffleResPath = {
	[0] = "scenes/v1a5_m_s12_dfw_krd/perefab/stone_a.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_b.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_c.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_d.prefab"
}
var_0_0.VerBaffleResPath = {
	[0] = "scenes/v1a5_m_s12_dfw_krd/perefab/stone_e.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_f.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_g.prefab",
	"scenes/v1a5_m_s12_dfw_krd/perefab/stone_h.prefab"
}
var_0_0.BrokenGroundItemPath = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_xianjing.prefab"
var_0_0.SwitchPlayerEffPath = "scenes/v1a5_m_s12_dfw_krd/perefab/vx_fire.prefab"
var_0_0.BaffleOffset = {
	baffleOffsetY = 0.44,
	baffleOffsetX = 0.64
}

return var_0_0
