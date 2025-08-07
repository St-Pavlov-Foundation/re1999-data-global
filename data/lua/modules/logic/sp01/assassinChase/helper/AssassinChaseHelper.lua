module("modules.logic.sp01.assassinChase.helper.AssassinChaseHelper", package.seeall)

return {
	getActivityEndTimeStamp = function(arg_1_0)
		local var_1_0 = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.EndTime)
		local var_1_1 = tonumber(var_1_0.value) * TimeUtil.OneDaySecond

		return math.max(0, arg_1_0 - var_1_1)
	end
}
