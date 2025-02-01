module("modules.logic.versionactivity1_4.puzzle.define.Role37PuzzleEnum", package.seeall)

slot0 = _M
slot0.ControlType = {
	Repleace = 4,
	Add = 1,
	Exchange = 3,
	Remove = 2,
	Move = 5
}
slot0.OperType = {
	Two = 2,
	Five = 5,
	Seven = 7,
	Three = 3,
	Four = 4,
	One = 1,
	Six = 6
}
slot0.AnimalRules = {
	[slot0.OperType.Three] = 1,
	[slot0.OperType.One] = 2,
	[slot0.OperType.Two] = 3
}
slot0.AnimalStr = {
	[slot0.AnimalRules[3]] = "v1a4_role37_puzzle_animal_wolf",
	[slot0.AnimalRules[1]] = "v1a4_role37_puzzle_animal_sheep",
	[slot0.AnimalRules[2]] = "v1a4_role37_puzzle_animal_dish"
}
slot0.PuzzleId = {
	Final = 801,
	WolfSheepDish = 601,
	SnailMove = 101,
	MonkeyBanana = 401,
	SortByRules7 = 501,
	SortByRules5 = 301
}
slot0.PuzzleType = {
	Sort = 2,
	Logic = 1
}

return slot0
