module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairView", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryRepairView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#txt_Tips")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, arg_2_0._onGameClear, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, arg_2_0._onResetGame, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, arg_3_0._onGameClear, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, arg_3_0._onResetGame, arg_3_0)
end

function var_0_0._onGameClear(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(arg_4_0._gofinish, true)
	Activity157Rpc.instance:sendAct157UnlockComponentRequest(arg_4_0.actId, arg_4_0.curComponentId)
end

function var_0_0._onResetGame(arg_5_0)
	gohelper.setActive(arg_5_0._gofinish, false)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = Activity157Model.instance:getActId()
	arg_6_0.curComponentId = Activity157RepairGameModel.instance:getCurComponentId()

	gohelper.setActive(arg_6_0._gofinish, false)
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = Activity157Config.instance:getAct157RepairMapTitleTip(arg_7_0.actId, arg_7_0.curComponentId)

	arg_7_0._txtTips.text = var_7_0
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
