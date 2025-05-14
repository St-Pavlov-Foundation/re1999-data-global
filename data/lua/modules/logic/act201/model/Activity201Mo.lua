module("modules.logic.act201.model.Activity201Mo", package.seeall)

local var_0_0 = pureTable("Activity201Mo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.invitePlayers = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.activityId = arg_2_1.activityId
	arg_2_0.isTurnBack = arg_2_1.isTurnback
	arg_2_0.inviteCode = arg_2_1.inviteCode

	arg_2_0:refreshInvitaPlayerInfo(arg_2_1.invitePlayers)
end

function var_0_0.refreshInvitaPlayerInfo(arg_3_0, arg_3_1)
	tabletool.clear(arg_3_0.invitePlayers)

	if arg_3_1 and #arg_3_1 > 0 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			local var_3_0 = {
				name = iter_3_1.name,
				userId = iter_3_1.userId,
				portrait = iter_3_1.portrait,
				roleType = iter_3_1.roleType
			}

			table.insert(arg_3_0.invitePlayers, var_3_0)
		end
	end
end

return var_0_0
