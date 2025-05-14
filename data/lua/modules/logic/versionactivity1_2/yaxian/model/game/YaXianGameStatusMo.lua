module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameStatusMo", package.seeall)

local var_0_0 = pureTable("YaXianGameStatusMo")

function var_0_0.NewFunc()
	return var_0_0.New()
end

function var_0_0.resetFunc(arg_2_0)
	arg_2_0.status = nil
	arg_2_0.directionList = nil
end

function var_0_0.releaseFunc(arg_3_0)
	arg_3_0:resetFunc()
end

function var_0_0.addStatus(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.status = arg_4_1

	if arg_4_2 then
		arg_4_0.directionList = arg_4_0.directionList or {}

		if not tabletool.indexOf(arg_4_0.directionList, arg_4_2) then
			table.insert(arg_4_0.directionList, arg_4_2)
		end
	end
end

return var_0_0
