module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleModel", package.seeall)

local var_0_0 = class("GaoSiNiaoBattleModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	GaoSiNiaoBattleMapMO.default_ctor(arg_1_0, "_mapMO")

	arg_1_0._trackMO = GaoSiNiaoBattleTrackMO.New()

	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._episodeId = 0
	arg_2_0._isServerCompleted = false

	if arg_2_0._dragContext then
		arg_2_0._dragContext:clear()
	else
		arg_2_0._dragContext = GaoSiNiaoMapDragContext.New()
	end
end

function var_0_0.restart(arg_3_0, arg_3_1)
	arg_3_0:setServerCompleted(false)

	arg_3_0._episodeId = arg_3_1

	arg_3_0._dragContext:clear()
	arg_3_0._mapMO:createMapByEpisodeId(arg_3_1)
end

function var_0_0.episodeId(arg_4_0)
	return arg_4_0._episodeId
end

function var_0_0.mapMO(arg_5_0)
	return arg_5_0._mapMO
end

function var_0_0.dragContext(arg_6_0)
	return arg_6_0._dragContext
end

function var_0_0.trackMO(arg_7_0)
	return arg_7_0._trackMO
end

function var_0_0._onReceiveAct210FinishEpisodeReply(arg_8_0, arg_8_1)
	if arg_8_1.episodeId ~= arg_8_0._episodeId then
		return
	end

	arg_8_0:setServerCompleted(true)
end

function var_0_0.isServerCompleted(arg_9_0)
	return arg_9_0._isServerCompleted
end

function var_0_0.setServerCompleted(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._isServerCompleted = arg_10_1
	arg_10_0._episodeId = arg_10_2 or arg_10_0._episodeId
end

function var_0_0.saveProgressAsStr(arg_11_0)
	return ""
end

function var_0_0.loadProgressInfoInByStr(arg_12_0, arg_12_1)
	return
end

function var_0_0._onReceiveAct210SaveEpisodeProgressReply(arg_13_0, arg_13_1)
	return
end

function var_0_0.track_act210_operation(arg_14_0, arg_14_1)
	arg_14_0._trackMO:track_act210_operation(arg_14_0:mapMO(), arg_14_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
