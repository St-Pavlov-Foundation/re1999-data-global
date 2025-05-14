module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueEventMO", package.seeall)

local var_0_0 = pureTable("RogueEventMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.eventId = arg_1_1.eventId
	arg_1_0.status = arg_1_1.status
	arg_1_0.eventData = arg_1_1.eventData
	arg_1_0.option = arg_1_1.option
	arg_1_0._eventJsonData = nil
end

function var_0_0.getEventCo(arg_2_0)
	if not arg_2_0.co then
		arg_2_0.co = lua_rogue_event.configDict[arg_2_0.eventId]
	end

	return arg_2_0.co
end

function var_0_0.getBattleData(arg_3_0)
	local var_3_0 = arg_3_0:getEventCo()

	if not var_3_0 or var_3_0.type ~= V1a6_CachotEnum.EventType.Battle then
		return
	end

	return arg_3_0:_getJsonData()
end

function var_0_0._getJsonData(arg_4_0)
	if not arg_4_0._eventJsonData then
		if string.nilorempty(arg_4_0.eventData) then
			arg_4_0._eventJsonData = {}
		else
			arg_4_0._eventJsonData = cjson.decode(arg_4_0.eventData)
		end
	end

	return arg_4_0._eventJsonData
end

function var_0_0.isBattleSuccess(arg_5_0)
	local var_5_0 = arg_5_0:getBattleData()

	if not var_5_0 then
		return false
	end

	return var_5_0.status == 1
end

function var_0_0.getRetries(arg_6_0)
	local var_6_0 = arg_6_0:getBattleData()

	if not var_6_0 then
		return 0
	end

	return var_6_0.retries or 0
end

function var_0_0.getDropList(arg_7_0)
	if arg_7_0.status == V1a6_CachotEnum.EventStatus.Finish then
		return
	end

	local var_7_0 = arg_7_0:_getJsonData()

	if not var_7_0 then
		return
	end

	if var_7_0.status == 1 then
		if string.nilorempty(var_7_0.drop) then
			return {}
		end

		local var_7_1 = {}
		local var_7_2 = cjson.decode(var_7_0.drop)

		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			if iter_7_1.status == 0 then
				local var_7_3 = false

				if iter_7_1.type == "EVENT" then
					local var_7_4 = lua_rogue_event.configDict[iter_7_1.value]

					if var_7_4 and var_7_4.type == V1a6_CachotEnum.EventType.ChoiceSelect then
						var_7_3 = true
					end
				end

				if not var_7_3 then
					table.insert(var_7_1, iter_7_1)
				end
			end
		end

		return var_7_1
	end
end

return var_0_0
