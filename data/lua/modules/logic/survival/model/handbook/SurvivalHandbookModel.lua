module("modules.logic.survival.model.handbook.SurvivalHandbookModel", package.seeall)

local var_0_0 = class("SurvivalHandbookModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.handbookMoDic = nil
	arg_1_0.subTypeMoDic = {}
	arg_1_0.resultMos = {}
	arg_1_0.progressDic = {}
	arg_1_0.eventTypes = {}

	for iter_1_0, iter_1_1 in pairs(SurvivalEnum.HandBookEventSubType) do
		table.insert(arg_1_0.eventTypes, iter_1_1)
	end

	arg_1_0.amplifierTypes = {}

	for iter_1_2, iter_1_3 in pairs(SurvivalEnum.HandBookAmplifierSubType) do
		table.insert(arg_1_0.amplifierTypes, iter_1_3)
	end

	arg_1_0.npcTypes = {}

	for iter_1_4, iter_1_5 in pairs(SurvivalEnum.HandBookNpcSubType) do
		table.insert(arg_1_0.npcTypes, iter_1_5)
	end

	local var_1_0 = SurvivalEnum.HandBookAmplifierSubType
	local var_1_1 = SurvivalEnum.HandBookNpcSubType

	arg_1_0.handbookTypeCfg = {
		[SurvivalEnum.HandBookType.Amplifier] = {
			[var_1_0.Common] = {
				tabImage = "99_1",
				tabTitle = "p_survivalhandbookview_txt_tab_Common"
			},
			[var_1_0.ElectricEnergy] = {
				tabImage = "101_1",
				tabTitle = "p_survivalhandbookview_txt_tab_ElectricEnergy"
			},
			[var_1_0.Revelation] = {
				tabImage = "102_1",
				tabTitle = "p_survivalhandbookview_txt_tab_Revelation"
			},
			[var_1_0.Bloom] = {
				tabImage = "103_1",
				tabTitle = "p_survivalhandbookview_txt_tab_Bloom"
			},
			[var_1_0.ExtraActions] = {
				tabImage = "104_1",
				tabTitle = "p_survivalhandbookview_txt_tab_ExtraActions"
			},
			[var_1_0.Ceremony] = {
				tabImage = "105_1",
				tabTitle = "p_survivalhandbookview_txt_tab_Ceremony"
			},
			[var_1_0.StateAbnormal] = {
				tabImage = "106_1",
				tabTitle = "Survival_HandBookTitle_StateAbnormal"
			},
			RedDot = RedDotEnum.DotNode.SurvivalHandbookAmplifier
		},
		[SurvivalEnum.HandBookType.Npc] = {
			[var_1_1.People] = {
				tabImage = "survival_handbook_npctabicon4",
				tabTitle = "p_survivalhandbookview_txt_tab_People"
			},
			[var_1_1.Laplace] = {
				tabImage = "survival_handbook_npctabicon2",
				tabTitle = "p_survivalhandbookview_txt_tab_Laplace"
			},
			[var_1_1.Foundation] = {
				tabImage = "survival_handbook_npctabicon1",
				tabTitle = "p_survivalhandbookview_txt_tab_Foundation"
			},
			[var_1_1.Zeno] = {
				tabImage = "survival_handbook_npctabicon3",
				tabTitle = "p_survivalhandbookview_txt_tab_Zeno"
			},
			RedDot = RedDotEnum.DotNode.SurvivalHandbookNpc
		},
		[SurvivalEnum.HandBookType.Event] = {
			RedDot = RedDotEnum.DotNode.SurvivalHandbookEvent
		},
		[SurvivalEnum.HandBookType.Result] = {
			RedDot = RedDotEnum.DotNode.SurvivalHandbookResult
		}
	}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.handbookMoDic = nil
	arg_2_0.subTypeMoDic = {}
	arg_2_0.resultMos = {}
end

function var_0_0.setSurvivalHandbookBox(arg_3_0, arg_3_1)
	arg_3_0:_parseBasicData()

	arg_3_0.cellMoDic = {}

	local var_3_0 = {}

	if arg_3_1 then
		local var_3_1 = arg_3_1.handbook

		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			local var_3_2 = iter_3_1.id
			local var_3_3 = iter_3_1.isNew
			local var_3_4 = arg_3_0.handbookMoDic[var_3_2]

			if var_3_4 then
				local var_3_5 = true

				if var_3_4:getType() == SurvivalEnum.HandBookType.Amplifier and iter_3_1.param then
					local var_3_6 = lua_survival_equip.configDict[iter_3_1.param]

					if not var_3_4:isLinkGroup(var_3_6.group) then
						var_3_5 = false
					end
				end

				if var_3_5 then
					var_3_4:setCellCfgId(iter_3_1.param)
					var_3_4:setIsNew(var_3_3)

					var_3_0[var_3_2] = true

					if iter_3_1.param then
						arg_3_0.cellMoDic[iter_3_1.param] = var_3_4
					end
				end
			else
				logError("配置表没有id：" .. tostring(var_3_2) .. " i:" .. iter_3_0)
			end
		end
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0.handbookMoDic) do
		local var_3_7 = var_3_0[iter_3_3.id]

		iter_3_3:setIsUnlock(var_3_7)
	end

	tabletool.clear(arg_3_0.progressDic)

	for iter_3_4, iter_3_5 in pairs(arg_3_0.handbookMoDic) do
		local var_3_8 = iter_3_5:getType()

		if arg_3_0.progressDic[var_3_8] == nil then
			arg_3_0.progressDic[var_3_8] = {
				progress = 0,
				amount = 0
			}
		end

		arg_3_0.progressDic[var_3_8].amount = arg_3_0.progressDic[var_3_8].amount + 1

		if iter_3_5.isUnlock then
			arg_3_0.progressDic[var_3_8].progress = arg_3_0.progressDic[var_3_8].progress + 1
		end
	end

	arg_3_0:refreshRedDot()

	arg_3_0.inheritSelectDic = {}
	arg_3_0.inheritSelectList = {}
	arg_3_0.inheritSubTypeMoDic = {}

	for iter_3_6, iter_3_7 in pairs(var_3_0) do
		local var_3_9 = lua_survival_handbook.configDict[iter_3_6]

		if var_3_9.type == SurvivalEnum.HandBookType.Amplifier then
			local var_3_10 = arg_3_0.handbookMoDic[iter_3_6]
			local var_3_11 = var_3_10:getCellCfgId()
			local var_3_12 = var_3_9.subtype
			local var_3_13 = lua_survival_item.configDict[var_3_11].rare

			if var_3_10:getSurvivalBagItemMo():getExtendCost() > 0 then
				arg_3_0:insetInheritMo(var_3_11, var_3_12, var_3_10)
			end

			local var_3_14 = var_3_9.link
			local var_3_15 = SurvivalConfig.instance:getEquipByGroup(var_3_14)

			for iter_3_8, iter_3_9 in ipairs(var_3_15) do
				local var_3_16 = iter_3_9.id

				if var_3_16 ~= var_3_11 and var_3_13 >= lua_survival_item.configDict[var_3_16].rare then
					local var_3_17 = SurvivalHandbookMo.New()

					var_3_17:setData(var_3_10.cfg)
					var_3_17:setCellCfgId(var_3_16)
					var_3_17:setIsNew(var_3_10.isNew)
					var_3_17:setIsUnlock(var_3_10.isUnlock)

					if var_3_17:getSurvivalBagItemMo():getExtendCost() > 0 then
						arg_3_0:insetInheritMo(var_3_16, var_3_12, var_3_17)
					end
				end
			end
		end
	end

	arg_3_0.inheritSubTypeNpcList = {}

	for iter_3_10, iter_3_11 in pairs(arg_3_0.subTypeMoDic[SurvivalEnum.HandBookType.Npc]) do
		arg_3_0.inheritSubTypeNpcList[iter_3_10] = {}

		for iter_3_12, iter_3_13 in pairs(iter_3_11) do
			if iter_3_13.isUnlock and iter_3_13:getSurvivalBagItemMo():getExtendCost() > 0 then
				table.insert(arg_3_0.inheritSubTypeNpcList[iter_3_10], iter_3_13)
			end
		end
	end
