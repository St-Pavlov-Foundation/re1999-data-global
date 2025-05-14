module("modules.logic.versionactivity2_5.autochess.view.AutoChessStartFightView", package.seeall)

local var_0_0 = class("AutoChessStartFightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._onEscapeBtnClick(arg_2_0)
	return
end

function var_0_0._editableInitView(arg_3_0)
	NavigateMgr.instance:addEscape(ViewName.AutoChessStartFightView, arg_3_0._onEscapeBtnClick, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = AudioMgr.instance:getIdFromString("autochess")
	local var_4_1 = AudioMgr.instance:getIdFromString("battle")

	AudioMgr.instance:setSwitch(var_4_0, var_4_1)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_battle_enter)
	TaskDispatcher.runDelay(arg_4_0.closeThis, arg_4_0, 1.5)
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.closeThis, arg_5_0)
end

return var_0_0
