module("modules.logic.versionactivity2_7.lengzhou6.define.EliminateEnum_2_7", package.seeall)

local var_0_0 = class("EliminateEnum_2_7", EliminateEnum)

var_0_0.MaxBuffCount = 50
var_0_0.ChessType = {
	beast = "beast",
	cliff = "cliff",
	stone = "stone",
	tree = "tree",
	star = "star"
}
var_0_0.ChessIndexToType = {
	nil,
	nil,
	nil,
	nil,
	nil,
	"beast",
	"tree",
	"cliff",
	[9] = "star",
	[10] = "stone"
}
var_0_0.ChessTypeToIndex = {
	beast = 6,
	cliff = 8,
	stone = 10,
	tree = 7,
	star = 9
}
var_0_0.eliminateType = {
	five = "five",
	three = "three",
	base = "base",
	four = "four",
	cross = "cross"
}
var_0_0.AllChessType = {
	"beast",
	"tree",
	"cliff",
	"star"
}
var_0_0.AllChessID = {
	6,
	7,
	8,
	9
}
var_0_0.ChessWidth = 120
var_0_0.ChessHeight = 122
var_0_0.ChessIntervalX = 2
var_0_0.ChessIntervalY = 2
var_0_0.MaxRow = 6
var_0_0.MaxCol = 6
var_0_0.AssessShowTime = LengZhou6Config.instance:getEliminateBattleCost(26) / 1000
var_0_0.UpdateDamageStepTime = 1
var_0_0.DieStepTime = 0.3
var_0_0.AssessLevel = {
	3,
	5,
	7,
	10
}
var_0_0.AssessLevelToImageName = {
	"v2a7_hissabeth_game_paneltips3",
	"v2a7_hissabeth_game_paneltips4",
	"v2a7_hissabeth_game_paneltips5",
	"v2a7_hissabeth_game_paneltips6"
}
var_0_0.SpecialChessImage = {
	frost = LengZhou6Config.instance:getEliminateBattleCostStr(23),
	pollution = LengZhou6Config.instance:getEliminateBattleCostStr(22),
	beast = LengZhou6Config.instance:getEliminateBattleCostStr(18),
	tree = LengZhou6Config.instance:getEliminateBattleCostStr(19),
	cliff = LengZhou6Config.instance:getEliminateBattleCostStr(21),
	star = LengZhou6Config.instance:getEliminateBattleCostStr(20)
}
var_0_0.ChessEffect = {
	frost = "frost",
	pollution = "pollution"
}
var_0_0.SpecialChessAni = {
	frost = "freeze",
	pollution = "glitch"
}
var_0_0.InitDropTime = 0.1

return var_0_0
