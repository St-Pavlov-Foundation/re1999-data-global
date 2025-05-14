module("framework.core.userdata.UserDataDispose", package.seeall)

local var_0_0 = class("UserDataDispose")

function var_0_0.__onInit(arg_1_0)
	getmetatable(arg_1_0).__newindex = function(arg_2_0, arg_2_1, arg_2_2)
		rawset(arg_2_0, arg_2_1, arg_2_2)

		if type(arg_2_2) == "userdata" then
			if not rawget(arg_2_0, "__userDataKeys") then
				rawset(arg_2_0, "__userDataKeys", {})
			end

			arg_2_0.__userDataKeys[arg_2_1] = true
		end
	end
	arg_1_0.__userDataTbs = {}
	arg_1_0.__eventTbs = {}
	arg_1_0.__clickObjs = {}
end

function var_0_0.__onDispose(arg_3_0)
	if arg_3_0.__userDataKeys then
		local var_3_0 = arg_3_0.__userDataKeys

		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			rawset(arg_3_0, iter_3_0, nil)
		end

		arg_3_0.__userDataKeys = nil
	end

	if arg_3_0.__userDataTbs then
		for iter_3_2, iter_3_3 in ipairs(arg_3_0.__userDataTbs) do
			for iter_3_4 in pairs(iter_3_3) do
				rawset(iter_3_3, iter_3_4, nil)
			end

			rawset(arg_3_0.__userDataTbs, iter_3_2, nil)
		end

		arg_3_0.__userDataTbs = nil
	end

	if arg_3_0.__eventTbs then
		for iter_3_5, iter_3_6 in ipairs(arg_3_0.__eventTbs) do
			iter_3_6[1]:unregisterCallback(iter_3_6[2], iter_3_6[3], iter_3_6[4])
		end

		arg_3_0.__eventTbs = nil
	end

	if arg_3_0.__clickObjs then
		for iter_3_7, iter_3_8 in pairs(arg_3_0.__clickObjs) do
			if not iter_3_7:Equals(nil) then
				iter_3_7:RemoveClickListener()
			end
		end

		arg_3_0.__clickObjs = nil
	end
end

function var_0_0.getUserDataTb_(arg_4_0)
	local var_4_0 = {}

	if arg_4_0.__userDataTbs then
		table.insert(arg_4_0.__userDataTbs, var_4_0)
	end

	return var_4_0
end

function var_0_0.addEventCb(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if not arg_5_1 or not arg_5_2 or not arg_5_3 then
		logError("UserDataDispose:addEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	arg_5_1:registerCallback(arg_5_2, arg_5_3, arg_5_4, arg_5_5)

	if arg_5_0.__eventTbs then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.__eventTbs) do
			if iter_5_1[1] == arg_5_1 and iter_5_1[2] == arg_5_2 and iter_5_1[3] == arg_5_3 and iter_5_1[4] == arg_5_4 then
				return
			end
		end
	end

	table.insert(arg_5_0.__eventTbs, {
		arg_5_1,
		arg_5_2,
		arg_5_3,
		arg_5_4
	})
end

function var_0_0.removeEventCb(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if not arg_6_1 or not arg_6_2 or not arg_6_3 then
		logError("UserDataDispose:removeEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	if arg_6_0.__eventTbs then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.__eventTbs) do
			if iter_6_1[1] == arg_6_1 and iter_6_1[2] == arg_6_2 and iter_6_1[3] == arg_6_3 and iter_6_1[4] == arg_6_4 then
				table.remove(arg_6_0.__eventTbs, iter_6_0)

				break
			end
		end
	end

	arg_6_1:unregisterCallback(arg_6_2, arg_6_3, arg_6_4)
end

function var_0_0.addClickCb(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if not arg_7_1 or arg_7_1:Equals(nil) or not arg_7_2 or not arg_7_3 then
		logError("UserDataDispose:addClickCb clickObj or callback or cbObj is null!")

		return
	end

	if arg_7_0.__clickObjs and not arg_7_0.__clickObjs[arg_7_1] then
		arg_7_0.__clickObjs[arg_7_1] = true

		arg_7_1:AddClickListener(arg_7_2, arg_7_3, arg_7_4)
	end
end

function var_0_0.removeClickCb(arg_8_0, arg_8_1)
	if not arg_8_1 or arg_8_1:Equals(nil) then
		logError("UserDataDispose:removeClickCb clickObj is null!")

		return
	end

	if arg_8_0.__clickObjs and arg_8_0.__clickObjs[arg_8_1] then
		arg_8_0.__clickObjs[arg_8_1] = nil

		arg_8_1:RemoveClickListener()
	end
end

return var_0_0
