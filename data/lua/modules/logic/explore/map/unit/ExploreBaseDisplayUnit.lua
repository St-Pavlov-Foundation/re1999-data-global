module("modules.logic.explore.map.unit.ExploreBaseDisplayUnit", package.seeall)

slot0 = class("ExploreBaseDisplayUnit", ExploreBaseUnit)
slot0.PairAnim = {
	[ExploreAnimEnum.AnimName.nToA] = ExploreAnimEnum.AnimName.aToN
}

function slot0.initComponents(slot0)
	slot0:addComp("clickComp", ExploreUnitClickComp)
	slot0:addComp("animComp", ExploreUnitAnimComp)
	slot0:addComp("animEffectComp", ExploreUnitAnimEffectComp)
	slot0:addComp("uiComp", ExploreUnitUIComp)
	slot0:addComp("outLineComp", ExploreOutLineComp)
	slot0:addComp("hangComp", ExploreHangComp)
end

function slot0.beginRotate(slot0)
end

function slot0.endRotate(slot0)
end

function slot0.doRotate(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._rotateEndCb = slot4
	slot0._rotateEndCallObj = slot5

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId, true)
	end

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot1, slot2, slot3, slot0._onFrameRotate, slot0._onRotateTweenFinish, slot0)
end

function slot0._onFrameRotate(slot0, slot1)
	slot0.mo.unitDir = ExploreHelper.getDir(slot1)

	slot0:updateRotationRoot()
	slot0:onRotation()
end

function slot0._onRotateTweenFinish(slot0)
	slot0._tweenId = nil

	if slot0._rotateEndCb then
		slot0._rotateEndCb(slot0._rotateEndCallObj)
	end

	slot0._rotateEndCb = nil
	slot0._rotateEndCallObj = nil

	slot0:onRotateFinish()
end

function slot0.onRotateFinish(slot0)
end

function slot0.onEnter(slot0)
	if slot0.animComp and slot0.animComp._curAnim == ExploreAnimEnum.AnimName.exit then
		slot0.animComp:playAnim(slot0:getIdleAnim(), true)
	end

	if slot0.clickComp then
		slot0.clickComp:setEnable(true)
	end

	uv0.super.onEnter(slot0)
end

function slot0.setExit(slot0)
	if slot0:isEnter() then
		slot0._playedEnter = false

		slot0.mo:setEnter(false)
		logWarn(string.format("[-]%s:%s退出地图", slot0.__cname, slot0.id))

		if slot0._isEnter == false then
			slot0:setActive(false)
			slot0:checkLight()
		else
			if slot0.clickComp then
				slot0.clickComp:setEnable(false)
			end

			slot0:playAnim(ExploreAnimEnum.AnimName.exit)
		end

		slot0._isEnter = false

		slot0:checkShowIcon()
		slot0:onExit()
	else
		logWarn("重复退出" .. slot0.id .. slot0.__cname)
	end
end

function slot0.playAnim(slot0, slot1)
	if not slot0._displayGo or not slot0:isInFOV() then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitAnimEnd, slot0.id, slot1)
	else
		slot0.animComp:playAnim(slot1)
	end
end

function slot0.isPairAnim(slot0, slot1, slot2)
	return slot0.PairAnim[slot1] == slot2 or slot0.PairAnim[slot2] == slot1
end

function slot0.onAnimEnd(slot0, slot1, slot2)
	if slot1 == ExploreAnimEnum.AnimName.exit then
		slot0:setActive(false)
		slot0:_releaseDisplayGo()
		slot0:checkLight()
	end
end

function slot0.onInit(slot0)
end

function slot0._setupMO(slot0)
	slot0:setupRes()
	slot0:setupMO()
	slot0:updateRotation()
	slot0:updateRotationRoot()
	slot0:checkShowIcon()
end

function slot0.setupRes(slot0)
	slot0:setResPath(slot0.mo.showRes)
end

function slot0.setResPath(slot0, slot1)
	if not slot0:isEnter() or slot0:isInFOV() == false then
		return
	end

	if slot1 == "explore/prefabs/unit/ice.prefab" or slot1 == "" then
		slot1 = nil
	end

	if slot1 and slot0._resPath ~= slot1 then
		slot0._resPath = slot1
		slot0._assetId = ResMgr.getAbAsset(slot0._resPath, slot0._onResLoaded, slot0, slot0._assetId)

		if slot0._assetId then
			slot0:getMap():addUnitNeedLoadedNum(1)
		end
	elseif slot1 and slot0._resPath == slot1 and slot0._displayGo == nil then
		slot0._assetId = ResMgr.getAbAsset(slot0._resPath, slot0._onResLoaded, slot0, slot0._assetId)

		if slot0._assetId then
			slot0:getMap():addUnitNeedLoadedNum(1)
		end
	else
		slot0:onResLoaded()
	end
