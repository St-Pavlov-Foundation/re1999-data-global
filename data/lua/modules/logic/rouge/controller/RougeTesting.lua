module("modules.logic.rouge.controller.RougeTesting", package.seeall)

slot0 = _G.class("TestingBase")

function slot0.build_test(slot0)
end

function slot0.link(slot0, slot1)
	slot0._obj = slot1
end

slot1 = _G.class("SRougeTesting", slot0)

function slot1.ctor(slot0)
	slot0._season2RougeInfo = {}
	slot0._season2RougeOutsideInfo = {}
end

function slot1._make_RougeBattleHero(slot0, slot1)
	return {
		supportHeroSkill = 0,
		index = slot1 or math.random(1, 4),
		heroId = math.random(3003, 3020),
		equipUid = math.random(1501, 1510),
		supportHeroId = math.random(3022, 3060)
	}
end

function slot1._make_RougeHeroLife(slot0, slot1)
	return {
		heroId = slot1 or math.random(3003, 3020),
		life = math.random(1, 100) * 1000
	}
end

function slot1._make_RougeTeamInfo(slot0)
	for slot6 = 1, 4 do
		slot7 = slot0:_make_RougeBattleHero(slot6)
		slot7.supportHeroId = math.random(1, 1000) % 2 == 0 and slot7.supportHeroId or 0

		table.insert(({
			battleHeroList = {},
			heroLifeList = {},
			HasField = function (slot0, slot1)
				return uv0[slot1] ~= nil
			end
		}).battleHeroList, slot7)
	end

	for slot6 = 1, slot2 do
		table.insert(slot1.heroLifeList, slot0:_make_RougeHeroLife(slot1.battleHeroList[slot6].heroId))
	end

	return slot1
end

function slot1._make_RougeBagPos(slot0, slot1, slot2)
	return {
		row = slot1 or 0,
		col = slot2 or 0
	}
end

slot2 = 1

