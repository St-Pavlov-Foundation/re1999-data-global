module("modules.logic.versionactivity2_4.dungeon.controller.VersionActivity2_4SudokuController", package.seeall)

local var_0_0 = class("VersionActivity2_4SudokuController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openSudokuView(arg_3_0)
	VersionActivity2_4SudokuModel.instance:selectItem(nil)
	VersionActivity2_4SudokuModel.instance:selectKeyboardItem(nil)
	VersionActivity2_4SudokuModel.instance:clearCmd()
	ViewMgr.instance:openView(ViewName.VersionActivity2_4SudokuView)
	arg_3_0:initStatData()
end

function var_0_0.excuteNewCmd(arg_4_0, arg_4_1)
	VersionActivity2_4SudokuModel.instance:pushCmd(arg_4_1)
	arg_4_0:dispatchEvent(VersionActivity2_4DungeonEvent.DoSudokuCmd, arg_4_1)
end

function var_0_0.excuteLastCmd(arg_5_0)
	local var_5_0 = VersionActivity2_4SudokuModel.instance:popCmd()

	if var_5_0 then
		var_5_0:undo()
		arg_5_0:dispatchEvent(VersionActivity2_4DungeonEvent.DoSudokuCmd, var_5_0)
		arg_5_0:addUndoCount()
	else
		arg_5_0:resetGame()
	end
end

function var_0_0.resetGame(arg_6_0)
	VersionActivity2_4SudokuModel.instance:selectItem(nil)
	VersionActivity2_4SudokuModel.instance:selectKeyboardItem(nil)
	arg_6_0:dispatchEvent(VersionActivity2_4DungeonEvent.SudokuReset)
	arg_6_0:setStatResult("reset")
	arg_6_0:sendStat()
	arg_6_0:initStatData()
end

function var_0_0.initStatData(arg_7_0)
	arg_7_0._statMo = VersionActivity2_4SudokuMo.New()
end

function var_0_0.setStatResult(arg_8_0, arg_8_1)
	arg_8_0._statMo:setResult(arg_8_1)
end

function var_0_0.addUndoCount(arg_9_0)
	arg_9_0._statMo:addUndoCount()
end

function var_0_0.addErrorCount(arg_10_0)
	arg_10_0._statMo:addErrorCount()
end

function var_0_0.sendStat(arg_11_0)
	arg_11_0._statMo:sendStatData()
end

var_0_0.instance = var_0_0.New()

return var_0_0
