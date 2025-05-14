module("framework.storage.PlayerPrefsHelper", package.seeall)

local var_0_0 = {}

var_0_0.FlushInterval = 0.1
var_0_0._keySet = {}
var_0_0._dict = {}
var_0_0._needFlushDict = {}
var_0_0._needFlush = false
var_0_0._needSave = false

function var_0_0.getNumber(arg_1_0, arg_1_1)
	return var_0_0._get(arg_1_0, arg_1_1, true)
end

function var_0_0.getString(arg_2_0, arg_2_1)
	return var_0_0._get(arg_2_0, arg_2_1, false)
end

function var_0_0.setNumber(arg_3_0, arg_3_1)
	var_0_0._set(arg_3_0, tonumber(arg_3_1))
end

function var_0_0.setString(arg_4_0, arg_4_1)
	var_0_0._set(arg_4_0, tostring(arg_4_1))
end

function var_0_0.hasKey(arg_5_0)
	local var_5_0 = var_0_0._keySet[arg_5_0]

	if var_5_0 ~= nil then
		return var_5_0
	end

	local var_5_1 = UnityEngine.PlayerPrefs.HasKey(arg_5_0)

	var_0_0._keySet[arg_5_0] = var_5_1

	return var_5_1
end

function var_0_0.deleteKey(arg_6_0)
	if var_0_0._keySet[arg_6_0] == false then
		return
	end

	var_0_0._keySet[arg_6_0] = false
	var_0_0._dict[arg_6_0] = nil
	var_0_0._needFlushDict[arg_6_0] = nil

	UnityEngine.PlayerPrefs.DeleteKey(arg_6_0)
end

function var_0_0.deleteAll()
	var_0_0._keySet = {}
	var_0_0._dict = {}
	var_0_0._needFlushDict = {}

	UnityEngine.PlayerPrefs.DeleteAll()
end

function var_0_0._get(arg_8_0, arg_8_1, arg_8_2)
	if var_0_0._keySet[arg_8_0] == true then
		if var_0_0._dict[arg_8_0] == nil then
			local var_8_0 = arg_8_2 and UnityEngine.PlayerPrefs.GetFloat(arg_8_0) or UnityEngine.PlayerPrefs.GetString(arg_8_0)

			var_0_0._dict[arg_8_0] = var_8_0
			var_0_0._keySet[arg_8_0] = true
		end

		return var_0_0._dict[arg_8_0]
	elseif var_0_0._keySet[arg_8_0] == nil then
		if UnityEngine.PlayerPrefs.HasKey(arg_8_0) then
			local var_8_1 = arg_8_2 and UnityEngine.PlayerPrefs.GetFloat(arg_8_0) or UnityEngine.PlayerPrefs.GetString(arg_8_0)

			var_0_0._dict[arg_8_0] = var_8_1
			var_0_0._keySet[arg_8_0] = true

			return var_8_1
		else
			var_0_0._keySet[arg_8_0] = false

			return arg_8_1
		end
	else
		return arg_8_1
	end
end

function var_0_0._set(arg_9_0, arg_9_1)
	if arg_9_1 ~= nil then
		if var_0_0._dict[arg_9_0] ~= arg_9_1 then
			var_0_0._dict[arg_9_0] = arg_9_1
			var_0_0._keySet[arg_9_0] = true
			var_0_0._needFlushDict[arg_9_0] = arg_9_1

			if not var_0_0._needFlush then
				var_0_0._needFlush = true
				var_0_0._needSave = true

				TaskDispatcher.runDelay(var_0_0.flush, nil, var_0_0.FlushInterval)
			end
		end
	else
		logError("PlayerPrefsHelper._set error, value can't be nil, use deleteKey instead")
	end
end

function var_0_0.flush()
	if var_0_0._needFlush then
		var_0_0._needFlush = false

		for iter_10_0, iter_10_1 in pairs(var_0_0._needFlushDict) do
			if type(iter_10_1) == "number" then
				UnityEngine.PlayerPrefs.SetFloat(iter_10_0, iter_10_1)
			else
				UnityEngine.PlayerPrefs.SetString(iter_10_0, iter_10_1)
			end
		end

		var_0_0._needFlushDict = {}
	end
end

function var_0_0.save()
	if var_0_0._needSave then
		var_0_0._needSave = false

		UnityEngine.PlayerPrefs.Save()
	end
end

return var_0_0
