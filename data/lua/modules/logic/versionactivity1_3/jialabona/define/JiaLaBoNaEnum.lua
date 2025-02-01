module("modules.logic.versionactivity1_3.jialabona.define.JiaLaBoNaEnum", package.seeall)

slot0 = _M
slot0.StageType = {
	Branch = 2,
	Main = 1
}
slot0.Stage = {
	StarIcon = {
		[slot0.StageType.Main] = "v1a3_role1_og_stagestar1",
		[slot0.StageType.Branch] = "v1a3_role1_og_stagestar2"
	},
	FrameBg = {
		[slot0.StageType.Main] = "v1a3_role1_og_stagemainclearbg",
		[slot0.StageType.Branch] = "v1a3_role1_og_stagebranchclearbg"
	},
	StageColor = {
		[slot0.StageType.Main] = "#AFD3FF",
		[slot0.StageType.Branch] = "#D5CAB0"
	},
	StageNameColor = {
		[slot0.StageType.Main] = "#C2E4FF",
		[slot0.StageType.Branch] = "#D5CAB0"
	}
}
slot0.StatgePiontSpriteName = {
	Finished = "v1a3_role1_og_stagepointfinished",
	Current = "v1a3_role1_og_stagepointcurrent",
	UnFinished = "v1a3_role1_og_stagepointunfinished"
}
slot0.Chapter = {
	Two = 2,
	One = 1
}
slot0.MapSceneRes = {
	[slot0.Chapter.One] = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_01_p.prefab",
	[slot0.Chapter.Two] = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_02_p.prefab"
}
slot0.ChapterPathAnimParam = {
	[slot0.Chapter.One] = {
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
	[slot0.Chapter.Two] = {
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
slot0.AnimatorTime = {
	MapViewOpen = 1,
	TaskRewardMoveUp = 0.15,
	ChapterPath = 1,
	TaskReward = 0.5,
	SwithSceneOpen = 0.5,
	MapViewClose = 0.3
}
slot0.StoryType = {
	Episode = 1,
	Interact = 2
}
slot0.SceneResPath = {
	GroundPoSui = "scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_dimian_b.prefab"
}
slot0.ComponentType = {
	Animator = typeof(UnityEngine.Animator),
	UIMesh = typeof(UIMesh)
}
slot0.ResultLangResPath = {
	[0] = "Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed.png",
	"Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed_2.png",
	nil,
	"Assets/ZResourcesLib/singlebg_lang/txt_v1a3_role1_singlebg/v1a3_role1_resulttitlefailed_3.png"
}
slot0.FailResultLangTxtId = {
	[ActivityChessEnum.FailReason.None] = "p_v1a3_role2_resulttitle_3",
	[ActivityChessEnum.FailReason.Battle] = "p_v1a3_role2_resulttitle_4",
	[ActivityChessEnum.FailReason.CanNotMove] = "p_v1a3_role2_resulttitle_3",
	[ActivityChessEnum.FailReason.MaxRound] = "p_v1a3_role2_resulttitle_5",
	[ActivityChessEnum.FailReason.FailInteract] = "p_v1a3_role2_resulttitle_3"
}
slot0.TaskMOAllFinishId = -100
slot0.episodeId = 1380101
slot0.chapterId = 13801

return slot0
