module("modules.logic.dungeon.defines.DungeonPuzzleEnum", package.seeall)

slot0 = _M
slot0.hintCount = 3
slot0.pipeEntryClearCount = 2
slot0.pipeEntryClearDecimal = 10
slot0.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
slot0.backgroundRes = {
	[0] = {
		"bg_jiemi_weijietuong",
		0,
		0,
		0
	},
	[28] = {
		"bg_jiemi_zhixian",
		0,
		0,
		0
	},
	[46] = {
		"bg_jiemi_zhixian",
		90,
		0,
		0
	},
	[48] = {
		"bg_jiemi_guaijiao",
		90,
		45.2,
		36
	},
	[68] = {
		"bg_jiemi_guaijiao",
		0,
		45.2,
		36
	},
	[26] = {
		"bg_jiemi_guaijiao",
		270,
		45.2,
		36
	},
	[24] = {
		"bg_jiemi_guaijiao",
		180,
		45.2,
		36
	},
	[468] = {
		"bg_jiemi_sancha",
		0,
		0,
		36
	},
	[268] = {
		"bg_jiemi_sancha",
		270,
		0,
		36
	},
	[246] = {
		"bg_jiemi_sancha",
		180,
		0,
		36
	},
	[248] = {
		"bg_jiemi_sancha",
		90,
		0,
		36
	}
}
slot0.connectRes = {
	[0] = {
		"bg_jiemi_jietuong",
		0,
		0,
		0
	},
	[28] = {
		"bg_jiemi_lianjie_1",
		0,
		0,
		0
	},
	[46] = {
		"bg_jiemi_lianjie_1",
		90,
		0,
		0
	},
	[48] = {
		"bg_jiemi_lianjie_2",
		90,
		47.1,
		43
	},
	[68] = {
		"bg_jiemi_lianjie_2",
		0,
		47.1,
		43
	},
	[26] = {
		"bg_jiemi_lianjie_2",
		270,
		47.1,
		43
	},
	[24] = {
		"bg_jiemi_lianjie_2",
		180,
		47.1,
		43
	},
	[468] = {
		"bg_jiemi_lianjie_3",
		90,
		46.4,
		-6.4
	},
	[268] = {
		"bg_jiemi_lianjie_3",
		0,
		46.4,
		-6.4
	},
	[246] = {
		"bg_jiemi_lianjie_3",
		270,
		46.4,
		-6.4
	},
	[248] = {
		"bg_jiemi_lianjie_3",
		180,
		46.4,
		-6.4
	}
}
slot0.mazeDrawWidth = 4
slot0.mazeDrawHeight = 3
slot0.mazeUIGridWidth = 257.3
slot0.mazeUIGridHeight = 167.5
slot0.mazeUILineWidth = 90
slot0.mazeUILineHorizonUIWidth = 261.2
slot0.mazeUILineVerticalUIWidth = 170.5
slot0.mazeMonsterHeight = 45
slot0.mazeMonsterTouchOffsetX = 0
slot0.MazeObjType = {
	CheckPointPassed = 14,
	End = 2,
	CheckPoint = 4,
	Start = 1,
	Block = 3
}
slot0.MazeObjResType = {
	[slot0.MazeObjType.Start] = {
		"ui_maze_start",
		-13.1,
		13.1
	},
	[slot0.MazeObjType.End] = {
		"ui_maze_end",
		-21.7,
		7.2
	},
	[slot0.MazeObjType.Block] = {
		"bg_zhangai_1",
		3.4,
		0,
		"bg_zhangai_1_dis"
	},
	[slot0.MazeObjType.CheckPoint] = {
		"bg_didian_1_dis",
		1.7,
		22.1
	},
	[slot0.MazeObjType.CheckPointPassed] = {
		"bg_didian_1",
		1.7,
		22.1
	}
}
slot0.mazeCheckPointResMap = {
	[0] = {
		"bg_didian_1_dis",
		1,
		30
	},
	{
		"bg_didian_2_dis",
		4.6,
		34.3
	},
	{
		"bg_didian_3_dis",
		1.3,
		32.3
	},
	{
		"bg_didian_4_dis",
		16.7,
		32.1
	},
	{
		"bg_didian_5_dis",
		-6.5,
		29.1
	}
}
slot0.mazeCheckPointPassedResMap = {
	[0] = {
		"bg_didian_1",
		1,
		30
	},
	{
		"bg_didian_2",
		4.6,
		34.3
	},
	{
		"bg_didian_3",
		1.3,
		32.3
	},
	{
		"bg_didian_4",
		16.7,
		32.1
	},
	{
		"bg_didian_5",
		-6.5,
		29.1
	}
}
slot0.mazeBlockResMap = {
	[0] = {
		"bg_zhangai_1",
		-2.8,
		-7.3,
		"bg_zhangai_1_dis"
	},
	{
		"bg_zhangai_2",
		32.6,
		0,
		"bg_zhangai_2_dis"
	},
	{
		"bg_zhangai_3",
		10,
		-11.3,
		"bg_zhangai_3_dis"
	},
	{
		"bg_zhangai_4",
		2.6,
		2,
		"bg_zhangai_4_dis"
	}
}
slot0.NormalLineResPath = {
	"bg_huaxian_1",
	0,
	0,
	"bg_huaxian_1_dis"
}
slot0.SpecLineResMap = {}
slot0.MazeAlertBlockOffsetY = 48.5
slot0.MazeAlertBlockOffsetX = 90.8
slot0.MazeAlertCrossOffsetY = 33.1
slot0.MazeAlertCrossOffsetX = 25.3
slot0.MazePawnPath = {
	"ui_maze_pawn",
	3.1,
	65.5
}
slot0.MazePawnWidth = 282
slot0.MazePawnHeight = 216
slot0.MazeAlertResPath = "ui_maze_alert"
slot0.AnimEvent_OnJump = "OnJump"

return slot0
