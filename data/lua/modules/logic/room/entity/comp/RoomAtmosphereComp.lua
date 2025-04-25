module("modules.logic.room.entity.comp.RoomAtmosphereComp", package.seeall)

slot0 = class("RoomAtmosphereComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._buildingId = slot0.entity.id

	if slot0.entity.getMO then
		slot0._buildingId = slot0.entity:getMO().buildingId
	end

	slot0._atmosphereDict = {}

	slot0:setIsBlockAtmosphere(false)
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in ipairs(RoomConfig.instance:getBuildingAtmospheres(slot0._buildingId)) do
		for slot14, slot15 in ipairs(RoomConfig.instance:getAtmosphereAllEffectPathList(slot9)) do
			if not slot3[slot15] then
				slot2[#slot2 + 1] = slot15
				slot3[slot15] = true
			end
		end
	end

	GameSceneMgr.instance:getCurScene().loader:makeSureLoaded(slot2, slot0.beginCheckAtmosphere, slot0)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BlockAtmosphereEffect, slot0.onBlockAtmosphere, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ResumeAtmosphereEffect, slot0.onResumeAtmosphere, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0.refreshManufactureState, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0.refreshManufactureState, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.BlockAtmosphereEffect, slot0.onBlockAtmosphere, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.ResumeAtmosphereEffect, slot0.onResumeAtmosphere, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0.refreshManufactureState, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0.refreshManufactureState, slot0)
end

function slot0.onBlockAtmosphere(slot0)
	slot0:setIsBlockAtmosphere(true)
	TaskDispatcher.cancelTask(slot0.repeatCheckAtmosphere, slot0)
	slot0:stopAllAtmosphere()
end

function slot0.onResumeAtmosphere(slot0)
	slot0:setIsBlockAtmosphere(false)
	slot0:beginCheckAtmosphere()
end

function slot0.onOpenViewFinish(slot0, slot1)
	if RoomEnum.AtmosphereAudioFadeView[slot1] then
		slot0:setAtmosphereAudioIsFade(true)
	end
end

function slot0.onCloseView(slot0, slot1)
	if RoomEnum.AtmosphereAudioFadeView[slot1] then
		slot0:setAtmosphereAudioIsFade(false)
	end
end

function slot0.setAtmosphereAudioIsFade(slot0, slot1)
	for slot5, slot6 in pairs(slot0._atmosphereDict) do
		if slot0:_getAtmosphereFlow(slot5) then
			slot7:setAllWorkAudioIsFade(slot1)
		end
	end
end

function slot0.setIsBlockAtmosphere(slot0, slot1)
	slot0._isBlockAtmosphere = slot1
end

function slot0._getAtmosphere(slot0, slot1)
	if not slot0._atmosphereDict then
		slot0._atmosphereDict = {}
	end

	if not slot0._atmosphereDict[slot1] then
		slot2 = {}

		slot0:_resetAtmosphere(slot2)

		slot0._atmosphereDict[slot1] = slot2
	end

	return slot2
end

function slot0._getAtmosphereFlow(slot0, slot1, slot2)
	if not slot0:_getAtmosphere(slot1).flow and slot2 then
		slot4 = RoomAtmosphereFlowSequence.New(slot1)

		for slot9, slot10 in ipairs(RoomConfig.instance:getAtmosphereEffectIdList(slot1)) do
			slot4:addWork(RoomAtmosphereEffectWork.New(slot10, slot0.go))
		end

		slot3.flow = slot4

		slot4:registerDoneListener(slot0.atmosphereSequenceFinish, slot0)
	end

	return slot4
end

function slot0._getAtmosphereResidentEffGO(slot0, slot1, slot2)
	if not RoomConfig.instance:getAtmosphereResidentEffect(slot1) or slot3 == 0 then
		return
	end

	if gohelper.isNil(slot0:_getAtmosphere(slot1).residentEffGO) and slot2 then
		slot6 = RoomConfig.instance:getRoomEffectPath(slot3)
		slot7 = nil

		if not GameResMgr.IsFromEditorDir then
			slot7 = FightHelper.getEffectAbPath(slot6)
		end

		slot4.residentEffGO = RoomGOPool.getInstance(slot6, slot0.go, "residentEffect_" .. slot3, slot7)
	end

	return slot5
end

function slot0._resetAtmosphere(slot0, slot1)
	if not slot1 then
		return
	end

	slot1.cyclesTimes = 0
	slot1.isPlaying = false
	slot1.isFlowPlaying = false
end

function slot0.beginCheckAtmosphere(slot0)
	slot0:repeatCheckAtmosphere()
	TaskDispatcher.cancelTask(slot0.repeatCheckAtmosphere, slot0)
	TaskDispatcher.runRepeat(slot0.repeatCheckAtmosphere, slot0, 1)
end

function slot0.repeatCheckAtmosphere(slot0)
	if slot0._isBlockAtmosphere then
		return
	end

	slot1, slot2 = RoomModel.instance:getOpenAndEndAtmosphereList(slot0._buildingId)

	for slot6, slot7 in ipairs(slot2) do
		slot0:stopAtmosphere(slot7)
	end

	if not slot1 or #slot1 <= 0 then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if not slot0:_getAtmosphere(slot7).isFlowPlaying then
			slot0:beginAtmosphere(slot7)
		end
	end
end

function slot0.beginAtmosphere(slot0, slot1)
	slot2 = slot0:_getAtmosphere(slot1)
	slot2.cyclesTimes = 1
	slot2.isFlowPlaying = true
	slot3 = slot0:_getAtmosphereResidentEffGO(slot1, true)

	gohelper.setActive(slot3, false)
	gohelper.setActive(slot3, true)

	slot2.isPlaying = true
	slot4 = slot0:_getAtmosphereFlow(slot1, true)

	slot4:reset()
	slot4:start()
end

function slot0.atmosphereSequenceFinish(slot0, slot1, slot2)
	if not (slot2 and slot0:_getAtmosphere(slot2) or nil) then
		return
	end

	if not slot1 then
		slot0:stopAtmosphere(slot2)

		return
	end

	slot4 = RoomConfig.instance:getAtmosphereCyclesTimes(slot2)

	if slot0:_getAtmosphereFlow(slot2) and (slot4 == 0 or slot3.cyclesTimes < slot4) and (RoomConfig.instance:getAtmosphereCfg(slot2) and slot5.cdtimes or 0) == 0 then
		slot9:start()

		slot3.cyclesTimes = slot7 + 1
	else
		if slot9 then
			slot9:reset()
		end

		slot0:stopAtmosphere(slot2)
		RoomModel.instance:setAtmosphereHasPlay(slot2)
	end
end

function slot0.stopAllAtmosphere(slot0)
	for slot4, slot5 in pairs(slot0._atmosphereDict) do
		slot0:stopAtmosphere(slot4)
	end
end

function slot0.stopAtmosphere(slot0, slot1)
	if not slot0:_getAtmosphere(slot1).isPlaying then
		return
	end

	if slot0:_getAtmosphereFlow(slot1) then
		slot3:stop()
	end

	slot0:_resetAtmosphere(slot2)
	gohelper.setActive(slot0:_getAtmosphereResidentEffGO(slot1), false)
end

function slot0.onEffectRebuild(slot0)
	if slot0.__willDestroy then
		return
	end

	slot0:refreshManufactureState()
end

function slot0.refreshManufactureState(slot0)
	slot1 = nil

	if slot0.entity.getMO then
		slot1 = slot0.entity:getMO()
	end

	if not slot1 then
		return
	end

	if not ManufactureConfig.instance:isManufactureBuilding(slot0._buildingId) then
		return
	end

	slot5 = RoomBuildingEnum.AnimName.Idel

	if slot1:getManufactureState() == RoomManufactureEnum.ManufactureState.Running then
		slot5 = RoomBuildingEnum.AnimName.Produce
	end

	slot6 = slot0.entity:getMainEffectKey()

	slot0.entity.effect:playEffectAnimator(slot6, slot5)

	if slot0.entity.effect:getGameObjectsByName(slot6, RoomEnum.EntityChildKey.ProduceGOKey) then
		for slot11, slot12 in ipairs(slot7) do
			gohelper.setActive(slot12, slot4)
		end
	end
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

	slot0:removeEventListeners()
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.repeatCheckAtmosphere, slot0)

	slot0.entity = nil
	slot0.go = nil
	slot0._buildingId = nil

	for slot4, slot5 in pairs(slot0._atmosphereDict) do
		if not gohelper.isNil(slot5.residentEffGO) then
			RoomGOPool.returnInstance(RoomConfig.instance:getRoomEffectPath(RoomConfig.instance:getAtmosphereResidentEffect(slot4)), slot5.residentEffGO)
		end

		if slot5.flow then
			slot6:unregisterDoneListener(slot0.atmosphereSequenceFinish, slot0)
			slot6:destroy()
		end

		slot0:_resetAtmosphere(slot5)
	end

	slot0._atmosphereDict = nil

	slot0:setIsBlockAtmosphere(false)
end

return slot0
