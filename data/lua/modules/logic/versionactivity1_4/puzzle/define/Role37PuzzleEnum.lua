module("modules.logic.versionactivity1_4.puzzle.define.Role37PuzzleEnum", package.seeall)

local var_0_0 = _M

var_0_0.ControlType = {
	Repleace = 4,
	Add = 1,
	Exchange = 3,
	Remove = 2,
	Move = 5
}
var_0_0.OperType = {
	Two = 2,
	Five = 5,
	Seven = 7,
	Three = 3,
	Four = 4,
	One = 1,
	Six = 6
}
var_0_0.AnimalRules = {
	[var_0_0.OperType.Three] = 1,
	[var_0_0.OperType.One] = 2,
	[var_0_0.OperType.Two] = 3
}
var_0_0.AnimalStr = {
	[var_0_0.AnimalRules[3]] = "v1a4_role37_puzzle_animal_wolf",
	[var_0_0.AnimalRules[1]] = "v1a4_role37_puzzle_animal_sheep",
	[var_0_0.AnimalRules[2]] = "v1a4_role37_puzzle_animal_dish"
}
var_0_0.PuzzleId = {
	Final = 801,
	WolfSheepDish = 601,
	SnailMove = 101,
	MonkeyBanana = 401,
	SortByRules7 = 501,
	SortByRules5 = 301
}
var_0_0.PuzzleType = {
	Sort = 2,
	Logic = 1
}

return var_0_0
