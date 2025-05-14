module("modules.logic.versionactivity2_2.lopera.define.LoperaEnum", package.seeall)

local var_0_0 = _M

var_0_0.EpisodeType = {
	Explore = 3,
	Story = 1,
	ExploreEndless = 4,
	Battle = 2
}
var_0_0.MapCfgIdx = {
	dir = 4,
	start = 6,
	destination = 7,
	storyId = 8,
	event = 5,
	name = 3,
	coord = 2,
	id = 1,
	storyEvent = 9
}
var_0_0.DirEnum = {
	South = 2,
	West = 3,
	East = 4,
	North = 1
}
var_0_0.ResultEnum = {
	Completed = 1,
	PowerUseup = 2,
	Quit = 3
}
var_0_0.EndlessEpisodeId = 1220409
var_0_0.OriStepCostId = 11
var_0_0.PlayedCellStory = "PlayedCellStory"
var_0_0.EpisodeStatus = {
	PlayEndStory = 2,
	Unlock = 0,
	PlayStartStory = 1
}
var_0_0.EffectType = {
	ActionPointChange = 1,
	ActionPointCost = 2
}
var_0_0.ItemType = {
	Product = 1,
	Material = 2
}
var_0_0.resultStatUse = {
	"成功",
	"失败",
	"主动中断",
	"成功"
}
var_0_0.TaskMOAllFinishId = -100

return var_0_0
