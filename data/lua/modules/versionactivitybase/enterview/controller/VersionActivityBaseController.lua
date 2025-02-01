module("modules.versionactivitybase.enterview.controller.VersionActivityBaseController", package.seeall)

slot0 = class("VersionActivityBaseController", BaseController)

function slot0.isPlayedActivityVideo(slot0, slot1)
	if not ActivityConfig.instance:getActivityCo(slot1) then
		return true
	end

	if string.nilorempty(slot2.storyId) or slot2.storyId == 0 then
		return true
	end

	return StoryModel.instance:isStoryFinished(slot2.storyId)
end

function slot0._initPlayedActUnlockAnimationList(slot0)
	if string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))) then
		slot0.playedActUnlockAnimationList = {}

		return
	end

	slot0.playedActUnlockAnimationList = string.splitToNumber(slot1, "#")
end

function slot0.playedActivityUnlockAnimation(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0.playedActUnlockAnimationList then
		slot0:_initPlayedActUnlockAnimationList()
	end

	if tabletool.indexOf(slot0.playedActUnlockAnimationList, slot1) then
		return
	end

	table.insert(slot0.playedActUnlockAnimationList, slot1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey), table.concat(slot0.playedActUnlockAnimationList, "#"))
end

function slot0.isPlayedUnlockAnimation(slot0, slot1)
	if not slot0.playedActUnlockAnimationList then
		slot0:_initPlayedActUnlockAnimationList()
	end

	return tabletool.indexOf(slot0.playedActUnlockAnimationList, slot1)
end

function slot0.clear(slot0)
	slot0.playedActUnlockAnimationList = nil
	slot0.playedVideosActivityIdList = nil
end

function slot0.enterVersionActivityView(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7 = ActivityHelper.getActivityStatusAndToast(slot2)

	if slot5 ~= ActivityEnum.ActivityStatus.Normal then
		if slot6 then
			GameFacade.showToast(slot6, slot7)
		end

		return
	end

	if slot3 then
		slot3(slot4, slot1, slot2)

		return
	end

	ViewMgr.instance:openView(slot1)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
