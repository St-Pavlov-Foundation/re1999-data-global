module("modules.logic.fight.view.FightEditorStateLogView", package.seeall)

local var_0_0 = class("FightEditorStateLogView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnListRoot = gohelper.findChild(arg_1_0.viewGO, "btnScrill/Viewport/Content")
	arg_1_0._btnModel = gohelper.findChild(arg_1_0._btnListRoot, "btnModel")
	arg_1_0._logText = gohelper.findChildText(arg_1_0.viewGO, "ScrollView/Viewport/Content/logText")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0.processStr(arg_6_0)
	local var_6_0 = "cardInfoList.-heroId: [-%d]+"
	local var_6_1, var_6_2 = string.find(arg_6_0, var_6_0)
	local var_6_3 = ""
	local var_6_4 = ""

	while var_6_1 do
		local var_6_5 = string.sub(arg_6_0, 1, var_6_1 - 1)
		local var_6_6 = string.sub(arg_6_0, var_6_1, -1)
		local var_6_7 = string.gsub(var_6_6, "(uid: ([-%d]+))", function(arg_7_0, arg_7_1)
			local var_7_0 = ""
			local var_7_1 = ""
			local var_7_2 = FightLocalDataMgr.instance:getEntityById(arg_7_1)

			if var_7_2 then
				var_7_1 = var_7_2:getEntityName()
			end

			return var_7_0 .. arg_7_0 .. " 卡牌持有者:" .. var_7_1
		end, 1)
		local var_6_8 = string.gsub(var_6_7, "(skillId: ([-%d]+))", function(arg_8_0, arg_8_1)
			local var_8_0 = ""
			local var_8_1 = tonumber(arg_8_1)
			local var_8_2 = lua_skill.configDict[var_8_1]

			return var_8_0 .. arg_8_0 .. " 技能名称:" .. (var_8_2 and var_8_2.name or "")
		end, 1)
		local var_6_9 = string.gsub(var_6_8, "(heroId: ([-%d]+))", function(arg_9_0, arg_9_1)
			return "" .. arg_9_0 .. " 模型id(肉鸽支援技能牌会用到):" .. arg_9_1
		end, 1)

		arg_6_0 = var_6_5 .. var_6_9

		local var_6_10

		var_6_1, var_6_10 = string.find(arg_6_0, var_6_0, var_6_1 + 1)
	end

	local var_6_11 = "modelId: %d+"
	local var_6_12, var_6_13 = string.find(arg_6_0, var_6_11)

	while var_6_12 do
		local var_6_14 = string.sub(arg_6_0, 1, var_6_12 - 1)
		local var_6_15 = string.sub(arg_6_0, var_6_12, -1)
		local var_6_16 = string.gsub(var_6_15, "(modelId: (%d+))", function(arg_10_0, arg_10_1)
			local var_10_0 = tonumber(arg_10_1)
			local var_10_1 = lua_character.configDict[var_10_0] or lua_monster.configDict[var_10_0]
			local var_10_2 = var_10_1 and var_10_1.name or ""

			return arg_10_0 .. " 角色名称:" .. var_10_2
		end, 1)

		arg_6_0 = var_6_14 .. var_6_16

		local var_6_17

		var_6_12, var_6_17 = string.find(arg_6_0, var_6_11, var_6_12 + 1)
	end

	local var_6_18 = "skin: [-%d]+"
	local var_6_19, var_6_20 = string.find(arg_6_0, var_6_18)

	while var_6_19 do
		local var_6_21 = string.sub(arg_6_0, 1, var_6_19 - 1)
		local var_6_22 = string.sub(arg_6_0, var_6_19, -1)
		local var_6_23 = string.gsub(var_6_22, "(skin: ([-%d]+))", function(arg_11_0, arg_11_1)
			return arg_11_0 .. " 皮肤id:" .. arg_11_1
		end, 1)

		arg_6_0 = var_6_21 .. var_6_23

		local var_6_24

		var_6_19, var_6_24 = string.find(arg_6_0, var_6_18, var_6_19 + 1)
	end

	local var_6_25 = "actType: [-%d]+"
	local var_6_26, var_6_27 = string.find(arg_6_0, var_6_25)

	while var_6_26 do
		local var_6_28 = string.sub(arg_6_0, 1, var_6_26 - 1)
		local var_6_29 = string.sub(arg_6_0, var_6_26, -1)
		local var_6_30 = string.gsub(var_6_29, "(actType: ([-%d]+))", function(arg_12_0, arg_12_1)
			if arg_12_1 == "1" then
				return arg_12_0 .. " 步骤类型:技能"
			elseif arg_12_1 == "2" then
				return arg_12_0 .. " 步骤类型:buff"
			elseif arg_12_1 == "3" then
				return arg_12_0 .. " 步骤类型:效果"
			elseif arg_12_1 == "4" then
				return arg_12_0 .. " 步骤类型:换人"
			elseif arg_12_1 == "5" then
				return arg_12_0 .. " 步骤类型:换波次时机（供客户端使用）"
			end

			return arg_12_0
		end, 1)

		arg_6_0 = var_6_28 .. var_6_30

		local var_6_31

		var_6_26, var_6_31 = string.find(arg_6_0, var_6_25, var_6_26 + 1)
	end

	local var_6_32 = "步骤类型:技能"
	local var_6_33, var_6_34 = string.find(arg_6_0, var_6_32)

	while var_6_33 do
		local var_6_35 = string.sub(arg_6_0, 1, var_6_33 - 1)
		local var_6_36 = string.sub(arg_6_0, var_6_33, -1)
		local var_6_37
		local var_6_38 = string.gsub(var_6_36, "(fromId: ([-%d]+))", function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_1
			local var_13_1 = ""

			if arg_13_1 == FightEntityScene.MySideId then
				var_13_1 = "维尔汀"
			elseif arg_13_1 == FightEntityScene.EnemySideId then
				var_13_1 = "重塑之手"
			else
				var_6_37 = var_13_0

				local var_13_2 = FightLocalDataMgr.instance:getEntityById(var_13_0)

				if var_13_2 then
					var_13_1 = var_13_2:getEntityName()
				end
			end

			return arg_13_0 .. " 技能发起者:" .. var_13_1
		end, 1)
		local var_6_39 = string.gsub(var_6_38, "(toId: ([-%d]+))", function(arg_14_0, arg_14_1)
			local var_14_0 = arg_14_1
			local var_14_1 = ""

			if arg_14_1 == FightEntityScene.MySideId then
				var_14_1 = "维尔汀"
			elseif arg_14_1 == FightEntityScene.EnemySideId then
				var_14_1 = "重塑之手"
			else
				local var_14_2 = FightLocalDataMgr.instance:getEntityById(var_14_0)

				if var_14_2 then
					var_14_1 = var_14_2:getEntityName()
				end
			end

			return arg_14_0 .. " 技能承受者:" .. var_14_1
		end, 1)
		local var_6_40 = string.gsub(var_6_39, "(actId: ([-%d]+))", function(arg_15_0, arg_15_1)
			local var_15_0 = tonumber(arg_15_1)
			local var_15_1 = lua_skill.configDict[var_15_0]
			local var_15_2 = var_15_1 and var_15_1.name or ""

			return arg_15_0 .. " 技能id:" .. arg_15_1 .. " 技能名字:" .. var_15_2 .. " timeline : " .. FightLogHelper.getTimelineName(var_6_37, var_15_0)
		end, 1)

		arg_6_0 = var_6_35 .. var_6_40

		local var_6_41

		var_6_33, var_6_41 = string.find(arg_6_0, var_6_32, var_6_33 + 1)
	end

	local var_6_42 = "targetId: [-%d]+"
	local var_6_43, var_6_44 = string.find(arg_6_0, var_6_42)

	while var_6_43 do
		local var_6_45 = string.sub(arg_6_0, 1, var_6_43 - 1)
		local var_6_46 = string.sub(arg_6_0, var_6_43, -1)
		local var_6_47 = string.gsub(var_6_46, "(targetId: ([-%d]+))", function(arg_16_0, arg_16_1)
			local var_16_0 = arg_16_1
			local var_16_1 = ""

			if arg_16_1 == FightEntityScene.MySideId then
				var_16_1 = "维尔汀"
			elseif arg_16_1 == FightEntityScene.EnemySideId then
				var_16_1 = "重塑之手"
			else
				local var_16_2 = FightLocalDataMgr.instance:getEntityById(var_16_0)

				if var_16_2 then
					var_16_1 = var_16_2:getEntityName()
				end
			end

			return arg_16_0 .. " 作用对象:" .. var_16_1
		end, 1)

		arg_6_0 = var_6_45 .. var_6_47

		local var_6_48

		var_6_43, var_6_48 = string.find(arg_6_0, var_6_42, var_6_43 + 1)
	end

	local var_6_49 = "buffId: %d+"
	local var_6_50, var_6_51 = string.find(arg_6_0, var_6_49)

	while var_6_50 do
		local var_6_52 = string.sub(arg_6_0, 1, var_6_50 - 1)
		local var_6_53 = string.sub(arg_6_0, var_6_50, -1)
		local var_6_54 = string.gsub(var_6_53, "(buffId: ([-%d]+))", function(arg_17_0, arg_17_1)
			local var_17_0 = tonumber(arg_17_1)
			local var_17_1 = lua_skill_buff.configDict[var_17_0]
			local var_17_2 = var_17_1 and var_17_1.name or ""

			return arg_17_0 .. " buff名称:" .. var_17_2
		end, 1)

		arg_6_0 = var_6_52 .. var_6_54

		local var_6_55

		var_6_50, var_6_55 = string.find(arg_6_0, var_6_49, var_6_50 + 1)
	end

	arg_6_0 = var_0_0.typeExplain(arg_6_0)

	return arg_6_0
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0._type2FuncName = {}

	local var_18_0 = FightDataHelper.protoCacheMgr.roundProtoList

	arg_18_0._strList = {}

	arg_18_0:addLog("入场数据")
	arg_18_0:addLog(FightHelper.logStr(FightDataHelper.roundMgr.enterData))

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_1 = var_18_0[iter_18_0 - 1]

		if var_18_1 then
			arg_18_0:addLog("回合" .. var_18_1.curRound)
		end

		arg_18_0:addLog(tostring(iter_18_1))
	end

	local var_18_2 = ""

	for iter_18_2, iter_18_3 in ipairs(arg_18_0._strList) do
		var_18_2 = var_18_2 .. iter_18_3 .. "\n"
	end

	arg_18_0._logText.text = var_0_0.processStr(var_18_2)

	local var_18_3 = {
		{
			name = "复制"
		}
	}

	arg_18_0:com_createObjList(arg_18_0._onBtnItemShow, var_18_3, arg_18_0._btnListRoot, arg_18_0._btnModel)
end

function var_0_0._onBtnItemShow(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	gohelper.findChildText(arg_19_1, "text").text = arg_19_2.name

	local var_19_0 = gohelper.findChildClick(arg_19_1, "btn")

	arg_19_0:addClickCb(var_19_0, arg_19_0["_onBtnClick" .. arg_19_3], arg_19_0)
end

function var_0_0._onBtnClick1(arg_20_0)
	ZProj.UGUIHelper.CopyText(arg_20_0._logText.text)
end

function var_0_0.addLog(arg_21_0, arg_21_1)
	table.insert(arg_21_0._strList, arg_21_1)
end

function var_0_0.onClose(arg_22_0)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	return
end

function var_0_0.typeExplain(arg_24_0)
	local var_24_0 = "Assets/ZProj/Scripts/Lua/modules/logic/fight/config/FightEnum.lua"
	local var_24_1 = io.open(var_24_0, "r")
	local var_24_2 = var_24_1:read("*a")

	var_24_1:close()

	local var_24_3, var_24_4 = string.find(var_24_2, "FightEnum.EffectType = {.-}")
	local var_24_5 = string.sub(var_24_2, var_24_3, var_24_4)
	local var_24_6 = string.gsub(var_24_5, "FightEnum.EffectType =", "")
	local var_24_7 = {}

	for iter_24_0, iter_24_1 in string.gmatch(var_24_6, "=.-([-%d]+).-%-%-(.-)\n") do
		var_24_7[iter_24_0] = iter_24_1
	end

	local var_24_8 = "effectType: [-%d]+"
	local var_24_9, var_24_10 = string.find(arg_24_0, var_24_8)

	while var_24_9 do
		local var_24_11 = string.sub(arg_24_0, 1, var_24_9 - 1)
		local var_24_12 = string.sub(arg_24_0, var_24_9, -1)
		local var_24_13 = string.gsub(var_24_12, "(effectType: ([-%d]+))", function(arg_25_0, arg_25_1)
			return arg_25_0 .. " " .. (var_24_7[arg_25_1] or "")
		end, 1)

		arg_24_0 = var_24_11 .. var_24_13

		local var_24_14

		var_24_9, var_24_14 = string.find(arg_24_0, var_24_8, var_24_9 + 1)
	end

	return arg_24_0
end

return var_0_0
