module("modules.logic.versionactivity2_4.warmup.config.V2a4_WarmUpConfig", package.seeall)

local var_0_0 = class("V2a4_WarmUpConfig", BaseConfig)
local var_0_1 = math.randomseed
local var_0_2 = math.random
local var_0_3 = string.format
local var_0_4 = table.insert
local var_0_5 = string.find
local var_0_6 = tonumber

function var_0_0.actId(arg_1_0)
	return ActivityEnum.Activity.V2a4_WarmUp
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"v2a4_warmup_fmt_effect",
		"v2a4_warmup_const",
		"v2a4_warmup_const_mlstring",
		"v2a4_warmup_level",
		"v2a4_warmup_ask_type",
		"v2a4_warmup_dialog_style",
		"v2a4_warmup_dialog_type",
		"v2a4_warmup_dialog",
		"v2a4_warmup_text_info",
		"v2a4_warmup_text_item_list",
		"v2a4_warmup_photo_item_list"
	}
end

local function var_0_7(arg_3_0)
	return lua_v2a4_warmup_fmt_effect.configDict[arg_3_0]
end

local function var_0_8(arg_4_0)
	return lua_v2a4_warmup_const.configDict[arg_4_0]
end

local function var_0_9(arg_5_0)
	return lua_v2a4_warmup_dialog_style.configDict[arg_5_0]
end

local function var_0_10(arg_6_0)
	return lua_v2a4_warmup_dialog_type.configDict[arg_6_0]
end

local function var_0_11(arg_7_0)
	return lua_v2a4_warmup_dialog.configDict[arg_7_0]
end

local function var_0_12(arg_8_0)
	local var_8_0 = var_0_11(arg_8_0)

	return var_8_0 and var_8_0.nextId or 0
end

local function var_0_13(arg_9_0)
	return lua_v2a4_warmup_photo_item_list.configDict[arg_9_0]
end

