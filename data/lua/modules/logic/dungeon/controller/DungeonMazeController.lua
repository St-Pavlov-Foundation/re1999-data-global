module("modules.logic.dungeon.controller.DungeonMazeController", package.seeall)

local var_0_0 = class("DungeonMazeController", BaseController)

function var_0_0.onInitFinish(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.release(arg_4_0)
	return
end

function var_0_0.MoveTo(arg_5_0, arg_5_1)
	local var_5_0 = DungeonMazeModel.instance:getCurCellData().connectSet[arg_5_1]
	local var_5_1 = false

	if var_5_0 then
		DungeonMazeModel.instance:setCurCellData(var_5_0)
		DungeonMazeModel.instance:addChaosValue()

		local var_5_2 = DungeonMazeModel.instance:getChaosValue()
		local var_5_3 = {
			episodeId = arg_5_0._mazeEpisodeId
		}

		if var_5_0.value == 2 then
			arg_5_0:sandStatData(DungeonMazeEnum.resultStat[1], var_5_0.cellId, var_5_2)

			local var_5_4 = DungeonConfig.instance:getEpisodeCO(arg_5_0._mazeEpisodeId)
			local var_5_5 = tonumber(var_5_4.story)

			if var_5_5 ~= 0 then
				arg_5_0:playMazeAfterStory(var_5_5)

				return
			else
				DungeonRpc.instance:sendEndDungeonRequest(false)

				var_5_3.isWin = true

				arg_5_0:openMazeResultView(var_5_3)

				var_5_1 = true
			end
		elseif var_5_2 == DungeonMazeEnum.MaxChaosValue then
			arg_5_0:sandStatData(DungeonMazeEnum.resultStat[2], var_5_0.cellId, var_5_2)

			var_5_3.isWin = false

			arg_5_0:openMazeResultView(var_5_3)

			var_5_1 = true
		end
	end

	DungeonMazeModel.instance:UnpateSkillState(true)

	if not var_5_1 then
		DungeonMazeModel.instance:SaveCurProgress()
	end
end

function var_0_0.playMazeAfterStory(arg_6_0, arg_6_1)
	local var_6_0 = {}

	var_6_0.mark = true

	local var_6_1 = {
		episodeId = arg_6_0._mazeEpisodeId
	}

	var_6_1.isWin = true

	StoryController.instance:playStory(arg_6_1, var_6_0, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		DungeonRpc.instance:sendEndDungeonRequest(false)
		var_0_0.instance:openMazeResultView(var_6_1)
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
	end)
end

function var_0_0.UseEyeSkill(arg_8_0)
	local var_8_0 = DungeonMazeModel.instance:GetSkillState()

	if var_8_0 == DungeonMazeEnum.skillState.using then
		return
	end

	if var_8_0 == DungeonMazeEnum.skillState.cooling then
		return
	end

	DungeonMazeModel.instance:UnpateSkillState()
end

function var_0_0.openMazeGameView(arg_9_0, arg_9_1)
	arg_9_0:initStatData()

	arg_9_0._mazeEpisodeId = arg_9_1.episodeCfg.id

	DungeonMazeModel.instance:initData()
	DungeonMazeModel.instance:LoadProgress()
	ViewMgr.instance:openView(ViewName.DungeonMazeView, arg_9_1)
end

function var_0_0.openMazeResultView(arg_10_0, arg_10_1)
	DungeonMazeModel.instance:ClearProgress()
	ViewMgr.instance:openView(ViewName.DungeonMazeResultView, arg_10_1)
end

function var_0_0.initStatData(arg_11_0)
	arg_11_0.statMo = DungeonGameMo.New()
end

function var_0_0.sandStatData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.statMo:sendMazeGameStatData(arg_12_1, arg_12_2, arg_12_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
