module("modules.logic.rouge.map.model.rpcmo.RougeBaseEventMO", package.seeall)

local var_0_0 = pureTable("RougeBaseEventMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.eventCo = arg_1_1
	arg_1_0.jsonData = cjson.decode(arg_1_2)
	arg_1_0.state = arg_1_0.jsonData.state
	arg_1_0.eventId = arg_1_0.jsonData.eventId
	arg_1_0.type = arg_1_0.jsonData.type
	arg_1_0.fightFail = arg_1_0.jsonData.fightFail
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.eventCo = arg_2_1
	arg_2_0.jsonData = cjson.decode(arg_2_2)
	arg_2_0.eventId = arg_2_0.jsonData.eventId
	arg_2_0.type = arg_2_0.jsonData.type
	arg_2_0.fightFail = arg_2_0.jsonData.fightFail

	if arg_2_0.state ~= arg_2_0.jsonData.state then
		arg_2_0.state = arg_2_0.jsonData.state

		RougeMapController.instance:dispatchEvent(RougeMapEvent.onNodeEventStatusChange, arg_2_0.eventId, arg_2_0.state)
	end
end

function var_0_0.__tostring(arg_3_0)
	return string.format("eventId : %s, jsonData : %s, state : %s, type : %s, fightFail : %s", arg_3_0.eventId, cjson.encode(arg_3_0.jsonData), arg_3_0.state, arg_3_0.type, arg_3_0.fightFail)
end

return var_0_0
