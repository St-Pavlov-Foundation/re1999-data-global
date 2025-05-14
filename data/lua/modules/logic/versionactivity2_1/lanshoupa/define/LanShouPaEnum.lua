module("modules.logic.versionactivity2_1.lanshoupa.define.LanShouPaEnum", package.seeall)

local var_0_0 = _M

var_0_0.MinSlideX = 0
var_0_0.MaxSlideX = 1110
var_0_0.SceneMaxX = 14.92
var_0_0.SlideSpeed = 1
var_0_0.MaxShowEpisodeCount = 5
var_0_0.ProgressType = {
	Interact = 1,
	BeforeStory = 0,
	Finished = 3,
	AfterStory = 2
}
var_0_0.StageType = {
	Branch = 2,
	Main = 1
}
var_0_0.Stage = {
	StarIcon = {
		[var_0_0.StageType.Main] = "v1a3_role1_og_stagestar1",
		[var_0_0.StageType.Branch] = "v1a3_role1_og_stagestar2"
	},
	FrameBg = {
		[var_0_0.StageType.Main] = "v1a3_role1_og_stagemainclearbg",
		[var_0_0.StageType.Branch] = "v1a3_role1_og_stagebranchclearbg"
	},
	StageColor = {
		[var_0_0.StageType.Main] = "#AFD3FF",
		[var_0_0.StageType.Branch] = "#D5CAB0"
	},
	StageNameColor = {
		[var_0_0.StageType.Main] = "#C2E4FF",
		[var_0_0.StageType.Branch] = "#D5CAB0"
	}
}
var_0_0.StatgePiontSpriteName = {
	Finished = "v1a3_role1_og_stagepointfinished",
	Current = "v1a3_role1_og_stagepointcurrent",
	UnFinished = "v1a3_role1_og_stagepointunfinished"
}
var_0_0.Chapter = {
	Two = 2,
	One = 1
}
var_0_0.MapSceneRes = {
	[var_0_0.Chapter.One] = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_01_p.prefab",
	[var_0_0.Chapter.Two] = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_02_p.prefab"
}
var_0_0.ChapterPathAnimParam = {
	[var_0_0.Chapter.One] = {
		{
			1,
			0.89
		},
		{
			0.89,
			0.71
		},
		{
			0.71,
			0.54
		},
		{
			0.54,
			0.28
		},
		{
			0.28,
			0
		}
	},
	[var_0_0.Chapter.Two] = {
		{
			1,
			0.89
		},
		{
			0.89,
			0.68
		},
		{
			0.68,
			0.41
		},
		{
			0.41,
			0.28
		},
		{
			0.23,
			0
		}
	}
}
var_0_0.AnimatorTime = {
	MapViewOpen = 1,
	TaskRewardMoveUp = 0.15,
	ChapterPath = 1,
	TaskReward = 0.5,
	SwithSceneOpen = 0.5,
	MapViewClose = 0.3
}
var_0_0.SceneResPath = {
	GroundPoSui = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_dimian_b.prefab"
}
var_0_0.ComponentType = {
	Animator = typeof(UnityEngine.Animator),
	UIMesh = typeof(UIMesh)
}
var_0_0.ResultLangResPath = {
	[0] = "Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed.png",
	"Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed_2.png",
	nil,
	"Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed_3.png"
}
var_0_0.TaskMOAllFinishId = -100
var_0_0.episodeId = 1211401
var_0_0.chapterId = 13801
var_0_0.lvSceneType = {
	Light = 1,
	Moon = 2
}

return var_0_0