function slot1._make_RougeItem(slot0, slot1, slot2)
	uv0 = uv0 + 1
	slot7 = {}

	for slot11 = 1, 0 do
		({
			id = slot1 or uv0,
			itemId = slot2 or slot3[math.random(1, #lua_item.configList)].id,
			holdItems = {},
			holdIds = {}
		}).holdItems[slot11] = slot7[math.random(1, #slot7)]
	end

	for slot12 = 1, 0 do
		slot5.holdItems[slot12] = slot8
	end

	return slot5
end

function slot1._make_RougeItemLayout(slot0)
	slot1 = 1
	slot2 = 1

	if RougeEnum.MaxCollectionSlotSize then
		slot1 = RougeEnum.MaxCollectionSlotSize.x
		slot2 = RougeEnum.MaxCollectionSlotSize.y
	end

	for slot10 = 1, 0 do
		({
			pos = slot0:_make_RougeBagPos(math.random(1, slot1), math.random(1, slot2)),
			rotation = math.random(0, 3),
			item = slot0:_make_RougeItem(),
			baseEffects = {},
			extraEffects = {}
		}).baseEffects[slot10] = 1
	end

	for slot11 = 1, 0 do
		slot5.extraEffects[slot11] = 1
	end

	return slot5
end

function slot1._make_RougeBag(slot0)
	slot1 = {
		layouts = {}
	}

	for slot6 = 1, 0 do
		slot1.layouts[slot6] = slot0:_make_RougeItemLayout()
	end

	return slot1
end

function slot1._make_RougeTalent(slot0, slot1, slot2)
	return {
		id = slot1,
		isActive = slot2 or false
	}
end

function slot1._make_RougeTalentTree(slot0)
	slot1 = {
		rougeTalent = {}
	}

	for slot6, slot7 in ipairs(lua_rouge_talent.configList or {}) do
		slot1.rougeTalent[slot6] = slot0:_make_RougeTalent(slot7.id, math.random(0, 9999) % 2 == 0)
	end

	return slot1
end

function slot1._make_RougeWarehouse(slot0)
	slot1 = {
		items = {}
	}

	for slot6 = 1, 0 do
		slot1.items[slot6] = slot0:_make_RougeItem()
	end

	return slot1
end

function slot1._make_NodeInfo(slot0, slot1, slot2)
	return {
		nodeId = 0,
		status = 0,
		eventId = 0,
		eventData = "",
		layer = slot1 or 0,
		stage = slot2 or 0,
		lastNodeList = {},
		nextNodeList = {}
	}
end

function slot1._make_RougeMapInfo(slot0)
	slot1 = {
		curNode = 0,
		middleLayerId = 0,
		curStage = 0,
		layerId = 0,
		mapType = RougeMapEnum.MapType.Normal,
		nodeInfo = {}
	}

	for slot7 = 1, 5 do
		table.insert(slot1.nodeInfo, slot0:_make_NodeInfo(slot1.layerId, slot1.curStage))
	end

	return slot1
end

function slot1._make_RougeLastReward(slot0, slot1, slot2)
	slot4 = #addGlobalModule("modules.configs.rouge.lua_rouge_collection_editor", "lua_rouge_collection_editor")

	if (lua_rouge_last_reward.configDict or {})[slot1] and slot7[slot2] or nil then
		if slot8.type == "drop" then
			-- Nothing
		elseif slot9 == "dropGroup" then
			slot5.param = tostring(slot3[math.random(1, slot4)].id)
		end
	end

	return {
		param = "",
		id = slot2 or 0,
		param = ""
	}
end

function slot1._make_RougeLastReward_lastReward(slot0, slot1)
	for slot7 = 1, 4 do
		slot9 = (lua_rouge_last_reward and lua_rouge_last_reward.configList or {})[math.random(1, slot3)]

		table.insert(slot1, slot0:_make_RougeLastReward(slot9.season, slot9.id))
	end
end

function slot1._make_RougeInfo(slot0, slot1, slot2, slot3, slot4)
	slot5 = {
		selectRewardNum = 0,
		state = 0,
		endId = 0,
		season = slot1,
		version = slot2 or {},
		difficulty = slot3 or 1,
		lastReward = {},
		style = slot4 or 0,
		teamLevel = math.random(1, 100),
		teamExp = math.random(1, 100),
		teamSize = math.random(1, 4),
		coin = math.random(0, 100),
		talentPoint = math.random(1, 100),
		teamInfo = slot0:_make_RougeTeamInfo(),
		bag = slot0:_make_RougeBag(),
		warehouse = slot0:_make_RougeWarehouse(),
		talentTree = slot0:_make_RougeTalentTree(),
		effectInfo = {}
	}

	slot0:_make_RougeLastReward_lastReward(slot5.lastReward)

	function slot5.HasField(slot0, slot1)
		return uv0[slot1] ~= nil
	end

	if #slot5.lastReward > 0 then
		slot5.selectRewardNum = math.random(1, #slot5.lastReward)
	end

	return slot5
end

function slot1._make_RougeOutsideBonusStageNO(slot0, slot1, ...)
	return {
		stage = slot1 or 1,
		bonusIds = {
			...
		}
	}
end

function slot1._make_RougeOutsideBonusNO(slot0)
	return {
		bonusStages = {}
	}
end

function slot1._make_RougeReviewInfo(slot0, slot1, slot2, slot3)
	return {
		portrait = 0,
		playerName = "123456",
		season = slot1 or 1,
		playerLevel = math.random(1, 999),
		finishTime = os.time(),
		difficulty = slot2 or math.random(1, 5),
		style = slot3 or math.random(1, 5),
		teamLevel = math.random(1, 10),
		collectionNum = math.random(1, 10)
	}
end

function slot1._make_RougeOutsideInfo(slot0, slot1)
	return {
		isGeniusNewStage = false,
		season = slot1,
		geniusPoint = math.random(0, 100),
		geniusIds = {
			1,
			2,
			3
		},
		point = math.random(0, 100),
		bonus = slot0:_make_RougeOutsideBonusNO(),
		review = {},
		gameRecordInfo = {
			lastGameTime = 0,
			maxDifficulty = math.random(0, #RougeConfig1.instance:getDifficultyCOListByVersions({
				101
			})),
			passLayerId = {},
			passEventId = {},
			passEndId = {},
			passEntrustId = {}
		}
	}
end

function slot1.handleGetRougeOutsideInfo(slot0, slot1, slot2)
	if not slot0:_getRougeOutsideInfo(slot1.season) then
		slot0._season2RougeOutsideInfo[slot3] = slot0:_make_RougeOutsideInfo(slot3)
	end

	rawset(slot2, "rougeInfo", slot0:_getRougeOutsideInfo(slot3))
end

function slot1.handleGetRougeInfo(slot0, slot1, slot2)
	if not slot0:_getRougeInfo(slot1.season) then
		slot0._season2RougeInfo[slot3] = slot0:_make_RougeInfo(slot3)
	end

	rawset(slot2, "rougeInfo", slot0:_getRougeInfo(slot3))
end

function slot1.handleEnterRougeSelectDifficulty(slot0, slot1, slot2)
	slot3 = slot1.season
	slot4 = slot0:_getRougeInfo(slot3)

	assert(slot4, "handleEnterRougeSelectDifficulty rougeInfo == nil")

	slot4.season = slot1.season
	slot4.version = slot1.version
	slot4.difficulty = slot1.difficulty
	slot4.state = RougeEnum.State.Difficulty

	rawset(slot2, "season", slot3)
	rawset(slot2, "rougeInfo", slot0:_getRougeInfo(slot3))
end

function slot1.handleEnterRougeSelectReward(slot0, slot1, slot2)
	slot3 = slot1.season
	slot4 = slot0:_getRougeInfo(slot3)

	assert(slot4, "handleEnterRougeSelectReward rougeInfo == nil")

	slot4.selectRewardId = slot1.rewardId
	slot4.state = RougeEnum.State.LastReward

	rawset(slot2, "season", slot3)
	rawset(slot2, "rougeInfo", slot0:_getRougeInfo(slot3))
end

function slot1.handleEnterRougeSelectStyle(slot0, slot1, slot2)
	slot3 = slot1.season
	slot4 = slot0:_getRougeInfo(slot3)

	assert(slot4, "handleEnterRougeSelectStyle rougeInfo == nil")

	slot4.style = slot1.style

	rawset(slot2, "season", slot3)
	rawset(slot2, "rougeInfo", slot0:_getRougeInfo(slot3))
end

function slot1._getRougeInfo(slot0, slot1)
	return slot0._season2RougeInfo[slot1]
end

function slot1._getRougeOutsideInfo(slot0, slot1)
	return slot0._season2RougeOutsideInfo[slot1]
end

slot3 = _G.class("CRougeTesting", slot0)

function slot3.ctor(slot0)
	slot0._cCfg = RougeConfig1
	slot0._cRpc = RougeRpc
	slot0._cCtrl = RougeController
	slot0._cModel = RougeModel
	slot0._cOutsideRpc = RougeOutsideRpc
	slot0._cOutsideCtrl = RougeOutsideController
	slot0._cOutsideModel = RougeOutsideModel
	slot0._cOpenModel = OpenModel
end

function slot3.build_test(slot0)
	slot1 = 0
	slot2 = slot0._cCfg.instance
	slot3 = slot0._cRpc.instance
	slot4 = slot0._cCtrl.instance
	slot5 = slot0._cModel.instance
	slot6 = slot0._cOutsideRpc.instance

	function slot0._cOutsideRpc.sendGetRougeOutsideInfoRequest(slot0, slot1, slot2, slot3)
		slot4 = RougeOutsideModule_pb.GetRougeOutsideInfoRequest()
		slot4.season = slot1
		slot5 = RougeOutsideModule_pb.GetRougeOutsideInfoReply()

		uv0._obj:handleGetRougeOutsideInfo(slot4, slot5)
		uv1:onReceiveGetRougeOutsideInfoReply(uv2, slot5)

		if slot2 then
			if slot3 then
				slot2(slot3, LuaSocketMgr.instance:getCmdByPbStructName(slot4.__cname), uv2)
			else
				slot2(slot6, uv2)
			end
		end
	end

	slot0._cOutsideRpc.sendGetRougeOutSideInfoRequest = slot0._cOutsideRpc.sendGetRougeOutsideInfoRequest

	function slot0._cRpc.sendGetRougeInfoRequest(slot0, slot1, slot2, slot3)
		slot4 = RougeModule_pb.GetRougeInfoRequest()
		slot4.season = slot1
		slot5 = RougeModule_pb.GetRougeInfoReply()

		uv0._obj:handleGetRougeInfo(slot4, slot5)
		uv1:onReceiveGetRougeInfoReply(uv2, slot5)

		if slot2 then
			if slot3 then
				slot2(slot3, LuaSocketMgr.instance:getCmdByPbStructName(slot4.__cname), uv2)
			else
				slot2(slot6, uv2)
			end
		end
	end

	function slot0._cRpc.sendEnterRougeSelectDifficultyRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		RougeModule_pb.EnterRougeSelectDifficultyRequest().season = slot1

		for slot11, slot12 in ipairs(slot2) do
			slot7.version:append(slot12)
		end

		slot7.difficulty = slot3
		slot8 = RougeModule_pb.EnterRougeSelectDifficultyReply()

		uv0._obj:handleEnterRougeSelectDifficulty(slot7, slot8)
		uv1:onReceiveEnterRougeSelectDifficultyReply(uv2, slot8)

		if slot5 then
			if slot6 then
				slot5(slot6, LuaSocketMgr.instance:getCmdByPbStructName(slot7.__cname), uv2)
			else
				slot5(slot9, uv2)
			end
		end
	end

	function slot0._cRpc.sendEnterRougeSelectRewardRequest(slot0, slot1, slot2, slot3, slot4)
		RougeModule_pb.EnterRougeSelectRewardRequest().season = slot1

		for slot9, slot10 in ipairs(slot2) do
			slot5.rewardId:append(slot10)
		end

		slot6 = RougeModule_pb.EnterRougeSelectRewardReply()

		uv0._obj:handleEnterRougeSelectReward(slot5, slot6)
		uv1:onReceiveEnterRougeSelectRewardReply(uv2, slot6)

		if slot3 then
			if slot4 then
				slot3(slot4, LuaSocketMgr.instance:getCmdByPbStructName(slot5.__cname), uv2)
			else
				slot3(slot7, uv2)
			end
		end
	end

	function slot0._cRpc.sendEnterRougeSelectStyleRequest(slot0, slot1, slot2, slot3, slot4)
		slot5 = RougeModule_pb.EnterRougeSelectStyleRequest()
		slot5.season = slot1
		slot5.style = slot2
		slot6 = RougeModule_pb.EnterRougeSelectStyleReply()

		uv0._obj:handleEnterRougeSelectStyle(slot5, slot6)
		uv1:onReceiveEnterRougeSelectStyleReply(uv2, slot6)

		if slot3 then
			if slot4 then
				slot3(slot4, LuaSocketMgr.instance:getCmdByPbStructName(slot5.__cname), uv2)
			else
				slot3(slot7, uv2)
			end
		end
	end

	function slot0._cOpenModel.isFunctionUnlock()
		return true
	end

	function slot0._cOutsideModel.isUnlock()
		return true
	end

	function slot0._cOutsideCtrl.isOpen()
		return true
	end

	slot8 = false
	slot9 = false

	function slot0._cModel.isContinueLast()
		return uv0 or uv1 or false
	end

	if false then
		function slot0._cModel.isContinueLast()
			return false
		end

		function slot0._cOutsideModel.isOpenedDifficulty()
			return true
		end

		function slot0._cOutsideModel.isPassedDifficulty()
			return true
		end

		function slot0._cModel.getDifficulty(slot0)
			return slot0._rougeInfo and slot0._rougeInfo.difficulty or nil
		end
	end

	if slot9 then
		function slot0._cModel.isFinishedLastReward()
			return true
		end

		function slot0._cModel.getDifficulty()
			return 1
		end

		function slot0._cOutsideModel.isOpenedStyle(slot0, slot1)
			return math.random(1, 99999) % 2 == 0
		end
	end

	if slot8 then
		function slot0._cModel.isCanSelectRewards()
			return true
		end

		function slot0._cModel.isFinishedLastReward()
			return false
		end

		function slot0._cModel.isFinishedDifficulty()
			return true
		end
	end
end

function slot3.build_test_outside(slot0)
	slot1 = 0
	slot2 = slot0._cCfg.instance
	slot3 = slot0._cOutsideRpc.instance
	slot4 = slot0._cOutsideCtrl.instance
	slot5 = slot0._cOutsideModel.instance

	function slot0._cOutsideRpc.sendGetRougeOutsideInfoRequest(slot0, slot1, slot2, slot3)
		slot4 = RougeOutsideModule_pb.GetRougeOutsideInfoRequest()
		slot4.season = slot1
		slot5 = RougeOutsideModule_pb.GetRougeOutsideInfoReply()

		uv0._obj:handleGetRougeOutsideInfo(slot4, slot5)
		uv1:onReceiveGetRougeOutsideInfoReply(uv2, slot5)

		if slot2 then
			if slot3 then
				slot2(slot3, LuaSocketMgr.instance:getCmdByPbStructName(slot4.__cname), uv2)
			else
				slot2(slot6, uv2)
			end
		end
	end

	slot0._cOutsideRpc.sendGetRougeOutSideInfoRequest = slot0._cOutsideRpc.sendGetRougeOutsideInfoRequest

	if true then
		slot7 = {}

		function slot0._cOutsideModel.getIsNewUnlockDifficulty(slot0, slot1)
			return not uv0[slot1]
		end

		function slot0._cOutsideModel.setIsNewUnlockDifficulty(slot0, slot1, slot2)
			uv0[slot1] = not slot2
		end

		slot8 = {}

		function slot0._cOutsideModel.getIsNewUnlockStyle(slot0, slot1)
			return not uv0[slot1]
		end

		function slot0._cOutsideModel.setIsNewUnlockStyle(slot0, slot1, slot2)
			uv0[slot1] = not slot2
		end
	end
end

slot4 = _G.class("RougeTesting")

function slot4.ctor(slot0)
	slot0._client = uv0.New()
	slot0._sever = uv1.New()

	slot0._sever:link(slot0._client)
	slot0._client:link(slot0._sever)
end

function slot4._test(slot0)
	slot0._client:build_test()
	slot0._sever:build_test()
	slot0._client:build_test_outside()
end

slot4.instance = slot4.New()

return slot4
