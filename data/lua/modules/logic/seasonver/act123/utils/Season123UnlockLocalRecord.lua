module("modules.logic.seasonver.act123.utils.Season123UnlockLocalRecord", package.seeall)

local var_0_0 = class("Season123UnlockLocalRecord")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityId = arg_1_1
	arg_1_0.reasonKey = arg_1_2
	arg_1_0._localKey = arg_1_0:getLocalKey()
	arg_1_0._dict = nil
	arg_1_0._moduleSet = {}

	arg_1_0:initLocalSave()
end

function var_0_0.initLocalSave(arg_2_0)
	if string.nilorempty(arg_2_0._localKey) then
		return
	end

	local var_2_0 = PlayerPrefsHelper.getString(arg_2_0._localKey, "")

	if not string.nilorempty(var_2_0) then
		local var_2_1 = cjson.decode(var_2_0)

		if var_2_1 then
			arg_2_0._dict = var_2_1

			for iter_2_0, iter_2_1 in pairs(var_2_1) do
				arg_2_0._moduleSet[iter_2_0] = {}

				for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
					arg_2_0._moduleSet[iter_2_0][iter_2_3] = true
				end
			end
		else
			arg_2_0._dict = {}
		end
	else
		arg_2_0._dict = {}
	end
end

function var_0_0.add(arg_3_0, arg_3_1, arg_3_2)
	if string.nilorempty(arg_3_0._localKey) then
		return
	end

	arg_3_0._moduleSet[arg_3_2] = arg_3_0._moduleSet[arg_3_2] or {}

	if not arg_3_0._moduleSet[arg_3_2][arg_3_1] then
		arg_3_0._moduleSet[arg_3_2][arg_3_1] = true
		arg_3_0._dict[arg_3_2] = arg_3_0._dict[arg_3_2] or {}

		table.insert(arg_3_0._dict[arg_3_2], arg_3_1)
		arg_3_0:save()
	end
end

function var_0_0.contain(arg_4_0, arg_4_1, arg_4_2)
	if string.nilorempty(arg_4_0._localKey) then
		return false
	end

	return arg_4_0._moduleSet[arg_4_2] and arg_4_0._moduleSet[arg_4_2][arg_4_1]
end

function var_0_0.save(arg_5_0)
	if string.nilorempty(arg_5_0._localKey) then
		return
	end

	PlayerPrefsHelper.setString(arg_5_0._localKey, cjson.encode(arg_5_0._dict))
end

function var_0_0.getLocalKey(arg_6_0)
	return tostring(arg_6_0.reasonKey) .. "#" .. tostring(arg_6_0.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return var_0_0
