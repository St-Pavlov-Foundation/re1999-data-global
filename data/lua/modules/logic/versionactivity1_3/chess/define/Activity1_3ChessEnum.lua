module("modules.logic.versionactivity1_3.chess.define.Activity1_3ChessEnum", package.seeall)

local var_0_0 = _M

var_0_0.NodeType = {
	Branch = 2,
	Main = 1
}
var_0_0.NodeResPathEnum = {
	FrameBg = "v1a3_role1_og_stagemainclearbg",
	StarIcon = "v1a3_role1_og_stagestar1",
	StageNameColor = "#C2E4FF",
	StageColor = "#AFD3FF"
}
var_0_0.ChessGameEnum = {
	MainTargetColorGray = "#989898",
	ExTargetColorGray = "#6D6D6D",
	ExTargetColorActive = "#F1EE92",
	MainTargetColorActive = "#A5C26E"
}
var_0_0.Chapter = {
	Two = 2,
	One = 1
}
var_0_0.MapSceneResPath = {
	[1] = "scenes/v1a3_m_s12_dfw_zmsl/prefab/m_s12_zjm_zmsl_a_p.prefab",
	[2] = "scenes/v1a3_m_s12_dfw_zmsl/prefab/m_s12_zjm_zmsl_b_p.prefab"
}
var_0_0.SpriteName = {
	NodeFinished = "v1a3_role1_og_stagepointfinished",
	NodeCurrent = "v1a3_role1_og_stagepointcurrent",
	LifeIconGrey = "v1a3_role2_ig_lifeicon1",
	NodeUnFinished = "v1a3_role1_og_stagepointunfinished",
	LifeIcon = "v1a3_role2_ig_lifeicon2"
}
var_0_0.SceneResPath = {
	SightTile2 = "scenes/v1a3_m_s12_dfw_zmsl/prefab/m_s12_mask_02.prefab",
	FireTile = "scenes/v1a3_m_s12_dfw_zmsl/prefab/picpe/m_s12_zmsl_hydc.prefab",
	SightTile3 = "scenes/v1a3_m_s12_dfw_zmsl/prefab/m_s12_mask_03.prefab",
	SightEdgeTile = "scenes/v1a3_m_s12_dfw_zmsl/prefab/m_s12_mask_04.prefab",
	SightTile1 = "scenes/v1a3_m_s12_dfw_zmsl/prefab/m_s12_mask_01.prefab"
}
var_0_0.StoryType = {
	Episode = 1,
	Interact = 2
}
var_0_0.UIBlockKey = "Activity1_3ChessUIBlock"
var_0_0.episodeId = 1370101
var_0_0.chapterId = 13701

return var_0_0