function var_0_0.onConfigLoaded(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == "v2a4_warmup_dialog" then
		arg_10_0:__init_v2a4_warmup_dialog(arg_10_2)
	elseif arg_10_1 == "v2a4_warmup_text_item_list" then
		arg_10_0:__init_v2a4_warmup_text_item_list(arg_10_2)
	elseif arg_10_1 == "v2a4_warmup_photo_item_list" then
		arg_10_0:__init_v2a4_warmup_photo_item_list(arg_10_2)
	end
end

function var_0_0.__init_v2a4_warmup_dialog(arg_11_0, arg_11_1)
	if isDebugBuild then
		arg_11_0.__log = {}
	end

	arg_11_0.__v2a4_warmup_dialog = {}
	arg_11_0.__prefaceDialogListCO = {}

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(lua_v2a4_warmup_dialog.configList) do
		local var_11_1 = iter_11_1.group
		local var_11_2 = iter_11_1.id
		local var_11_3 = iter_11_1.nextId

		if isDebugBuild and var_11_2 == var_11_3 then
			if #arg_11_0.__log == 0 then
				local var_11_4 = var_0_3("[V2a4_WarmUpConfig - __init_v2a4_warmup_dialog]: 2.4预热活动_接听电话.xlsx - export_对话内容库")

				var_0_4(arg_11_0.__log, "[V2a4_WarmUpConfig - __init_v2a4_warmup_dialog] =========== begin")
				var_0_4(arg_11_0.__log, var_0_3("source: %s", var_11_4))
			end

			var_0_4(arg_11_0.__log, var_0_3("id=%s\tnextId=%s", var_11_2, var_11_3))
		end

		arg_11_0.__v2a4_warmup_dialog[var_11_1] = arg_11_0.__v2a4_warmup_dialog[var_11_1] or {}

		if var_11_1 == V2a4_WarmUpEnum.DialogType.Preface then
			var_0_4(arg_11_0.__prefaceDialogListCO, iter_11_1)
		end

		if var_11_3 == 0 then
			var_0_4(var_11_0, var_11_2)
		end
	end

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_5 = arg_11_1.configDict[iter_11_3]
		local var_11_6 = var_11_5.group
		local var_11_7 = arg_11_0.__v2a4_warmup_dialog[var_11_6]

		var_0_4(var_11_7, var_11_5)
	end

	table.sort(arg_11_0.__prefaceDialogListCO, function(arg_12_0, arg_12_1)
		return arg_12_0.id < arg_12_1.id
	end)

	if isDebugBuild and #arg_11_0.__log ~= 0 then
		var_0_4(arg_11_0.__log, "[V2a4_WarmUpConfig - __init_v2a4_warmup_dialog] =========== end")
		logError(table.concat(arg_11_0.__log, "\n"))
	end
end

function var_0_0.__init_v2a4_warmup_yesno_item_list(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if isDebugBuild then
		arg_13_0.__log = {}
	end

	local function var_13_0()
		if #arg_13_0.__log ~= 0 then
			return
		end

		var_0_4(arg_13_0.__log, "[V2a4_WarmUpConfig - __init_v2a4_warmup_yesno_item_list] =========== begin")
		var_0_4(arg_13_0.__log, var_0_3("source: %s", arg_13_1))
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_3.configList) do
		if isDebugBuild and iter_13_0 == 1 then
			local var_13_1 = 1

			while iter_13_1["yes" .. var_13_1] ~= nil do
				if not iter_13_1["no" .. var_13_1] then
					var_13_0()
					var_0_4(arg_13_0.__log, var_0_3("\tno field 'no%s'", var_13_1))
				end

				var_13_1 = var_13_1 + 1
			end

			while iter_13_1["no" .. var_13_1] ~= nil do
				if not iter_13_1["yes" .. var_13_1] then
					var_13_0()
					var_0_4(arg_13_0.__log, var_0_3("\tno field 'yes%s'", var_13_1))
				end

				var_13_1 = var_13_1 + 1
			end

			if #arg_13_0.__log ~= 0 then
				var_0_4(arg_13_0.__log, "[V2a4_WarmUpConfig - __init_v2a4_warmup_yesno_item_list] =========== end")
				logError(table.concat(arg_13_0.__log, "\n"))
			end
		end

		local var_13_2 = iter_13_1.level

		arg_13_2[var_13_2] = arg_13_2[var_13_2] or {}

		local var_13_3 = arg_13_2[var_13_2]

		var_0_4(var_13_3, iter_13_1)
	end
end

function var_0_0.__init_v2a4_warmup_text_item_list(arg_15_0, arg_15_1)
	arg_15_0.__v2a4_warmup_text_item_list = {}

	if isDebugBuild then
		local var_15_0 = var_0_3("[logError] 2.4预热活动_接听电话.xlsx - export_文字型题库集（路人）")

		arg_15_0:__init_v2a4_warmup_yesno_item_list(var_15_0, arg_15_0.__v2a4_warmup_text_item_list, arg_15_1)
	else
		arg_15_0:__init_v2a4_warmup_yesno_item_list(nil, arg_15_0.__v2a4_warmup_text_item_list, arg_15_1)
	end

	arg_15_0.__v2a4_warmup_text_item_list_yesno_header_count = arg_15_0:__init_v2a4_warmup_yesno_count(arg_15_1)
end

function var_0_0.__init_v2a4_warmup_photo_item_list(arg_16_0, arg_16_1)
	arg_16_0.__v2a4_warmup_photo_item_list = {}

	if isDebugBuild then
		local var_16_0 = var_0_3("[logError] 2.4预热活动_接听电话.xlsx - export_图片型题库集")

		arg_16_0:__init_v2a4_warmup_yesno_item_list(var_16_0, arg_16_0.__v2a4_warmup_photo_item_list, arg_16_1)
	else
		arg_16_0:__init_v2a4_warmup_yesno_item_list(nil, arg_16_0.__v2a4_warmup_photo_item_list, arg_16_1)
	end

	arg_16_0.__v2a4_warmup_photo_item_list_yesno_header_count = arg_16_0:__init_v2a4_warmup_yesno_count(arg_16_1)
end

function var_0_0.__init_v2a4_warmup_yesno_count(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return 0
	end

	local var_17_0, var_17_1 = next(arg_17_1.configList)

	if not var_17_1 then
		return 0
	end

	for iter_17_0 = 1, 1999 do
		if not var_17_1["yes" .. iter_17_0] then
			return iter_17_0 - 1
		end
	end

	return 0
end

function var_0_0.nextDialogCO(arg_18_0, arg_18_1)
	local var_18_0 = var_0_12(arg_18_1)

	if var_18_0 <= 0 then
		return
	end

	return var_0_11(var_18_0)
end

function var_0_0.dialogCount(arg_19_0, arg_19_1)
	if not var_0_11(arg_19_1) then
		return 0
	end

	local var_19_0 = 0

	while arg_19_1 > 0 do
		var_19_0 = var_19_0 + 1
		arg_19_1 = var_0_12(arg_19_1)
	end

	return var_19_0
end

function var_0_0.getRandomDialogCO(arg_20_0, arg_20_1)
	if arg_20_1 == V2a4_WarmUpEnum.DialogType.Preface then
		return arg_20_0.__prefaceDialogListCO[1]
	end

	local var_20_0 = arg_20_0.__v2a4_warmup_dialog[arg_20_1]

	if not var_20_0 or #var_20_0 == 0 then
		return nil
	end

	var_0_1(os.time())

	return var_20_0[var_0_2(1, #var_20_0)]
end

function var_0_0.prefaceDialogListCO(arg_21_0)
	return arg_21_0.__prefaceDialogListCO
end

function var_0_0.getConst(arg_22_0, arg_22_1)
	return var_0_8(arg_22_1).numValue
end

function var_0_0.getConstStr(arg_23_0, arg_23_1)
	return lua_v2a4_warmup_const_mlstring.configDict[arg_23_1].value
end

function var_0_0.getLevelCO(arg_24_0, arg_24_1)
	return v2a4_warmup_level.configDict[arg_24_1]
end

function var_0_0.getDialogStyleCO(arg_25_0, arg_25_1)
	local var_25_0 = var_0_10(arg_25_1)

	return var_0_9(var_25_0.style)
end

function var_0_0.getTextItemListCO(arg_26_0, arg_26_1)
	return arg_26_0.__v2a4_warmup_text_item_list[arg_26_1] or {}
end

function var_0_0.getPhotoItemListCO(arg_27_0, arg_27_1)
	return arg_27_0.__v2a4_warmup_photo_item_list[arg_27_1] or {}
end

function var_0_0.getYesMaxCount(arg_28_0, arg_28_1)
	if arg_28_1 == V2a4_WarmUpEnum.AskType.Text then
		return arg_28_0.__v2a4_warmup_text_item_list_yesno_header_count
	elseif arg_28_1 == V2a4_WarmUpEnum.AskType.Photo then
		return arg_28_0.__v2a4_warmup_photo_item_list_yesno_header_count
	end

	return 0
end

function var_0_0.getYesAndNoMaxCount(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getYesMaxCount(arg_29_1)

	return var_29_0 + var_29_0
end

function var_0_0.getDialogCOList(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}

	arg_30_0.appendDialogCOList(var_30_0, arg_30_1, arg_30_2)

	return var_30_0
end

function var_0_0.appendDialogCOList(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if isDebugBuild then
		arg_31_0.__debug_stk_overflow = {}
		arg_31_0.__debug_stk_overflow_loop_cnt = 0
		arg_31_0.__log = {}
	end

	local var_31_0 = var_0_11(arg_31_3)

	while var_31_0 ~= nil do
		if isDebugBuild then
			local var_31_1 = arg_31_0.__debug_stk_overflow_loop_cnt + 1
			local var_31_2 = var_31_0.id

			if not arg_31_0.__debug_stk_overflow[var_31_2] then
				arg_31_0.__debug_stk_overflow[var_31_2] = var_31_1
				arg_31_0.__debug_stk_overflow_loop_cnt = var_31_1
			else
				var_0_4(arg_31_0.__log, "[V2a4_WarmUpConfig - getNpcPreTalkCOList] =========== begin")
				var_0_4(arg_31_0.__log, var_0_3("source: %s", arg_31_2))
				var_0_4(arg_31_0.__log, var_0_3("[logError] 2.4预热活动_接听电话.xlsx - export_对话内容库: id=%s", var_31_2))

				for iter_31_0, iter_31_1 in pairs(arg_31_0.__debug_stk_overflow) do
					if var_31_2 == iter_31_0 then
						var_0_4(arg_31_0.__log, var_0_3("%s: %s !!<----- this", iter_31_1, iter_31_0))
					else
						var_0_4(arg_31_0.__log, var_0_3("%s: %s", iter_31_1, iter_31_0))
					end
				end

				var_0_4(arg_31_0.__log, var_0_3("%s: %s !!<----- error cyclic reference", var_31_1, var_31_2))
				var_0_4(arg_31_0.__log, "[V2a4_WarmUpConfig - getNpcPreTalkCOList] =========== end")
				logError(table.concat(arg_31_0.__log, "\n"))

				break
			end
		end

		var_0_4(arg_31_1, var_31_0)

		var_31_0 = var_0_11(var_31_0.nextId)
	end
end

function var_0_0.textInfoCO(arg_32_0, arg_32_1)
	return lua_v2a4_warmup_text_info.configDict[arg_32_1]
end

function var_0_0.textItemListCO(arg_33_0, arg_33_1)
	return lua_v2a4_warmup_text_item_list.configDict[arg_33_1]
end

function var_0_0.getDialogDesc(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return ""
	end

	local var_34_0

	if type(arg_34_1) == "number" then
		var_34_0 = var_0_11(arg_34_1)
	else
		var_34_0 = arg_34_1
	end

	if isDebugBuild then
		local var_34_1 = var_0_3("[logError] 2.4预热活动_接听电话.xlsx - export_对话内容库: id=%s", var_34_0.id)

		return arg_34_0:FmtFromCO(var_34_1, var_34_0.desc, var_34_0)
	else
		return arg_34_0:FmtFromCO(nil, var_34_0.desc, var_34_0)
	end
end

function var_0_0.getFmtEffectStr(arg_35_0, arg_35_1)
	local var_35_0 = var_0_7(arg_35_1)
	local var_35_1 = var_35_0.handler

	assert(not string.nilorempty(var_35_1))
	arg_35_0[var_35_1](arg_35_0, var_35_0.args)
end

function var_0_0.fmt_const_strs(arg_36_0, arg_36_1)
	local var_36_0 = ""

	if not arg_36_1 or #arg_36_1 == 0 then
		return var_36_0
	end

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		local var_36_1 = var_0_6(iter_36_1)

		var_36_0 = var_36_0 .. arg_36_0:getConstStr(var_36_1)
	end

	return var_36_0
end

function var_0_0.getDurationSec(arg_37_0)
	return arg_37_0:getConst(1) or 60
end

function var_0_0.getHangonWaitSec(arg_38_0)
	return arg_38_0:getConst(2) or 10
end

function var_0_0.getSentenceInBetweenSec(arg_39_0)
	return arg_39_0:getConst(3) or 1
end

local var_0_14 = "fmt"
local var_0_15 = "▩"

function var_0_0.FmtFromCO(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if not var_0_5(arg_40_2, var_0_15) then
		return arg_40_2
	end

	if isDebugBuild then
		arg_40_0.__debug_fillParamsIndexDict = {}
		arg_40_0.__log = {}

		for iter_40_0, iter_40_1 in string.gmatch(arg_40_2, "▩([0-9]+)%%([sd])") do
			arg_40_0.__debug_fillParamsIndexDict[iter_40_0] = iter_40_1
		end
	end

	local var_40_0 = 1
	local var_40_1 = var_0_14 .. var_40_0
	local var_40_2 = arg_40_3[var_40_1]
	local var_40_3 = {}

	while var_40_2 ~= nil do
		if var_40_2 > 0 then
			var_0_4(var_40_3, arg_40_0:getFmtEffectStr(var_40_2))

			if isDebugBuild and not arg_40_0.__debug_fillParamsIndexDict[var_40_0] then
				if #arg_40_0.__log == 0 then
					var_0_4(arg_40_0.__log, "[V2a4_WarmUpConfig - FmtFromCO] =========== begin")
					var_0_4(arg_40_0.__log, var_0_3("source: %s", arg_40_1))
				end

				var_0_4(arg_40_0.__log, var_0_3("[logError] %s 未找到 ▩%s", var_40_1, var_40_0))
			end
		end

		var_40_2 = arg_40_3[var_0_14 .. var_40_0]
	end

	if isDebugBuild and #arg_40_0.__log ~= 0 then
		var_0_4(arg_40_0.__log, var_0_3("error fotmat: %s", arg_40_2))
		var_0_4(arg_40_0.__log, "[V2a4_WarmUpConfig - FmtFromCO] =========== end")
		logError(table.concat(arg_40_0.__log, "\n"))
	end

	if #var_40_3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(arg_40_2, var_40_3)
	end

	return arg_40_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
