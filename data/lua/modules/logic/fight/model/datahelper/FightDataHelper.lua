module("modules.logic.fight.model.datahelper.FightDataHelper", package.seeall)

slot0 = {
	defineMgrRef = function ()
		slot0 = FightDataMgr.instance.mgrList

		for slot4, slot5 in pairs(FightDataMgr.instance) do
			for slot9, slot10 in ipairs(slot0) do
				if slot10 == slot5 then
					uv0[slot4] = slot10

					break
				end
			end
		end
	end,
	initDataMgr = function ()
		uv0.lastFightResult = nil

		FightLocalDataMgr.instance:initDataMgr()
		FightDataMgr.instance:initDataMgr()
		uv0.defineMgrRef()
		FightMsgMgr.sendMsg(FightMsgId.AfterInitDataMgrRef)
	end,
	initFightData = function (slot0)
		if not slot0 then
			uv0.version = 999
			FightModel.instance._version = uv0.version

			return
		end

		uv0.version = FightModel.GMForceVersion or slot0.version or 0
		FightModel.instance._version = uv0.version

		uv0.checkReplay(slot0)
		FightLocalDataMgr.instance:updateFightData(slot0)
		FightDataMgr.instance:updateFightData(slot0)
	end,
	checkReplay = function (slot0)
		if uv0.version >= 1 then
			if slot0.isRecord then
				uv0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
			end
		elseif FightModel.instance:getFightParam() and slot3.isReplay then
			uv0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		elseif FightReplayModel.instance:isReconnectReplay() then
			uv0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		end
	end,
	cacheFightWavePush = function (slot0)
		FightLocalDataMgr.instance.cacheFightMgr:cacheFightWavePush(slot0.fight)
		FightDataMgr.instance.cacheFightMgr:cacheFightWavePush(slot0.fight)
	end,
	playEffectData = function (slot0)
		if slot0:isDone() then
			return
		end

		uv0.calMgr:playActEffectData(slot0)
	end,
	coverData = function (slot0, slot1, slot2, slot3)
		if slot0 == nil then
			slot0 = {}
		end

		if slot1 == nil then
			if getmetatable(slot0) then
				setmetatable({}, slot4)
			end
		end

		for slot7, slot8 in pairs(slot1) do
			slot9 = false

			if slot2 and slot2[slot7] then
				slot9 = true
			end

			if uv0[slot7] then
				slot9 = true
			end

			if not slot9 and slot0[slot7] == nil then
				slot1[slot7] = nil
			end
		end

		for slot7, slot8 in pairs(slot0) do
			slot9 = false

			if slot2 and slot2[slot7] then
				slot9 = true
			end

			if uv0[slot7] then
				slot9 = true
			end

			if not slot9 then
				if slot3 and slot3[slot7] then
					slot3[slot7](slot0, slot1)
				elseif slot1[slot7] == nil then
					slot1[slot7] = FightHelper.deepCopySimpleWithMeta(slot0[slot7])
				elseif type(slot8) == "table" then
					uv1.coverInternal(slot8, slot1[slot7])
				else
					slot1[slot7] = slot8
				end
			end
		end

		return slot1
	end,
	coverInternal = function (slot0, slot1)
		for slot5, slot6 in pairs(slot1) do
			if slot0[slot5] == nil then
				slot1[slot5] = nil
			end
		end

		for slot5, slot6 in pairs(slot0) do
			if type(slot6) == "table" then
				if slot1[slot5] == nil then
					slot1[slot5] = FightHelper.deepCopySimpleWithMeta(slot6)
				else
					uv0.coverInternal(slot6, slot1[slot5])
				end
			else
				slot1[slot5] = slot6
			end
		end
	end,
	findDiffList = {},
	findDiffPath = {},
	addPathkey = function (slot0)
		table.insert(uv0.findDiffPath, slot0)
	end,
	removePathKey = function ()
		table.remove(uv0.findDiffPath)
	end,
	findDiff = function (slot0, slot1, slot2, slot3)
		uv0.findDiffList = {}
		uv0.findDiffPath = {}
		slot8 = slot3

		uv0.doFindDiff(slot0, slot1, slot2, slot8)

		slot4 = {}

		for slot8, slot9 in ipairs(uv0.findDiffList) do
			slot4[slot10] = slot4[slot9.pathList[1]] or {}

			table.insert(slot4[slot10], slot9)
		end

		return #uv0.findDiffList > 0, slot4, uv0.findDiffList
	end,
	doFindDiff = function (slot0, slot1, slot2, slot3, slot4)
		if type(slot0) ~= "table" or type(slot1) ~= "table" then
			logError("传入的参数必须是表结构,请检查代码")

			return
		end

		slot8 = slot2

		uv0.doCheckMissing(slot0, slot1, slot8)

		for slot8, slot9 in pairs(slot0) do
			slot10 = false

			if slot2 and slot2[slot8] then
				slot10 = true
			end

			if not slot10 and slot1[slot8] ~= nil then
				uv0.addPathkey(slot8)

				if slot3 and slot3[slot8] then
					slot3[slot8](slot0[slot8], slot1[slot8], slot0, slot1)
				elseif slot4 then
					slot4(slot0[slot8], slot1[slot8])
				else
					uv0.checkDifference(slot0[slot8], slot1[slot8])
				end

				uv0.removePathKey()
			end
		end
	end,
	checkDifference = function (slot0, slot1)
		if type(slot0) ~= type(slot1) then
			uv0.addDiff(nil, uv0.diffType.difference)

			return
		elseif type(slot0) == "table" then
			uv0.doCheckMissing(slot0, slot1)

			for slot5, slot6 in pairs(slot0) do
				if slot1[slot5] ~= nil then
					uv0.addPathkey(slot5)
					uv0.checkDifference(slot6, slot1[slot5])
					uv0.removePathKey()
				end
			end
		elseif slot0 ~= slot1 then
			uv0.addDiff(nil, uv0.diffType.difference)
		end
	end,
	doCheckMissing = function (slot0, slot1, slot2)
		for slot6, slot7 in pairs(slot1) do
			slot8 = false

			if slot2 and slot2[slot6] then
				slot8 = true
			end

			if not slot8 and slot0[slot6] == nil then
				uv0.addDiff(slot6, uv0.diffType.missingSource)
			end
		end

		for slot6, slot7 in pairs(slot0) do
			slot8 = false

			if slot2 and slot2[slot6] then
				slot8 = true
			end

			if not slot8 and slot1[slot6] == nil then
				uv0.addDiff(slot6, uv0.diffType.missingTarget)
			end
		end
	end,
	diffType = {
		missingTarget = 2,
		difference = 3,
		missingSource = 1
	},
	addDiff = function (slot0, slot1)
		slot2 = {
			diffType = slot1 or uv0.diffType.difference
		}
		slot3 = uv0.coverData(uv0.findDiffPath)

		if slot0 then
			table.insert(slot3, slot0)
		end

		slot2.pathList = slot3
		slot2.pathStr = table.concat(slot3, ".")

		table.insert(uv0.findDiffList, slot2)

		return slot2
	end,
	getDiffValue = function (slot0, slot1, slot2)
		slot3, slot4 = nil

		for slot11, slot12 in ipairs(slot2.pathList) do
			slot6 = slot0[slot12]
			slot7 = slot1[slot12]
		end

		if slot3 == nil then
			slot3 = "nil"
		end

		if slot4 == nil then
			slot4 = "nil"
		end

		return slot3, slot4
	end
}
slot1 = {
	class = true
}

slot0.initDataMgr()

return slot0
