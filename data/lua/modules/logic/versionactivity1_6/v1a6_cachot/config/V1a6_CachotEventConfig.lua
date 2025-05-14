module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotEventConfig", package.seeall)

local var_0_0 = class("V1a6_CachotEventConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._dramaChoiceDict = {}
	arg_1_0._dramaChoiceGroupToId = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"rogue_collection_drop",
		"rogue_collection_group",
		"rogue_dialog",
		"rogue_event",
		"rogue_event_drama_choice",
		"rogue_event_fight",
		"rogue_event_hint",
		"rogue_event_life",
		"rogue_event_revive",
		"rogue_goods",
		"rogue_shop",
		"rogue_ending",
		"rogue_event_drop_desc",
		"rogue_event_tips"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "rogue_event_drama_choice" then
		for iter_3_0, iter_3_1 in pairs(arg_3_2.configList) do
			if iter_3_1.type == 1 then
				arg_3_0._dramaChoiceGroupToId[iter_3_1.group] = iter_3_1.id
			elseif iter_3_1.type == 2 then
				if not arg_3_0._dramaChoiceDict[iter_3_1.group] then
					arg_3_0._dramaChoiceDict[iter_3_1.group] = {}
				end

				table.insert(arg_3_0._dramaChoiceDict[iter_3_1.group], iter_3_1)
			end
		end
	elseif arg_3_1 == "rogue_collection_drop" then
		arg_3_0:onCollectionDropConfigLoaded(arg_3_2)
	end
end

function var_0_0.onCollectionDropConfigLoaded(arg_4_0, arg_4_1)
	arg_4_0._collectionDropMap = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.configList) do
		if not arg_4_0._collectionDropMap[iter_4_1.groupId] then
			arg_4_0._collectionDropMap[iter_4_1.groupId] = {}
		end

		table.insert(arg_4_0._collectionDropMap[iter_4_1.groupId], iter_4_1)
	end
end

function var_0_0.getChoiceCos(arg_5_0, arg_5_1)
	return arg_5_0._dramaChoiceDict[arg_5_1]
end

function var_0_0.getDramaId(arg_6_0, arg_6_1)
	return arg_6_0._dramaChoiceGroupToId[arg_6_1]
end

function var_0_0.getEventHeartShow(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = lua_rogue_event.configDict[arg_7_1]

	if not var_7_0 then
		return
	end

	local var_7_1
	local var_7_2 = 0

	if var_7_0.type == V1a6_CachotEnum.EventType.Battle then
		local var_7_3 = lua_rogue_event_fight.configDict[var_7_0.eventId]

		if var_7_3 then
			local var_7_4 = var_7_3["heartChange" .. arg_7_2]

			if not string.nilorempty(var_7_4) then
				local var_7_5 = string.split(var_7_4, "|") or {}

				for iter_7_0 = 1, #var_7_5 do
					local var_7_6 = string.match(var_7_5[iter_7_0], "^1#1#(-?[0-9]+)$")

					if var_7_6 then
						var_7_2 = tonumber(var_7_6)

						break
					end
				end
			end
		end
	end

	local var_7_7 = var_7_0["dropGroup" .. arg_7_2] or var_7_0.dropGroup or ""
	local var_7_8 = string.split(var_7_7, "|") or {}

	for iter_7_1 = 1, #var_7_8 do
		local var_7_9 = string.match(var_7_8[iter_7_1], "^[0-9]+#(heart[1-3])$")

		if var_7_9 and not string.nilorempty(var_7_0[var_7_9]) then
			if var_7_1 then
				var_7_1 = "?"

				break
			else
				var_7_1 = string.format("%+d", (tonumber(var_7_0[var_7_9]) or 0) + var_7_2)
			end
		end
	end

	if not var_7_1 and var_7_2 ~= 0 then
		var_7_1 = string.format("%+d", var_7_2)
	end

	return var_7_1
end

function var_0_0.getCollectionDropListByGroupId(arg_8_0, arg_8_1)
	return arg_8_0._collectionDropMap and arg_8_0._collectionDropMap[arg_8_1]
end

function var_0_0.getBgmIdByLayer(arg_9_0, arg_9_1)
	if not arg_9_0._bgmIdDict then
		arg_9_0._bgmIdDict = {}

		local var_9_0 = GameUtil.splitString2(lua_rogue_const.configDict[V1a6_CachotEnum.Const.LayerBGM].value, true)

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			arg_9_0._bgmIdDict[iter_9_1[1]] = iter_9_1[2]
		end
	end

	return arg_9_0._bgmIdDict[arg_9_1] or arg_9_0._bgmIdDict[0]
end

function var_0_0.getSceneIdByLayer(arg_10_0, arg_10_1)
	if not arg_10_0._sceneIdDict then
		arg_10_0._sceneIdDict = {}

		local var_10_0 = GameUtil.splitString2(lua_rogue_const.configDict[V1a6_CachotEnum.Const.LayerFightScene].value, true)

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			arg_10_0._sceneIdDict[iter_10_1[1]] = {
				sceneId = iter_10_1[2],
				levelId = iter_10_1[3]
			}
		end
	end

	return arg_10_0._sceneIdDict[arg_10_1] or arg_10_0._sceneIdDict[1]
end

function var_0_0.getDescCoByEventId(arg_11_0, arg_11_1)
	local var_11_0
	local var_11_1
	local var_11_2 = lua_rogue_event.configDict[arg_11_1]

	if var_11_2 then
		if var_11_2.type == V1a6_CachotEnum.EventType.CharacterCure then
			local var_11_3 = lua_rogue_event_life.configDict[var_11_2.eventId]
			local var_11_4 = string.splitToNumber(var_11_3.num, "#")
			local var_11_5 = var_11_4[1]
			local var_11_6 = var_11_4[2] or 1
			local var_11_7 = var_11_3.lifeAdd / 10

			var_11_0 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.CureEvent][var_11_5]

			if var_11_5 == 1 then
				var_11_1 = GameUtil.getSubPlaceholderLuaLang(var_11_0.desc, {
					var_11_6,
					var_11_7
				})
			elseif var_11_5 == 2 then
				var_11_1 = GameUtil.getSubPlaceholderLuaLang(var_11_0.desc, {
					var_11_6,
					var_11_7
				})
			elseif var_11_5 == 3 then
				var_11_1 = GameUtil.getSubPlaceholderLuaLang(var_11_0.desc, {
					var_11_7
				})
			end
		elseif var_11_2.type == V1a6_CachotEnum.EventType.CharacterRebirth then
			local var_11_8 = lua_rogue_event_revive.configDict[var_11_2.eventId]
			local var_11_9 = string.splitToNumber(var_11_8.num, "#")[1]

			var_11_0 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.ReviveEvent][var_11_9]
		elseif var_11_2.type == V1a6_CachotEnum.EventType.CharacterGet then
			var_11_0 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.CharacterGet][1]
		elseif var_11_2.type == V1a6_CachotEnum.EventType.HeroPosUpgrade then
			var_11_0 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.HeroPosUpgrade][1]
		end
	end

	return var_11_0, var_11_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
