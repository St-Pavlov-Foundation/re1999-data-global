module("modules.logic.versionactivity2_5.challenge.define.Act183Event", package.seeall)

slot1 = 1

function slot2(slot0)
	assert(uv0[slot0] == nil, "[Act183Event] error redefined Act183Event." .. slot0)

	uv0[slot0] = uv1
	uv1 = uv1 + 1
end

slot2("OnClickEpisode")
slot2("OnUpdateGroupInfo")
slot2("OnUpdateRepressInfo")
slot2("OnUpdateBadgeNum")
slot2("OnClickSwitchGroup")
slot2("OnCreateHeroItemDone")
slot2("RefreshMedalReddot")
slot2("OnInitDungeonDone")
slot2("ClickToGetReward")
slot2("OnGroupAllTaskFinished")

return _M
