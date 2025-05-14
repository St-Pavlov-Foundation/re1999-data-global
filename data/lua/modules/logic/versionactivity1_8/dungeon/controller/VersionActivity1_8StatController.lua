module("modules.logic.versionactivity1_8.dungeon.controller.VersionActivity1_8StatController", package.seeall)

local var_0_0 = class("VersionActivity1_8StatController")

function var_0_0.startStat(arg_1_0)
	arg_1_0.startTime = ServerTime.now()
end

function var_0_0.statSuccess(arg_2_0)
	arg_2_0:_statEnd(StatEnum.Result.Success)
end

function var_0_0.statAbort(arg_3_0)
	arg_3_0:_statEnd(StatEnum.Result.Abort)
end

function var_0_0.statReset(arg_4_0)
	arg_4_0:_statEnd(StatEnum.Result.Reset)
	arg_4_0:startStat()
end

function var_0_0._statEnd(arg_5_0, arg_5_1)
	if not arg_5_0.startTime then
		return
	end

	StatController.instance:track(StatEnum.EventName.FactoryConnectionGame, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_5_0.startTime,
		[StatEnum.EventProperties.PartsId] = tostring(Activity157RepairGameModel.instance:getCurComponentId()),
		[StatEnum.EventProperties.Result] = arg_5_1
	})

	arg_5_0.startTime = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
