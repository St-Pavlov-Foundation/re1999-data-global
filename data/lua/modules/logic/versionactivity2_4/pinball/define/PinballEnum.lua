module("modules.logic.versionactivity2_4.pinball.define.PinballEnum", package.seeall)

local var_0_0 = _M

var_0_0.Shape = {
	Rect = 1,
	Circle = 2
}
var_0_0.Dir = {
	Down = -1,
	Up = 1,
	Right = -2,
	Left = 2,
	None = 0
}
var_0_0.UnitType = {
	MarblesElasticity = 5,
	MarblesDivision = 2,
	TriggerBlackHole = 101,
	MarblesGlass = 3,
	MarblesNormal = 1,
	TriggerElasticity = 104,
	TriggerRefresh = 102,
	ResStone = 201,
	ResFood = 202,
	ResWood = 203,
	MarblesExplosion = 4,
	ResSmallFood = 301,
	ResMine = 204,
	TriggerObstacle = 103,
	TriggerNone = 105,
	CommonEffect = 302
}
var_0_0.UnitLayers = {
	{
		var_0_0.UnitType.TriggerBlackHole
	},
	{
		var_0_0.UnitType.ResStone,
		var_0_0.UnitType.ResFood,
		var_0_0.UnitType.ResWood,
		var_0_0.UnitType.ResMine,
		var_0_0.UnitType.ResSmallFood
	},
	{
		var_0_0.UnitType.TriggerRefresh
	},
	{
		var_0_0.UnitType.TriggerObstacle,
		var_0_0.UnitType.TriggerElasticity,
		var_0_0.UnitType.TriggerNone
	}
}
var_0_0.UnitTypeToLayer = {}

for iter_0_0, iter_0_1 in pairs(var_0_0.UnitLayers) do
	for iter_0_2, iter_0_3 in pairs(iter_0_1) do
		var_0_0.UnitTypeToLayer[iter_0_3] = iter_0_0
	end
end

var_0_0.BuildingType = {
	Food = 4,
	Talent = 2,
	MainCity = 1,
	House = 3
}
var_0_0.ResType = {
	Complaint = 12,
	Play = 11,
	Mine = 2,
	Score = 21,
	Food = 4,
	Stone = 3,
	Wood = 1
}
var_0_0.OperType = {
	Rest = 2,
	Episode = 1,
	None = 0
}
var_0_0.BuildingOperType = {
	Remove = 3,
	Upgrade = 2,
	Build = 1
}
var_0_0.ConditionType = {
	Score = 2,
	Talent = 1
}
var_0_0.TalentEffectType = {
	MarblesNum = 2,
	UnlockMarbles = 1,
	AddResPer = 4,
	EpisodeCostDec = 5,
	MarblesLevel = 8,
	AutoGainFoodAdd = 7,
	PlayDec = 6,
	MarblesHoleNum = 3
}
var_0_0.BuildingEffectType = {
	CostFood = 5,
	AddScore = 1,
	AddFood = 2,
	AddPlayDemand = 7,
	AddPlay = 6,
	TriggerBubble = 3,
	UnlockTalent = 4
}
var_0_0.ConstId = {
	NoPlayAddComplaint = 9,
	PlayEnoughSubComplaint = 12,
	ComplaintLimit = 5,
	ResetDay = 17,
	ComplaintThresholdSubHoleNum = 20,
	ComplaintMaxSubHoleNum = 21,
	ComplaintThresholdAddCost = 10,
	DefaultMarblesNum = 3,
	FoodEnoughSubComplaint = 11,
	DefaultMarblesHoleNum = 4,
	NoFoodAddComplaint = 8,
	RestSubComplaint = 7,
	EpisodeCost = 13,
	ComplaintThreshold = 6
}
var_0_0.UnitTypeToName = {}

for iter_0_4, iter_0_5 in pairs(var_0_0.UnitType) do
	var_0_0.UnitTypeToName[iter_0_5] = iter_0_4
end

return var_0_0