end

function var_0_0.insetInheritMo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.inheritSelectDic[arg_4_1] = arg_4_3

	table.insert(arg_4_0.inheritSelectList, arg_4_3)

	if arg_4_0.inheritSubTypeMoDic[arg_4_2] == nil then
		arg_4_0.inheritSubTypeMoDic[arg_4_2] = {}
	end

	table.insert(arg_4_0.inheritSubTypeMoDic[arg_4_2], arg_4_3)
end

function var_0_0.getInheritMoById(arg_5_0, arg_5_1)
	if arg_5_0.inheritSelectDic[arg_5_1] then
		return arg_5_0.inheritSelectDic[arg_5_1]
	else
		return arg_5_0.cellMoDic[arg_5_1]
	end
end

function var_0_0.getInheritHandBookDatas(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	if arg_6_1 == SurvivalEnum.HandBookType.Amplifier then
		var_6_0 = arg_6_0.inheritSubTypeMoDic[arg_6_2]
	elseif arg_6_1 == SurvivalEnum.HandBookType.Npc then
		var_6_0 = arg_6_0.inheritSubTypeNpcList[arg_6_2]
	end

	return var_6_0 or {}
end

function var_0_0.getMoById(arg_7_0, arg_7_1)
	return arg_7_0.handbookMoDic[arg_7_1]
end

function var_0_0.getProgress(arg_8_0, arg_8_1)
	return arg_8_0.progressDic[arg_8_1]
end

function var_0_0.onReceiveSurvivalMarkNewHandbookReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_2.ids) do
			if arg_9_0.handbookMoDic[iter_9_1] then
				arg_9_0.handbookMoDic[iter_9_1]:setIsNew(false)
			else
				logError("??")
			end
		end
	end

	arg_9_0:refreshRedDot()
