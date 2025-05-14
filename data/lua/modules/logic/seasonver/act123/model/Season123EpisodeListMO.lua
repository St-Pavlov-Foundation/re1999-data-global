module("modules.logic.seasonver.act123.model.Season123EpisodeListMO", package.seeall)

local var_0_0 = pureTable("Season123EpisodeListMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_2.layer
	arg_1_0.cfg = arg_1_2

	if arg_1_1 then
		arg_1_0.isFinished = arg_1_1:isFinished()
		arg_1_0.round = arg_1_1.round
	else
		arg_1_0.isFinished = false
		arg_1_0.round = 0
	end
end

return var_0_0
