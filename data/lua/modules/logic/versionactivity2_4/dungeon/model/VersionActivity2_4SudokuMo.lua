module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4SudokuMo", package.seeall)

local var_0_0 = pureTable("VersionActivity2_4SudokuMo")
local var_0_1 = {
	["break"] = "中断",
	done = "成功",
	reset = "重新开始"
}

function var_0_0.ctor(arg_1_0)
	arg_1_0.beginTime = Time.realtimeSinceStartup
	arg_1_0.undoNum = 0
	arg_1_0.erroNum = 0
end

function var_0_0.setResult(arg_2_0, arg_2_1)
	arg_2_0.result = arg_2_1
end

function var_0_0.addUndoCount(arg_3_0)
	arg_3_0.undoNum = arg_3_0.undoNum + 1
end

function var_0_0.addErrorCount(arg_4_0)
	arg_4_0.erroNum = arg_4_0.erroNum + 1
end

function var_0_0.sendStatData(arg_5_0)
	StatController.instance:track(StatEnum.EventName.SudokuResult, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - arg_5_0.beginTime,
		[StatEnum.EventProperties.Result] = var_0_1[arg_5_0.result],
		[StatEnum.EventProperties.SudokuBackNum] = arg_5_0.undoNum,
		[StatEnum.EventProperties.SudokuErrorNum] = arg_5_0.erroNum
	})
end

return var_0_0