end

function var_0_0.refreshRedDot(arg_10_0)
	local var_10_0 = {}

	arg_10_0.eventRedDots = {}

	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.eventTypes) do
		local var_10_2 = arg_10_0:getRedDot(SurvivalEnum.HandBookType.Event, iter_10_1)

		arg_10_0.eventRedDots[iter_10_1] = var_10_2

		table.insert(var_10_0, {
			id = RedDotEnum.DotNode.SurvivalHandbookEvent,
			uid = iter_10_1,
			value = var_10_2
		})

		var_10_1 = var_10_1 + var_10_2
	end

	table.insert(var_10_0, {
		uid = -1,
		id = RedDotEnum.DotNode.SurvivalHandbookEvent,
		value = var_10_1
	})

	arg_10_0.amplifierRedDots = {}

	local var_10_3 = 0

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.amplifierTypes) do
		local var_10_4 = arg_10_0:getRedDot(SurvivalEnum.HandBookType.Amplifier, iter_10_3)

		arg_10_0.amplifierRedDots[iter_10_3] = var_10_4

		table.insert(var_10_0, {
			id = RedDotEnum.DotNode.SurvivalHandbookAmplifier,
			uid = iter_10_3,
			value = var_10_4
		})

		var_10_3 = var_10_3 + var_10_4
	end

	table.insert(var_10_0, {
		uid = -1,
		id = RedDotEnum.DotNode.SurvivalHandbookAmplifier,
		value = var_10_3
	})

	arg_10_0.npcRedDots = {}

	local var_10_5 = 0

	for iter_10_4, iter_10_5 in ipairs(arg_10_0.npcTypes) do
		local var_10_6 = arg_10_0:getRedDot(SurvivalEnum.HandBookType.Npc, iter_10_5)

		arg_10_0.npcRedDots[iter_10_5] = var_10_6

		table.insert(var_10_0, {
			id = RedDotEnum.DotNode.SurvivalHandbookNpc,
			uid = iter_10_5,
			value = var_10_6
		})

		var_10_5 = var_10_5 + var_10_6
	end

	table.insert(var_10_0, {
		uid = -1,
		id = RedDotEnum.DotNode.SurvivalHandbookNpc,
		value = var_10_5
	})

	local var_10_7 = arg_10_0:getRedDot(SurvivalEnum.HandBookType.Result)

	table.insert(var_10_0, {
		uid = -1,
		id = RedDotEnum.DotNode.SurvivalHandbookResult,
		value = var_10_7
	})
	RedDotRpc.instance:clientAddRedDotGroupList(var_10_0, true)
