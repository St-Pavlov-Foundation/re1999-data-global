module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114RoundBeginFlow", package.seeall)

slot0 = class("Activity114RoundBeginFlow", FlowSequence)

function slot0.beginFlow(slot0)
	slot1 = {
		day = Activity114Model.instance.serverData.day,
		round = Activity114Model.instance.serverData.round
	}

	if not Activity114Config.instance:getRoundCo(Activity114Model.instance.id, slot1.day, slot1.round) then
		logError("没有回合配置：" .. slot0.context.day .. "#" .. slot0.context.round)

		return
	end

	if string.nilorempty(slot2.preStoryId) then
		return
	end

	if Activity114Model.instance.serverData.week ~= 1 then
		return
	end

	if GuideController.instance:isForbidGuides() then
		logError("当前设置禁用引导，无法播放引导，请在GM中开启引导然后重新打开界面！！！")

		return
	end

	if #string.splitToNumber(slot2.preStoryId, "#") == 1 then
		slot3[2] = slot3[1]
		slot3[1] = Activity114Enum.PlayStartRoundType.Story
	end

	if slot3[1] == Activity114Enum.PlayStartRoundType.Story then
		slot0:addWork(Activity114StoryWork.New(slot3[2], Activity114Enum.StoryType.RoundStart))
	elseif slot3[1] == Activity114Enum.PlayStartRoundType.Guide then
		slot0:addWork(Activity114GuideWork.New(slot3[2]))
	else
		logError("回合开始配置错误" .. slot2.preStoryId)

		return
	end

	slot0:addWork(Activity114SendRoundBeginReqWork.New())
	slot0:addWork(Activity114ChangeEventWork.New())
	slot0:start(slot1)

	return true
end

return slot0
