module("modules.logic.versionactivity2_5.challenge.view.Act183MainBossEpisodeItem", package.seeall)

slot0 = class("Act183MainBossEpisodeItem", Act183BaseEpisodeItem)
slot1 = {
	2.9,
	-3.3,
	0,
	0,
	0
}

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._animunlock = gohelper.onceAddComponent(slot0._gounlock, gohelper.Type_Animator)

	slot0:addEventCb(Act183Controller.instance, Act183Event.OnInitDungeonDone, slot0._onInitDungeonDone, slot0)
end

function slot0._onInitDungeonDone(slot0)
	slot0:_checkPlayNewUnlockAnim()
end

function slot0._checkPlayNewUnlockAnim(slot0)
	if slot0._status ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	if Act183Model.instance:isEpisodeNewUnlock(slot0._episodeId) then
		slot0._animunlock:Play("unlock", 0, 0)
	end
end

function slot0._getCheckIconPosAndRotConfig(slot0, slot1)
	return uv0
end

return slot0
