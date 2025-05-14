module("modules.logic.rouge.controller.RougeTesting", package.seeall)

local var_0_0 = _G.class("TestingBase")

function var_0_0.build_test(arg_1_0)
	return
end

function var_0_0.link(arg_2_0, arg_2_1)
	arg_2_0._obj = arg_2_1
end

local var_0_1 = _G.class("SRougeTesting", var_0_0)

function var_0_1.ctor(arg_3_0)
	arg_3_0._season2RougeInfo = {}
	arg_3_0._season2RougeOutsideInfo = {}
end

function var_0_1._make_RougeBattleHero(arg_4_0, arg_4_1)
	return {
		supportHeroSkill = 0,
		index = arg_4_1 or math.random(1, 4),
		heroId = math.random(3003, 3020),
		equipUid = math.random(1501, 1510),
		supportHeroId = math.random(3022, 3060)
	}
end

function var_0_1._make_RougeHeroLife(arg_5_0, arg_5_1)
	return {
		heroId = arg_5_1 or math.random(3003, 3020),
		life = math.random(1, 100) * 1000
	}
end

function var_0_1._make_RougeTeamInfo(arg_6_0)
	local var_6_0 = {
		battleHeroList = {},
		heroLifeList = {}
	}

	function var_6_0.HasField(arg_7_0, arg_7_1)
		return var_6_0[arg_7_1] ~= nil
	end

	local var_6_1 = 4

	for iter_6_0 = 1, var_6_1 do
		local var_6_2 = arg_6_0:_make_RougeBattleHero(iter_6_0)

		var_6_2.supportHeroId = math.random(1, 1000) % 2 == 0 and var_6_2.supportHeroId or 0

		table.insert(var_6_0.battleHeroList, var_6_2)
	end

	for iter_6_1 = 1, var_6_1 do
		local var_6_3 = var_6_0.battleHeroList[iter_6_1].heroId
		local var_6_4 = arg_6_0:_make_RougeHeroLife(var_6_3)

		table.insert(var_6_0.heroLifeList, var_6_4)
	end

	return var_6_0
end

function var_0_1._make_RougeBagPos(arg_8_0, arg_8_1, arg_8_2)
	return {
		row = arg_8_1 or 0,
		col = arg_8_2 or 0
	}
end

local var_0_2 = 1

