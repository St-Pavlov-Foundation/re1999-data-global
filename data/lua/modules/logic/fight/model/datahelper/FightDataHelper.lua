module("modules.logic.fight.model.datahelper.FightDataHelper", package.seeall)

slot0 = {
	defineMgrRef = function ()
		uv0.calMgr = FightDataMgr.instance.calMgr
		uv0.entityMgr = FightDataMgr.instance.entityMgr
		uv0.handCardMgr = FightDataMgr.instance.handCardMgr
		uv0.fieldMgr = FightDataMgr.instance.fieldMgr
		uv0.operateMgr = FightDataMgr.instance.operateMgr
		uv0.simulateMgr = FightDataMgr.instance.simulateMgr
		uv0.stageMgr = FightDataMgr.instance.stageMgr
		uv0.paTaMgr = FightDataMgr.instance.paTaMgr
		uv0.playCardMgr = FightDataMgr.instance.playCardMgr
		uv0.tempMgr = FightDataMgr.instance.tempMgr
	end,
	initDataMgr = function ()
		uv0.lastFightResult = nil

		FightLocalDataMgr.instance:initDataMgr()
		FightDataMgr.instance:initDataMgr()
		uv0.defineMgrRef()
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
	coverData = function (slot0, slot1, slot2)
		slot0 = slot0 or {}

		if not slot1 then
			if getmetatable(slot0) then
				setmetatable({}, slot3)
			end
		end

		uv0.coverInternal(slot0, slot1, slot2)

		return slot1
	end,
	coverInternal = function (slot0, slot1, slot2)
		if not slot0 or not slot1 then
			return
		end

		for slot6, slot7 in pairs(slot1) do
			if slot0[slot6] == nil then
				slot1[slot6] = nil
			end
		end

		for slot6, slot7 in pairs(slot0) do
			slot8 = false

			if uv0[slot6] then
				slot8 = true
			end

			if slot2 and slot2[slot6] then
				slot8 = true
			end

			if not slot8 then
				if type(slot7) == "table" then
					if not slot1[slot6] then
						slot1[slot6] = FightHelper.deepCopySimpleWithMeta(slot0[slot6], slot2)
					else
						uv1.coverInternal(slot0[slot6], slot1[slot6], slot2)
					end
				else
					slot1[slot6] = slot0[slot6]
				end
			end
		end
	end
}
slot1 = {
	class = true
}

slot0.initDataMgr()

return slot0
