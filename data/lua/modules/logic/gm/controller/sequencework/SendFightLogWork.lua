module("modules.logic.gm.controller.sequencework.SendFightLogWork", package.seeall)

local var_0_0 = class("SendFightLogWork", BaseWork)
local var_0_1 = System.IO.Path.Combine

var_0_0.logDirName = "fightLog"
var_0_0.logDirPath = var_0_1(UnityEngine.Application.persistentDataPath, var_0_0.logDirName)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.roundIndex = arg_1_1
	arg_1_0.originRoundData = arg_1_2
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0.logFileName = string.format("章节Id_%s_关卡Id_%s_战斗Id_%s_回合数_%s.txt", arg_2_1 and arg_2_1.chapterId or 0, arg_2_1 and arg_2_1.episodeId or 0, arg_2_1 and arg_2_1.battleId or 0, arg_2_0.roundIndex)

	local var_2_0 = var_0_1(var_0_0.logDirPath, arg_2_0.logFileName)
	local var_2_1 = FightLogProtobufHelper.getFightRoundString(arg_2_0.originRoundData)

	SLFramework.FileHelper.WriteTextToPath(var_2_0, var_2_1)
	logWarn(string.format("写入文件 '%s' 成功, 开始发送文件", arg_2_0.logFileName))
	SendWeWorkFileHelper.SendFile(var_2_0, arg_2_0.onSendFileDone, arg_2_0)
end

function var_0_0.onSendFileDone(arg_3_0, arg_3_1)
	if arg_3_0.status ~= WorkStatus.Running then
		return
	end

	logWarn(string.format("发送文件 '%s' %s", arg_3_0.logFileName, arg_3_1 and "成功" or "失败"))
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
