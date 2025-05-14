module("modules.logic.room.entity.comp.RoomAnimEventAudioComp", package.seeall)

local var_0_0 = class("RoomAnimEventAudioComp", LuaCompBase)

var_0_0.AUDIO_MAX = 4

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.__willDestroy = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._effectKey = RoomEnum.EffectKey.BuildingGOKey
	arg_2_0._eventPrefix = "audio_"
	arg_2_0._configName = "room_building"

	local var_2_0 = arg_2_0:getMO()

	if var_2_0 and var_2_0.config and not string.nilorempty(var_2_0.config.audioExtendIds) then
		arg_2_0._audioExtendIds = string.splitToNumber(var_2_0.config.audioExtendIds, "#")
	end
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.getMO(arg_5_0)
	return arg_5_0.entity:getMO()
end

function var_0_0.setConfigName(arg_6_0, arg_6_1)
	arg_6_0._configName = arg_6_1
end

function var_0_0.setEffectKey(arg_7_0, arg_7_1)
	if arg_7_0._effectKey ~= arg_7_1 then
		arg_7_0._effectKey = arg_7_1

		arg_7_0:_removeAnimEvent()
	end
end

function var_0_0.beforeDestroy(arg_8_0)
	arg_8_0.__willDestroy = true

	arg_8_0:removeEventListeners()
	arg_8_0:_removeAnimEvent()
end

function var_0_0._onAnimEvent_1(arg_9_0)
	arg_9_0:_playAudio(1)
end

function var_0_0._onAnimEvent_2(arg_10_0)
	arg_10_0:_playAudio(2)
end

function var_0_0._onAnimEvent_3(arg_11_0)
	arg_11_0:_playAudio(3)
end

function var_0_0._onAnimEvent_4(arg_12_0)
	arg_12_0:_playAudio(4)
end

function var_0_0._playAudio(arg_13_0, arg_13_1)
	if arg_13_0.__willDestroy or arg_13_0._audioExtendIds == nil then
		return
	end

	local var_13_0 = arg_13_0._audioExtendIds[arg_13_1]

	if var_13_0 == nil then
		logNormal(string.format("RoomAnimEventAudioComp 请检\"%s\"表中\"audioExtendIds\"配置的音效数量不足。当前第%s个", arg_13_0._configName, arg_13_1))
	elseif var_13_0 ~= 0 then
		RoomHelper.audioExtendTrigger(var_13_0, arg_13_0.go)
	end
end

function var_0_0._addAnimEvent(arg_14_0)
	if arg_14_0.__willDestroy then
		return
	end

	if arg_14_0._animEventMonoList or not arg_14_0.effect:isHasEffectGOByKey(arg_14_0._effectKey) then
		return
	end

	local var_14_0 = arg_14_0.effect:getComponentsByKey(arg_14_0._effectKey, RoomEnum.ComponentName.AnimationEventWrap)

	if not var_14_0 then
		return
	end

	arg_14_0._animEventMonoList = {}

	tabletool.addValues(arg_14_0._animEventMonoList, var_14_0)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._animEventMonoList) do
		for iter_14_2 = 1, var_0_0.AUDIO_MAX do
			local var_14_1 = "_onAnimEvent_" .. iter_14_2
			local var_14_2 = arg_14_0[var_14_1]

			if var_14_2 then
				iter_14_1:AddEventListener(arg_14_0._eventPrefix .. iter_14_2, var_14_2, arg_14_0)
			else
				logError("RoomAnimEventAudioComp can not find function name is:" .. var_14_1)

				break
			end
		end
	end
end

function var_0_0._removeAnimEvent(arg_15_0)
	if arg_15_0._animEventMonoList then
		local var_15_0 = arg_15_0._animEventMonoList

		arg_15_0._animEventMonoList = nil

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			iter_15_1:RemoveAllEventListener()
		end

		for iter_15_2 in pairs(var_15_0) do
			rawset(var_15_0, iter_15_2, nil)
		end
	end
end

function var_0_0.onEffectRebuild(arg_16_0)
	local var_16_0 = arg_16_0.entity.effect

	if var_16_0:isHasEffectGOByKey(arg_16_0._effectKey) and not var_16_0:isSameResByKey(arg_16_0._effectKey, arg_16_0._effectRes) then
		arg_16_0._effectRes = var_16_0:getEffectRes(arg_16_0._effectKey)

		arg_16_0:_removeAnimEvent()
		arg_16_0:_addAnimEvent()
	end
end

function var_0_0.onEffectReturn(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._effectKey == arg_17_1 then
		arg_17_0:_removeAnimEvent()
	end
end

return var_0_0