end

function slot0.getMap(slot0)
	return ExploreController.instance:getMap()
end

function slot0.setInteractActive(slot0, slot1)
	slot0.mo:setStatus(ExploreHelper.setBit(slot0.mo:getStatus(), ExploreEnum.InteractIndex.ActiveState, slot1))
end

function slot0.getResPath(slot0)
	return slot0._resPath
end

function slot0._onResLoaded(slot0, slot1)
	if not slot1.IsLoadSuccess then
		return
	end

	slot0:_releaseDisplayGo()

	if slot0:isActive() then
		slot0._displayGo = slot1:getInstance(nil, , slot0.go)
		slot0._displayTr = slot0._displayGo.transform
		slot0._rotateRoot = slot0._displayTr:Find("#go_rotate")

		if slot0.mo then
			transformhelper.setLocalPos(slot0._displayTr, slot0.mo.resPosition[1], slot0.mo.resPosition[2], slot0.mo.resPosition[3])
		end

		for slot6, slot7 in ipairs(slot0:getCompList()) do
			if slot7.setup then
				slot7:setup(slot0._displayGo)
			end
		end

		slot0:updateRotation()
		slot0:updateRotationRoot()
		slot0:onResLoaded()
		slot0:_checkContainerNeedUpdate()

		if not slot0._akComp and ExploreConfig.instance:getAssetNeedAkGo(slot0._resPath) then
			gohelper.addAkGameObject(slot0.go)

			slot0._akComp = true
		end

		if not slot0._playedEnter and slot0.animComp and slot0.animComp.haveAnim and slot0.animComp:haveAnim(ExploreAnimEnum.AnimName.enter) then
			slot0:markPlayedEnter()
			slot0.animComp:playAnim(ExploreAnimEnum.AnimName.enter)
		end

		slot0:setOutLight(slot0._showOutLine)
	end
end

function slot0._checkContainerNeedUpdate(slot0)
	slot1 = false

	if slot0.animComp and slot0.animComp.animator then
		slot1 = true
	end

	slot0._luamonoContainer.enabled = slot1
end

function slot0.onMapInit(slot0)
	slot0:markPlayedEnter()
end

function slot0.markPlayedEnter(slot0)
	slot0._playedEnter = true
end

function slot0.updateRotation(slot0)
	if not slot0._displayTr or not slot0.mo then
		return
	end

	transformhelper.setLocalRotation(slot0._displayTr, slot0.mo.resRotation[1], slot0.mo.resRotation[2], slot0.mo.resRotation[3])
end

function slot0.getEffectRoot(slot0)
	return slot0._rotateRoot or slot0._displayTr or slot0.trans
end

function slot0.updateRotationRoot(slot0)
	if not slot0._rotateRoot or not slot0.mo then
		return
	end

	transformhelper.setLocalRotation(slot0._rotateRoot, 0, slot0.mo.unitDir - slot0.mo.resRotation[2], 0)
end

function slot0.onActiveChange(slot0, slot1)
	if slot1 then
		slot0:playAnim(ExploreAnimEnum.AnimName.nToA)
	else
		slot0:playAnim(ExploreAnimEnum.AnimName.aToN)
	end

	uv0.super.onActiveChange(slot0, slot1)
end

function slot0.onInteractChange(slot0, slot1)
	if slot1 then
		slot0:playAnim(ExploreAnimEnum.AnimName.uToN)
	else
		slot0:playAnim(ExploreAnimEnum.AnimName.nToU)
	end

	uv0.super.onInteractChange(slot0, slot1)
end

function slot0.forceOutLine(slot0, slot1)
	slot0._isForceOutLight = slot1

	slot0:setOutLight(slot0._showOutLine)
end

function slot0.setOutLight(slot0, slot1)
	if not slot0._displayGo or not slot0.outLineComp then
		return
	end

	slot0.outLineComp:setOutLight(slot0._isForceOutLight or slot1)
end

function slot0.onRoleNear(slot0)
	uv0.super.onRoleNear(slot0)

	if slot0.mo.isStrong then
		return
	end

	slot0:checkShowIcon()
end

function slot0.onRoleFar(slot0)
	uv0.super.onRoleFar(slot0)

	if slot0.mo.isStrong then
		return
	end

	slot0:checkShowIcon()
end

function slot0.isCustomShowOutLine(slot0)
	return false
end

