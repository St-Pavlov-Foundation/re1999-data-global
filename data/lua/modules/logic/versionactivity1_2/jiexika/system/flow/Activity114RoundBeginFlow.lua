module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114RoundBeginFlow", package.seeall)

local var_0_0 = class("Activity114RoundBeginFlow", FlowSequence)

function var_0_0.beginFlow(arg_1_0)
	local var_1_0 = {
		day = Activity114Model.instance.serverData.day,
		round = Activity114Model.instance.serverData.round
	}
	local var_1_1 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, var_1_0.day, var_1_0.round)

	if not var_1_1 then
		logError("没有回合配置：" .. arg_1_0.context.day .. "#" .. arg_1_0.context.round)

		return
	end

	if string.nilorempty(var_1_1.preStoryId) then
		return
	end

	if Activity114Model.instance.serverData.week ~= 1 then
		return
	end

	if GuideController.instance:isForbidGuides() then
		logError("当前设置禁用引导，无法播放引导，请在GM中开启引导然后重新打开界面！！！")

		return
	end

	local var_1_2 = string.splitToNumber(var_1_1.preStoryId, "#")

	if #var_1_2 == 1 then
		var_1_2[2] = var_1_2[1]
		var_1_2[1] = Activity114Enum.PlayStartRoundType.Story
	end

	if var_1_2[1] == Activity114Enum.PlayStartRoundType.Story then
		arg_1_0:addWork(Activity114StoryWork.New(var_1_2[2], Activity114Enum.StoryType.RoundStart))
	elseif var_1_2[1] == Activity114Enum.PlayStartRoundType.Guide then
		arg_1_0:addWork(Activity114GuideWork.New(var_1_2[2]))
	else
		logError("回合开始配置错误" .. var_1_1.preStoryId)

		return
	end

	arg_1_0:addWork(Activity114SendRoundBeginReqWork.New())
	arg_1_0:addWork(Activity114ChangeEventWork.New())
	arg_1_0:start(var_1_0)

	return true
end

return var_0_0
