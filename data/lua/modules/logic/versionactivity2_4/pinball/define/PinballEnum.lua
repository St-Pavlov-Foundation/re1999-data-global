module("modules.logic.versionactivity2_4.pinball.define.PinballEnum", package.seeall)

slot0 = _M
slot0.Shape = {
	Rect = 1,
	Circle = 2
}
slot0.Dir = {
	Down = -1,
	Up = 1,
	Right = -2,
	Left = 2,
	None = 0
}
slot0.UnitType = {
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
slot0.UnitLayers = {
	{
		slot0.UnitType.TriggerBlackHole
	},
	{
		slot0.UnitType.ResStone,
		slot0.UnitType.ResFood,
		slot0.UnitType.ResWood,
		slot0.UnitType.ResMine,
		slot0.UnitType.ResSmallFood
	},
	{
		slot0.UnitType.TriggerRefresh
	},
	{
		slot0.UnitType.TriggerObstacle,
		slot0.UnitType.TriggerElasticity,
		slot0.UnitType.TriggerNone
	}
}
slot0.UnitTypeToLayer = {}

for slot4, slot5 in pairs(slot0.UnitLayers) do
	for slot9, slot10 in pairs(slot5) do
		slot0.UnitTypeToLayer[slot10] = slot4
	end
end

slot0.BuildingType = {
	Food = 4,
	Talent = 2,
	MainCity = 1,
	House = 3
}
slot0.ResType = {
	Complaint = 12,
	Play = 11,
	Mine = 2,
	Score = 21,
	Food = 4,
	Stone = 3,
	Wood = 1
}
slot0.OperType = {
	Rest = 2,
	Episode = 1,
	None = 0
}
slot0.BuildingOperType = {
	Remove = 3,
	Upgrade = 2,
	Build = 1
}
slot0.ConditionType = {
	Score = 2,
	Talent = 1
}
slot0.TalentEffectType = {
	MarblesNum = 2,
	UnlockMarbles = 1,
	AddResPer = 4,
	EpisodeCostDec = 5,
	MarblesLevel = 8,
	AutoGainFoodAdd = 7,
	PlayDec = 6,
	MarblesHoleNum = 3
}
slot0.BuildingEffectType = {
	CostFood = 5,
	AddScore = 1,
	AddFood = 2,
	AddPlayDemand = 7,
	AddPlay = 6,
	TriggerBubble = 3,
	UnlockTalent = 4
}
slot0.ConstId = {
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
slot0.UnitTypeToName = {}

for slot4, slot5 in pairs(slot0.UnitType) do
	slot0.UnitTypeToName[slot5] = slot4
end

return slot0
