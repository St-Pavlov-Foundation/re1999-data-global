module("modules.logic.story.view.StoryExitBtn", package.seeall)

local var_0_0 = class("StoryExitBtn", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0.frontView = arg_1_3
	arg_1_0.go = arg_1_1
	arg_1_0.callback = arg_1_2
	arg_1_0.btn = gohelper.findButtonWithAudio(arg_1_1)

	arg_1_0:addClickCb(arg_1_0.btn, arg_1_0.onClickExitBtn, arg_1_0)
	gohelper.setActive(arg_1_0.go, false)

	arg_1_0.isActive = false
	arg_1_0.isInVideo = false

	arg_1_0:addEventCb(StoryController.instance, StoryEvent.VideoChange, arg_1_0._onVideoChange, arg_1_0)
end

function var_0_0.onClickExitBtn(arg_2_0)
	StoryModel.instance:setStoryAuto(false)
	GameFacade.showMessageBox(MessageBoxIdDefine.ExitStoryReplay, MsgBoxEnum.BoxType.Yes_No, arg_2_0.onMessageYes, nil, nil, arg_2_0)
end

function var_0_0.onMessageYes(arg_3_0)
	StoryController.instance:dispatchEvent(StoryEvent.Skip, true)
end

function var_0_0.onClickNext(arg_4_0)
	if StoryModel.instance:isPlayFinished() then
		return
	end

	if not arg_4_0:checkBtnCanShow() then
		return
	end

	arg_4_0:setActive(true)

	if not arg_4_0.isInVideo then
		return
	end

	arg_4_0:_startHideTime()
end

function var_0_0.refresh(arg_5_0, arg_5_1)
	if StoryModel.instance:isPlayFinished() then
		return
	end

	local var_5_0 = arg_5_0.frontView and arg_5_0.frontView.btnVisible

	if arg_5_0:checkBtnCanShow() then
		local var_5_1 = StoryModel.instance:isPlayingVideo()

		if not var_5_0 and var_5_1 then
			if not arg_5_0.isInVideo then
				arg_5_0:setActive(false)
			end

			arg_5_0.isInVideo = true
		else
			TaskDispatcher.cancelTask(arg_5_0._hideCallback, arg_5_0)

			arg_5_0.isInVideo = false

			arg_5_0:setActive(true)
		end
	else
		TaskDispatcher.cancelTask(arg_5_0._hideCallback, arg_5_0)

		arg_5_0.isInVideo = false

		arg_5_0:setActive(false)
	end
end

function var_0_0._onVideoChange(arg_6_0)
	arg_6_0:refresh()
end

function var_0_0._startHideTime(arg_7_0)
	local var_7_0 = 5

	TaskDispatcher.cancelTask(arg_7_0._hideCallback, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._hideCallback, arg_7_0, var_7_0)
end

function var_0_0._hideCallback(arg_8_0)
	arg_8_0:setActive(false)
end

function var_0_0.setActive(arg_9_0, arg_9_1)
	if StoryModel.instance:getHideBtns() then
		gohelper.setActive(arg_9_0.go, false)

		return
	end

	if arg_9_1 == arg_9_0.isActive then
		return
	end

	arg_9_0.isActive = arg_9_1

	gohelper.setActive(arg_9_0.go, arg_9_1)

	if arg_9_0.callback then
		arg_9_0.callback(arg_9_0.frontView)
	end
end

function var_0_0.checkBtnCanShow(arg_10_0)
	local var_10_0 = StoryController.instance:isReplay()
	local var_10_1 = StoryController.instance:isVersionActivityPV()

	return var_10_0 and not var_10_1
end

function var_0_0.destroy(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._hideCallback, arg_11_0)
	arg_11_0:__onDispose()
end

return var_0_0
