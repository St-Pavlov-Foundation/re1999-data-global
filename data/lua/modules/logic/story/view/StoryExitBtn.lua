module("modules.logic.story.view.StoryExitBtn", package.seeall)

slot0 = class("StoryExitBtn", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0.frontView = slot3
	slot0.go = slot1
	slot0.callback = slot2
	slot0.btn = gohelper.findButtonWithAudio(slot1)

	slot0:addClickCb(slot0.btn, slot0.onClickExitBtn, slot0)
	gohelper.setActive(slot0.go, false)

	slot0.isActive = false
	slot0.isInVideo = false

	slot0:addEventCb(StoryController.instance, StoryEvent.VideoChange, slot0._onVideoChange, slot0)
end

function slot0.onClickExitBtn(slot0)
	StoryModel.instance:setStoryAuto(false)
	GameFacade.showMessageBox(MessageBoxIdDefine.ExitStoryReplay, MsgBoxEnum.BoxType.Yes_No, slot0.onMessageYes, nil, , slot0)
end

function slot0.onMessageYes(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.Skip, true)
end

function slot0.onClickNext(slot0)
	if StoryModel.instance:isPlayFinished() then
		return
	end

	if not slot0:checkBtnCanShow() then
		return
	end

	slot0:setActive(true)

	if not slot0.isInVideo then
		return
	end

	slot0:_startHideTime()
end

function slot0.refresh(slot0, slot1)
	if StoryModel.instance:isPlayFinished() then
		return
	end

	if slot0:checkBtnCanShow() then
		if not (slot0.frontView and slot0.frontView.btnVisible) and StoryModel.instance:isPlayingVideo() then
			if not slot0.isInVideo then
				slot0:setActive(false)
			end

			slot0.isInVideo = true
		else
			TaskDispatcher.cancelTask(slot0._hideCallback, slot0)

			slot0.isInVideo = false

			slot0:setActive(true)
		end
	else
		TaskDispatcher.cancelTask(slot0._hideCallback, slot0)

		slot0.isInVideo = false

		slot0:setActive(false)
	end
end

function slot0._onVideoChange(slot0)
	slot0:refresh()
end

function slot0._startHideTime(slot0)
	TaskDispatcher.cancelTask(slot0._hideCallback, slot0)
	TaskDispatcher.runDelay(slot0._hideCallback, slot0, 5)
end

function slot0._hideCallback(slot0)
	slot0:setActive(false)
end

function slot0.setActive(slot0, slot1)
	if StoryModel.instance:getHideBtns() then
		gohelper.setActive(slot0.go, false)

		return
	end

	if slot1 == slot0.isActive then
		return
	end

	slot0.isActive = slot1

	gohelper.setActive(slot0.go, slot1)

	if slot0.callback then
		slot0.callback(slot0.frontView)
	end
end

function slot0.checkBtnCanShow(slot0)
	return StoryController.instance:isReplay() and not StoryController.instance:isVersionActivityPV()
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._hideCallback, slot0)
	slot0:__onDispose()
end

return slot0