function var_0_1._make_RougeItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = lua_item.configList
	local var_9_1 = math.random(1, #var_9_0)
	local var_9_2 = {
		id = arg_9_1 or var_0_2,
		itemId = arg_9_2 or var_9_0[var_9_1].id,
		holdItems = {},
		holdIds = {}
	}

	var_0_2 = var_0_2 + 1

	local var_9_3 = 0
	local var_9_4 = {}

	for iter_9_0 = 1, var_9_3 do
		local var_9_5 = math.random(1, #var_9_4)

		var_9_2.holdItems[iter_9_0] = var_9_4[var_9_5]
	end

	local var_9_6 = 0

	for iter_9_1 = 1, var_9_6 do
		var_9_2.holdItems[iter_9_1] = var_9_6
	end

	return var_9_2
end

function var_0_1._make_RougeItemLayout(arg_10_0)
	local var_10_0 = 1
	local var_10_1 = 1

	if RougeEnum.MaxCollectionSlotSize then
		var_10_0 = RougeEnum.MaxCollectionSlotSize.x
		var_10_1 = RougeEnum.MaxCollectionSlotSize.y
	end

	local var_10_2 = math.random(1, var_10_0)
	local var_10_3 = math.random(1, var_10_1)
	local var_10_4 = {
		pos = arg_10_0:_make_RougeBagPos(var_10_2, var_10_3),
		rotation = math.random(0, 3),
		item = arg_10_0:_make_RougeItem(),
		baseEffects = {},
		extraEffects = {}
	}
	local var_10_5 = 0

	for iter_10_0 = 1, var_10_5 do
		var_10_4.baseEffects[iter_10_0] = 1
	end

	local var_10_6 = 0

	for iter_10_1 = 1, var_10_6 do
		var_10_4.extraEffects[iter_10_1] = 1
	end

	return var_10_4
end

function var_0_1._make_RougeBag(arg_11_0)
	local var_11_0 = {
		layouts = {}
	}
	local var_11_1 = 0

	for iter_11_0 = 1, var_11_1 do
		var_11_0.layouts[iter_11_0] = arg_11_0:_make_RougeItemLayout()
	end

	return var_11_0
end

function var_0_1._make_RougeTalent(arg_12_0, arg_12_1, arg_12_2)
	return {
		id = arg_12_1,
		isActive = arg_12_2 or false
	}
end

function var_0_1._make_RougeTalentTree(arg_13_0)
	local var_13_0 = {
		rougeTalent = {}
	}
	local var_13_1 = lua_rouge_talent.configList

	for iter_13_0, iter_13_1 in ipairs(var_13_1 or {}) do
		local var_13_2 = iter_13_1.id
		local var_13_3 = math.random(0, 9999) % 2 == 0

		var_13_0.rougeTalent[iter_13_0] = arg_13_0:_make_RougeTalent(var_13_2, var_13_3)
	end

	return var_13_0
end

function var_0_1._make_RougeWarehouse(arg_14_0)
	local var_14_0 = {
		items = {}
	}
	local var_14_1 = 0

	for iter_14_0 = 1, var_14_1 do
		var_14_0.items[iter_14_0] = arg_14_0:_make_RougeItem()
	end

	return var_14_0
end

function var_0_1._make_NodeInfo(arg_15_0, arg_15_1, arg_15_2)
	return {
		nodeId = 0,
		status = 0,
		eventId = 0,
		eventData = "",
		layer = arg_15_1 or 0,
		stage = arg_15_2 or 0,
		lastNodeList = {},
		nextNodeList = {}
	}
end

function var_0_1._make_RougeMapInfo(arg_16_0)
	local var_16_0 = {
		curNode = 0,
		middleLayerId = 0,
		curStage = 0,
		layerId = 0,
		mapType = RougeMapEnum.MapType.Normal,
		nodeInfo = {}
	}
	local var_16_1 = var_16_0.layerId
	local var_16_2 = var_16_0.curStage

	for iter_16_0 = 1, 5 do
		local var_16_3 = arg_16_0:_make_NodeInfo(var_16_1, var_16_2)

		table.insert(var_16_0.nodeInfo, var_16_3)
	end

	return var_16_0
end

function var_0_1._make_RougeLastReward(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = addGlobalModule("modules.configs.rouge.lua_rouge_collection_editor", "lua_rouge_collection_editor")
	local var_17_1 = #var_17_0
	local var_17_2 = {
		param = "",
		id = arg_17_2 or 0
	}
	local var_17_3 = (lua_rouge_last_reward.configDict or {})[arg_17_1]
	local var_17_4 = var_17_3 and var_17_3[arg_17_2] or nil

	if var_17_4 then
		local var_17_5 = var_17_4.type

		if var_17_5 == "drop" then
			var_17_2.param = ""
		elseif var_17_5 == "dropGroup" then
			local var_17_6 = var_17_0[math.random(1, var_17_1)]

			var_17_2.param = tostring(var_17_6.id)
		end
	end

	return var_17_2
end

function var_0_1._make_RougeLastReward_lastReward(arg_18_0, arg_18_1)
	local var_18_0 = lua_rouge_last_reward and lua_rouge_last_reward.configList or {}
	local var_18_1 = 4

	for iter_18_0 = 1, var_18_1 do
		local var_18_2 = var_18_0[math.random(1, var_18_1)]
		local var_18_3 = var_18_2.id
		local var_18_4 = var_18_2.season

		table.insert(arg_18_1, arg_18_0:_make_RougeLastReward(var_18_4, var_18_3))
	end
end

function var_0_1._make_RougeInfo(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = {
		selectRewardNum = 0,
		state = 0,
		endId = 0,
		season = arg_19_1,
		version = arg_19_2 or {},
		difficulty = arg_19_3 or 1,
		lastReward = {},
		style = arg_19_4 or 0,
		teamLevel = math.random(1, 100),
		teamExp = math.random(1, 100),
		teamSize = math.random(1, 4),
		coin = math.random(0, 100),
		talentPoint = math.random(1, 100),
		teamInfo = arg_19_0:_make_RougeTeamInfo(),
		bag = arg_19_0:_make_RougeBag(),
		warehouse = arg_19_0:_make_RougeWarehouse(),
		talentTree = arg_19_0:_make_RougeTalentTree(),
		effectInfo = {}
	}

	arg_19_0:_make_RougeLastReward_lastReward(var_19_0.lastReward)

	function var_19_0.HasField(arg_20_0, arg_20_1)
		return var_19_0[arg_20_1] ~= nil
	end

	if #var_19_0.lastReward > 0 then
		var_19_0.selectRewardNum = math.random(1, #var_19_0.lastReward)
	end

	return var_19_0
end

function var_0_1._make_RougeOutsideBonusStageNO(arg_21_0, arg_21_1, ...)
	return {
		stage = arg_21_1 or 1,
		bonusIds = {
			...
		}
	}
end

function var_0_1._make_RougeOutsideBonusNO(arg_22_0)
	return {
		bonusStages = {}
	}
end

function var_0_1._make_RougeReviewInfo(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	return {
		portrait = 0,
		playerName = "123456",
		season = arg_23_1 or 1,
		playerLevel = math.random(1, 999),
		finishTime = os.time(),
		difficulty = arg_23_2 or math.random(1, 5),
		style = arg_23_3 or math.random(1, 5),
		teamLevel = math.random(1, 10),
		collectionNum = math.random(1, 10)
	}
end

function var_0_1._make_RougeOutsideInfo(arg_24_0, arg_24_1)
	local var_24_0 = RougeConfig1.instance:getDifficultyCOListByVersions({
		101
	})

	return {
		isGeniusNewStage = false,
		season = arg_24_1,
		geniusPoint = math.random(0, 100),
		geniusIds = {
			1,
			2,
			3
		},
		point = math.random(0, 100),
		bonus = arg_24_0:_make_RougeOutsideBonusNO(),
		review = {},
		gameRecordInfo = {
			lastGameTime = 0,
			maxDifficulty = math.random(0, #var_24_0),
			passLayerId = {},
			passEventId = {},
			passEndId = {},
			passEntrustId = {}
		}
	}
end

function var_0_1.handleGetRougeOutsideInfo(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1.season

	if not arg_25_0:_getRougeOutsideInfo(var_25_0) then
		arg_25_0._season2RougeOutsideInfo[var_25_0] = arg_25_0:_make_RougeOutsideInfo(var_25_0)
	end

	rawset(arg_25_2, "rougeInfo", arg_25_0:_getRougeOutsideInfo(var_25_0))
end

function var_0_1.handleGetRougeInfo(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1.season

	if not arg_26_0:_getRougeInfo(var_26_0) then
		arg_26_0._season2RougeInfo[var_26_0] = arg_26_0:_make_RougeInfo(var_26_0)
	end

	rawset(arg_26_2, "rougeInfo", arg_26_0:_getRougeInfo(var_26_0))
end

function var_0_1.handleEnterRougeSelectDifficulty(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1.season
	local var_27_1 = arg_27_0:_getRougeInfo(var_27_0)

	assert(var_27_1, "handleEnterRougeSelectDifficulty rougeInfo == nil")

	var_27_1.season = arg_27_1.season
	var_27_1.version = arg_27_1.version
	var_27_1.difficulty = arg_27_1.difficulty
	var_27_1.state = RougeEnum.State.Difficulty

	rawset(arg_27_2, "season", var_27_0)
	rawset(arg_27_2, "rougeInfo", arg_27_0:_getRougeInfo(var_27_0))
end

function var_0_1.handleEnterRougeSelectReward(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_1.season
	local var_28_1 = arg_28_0:_getRougeInfo(var_28_0)

	assert(var_28_1, "handleEnterRougeSelectReward rougeInfo == nil")

	var_28_1.selectRewardId = arg_28_1.rewardId
	var_28_1.state = RougeEnum.State.LastReward

	rawset(arg_28_2, "season", var_28_0)
	rawset(arg_28_2, "rougeInfo", arg_28_0:_getRougeInfo(var_28_0))
end

function var_0_1.handleEnterRougeSelectStyle(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1.season
	local var_29_1 = arg_29_0:_getRougeInfo(var_29_0)

	assert(var_29_1, "handleEnterRougeSelectStyle rougeInfo == nil")

	var_29_1.style = arg_29_1.style

	rawset(arg_29_2, "season", var_29_0)
	rawset(arg_29_2, "rougeInfo", arg_29_0:_getRougeInfo(var_29_0))
end

function var_0_1._getRougeInfo(arg_30_0, arg_30_1)
	return arg_30_0._season2RougeInfo[arg_30_1]
end

function var_0_1._getRougeOutsideInfo(arg_31_0, arg_31_1)
	return arg_31_0._season2RougeOutsideInfo[arg_31_1]
end

local var_0_3 = _G.class("CRougeTesting", var_0_0)

function var_0_3.ctor(arg_32_0)
	arg_32_0._cCfg = RougeConfig1
	arg_32_0._cRpc = RougeRpc
	arg_32_0._cCtrl = RougeController
	arg_32_0._cModel = RougeModel
	arg_32_0._cOutsideRpc = RougeOutsideRpc
	arg_32_0._cOutsideCtrl = RougeOutsideController
	arg_32_0._cOutsideModel = RougeOutsideModel
	arg_32_0._cOpenModel = OpenModel
end

function var_0_3.build_test(arg_33_0)
	local var_33_0 = 0
	local var_33_1 = arg_33_0._cCfg.instance
	local var_33_2 = arg_33_0._cRpc.instance
	local var_33_3 = arg_33_0._cCtrl.instance
	local var_33_4 = arg_33_0._cModel.instance
	local var_33_5 = arg_33_0._cOutsideRpc.instance

	function arg_33_0._cOutsideRpc.sendGetRougeOutsideInfoRequest(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
		local var_34_0 = RougeOutsideModule_pb.GetRougeOutsideInfoRequest()

		var_34_0.season = arg_34_1

		local var_34_1 = RougeOutsideModule_pb.GetRougeOutsideInfoReply()

		arg_33_0._obj:handleGetRougeOutsideInfo(var_34_0, var_34_1)
		var_33_5:onReceiveGetRougeOutsideInfoReply(var_33_0, var_34_1)

		local var_34_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_34_0.__cname)

		if arg_34_2 then
			if arg_34_3 then
				arg_34_2(arg_34_3, var_34_2, var_33_0)
			else
				arg_34_2(var_34_2, var_33_0)
			end
		end
	end

	arg_33_0._cOutsideRpc.sendGetRougeOutSideInfoRequest = arg_33_0._cOutsideRpc.sendGetRougeOutsideInfoRequest

	function arg_33_0._cRpc.sendGetRougeInfoRequest(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
		local var_35_0 = RougeModule_pb.GetRougeInfoRequest()

		var_35_0.season = arg_35_1

		local var_35_1 = RougeModule_pb.GetRougeInfoReply()

		arg_33_0._obj:handleGetRougeInfo(var_35_0, var_35_1)
		var_33_2:onReceiveGetRougeInfoReply(var_33_0, var_35_1)

		local var_35_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_35_0.__cname)

		if arg_35_2 then
			if arg_35_3 then
				arg_35_2(arg_35_3, var_35_2, var_33_0)
			else
				arg_35_2(var_35_2, var_33_0)
			end
		end
	end

	function arg_33_0._cRpc.sendEnterRougeSelectDifficultyRequest(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6)
		local var_36_0 = RougeModule_pb.EnterRougeSelectDifficultyRequest()

		var_36_0.season = arg_36_1

		for iter_36_0, iter_36_1 in ipairs(arg_36_2) do
			var_36_0.version:append(iter_36_1)
		end

		var_36_0.difficulty = arg_36_3

		local var_36_1 = RougeModule_pb.EnterRougeSelectDifficultyReply()

		arg_33_0._obj:handleEnterRougeSelectDifficulty(var_36_0, var_36_1)
		var_33_2:onReceiveEnterRougeSelectDifficultyReply(var_33_0, var_36_1)

		local var_36_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_36_0.__cname)

		if arg_36_5 then
			if arg_36_6 then
				arg_36_5(arg_36_6, var_36_2, var_33_0)
			else
				arg_36_5(var_36_2, var_33_0)
			end
		end
	end

	function arg_33_0._cRpc.sendEnterRougeSelectRewardRequest(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
		local var_37_0 = RougeModule_pb.EnterRougeSelectRewardRequest()

		var_37_0.season = arg_37_1

		for iter_37_0, iter_37_1 in ipairs(arg_37_2) do
			var_37_0.rewardId:append(iter_37_1)
		end

		local var_37_1 = RougeModule_pb.EnterRougeSelectRewardReply()

		arg_33_0._obj:handleEnterRougeSelectReward(var_37_0, var_37_1)
		var_33_2:onReceiveEnterRougeSelectRewardReply(var_33_0, var_37_1)

		local var_37_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_37_0.__cname)

		if arg_37_3 then
			if arg_37_4 then
				arg_37_3(arg_37_4, var_37_2, var_33_0)
			else
				arg_37_3(var_37_2, var_33_0)
			end
		end
	end

	function arg_33_0._cRpc.sendEnterRougeSelectStyleRequest(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
		local var_38_0 = RougeModule_pb.EnterRougeSelectStyleRequest()

		var_38_0.season = arg_38_1
		var_38_0.style = arg_38_2

		local var_38_1 = RougeModule_pb.EnterRougeSelectStyleReply()

		arg_33_0._obj:handleEnterRougeSelectStyle(var_38_0, var_38_1)
		var_33_2:onReceiveEnterRougeSelectStyleReply(var_33_0, var_38_1)

		local var_38_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_38_0.__cname)

		if arg_38_3 then
			if arg_38_4 then
				arg_38_3(arg_38_4, var_38_2, var_33_0)
			else
				arg_38_3(var_38_2, var_33_0)
			end
		end
	end

	function arg_33_0._cOpenModel.isFunctionUnlock()
		return true
	end

	function arg_33_0._cOutsideModel.isUnlock()
		return true
	end

	function arg_33_0._cOutsideCtrl.isOpen()
		return true
	end

	local var_33_6 = false
	local var_33_7 = false
	local var_33_8 = false

	function arg_33_0._cModel.isContinueLast()
		return var_33_8 or var_33_7 or false
	end

	if var_33_6 then
		function arg_33_0._cModel.isContinueLast()
			return false
		end

		function arg_33_0._cOutsideModel.isOpenedDifficulty()
			return true
		end

		function arg_33_0._cOutsideModel.isPassedDifficulty()
			return true
		end

		function arg_33_0._cModel.getDifficulty(arg_46_0)
			return arg_46_0._rougeInfo and arg_46_0._rougeInfo.difficulty or nil
		end
	end

	if var_33_8 then
		function arg_33_0._cModel.isFinishedLastReward()
			return true
		end

		function arg_33_0._cModel.getDifficulty()
			return 1
		end

		function arg_33_0._cOutsideModel.isOpenedStyle(arg_49_0, arg_49_1)
			return math.random(1, 99999) % 2 == 0
		end
	end

	if var_33_7 then
		function arg_33_0._cModel.isCanSelectRewards()
			return true
		end

		function arg_33_0._cModel.isFinishedLastReward()
			return false
		end

		function arg_33_0._cModel.isFinishedDifficulty()
			return true
		end
	end
end

function var_0_3.build_test_outside(arg_53_0)
	local var_53_0 = 0
	local var_53_1 = arg_53_0._cCfg.instance
	local var_53_2 = arg_53_0._cOutsideRpc.instance
	local var_53_3 = arg_53_0._cOutsideCtrl.instance
	local var_53_4 = arg_53_0._cOutsideModel.instance

	function arg_53_0._cOutsideRpc.sendGetRougeOutsideInfoRequest(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
		local var_54_0 = RougeOutsideModule_pb.GetRougeOutsideInfoRequest()

		var_54_0.season = arg_54_1

		local var_54_1 = RougeOutsideModule_pb.GetRougeOutsideInfoReply()

		arg_53_0._obj:handleGetRougeOutsideInfo(var_54_0, var_54_1)
		var_53_2:onReceiveGetRougeOutsideInfoReply(var_53_0, var_54_1)

		local var_54_2 = LuaSocketMgr.instance:getCmdByPbStructName(var_54_0.__cname)

		if arg_54_2 then
			if arg_54_3 then
				arg_54_2(arg_54_3, var_54_2, var_53_0)
			else
				arg_54_2(var_54_2, var_53_0)
			end
		end
	end

	arg_53_0._cOutsideRpc.sendGetRougeOutSideInfoRequest = arg_53_0._cOutsideRpc.sendGetRougeOutsideInfoRequest

	local var_53_5 = true

	if var_53_5 then
		local var_53_6 = {}

		function arg_53_0._cOutsideModel.getIsNewUnlockDifficulty(arg_55_0, arg_55_1)
			return not var_53_6[arg_55_1]
		end

		function arg_53_0._cOutsideModel.setIsNewUnlockDifficulty(arg_56_0, arg_56_1, arg_56_2)
			var_53_6[arg_56_1] = not arg_56_2
		end

		local var_53_7 = {}

		function arg_53_0._cOutsideModel.getIsNewUnlockStyle(arg_57_0, arg_57_1)
			return not var_53_7[arg_57_1]
		end

		function arg_53_0._cOutsideModel.setIsNewUnlockStyle(arg_58_0, arg_58_1, arg_58_2)
			var_53_7[arg_58_1] = not arg_58_2
		end
	end
end

local var_0_4 = _G.class("RougeTesting")

function var_0_4.ctor(arg_59_0)
	arg_59_0._client = var_0_3.New()
	arg_59_0._sever = var_0_1.New()

	arg_59_0._sever:link(arg_59_0._client)
	arg_59_0._client:link(arg_59_0._sever)
end

function var_0_4._test(arg_60_0)
	arg_60_0._client:build_test()
	arg_60_0._sever:build_test()
	arg_60_0._client:build_test_outside()
end

var_0_4.instance = var_0_4.New()

return var_0_4
