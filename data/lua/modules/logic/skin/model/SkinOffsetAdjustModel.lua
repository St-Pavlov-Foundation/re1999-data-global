module("modules.logic.skin.model.SkinOffsetAdjustModel", package.seeall)

local var_0_0 = class("SkinOffsetAdjustModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._offsetList = {}
	arg_1_0._saveList = {}
end

function var_0_0.getOffset(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0._offsetList[arg_2_1.id] = arg_2_0._offsetList[arg_2_1.id] or {}

	if arg_2_0._offsetList[arg_2_1.id][arg_2_2] then
		local var_2_0 = arg_2_0._offsetList[arg_2_1.id][arg_2_2]

		return tonumber(var_2_0[1]), tonumber(var_2_0[2]), tonumber(var_2_0[3])
	end

	if arg_2_0._saveList[arg_2_1.id] and arg_2_0._saveList[arg_2_1.id][arg_2_2] then
		local var_2_1 = arg_2_0._saveList[arg_2_1.id][arg_2_2]

		return tonumber(var_2_1[1]), tonumber(var_2_1[2]), tonumber(var_2_1[3])
	end

	local var_2_2 = arg_2_1[arg_2_2]

	if not var_2_2 then
		logError("skin offset key error:", arg_2_2)
	end

	local var_2_3, var_2_4 = SkinConfig.instance:getSkinOffset(var_2_2)

	if var_2_4 and not string.nilorempty(arg_2_3) then
		local var_2_5 = arg_2_1[arg_2_3]

		if not var_2_5 then
			logError("skin offset key error:", arg_2_3)
		end

		var_2_3, var_2_4 = SkinConfig.instance:getSkinOffset(var_2_5)

		if arg_2_4 ~= -1 then
			local var_2_6 = SkinConfig.instance:getSkinOffset(CommonConfig.instance:getConstStr(arg_2_4))

			var_2_3[1] = var_2_3[1] + var_2_6[1]
			var_2_3[2] = var_2_3[2] + var_2_6[2]
			var_2_3[3] = var_2_3[3] + var_2_6[3]
		end
	end

	local var_2_7 = var_2_3[1]
	local var_2_8 = var_2_3[2]
	local var_2_9 = var_2_3[3]

	arg_2_0._offsetList[arg_2_1.id][arg_2_2] = {
		var_2_7,
		var_2_8,
		var_2_9
	}

	return var_2_7, var_2_8, var_2_9, var_2_4
end

function var_0_0.resetTempOffset(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._offsetList[arg_3_1.id] = arg_3_0._offsetList[arg_3_1.id] or {}
	arg_3_0._offsetList[arg_3_1.id][arg_3_2] = nil
end

function var_0_0.setTempOffset(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0._offsetList[arg_4_1.id] = arg_4_0._offsetList[arg_4_1.id] or {}
	arg_4_0._offsetList[arg_4_1.id][arg_4_2] = {
		arg_4_3,
		arg_4_4,
		arg_4_5
	}
end

function var_0_0.setOffset(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_3 = tonumber(arg_5_3) == 0 and 0 or tonumber(arg_5_3)
	arg_5_4 = tonumber(arg_5_4) == 0 and 0 or tonumber(arg_5_4)
	arg_5_5 = tonumber(arg_5_5) == 0 and 0 or tonumber(arg_5_5)
	arg_5_0._offsetList[arg_5_1.id] = arg_5_0._offsetList[arg_5_1.id] or {}
	arg_5_0._offsetList[arg_5_1.id][arg_5_2] = {
		arg_5_3,
		arg_5_4,
		arg_5_5
	}
	arg_5_0._saveList[arg_5_1.id] = arg_5_0._saveList[arg_5_1.id] or {}
	arg_5_0._saveList[arg_5_1.id][arg_5_2] = {
		arg_5_3,
		arg_5_4,
		arg_5_5
	}

	arg_5_0:saveConfig()
end

function var_0_0.saveCameraSize(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._saveList[arg_6_1.id] = arg_6_0._saveList[arg_6_1.id] or {}
	arg_6_0._saveList[arg_6_1.id].fullScreenCameraSize = arg_6_2
end

function var_0_0.getCameraSize(arg_7_0, arg_7_1)
	return arg_7_0._saveList[arg_7_1] and arg_7_0._saveList[arg_7_1].fullScreenCameraSize
end

function var_0_0.getTrigger(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._offsetList[arg_8_1.id] = arg_8_0._offsetList[arg_8_1.id] or {}

	if arg_8_0._offsetList[arg_8_1.id][arg_8_2] then
		return arg_8_0._offsetList[arg_8_1.id][arg_8_2]
	end

	local var_8_0 = {}
	local var_8_1 = arg_8_1[arg_8_2]
	local var_8_2 = string.split(var_8_1, "_")

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_3 = string.split(iter_8_1, "|")

		if #var_8_3 == 2 then
			local var_8_4 = string.split(var_8_3[1], "#")
			local var_8_5 = string.split(var_8_3[2], "#")
			local var_8_6 = tonumber(var_8_4[1])
			local var_8_7 = tonumber(var_8_4[2])
			local var_8_8 = tonumber(var_8_5[1])
			local var_8_9 = tonumber(var_8_5[2])

			table.insert(var_8_0, {
				var_8_6,
				var_8_7,
				var_8_8,
				var_8_9
			})
		end
	end

	return var_8_0
end

function var_0_0.setTrigger(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0._offsetList[arg_9_1.id] = arg_9_0._offsetList[arg_9_1.id] or {}
	arg_9_0._offsetList[arg_9_1.id][arg_9_2] = arg_9_3
	arg_9_0._saveList[arg_9_1.id] = arg_9_0._saveList[arg_9_1.id] or {}
	arg_9_0._saveList[arg_9_1.id][arg_9_2] = arg_9_3

	arg_9_0:saveConfig()
end

function var_0_0.saveConfig(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0._saveList) do
		table.insert(var_10_0, {
			iter_10_0,
			iter_10_1
		})
	end

	local var_10_1 = cjson.encode(var_10_0)
	local var_10_2 = string.format("%s/../skinOffsetAdjust.json", UnityEngine.Application.dataPath)

	SLFramework.FileHelper.WriteTextToPath(var_10_2, var_10_1)
	GameFacade.showToast(ToastEnum.SkinOffsetAdjustSaveConfig)
end

var_0_0.instance = var_0_0.New()

return var_0_0
