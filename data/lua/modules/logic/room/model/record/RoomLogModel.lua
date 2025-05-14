module("modules.logic.room.model.record.RoomLogModel", package.seeall)

local var_0_0 = class("RoomLogModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._currentPage = 1
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._currentPage = 1
end

function var_0_0.getInfos(arg_3_0)
	return arg_3_0._list
end

function var_0_0.setInfos(arg_4_0, arg_4_1)
	arg_4_0._currentTime = nil
	arg_4_0._list = {}
	arg_4_0._newLog = nil

	local function var_4_0(arg_5_0, arg_5_1)
		return arg_5_0.time > arg_5_1.time
	end

	table.sort(arg_4_1, var_4_0)

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = {
			type = iter_4_1.type,
			time = iter_4_1.time,
			timestr = TimeUtil.timestampToString4(iter_4_1.time)
		}

		arg_4_0:setConfigByType(iter_4_1, var_4_1)

		if arg_4_0:checkIsNewDay(iter_4_1.time) and #arg_4_1 > 0 then
			local var_4_2 = os.date("*t", iter_4_1.time - TimeUtil.OneDaySecond).wday
			local var_4_3 = {
				type = RoomRecordEnum.LogType.Time,
				day = var_4_2
			}

			table.insert(arg_4_0._list, var_4_3)
		end

		table.insert(arg_4_0._list, var_4_1)
	end

	if arg_4_0._newLog then
		RoomController.instance:dispatchEvent(RoomEvent.NewLog, arg_4_0._newLog)
	end
end

function var_0_0.setConfigByType(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1.type == RoomRecordEnum.LogType.Speical then
		local var_6_0 = arg_6_1.id
		local var_6_1 = RoomConfig.instance:getCharacterInteractionConfig(var_6_0)
		local var_6_2 = HeroConfig.instance:getHeroCO(var_6_1.heroId).name

		if var_6_2 then
			arg_6_2.heroname = var_6_2
		end

		local var_6_3 = 0

		arg_6_2.config = var_6_1

		while true do
			arg_6_2.logConfigList = arg_6_2.logConfigList or {}
			var_6_3 = var_6_3 + 1

			local var_6_4 = RoomConfig.instance:getCharacterDialogConfig(var_6_1.dialogId, var_6_3)

			if not var_6_4 then
				break
			end

			table.insert(arg_6_2.logConfigList, var_6_4)
		end
	elseif arg_6_1.type == RoomRecordEnum.LogType.Normal then
		local var_6_5 = RoomLogConfig.instance:getLogConfigById(arg_6_1.id)

		if var_6_5 then
			arg_6_2.content = var_6_5.content
		end
	elseif arg_6_1.type == RoomRecordEnum.LogType.Custom then
		local var_6_6 = RoomTradeConfig.instance:getTaskCoById(arg_6_1.id)

		if var_6_6 then
			arg_6_2.config = var_6_6
			arg_6_2.name = HeroConfig.instance:getHeroCO(tonumber(var_6_6.speaker)).name

			local var_6_7 = {}

			if not string.nilorempty(var_6_6.logtext) then
				var_6_7 = string.splitToNumber(var_6_6.logtext, "#")
			end

			if #var_6_7 > 0 then
				arg_6_2.logConfigList = arg_6_2.logConfigList or {}

				local var_6_8, var_6_9 = var_6_7[1], var_6_7[2]

				while var_6_8 <= var_6_9 do
					local var_6_10 = RoomLogConfig.instance:getLogConfigById(var_6_8)

					table.insert(arg_6_2.logConfigList, var_6_10)

					var_6_8 = var_6_8 + 1
				end
			end
		end

		if arg_6_1.isNew and not arg_6_0._newLog then
			arg_6_0._newLog = arg_6_2
		end
	end
end

function var_0_0.checkIsNewDay(arg_7_0, arg_7_1)
	if not arg_7_0._currentTime then
		arg_7_0._currentTime = arg_7_1

		return false
	elseif arg_7_1 < arg_7_0._currentTime and not TimeUtil.isSameDay(arg_7_1, arg_7_0._currentTime) then
		arg_7_0._currentTime = arg_7_1

		return true
	end
end

function var_0_0.setPage(arg_8_0, arg_8_1)
	arg_8_0._currentPage = arg_8_1
end

function var_0_0.getPage(arg_9_0)
	return arg_9_0._currentPage or 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