function slot0.checkShowIcon(slot0)
	if not slot0.mo then
		return
	end

	if lua_explore_unit.configDict[slot0.mo.customIconType or slot0.mo.type] then
		slot2 = false

		if slot0.mo.isStrong then
			slot2 = true
		elseif slot0._roleNear and slot1.isShow == 1 then
			slot2 = true
		end

		if slot2 and not slot0:canTrigger() and not slot0:isCustomShowOutLine() and not slot0.mo.isCanMove or not slot0:isEnter() then
			slot2 = false
		end

		if not string.nilorempty(slot1.mapActiveIcon) and slot0.mo:isInteractActiveState() then
			ExploreMapModel.instance:setSmallMapIconById(slot0.id, slot0.mo.nodeKey, slot1.mapActiveIcon)
		elseif not string.nilorempty(slot1.mapIcon) or not string.nilorempty(slot1.mapIcon2) then
			if slot1.mapIconShow == 1 then
				ExploreMapModel.instance:setSmallMapIconById(slot0.id, slot0.mo.nodeKey, slot0:processMapIcon(slot0.mo.isStrong and slot1.mapIcon2 or slot1.mapIcon))
			else
				ExploreMapModel.instance:setSmallMapIconById(slot0.id, slot0.mo.nodeKey, slot3 and slot4 or nil)
			end
		else
			ExploreMapModel.instance:setSmallMapIconById(slot0.id, slot0.mo.nodeKey, nil)
		end

		slot0._showOutLine = slot2

		slot0:setOutLight(slot2)
	end
end

function slot0.processMapIcon(slot0, slot1)
	return slot1
end

function slot0.hideMapIcon(slot0)
	if not slot0.mo then
		return
	end

	if not lua_explore_unit.configDict[slot0.mo.customIconType or slot0.mo.type] or string.nilorempty(slot1.mapIcon) and string.nilorempty(slot1.mapIcon2) and string.nilorempty(slot1.mapActiveIcon) then
		return
	end

	ExploreMapModel.instance:setSmallMapIconById(slot0.id, slot0.mo.nodeKey, nil)
end

function slot0.onInFOVChange(slot0, slot1)
	slot0:setActive(slot1)

	if slot1 then
		slot0:setupRes()
		TaskDispatcher.cancelTask(slot0._releaseDisplayGo, slot0)
	else
		TaskDispatcher.runDelay(slot0._releaseDisplayGo, slot0, ExploreConstValue.CHECK_INTERVAL.UnitObjDestory)
	end
end

function slot0.setActive(slot0, ...)
	uv0.super.setActive(slot0, ...)

	if not ... and slot0.animEffectComp and slot0.animEffectComp.destoryEffectIfOnce then
		slot0.animEffectComp:destoryEffectIfOnce()
	end
end

function slot0.onNodeChange(slot0, slot1, slot2)
	slot0:checkLight()
end

function slot0.setEmitLight(slot0, slot1)
	slot0._isNoEmitLight = slot1
end

function slot0.getIsNoEmitLight(slot0)
	return slot0._isNoEmitLight
end

function slot0.checkLight(slot0)
	if slot0:getLightRecvType() == ExploreEnum.LightRecvType.Photic or slot1 == ExploreEnum.LightRecvType.Custom then
		return
	end

	if not ExploreController.instance:getMap():isInitDone() then
		return
	end

	ExploreController.instance:getMapLight():updateLightsByUnit(slot0)
end

function slot0.getIdleAnim(slot0)
	if not slot0.mo:isInteractEnabled() then
		return ExploreAnimEnum.AnimName.unable
	elseif not slot1:isInteractActiveState() then
		return ExploreAnimEnum.AnimName.normal
	else
		return ExploreAnimEnum.AnimName.active
	end
end

function slot0.onResLoaded(slot0)
end

function slot0._releaseDisplayGo(slot0)
	slot0:clearComp()

	if slot0._assetId and not slot0:isRole() then
		slot0:getMap():addUnitNeedLoadedNum(-1)
	end

	ResMgr.removeCallBack(slot0._assetId)
	ResMgr.ReleaseObj(slot0._displayGo)

	slot0._displayGo = nil
	slot0._displayTr = nil
	slot0._rotateRoot = nil
	slot0._assetId = nil

	slot0:_checkContainerNeedUpdate()
end

function slot0.clearComp(slot0)
	for slot5, slot6 in ipairs(slot0:getCompList()) do
		if slot6.clear then
			slot6:clear()
		end
	end
end

function slot0.onDestroy(slot0)
	slot0:_releaseDisplayGo()
	TaskDispatcher.cancelTask(slot0._releaseDisplayGo, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId, true)

		slot0._tweenId = nil
	end
end

return slot0