end

function var_0_0.getRedDot(arg_11_0, arg_11_1, arg_11_2)
	if #arg_11_0:getNewHandbook(arg_11_1, arg_11_2) > 0 then
		return 1
	end

	return 0
end

function var_0_0.getHandBookDatas(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.subTypeMoDic[arg_12_1] == nil or arg_12_0.subTypeMoDic[arg_12_1][arg_12_2] == nil then
		arg_12_0:_parseBasicData()
	end

	return arg_12_0.subTypeMoDic[arg_12_1][arg_12_2] or {}
end

function var_0_0.getHandBookUnlockDatas(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.subTypeMoDic[arg_13_1] == nil or arg_13_0.subTypeMoDic[arg_13_1][arg_13_2] == nil then
		arg_13_0:_parseBasicData()
	end

	local var_13_0 = arg_13_0.subTypeMoDic[arg_13_1][arg_13_2] or {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_1.isUnlock then
			table.insert(var_13_1, iter_13_1)
		end
	end

	return var_13_1
end

function var_0_0._parseBasicData(arg_14_0)
	if arg_14_0.handbookMoDic then
		return
	end

	arg_14_0.handbookMoDic = {}

	local var_14_0 = SurvivalHandbookConfig.instance:getConfigList()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = iter_14_1.type
		local var_14_2 = iter_14_1.subtype

		if arg_14_0.subTypeMoDic[var_14_1] == nil then
			arg_14_0.subTypeMoDic[var_14_1] = {}
		end

		local var_14_3 = SurvivalHandbookMo.New()

		var_14_3:setData(iter_14_1)

		arg_14_0.handbookMoDic[iter_14_1.id] = var_14_3

		if var_14_1 == SurvivalEnum.HandBookType.Result then
			table.insert(arg_14_0.resultMos, var_14_3)
		else
			if arg_14_0.subTypeMoDic[var_14_1][var_14_2] == nil then
				arg_14_0.subTypeMoDic[var_14_1][var_14_2] = {}
			end

			table.insert(arg_14_0.subTypeMoDic[var_14_1][var_14_2], var_14_3)
		end
	end
end

function var_0_0.getNewHandbook(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_0.handbookMoDic) do
		if iter_15_1:getType() == arg_15_1 and (arg_15_2 == nil or arg_15_2 == iter_15_1:getSubType()) and iter_15_1.isNew then
			table.insert(var_15_0, iter_15_0)
		end
	end

	return var_15_0
end

function var_0_0.getTabTitleBySubType(arg_16_0, arg_16_1, arg_16_2)
	return luaLang(arg_16_0.handbookTypeCfg[arg_16_1][arg_16_2].tabTitle)
end

function var_0_0.getTabImageBySubType(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0.handbookTypeCfg[arg_17_1][arg_17_2].tabImage
end

function var_0_0.handBookSortFuncById(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.isUnlock

	if var_18_0 ~= arg_18_1.isUnlock then
		return var_18_0
	end

	return arg_18_0.id < arg_18_1.id
end

function var_0_0.handBookSortFunc(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.isUnlock

	if var_19_0 ~= arg_19_1.isUnlock then
		return var_19_0
	end

	local var_19_1 = arg_19_0:getRare()
	local var_19_2 = arg_19_1:getRare()

	if var_19_1 ~= 0 and var_19_2 ~= 0 and var_19_1 ~= var_19_2 then
		return var_19_2 < var_19_1
	end

	return arg_19_0.id < arg_19_1.id
end

var_0_0.instance = var_0_0.New()

return var_0_0
