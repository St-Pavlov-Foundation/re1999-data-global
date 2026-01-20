-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapNodeIconHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapNodeIconHelper", package.seeall)

local Rouge2_MapNodeIconHelper = class("Rouge2_MapNodeIconHelper")

function Rouge2_MapNodeIconHelper.active()
	return
end

function Rouge2_MapNodeIconHelper.createMultiParamKey(...)
	local list = {
		...
	}

	return table.concat(list, "#")
end

local getKey = Rouge2_MapNodeIconHelper.createMultiParamKey

Rouge2_MapEnum.NodeIconBottomBg = {
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_4",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_4",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_4",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_4",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_chessbg_3",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_chessbg_4",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_chessbg_2",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_chessbg_2"
}
Rouge2_MapEnum.NodeIconBubbleBg = {
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_5",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_5",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_5",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_5",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_5",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_5",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_5",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_5",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_1",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_2",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_map_nodebg_3",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_map_nodebg_4",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_map_nodebg_5",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_map_nodebg_5"
}
Rouge2_MapEnum.NodeIcon = {
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_16_2",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_16_2",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_16_1",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_16_1",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_16_2",
	[getKey(Rouge2_MapEnum.EventType.NormalFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_16_2",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_2_2",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_2_2",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_2_1",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_2_1",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_2_2",
	[getKey(Rouge2_MapEnum.EventType.EliteFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_2_2",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_3_2",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_3_2",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_3_1",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_3_1",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_3_2",
	[getKey(Rouge2_MapEnum.EventType.BossFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_3_2",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_4_2",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_4_2",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_4_1",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_4_1",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_4_2",
	[getKey(Rouge2_MapEnum.EventType.HighHardFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_4_2",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_5_2",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_5_2",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_5_1",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_5_1",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_5_2",
	[getKey(Rouge2_MapEnum.EventType.Reward, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_5_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_6_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_6_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_6_1",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_6_1",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_6_2",
	[getKey(Rouge2_MapEnum.EventType.Rest, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_6_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_7_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_7_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_7_1",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_7_1",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_7_2",
	[getKey(Rouge2_MapEnum.EventType.Store, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_7_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_8_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_8_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_8_1",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_8_1",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_8_2",
	[getKey(Rouge2_MapEnum.EventType.Strengthen, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_8_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_9_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_9_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_15_1",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_15_1",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_9_2",
	[getKey(Rouge2_MapEnum.EventType.StoryChoice, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_9_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_10_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_10_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_10_1",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_10_1",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_10_2",
	[getKey(Rouge2_MapEnum.EventType.ExploreChoice, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_10_2",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.CantArrive)] = "rouge2_event_icon_1_2",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.NotArrive)] = "rouge2_event_icon_1_2",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.CanArrive)] = "rouge2_event_icon_1_1",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.ArrivingNotFinish)] = "rouge2_event_icon_1_1",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.ArrivingFinish)] = "rouge2_event_icon_1_2",
	[getKey(Rouge2_MapEnum.EventType.EasyFight, Rouge2_MapEnum.Arrive.Arrived)] = "rouge2_event_icon_1_2"
}

function Rouge2_MapNodeIconHelper.getNodeIconBottomBg(eventType, arriveStatus)
	local key = Rouge2_MapNodeIconHelper.createMultiParamKey(eventType, arriveStatus)

	return key and Rouge2_MapEnum.NodeIconBottomBg[key]
end

function Rouge2_MapNodeIconHelper.getNodeIconBubbleBg(eventType, arriveStatus)
	local key = Rouge2_MapNodeIconHelper.createMultiParamKey(eventType, arriveStatus)

	return key and Rouge2_MapEnum.NodeIconBubbleBg[key]
end

function Rouge2_MapNodeIconHelper.getNodeIcon(eventType, arriveStatus)
	local key = Rouge2_MapNodeIconHelper.createMultiParamKey(eventType, arriveStatus)

	return key and Rouge2_MapEnum.NodeIcon[key]
end

return Rouge2_MapNodeIconHelper
