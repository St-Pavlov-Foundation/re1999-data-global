module("modules.logic.guide.controller.trigger.GuideTriggerMainSceneSkin", package.seeall)

slot0 = class("GuideTriggerMainSceneSkin", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onViewChange, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onViewChange, slot0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, slot0._onMainScene, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot0:_isHasSkinItem() and slot0:_checkInMain()
end

function slot0._isHasSkinItem(slot0)
	for slot5, slot6 in ipairs(MainSceneSwitchConfig.instance:getItemLockList()) do
		if ItemModel.instance:getItemCount(slot6) > 0 then
			return true
		end
	end
end

function slot0._onMainScene(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0:checkStartGuide()
	end
end

function slot0._onViewChange(slot0)
	slot0:checkStartGuide()
end

function slot0._checkInMain(slot0)
	slot1 = ViewName.MainView

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main and not GameSceneMgr.instance:isLoading() and not GameSceneMgr.instance:isClosing() then
		slot5 = false

		for slot10, slot11 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
			if slot11 ~= slot1 and (ViewMgr.instance:isModal(slot11) or ViewMgr.instance:isFull(slot11)) then
				slot5 = true

				break
			end
		end

		if not slot5 and (string.nilorempty(slot1) or ViewMgr.instance:isOpen(slot1)) then
			return true
		end
	end
end

function slot0._checkStartGuide(slot0)
	slot0:checkStartGuide()
end

return slot0
