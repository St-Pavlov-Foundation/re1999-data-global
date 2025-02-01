module("modules.logic.versionactivity2_2.lopera.define.LoperaEnum", package.seeall)

slot0 = _M
slot0.EpisodeType = {
	Explore = 3,
	Story = 1,
	ExploreEndless = 4,
	Battle = 2
}
slot0.MapCfgIdx = {
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
slot0.DirEnum = {
	South = 2,
	West = 3,
	East = 4,
	North = 1
}
slot0.ResultEnum = {
	Completed = 1,
	PowerUseup = 2,
	Quit = 3
}
slot0.EndlessEpisodeId = 1220409
slot0.OriStepCostId = 11
slot0.PlayedCellStory = "PlayedCellStory"
slot0.EpisodeStatus = {
	PlayEndStory = 2,
	Unlock = 0,
	PlayStartStory = 1
}
slot0.EffectType = {
	ActionPointChange = 1,
	ActionPointCost = 2
}
slot0.ItemType = {
	Product = 1,
	Material = 2
}
slot0.resultStatUse = {
	"成功",
	"失败",
	"主动中断",
	"成功"
}
slot0.TaskMOAllFinishId = -100

return slot0
