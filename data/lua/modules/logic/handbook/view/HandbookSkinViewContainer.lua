module("modules.logic.handbook.view.HandbookSkinViewContainer", package.seeall)

local var_0_0 = class("HandbookSkinViewContainer", BaseViewContainer)
local var_0_1 = 0.01

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._scene = HandbookSkinScene.New()

	table.insert(var_1_0, HandbookSkinView.New())
	table.insert(var_1_0, arg_1_0._scene)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	if arg_3_0._scene then
		arg_3_0._scene:playCloseAni()
	end

	TaskDispatcher.runDelay(arg_3_0.closeThis, arg_3_0, var_0_1)
end

function var_0_0.onClickHome(arg_4_0)
	if arg_4_0._scene then
		arg_4_0._scene:playCloseAni()
	end

	TaskDispatcher.runDelay(arg_4_0._doHomeAction, arg_4_0, var_0_1)
end

function var_0_0._doHomeAction(arg_5_0)
	NavigateButtonsView.homeClick()
end

function var_0_0.onContainerClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.closeThis, arg_6_0)
end

function var_0_0.onContainerInit(arg_7_0)
	return
end

function var_0_0.onContainerOpenFinish(arg_8_0)
	arg_8_0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	arg_8_0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

function var_0_0._setVisible(arg_9_0, arg_9_1)
	BaseViewContainer._setVisible(arg_9_0, arg_9_1)

	if arg_9_0._scene then
		arg_9_0._scene.sceneVisible = arg_9_1
	end
end

return var_0_0
