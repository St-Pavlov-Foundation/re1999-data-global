module("modules.logic.permanent.controller.PermanentController", package.seeall)

slot0 = class("PermanentController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterActivity(slot0, slot1)
	if PlayerPrefsHelper.getNumber("PermanentStoryRecord" .. ActivityConfig.instance:getActivityCo(slot1).storyId .. PlayerModel.instance:getMyUserId(), 0) == 0 then
		StoryController.instance:playStory(slot3.storyId, nil, slot0.storyCallback, slot0, {
			_actId = slot1
		})
		PlayerPrefsHelper.setNumber(slot4, 1)
	else
		slot0:storyCallback({
			_actId = slot1
		})
	end
end

function slot0.storyCallback(slot0, slot1)
	if PermanentConfig.instance:getPermanentCO(slot1._actId) then
		ViewMgr.instance:openView(ViewName[slot3.enterview])
	end
end

function slot0.jump2Activity(slot0, slot1)
	if PermanentConfig.instance:getPermanentCO(slot1) then
		DungeonController.instance:openDungeonView()
		ViewMgr.instance:openView(ViewName[slot2.enterview])
	end
end

function slot0.unlockPermanent(slot0, slot1)
	ActivityRpc.instance:sendUnlockPermanentRequest(slot1)
end

slot0.instance = slot0.New()

return slot0
