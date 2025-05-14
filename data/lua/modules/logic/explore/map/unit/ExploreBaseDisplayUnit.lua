module("modules.logic.explore.map.unit.ExploreBaseDisplayUnit", package.seeall)

local var_0_0 = class("ExploreBaseDisplayUnit", ExploreBaseUnit)

var_0_0.PairAnim = {
	[ExploreAnimEnum.AnimName.nToA] = ExploreAnimEnum.AnimName.aToN
}

function var_0_0.initComponents(arg_1_0)
	arg_1_0:addComp("clickComp", ExploreUnitClickComp)
	arg_1_0:addComp("animComp", ExploreUnitAnimComp)
	arg_1_0:addComp("animEffectComp", ExploreUnitAnimEffectComp)
	arg_1_0:addComp("uiComp", ExploreUnitUIComp)
	arg_1_0:addComp("outLineComp", ExploreOutLineComp)
	arg_1_0:addComp("hangComp", ExploreHangComp)
end

function var_0_0.beginRotate(arg_2_0)
	return
end

function var_0_0.endRotate(arg_3_0)
	return
end

function var_0_0.doRotate(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0._rotateEndCb = arg_4_4
	arg_4_0._rotateEndCallObj = arg_4_5

	if arg_4_0._tweenId then
		ZProj.TweenHelper.KillById(arg_4_0._tweenId, true)
	end

	arg_4_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_4_1, arg_4_2, arg_4_3, arg_4_0._onFrameRotate, arg_4_0._onRotateTweenFinish, arg_4_0)
end

function var_0_0._onFrameRotate(arg_5_0, arg_5_1)
	arg_5_0.mo.unitDir = ExploreHelper.getDir(arg_5_1)

	arg_5_0:updateRotationRoot()
	arg_5_0:onRotation()
end

function var_0_0._onRotateTweenFinish(arg_6_0)
	arg_6_0._tweenId = nil

	if arg_6_0._rotateEndCb then
		arg_6_0._rotateEndCb(arg_6_0._rotateEndCallObj)
	end

	arg_6_0._rotateEndCb = nil
	arg_6_0._rotateEndCallObj = nil

	arg_6_0:onRotateFinish()
end

function var_0_0.onRotateFinish(arg_7_0)
	return
end

function var_0_0.onEnter(arg_8_0)
	if arg_8_0.animComp and arg_8_0.animComp._curAnim == ExploreAnimEnum.AnimName.exit then
		arg_8_0.animComp:playAnim(arg_8_0:getIdleAnim(), true)
	end

	if arg_8_0.clickComp then
		arg_8_0.clickComp:setEnable(true)
	end

	var_0_0.super.onEnter(arg_8_0)
end

function var_0_0.setExit(arg_9_0)
	if arg_9_0:isEnter() then
		arg_9_0._playedEnter = false

		arg_9_0.mo:setEnter(false)
		logWarn(string.format("[-]%s:%s退出地图", arg_9_0.__cname, arg_9_0.id))

		if arg_9_0._isEnter == false then
			arg_9_0:setActive(false)
			arg_9_0:checkLight()
		else
			if arg_9_0.clickComp then
				arg_9_0.clickComp:setEnable(false)
			end

			arg_9_0:playAnim(ExploreAnimEnum.AnimName.exit)
		end

		arg_9_0._isEnter = false

		arg_9_0:checkShowIcon()
		arg_9_0:onExit()
	else
		logWarn("重复退出" .. arg_9_0.id .. arg_9_0.__cname)
	end
end

function var_0_0.playAnim(arg_10_0, arg_10_1)
	if not arg_10_0._displayGo or not arg_10_0:isInFOV() then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitAnimEnd, arg_10_0.id, arg_10_1)
	else
		arg_10_0.animComp:playAnim(arg_10_1)
	end
end

function var_0_0.isPairAnim(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0.PairAnim[arg_11_1] == arg_11_2 or arg_11_0.PairAnim[arg_11_2] == arg_11_1
end

function var_0_0.onAnimEnd(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == ExploreAnimEnum.AnimName.exit then
		arg_12_0:setActive(false)
		arg_12_0:_releaseDisplayGo()
		arg_12_0:checkLight()
	end
end

function var_0_0.onInit(arg_13_0)
	return
end

function var_0_0._setupMO(arg_14_0)
	arg_14_0:setupRes()
	arg_14_0:setupMO()
	arg_14_0:updateRotation()
	arg_14_0:updateRotationRoot()
	arg_14_0:checkShowIcon()
end

function var_0_0.setupRes(arg_15_0)
	arg_15_0:setResPath(arg_15_0.mo.showRes)
end

function var_0_0.setResPath(arg_16_0, arg_16_1)
	if not arg_16_0:isEnter() or arg_16_0:isInFOV() == false then
		return
	end

	if arg_16_1 == "explore/prefabs/unit/ice.prefab" or arg_16_1 == "" then
		arg_16_1 = nil
	end

	if arg_16_1 and arg_16_0._resPath ~= arg_16_1 then
		arg_16_0._resPath = arg_16_1
		arg_16_0._assetId = ResMgr.getAbAsset(arg_16_0._resPath, arg_16_0._onResLoaded, arg_16_0, arg_16_0._assetId)

		if arg_16_0._assetId then
			arg_16_0:getMap():addUnitNeedLoadedNum(1)
		end
	elseif arg_16_1 and arg_16_0._resPath == arg_16_1 and arg_16_0._displayGo == nil then
		arg_16_0._assetId = ResMgr.getAbAsset(arg_16_0._resPath, arg_16_0._onResLoaded, arg_16_0, arg_16_0._assetId)

		if arg_16_0._assetId then
			arg_16_0:getMap():addUnitNeedLoadedNum(1)
		end
	else
		arg_16_0:onResLoaded()
	end
end

function var_0_0.getMap(arg_17_0)
	return ExploreController.instance:getMap()
end

function var_0_0.setInteractActive(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.mo:getStatus()
	local var_18_1 = ExploreHelper.setBit(var_18_0, ExploreEnum.InteractIndex.ActiveState, arg_18_1)

	arg_18_0.mo:setStatus(var_18_1)
end

function var_0_0.getResPath(arg_19_0)
	return arg_19_0._resPath
end

function var_0_0._onResLoaded(arg_20_0, arg_20_1)
	if not arg_20_1.IsLoadSuccess then
		return
	end

	arg_20_0:_releaseDisplayGo()

	if arg_20_0:isActive() then
		arg_20_0._displayGo = arg_20_1:getInstance(nil, nil, arg_20_0.go)
		arg_20_0._displayTr = arg_20_0._displayGo.transform
		arg_20_0._rotateRoot = arg_20_0._displayTr:Find("#go_rotate")

		if arg_20_0.mo then
			transformhelper.setLocalPos(arg_20_0._displayTr, arg_20_0.mo.resPosition[1], arg_20_0.mo.resPosition[2], arg_20_0.mo.resPosition[3])
		end

		local var_20_0 = arg_20_0:getCompList()

		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			if iter_20_1.setup then
				iter_20_1:setup(arg_20_0._displayGo)
			end
		end

		arg_20_0:updateRotation()
		arg_20_0:updateRotationRoot()
		arg_20_0:onResLoaded()
		arg_20_0:_checkContainerNeedUpdate()

		if not arg_20_0._akComp and ExploreConfig.instance:getAssetNeedAkGo(arg_20_0._resPath) then
			gohelper.addAkGameObject(arg_20_0.go)

			arg_20_0._akComp = true
		end

		if not arg_20_0._playedEnter and arg_20_0.animComp and arg_20_0.animComp.haveAnim and arg_20_0.animComp:haveAnim(ExploreAnimEnum.AnimName.enter) then
			arg_20_0:markPlayedEnter()
			arg_20_0.animComp:playAnim(ExploreAnimEnum.AnimName.enter)
		end

		arg_20_0:setOutLight(arg_20_0._showOutLine)
	end
end

function var_0_0._checkContainerNeedUpdate(arg_21_0)
	local var_21_0 = false

	if arg_21_0.animComp and arg_21_0.animComp.animator then
		var_21_0 = true
	end

	arg_21_0._luamonoContainer.enabled = var_21_0
end

function var_0_0.onMapInit(arg_22_0)
	arg_22_0:markPlayedEnter()
end

function var_0_0.markPlayedEnter(arg_23_0)
	arg_23_0._playedEnter = true
end

function var_0_0.updateRotation(arg_24_0)
	if not arg_24_0._displayTr or not arg_24_0.mo then
		return
	end

	transformhelper.setLocalRotation(arg_24_0._displayTr, arg_24_0.mo.resRotation[1], arg_24_0.mo.resRotation[2], arg_24_0.mo.resRotation[3])
end

function var_0_0.getEffectRoot(arg_25_0)
	return arg_25_0._rotateRoot or arg_25_0._displayTr or arg_25_0.trans
end

function var_0_0.updateRotationRoot(arg_26_0)
	if not arg_26_0._rotateRoot or not arg_26_0.mo then
		return
	end

	transformhelper.setLocalRotation(arg_26_0._rotateRoot, 0, arg_26_0.mo.unitDir - arg_26_0.mo.resRotation[2], 0)
end

function var_0_0.onActiveChange(arg_27_0, arg_27_1)
	if arg_27_1 then
		arg_27_0:playAnim(ExploreAnimEnum.AnimName.nToA)
	else
		arg_27_0:playAnim(ExploreAnimEnum.AnimName.aToN)
	end

	var_0_0.super.onActiveChange(arg_27_0, arg_27_1)
end

function var_0_0.onInteractChange(arg_28_0, arg_28_1)
	if arg_28_1 then
		arg_28_0:playAnim(ExploreAnimEnum.AnimName.uToN)
	else
		arg_28_0:playAnim(ExploreAnimEnum.AnimName.nToU)
	end

	var_0_0.super.onInteractChange(arg_28_0, arg_28_1)
end

function var_0_0.forceOutLine(arg_29_0, arg_29_1)
	arg_29_0._isForceOutLight = arg_29_1

	arg_29_0:setOutLight(arg_29_0._showOutLine)
end

function var_0_0.setOutLight(arg_30_0, arg_30_1)
	if not arg_30_0._displayGo or not arg_30_0.outLineComp then
		return
	end

	arg_30_0.outLineComp:setOutLight(arg_30_0._isForceOutLight or arg_30_1)
end

function var_0_0.onRoleNear(arg_31_0)
	var_0_0.super.onRoleNear(arg_31_0)

	if arg_31_0.mo.isStrong then
		return
	end

	arg_31_0:checkShowIcon()
end

function var_0_0.onRoleFar(arg_32_0)
	var_0_0.super.onRoleFar(arg_32_0)

	if arg_32_0.mo.isStrong then
		return
	end

	arg_32_0:checkShowIcon()
end

function var_0_0.isCustomShowOutLine(arg_33_0)
	return false
end

function var_0_0.checkShowIcon(arg_34_0)
	if not arg_34_0.mo then
		return
	end

	local var_34_0 = lua_explore_unit.configDict[arg_34_0.mo.customIconType or arg_34_0.mo.type]

	if var_34_0 then
		local var_34_1 = false

		if arg_34_0.mo.isStrong then
			var_34_1 = true
		elseif arg_34_0._roleNear and var_34_0.isShow == 1 then
			var_34_1 = true
		end

		local var_34_2 = arg_34_0:canTrigger()

		if var_34_1 and not var_34_2 and not arg_34_0:isCustomShowOutLine() and not arg_34_0.mo.isCanMove or not arg_34_0:isEnter() then
			var_34_1 = false
		end

		if not string.nilorempty(var_34_0.mapActiveIcon) and arg_34_0.mo:isInteractActiveState() then
			ExploreMapModel.instance:setSmallMapIconById(arg_34_0.id, arg_34_0.mo.nodeKey, var_34_0.mapActiveIcon)
		elseif not string.nilorempty(var_34_0.mapIcon) or not string.nilorempty(var_34_0.mapIcon2) then
			local var_34_3 = arg_34_0.mo.isStrong and var_34_0.mapIcon2 or var_34_0.mapIcon
			local var_34_4 = arg_34_0:processMapIcon(var_34_3)

			if var_34_0.mapIconShow == 1 then
				ExploreMapModel.instance:setSmallMapIconById(arg_34_0.id, arg_34_0.mo.nodeKey, var_34_4)
			else
				ExploreMapModel.instance:setSmallMapIconById(arg_34_0.id, arg_34_0.mo.nodeKey, var_34_2 and var_34_4 or nil)
			end
		else
			ExploreMapModel.instance:setSmallMapIconById(arg_34_0.id, arg_34_0.mo.nodeKey, nil)
		end

		arg_34_0._showOutLine = var_34_1

		arg_34_0:setOutLight(var_34_1)
	end
end

function var_0_0.processMapIcon(arg_35_0, arg_35_1)
	return arg_35_1
end

function var_0_0.hideMapIcon(arg_36_0)
	if not arg_36_0.mo then
		return
	end

	local var_36_0 = lua_explore_unit.configDict[arg_36_0.mo.customIconType or arg_36_0.mo.type]

	if not var_36_0 or string.nilorempty(var_36_0.mapIcon) and string.nilorempty(var_36_0.mapIcon2) and string.nilorempty(var_36_0.mapActiveIcon) then
		return
	end

	ExploreMapModel.instance:setSmallMapIconById(arg_36_0.id, arg_36_0.mo.nodeKey, nil)
end

function var_0_0.onInFOVChange(arg_37_0, arg_37_1)
	arg_37_0:setActive(arg_37_1)

	if arg_37_1 then
		arg_37_0:setupRes()
		TaskDispatcher.cancelTask(arg_37_0._releaseDisplayGo, arg_37_0)
	else
		TaskDispatcher.runDelay(arg_37_0._releaseDisplayGo, arg_37_0, ExploreConstValue.CHECK_INTERVAL.UnitObjDestory)
	end
end

function var_0_0.setActive(arg_38_0, ...)
	var_0_0.super.setActive(arg_38_0, ...)

	if not ... and arg_38_0.animEffectComp and arg_38_0.animEffectComp.destoryEffectIfOnce then
		arg_38_0.animEffectComp:destoryEffectIfOnce()
	end
end

function var_0_0.onNodeChange(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0:checkLight()
end

function var_0_0.setEmitLight(arg_40_0, arg_40_1)
	arg_40_0._isNoEmitLight = arg_40_1
end

function var_0_0.getIsNoEmitLight(arg_41_0)
	return arg_41_0._isNoEmitLight
end

function var_0_0.checkLight(arg_42_0)
	local var_42_0 = arg_42_0:getLightRecvType()

	if var_42_0 == ExploreEnum.LightRecvType.Photic or var_42_0 == ExploreEnum.LightRecvType.Custom then
		return
	end

	if not ExploreController.instance:getMap():isInitDone() then
		return
	end

	ExploreController.instance:getMapLight():updateLightsByUnit(arg_42_0)
end

function var_0_0.getIdleAnim(arg_43_0)
	local var_43_0 = arg_43_0.mo

	if not var_43_0:isInteractEnabled() then
		return ExploreAnimEnum.AnimName.unable
	elseif not var_43_0:isInteractActiveState() then
		return ExploreAnimEnum.AnimName.normal
	else
		return ExploreAnimEnum.AnimName.active
	end
end

function var_0_0.onResLoaded(arg_44_0)
	return
end

function var_0_0._releaseDisplayGo(arg_45_0)
	arg_45_0:clearComp()

	if arg_45_0._assetId and not arg_45_0:isRole() then
		arg_45_0:getMap():addUnitNeedLoadedNum(-1)
	end

	ResMgr.removeCallBack(arg_45_0._assetId)
	ResMgr.ReleaseObj(arg_45_0._displayGo)

	arg_45_0._displayGo = nil
	arg_45_0._displayTr = nil
	arg_45_0._rotateRoot = nil
	arg_45_0._assetId = nil

	arg_45_0:_checkContainerNeedUpdate()
end

function var_0_0.clearComp(arg_46_0)
	local var_46_0 = arg_46_0:getCompList()

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		if iter_46_1.clear then
			iter_46_1:clear()
		end
	end
end

function var_0_0.onDestroy(arg_47_0)
	arg_47_0:_releaseDisplayGo()
	TaskDispatcher.cancelTask(arg_47_0._releaseDisplayGo, arg_47_0)

	if arg_47_0._tweenId then
		ZProj.TweenHelper.KillById(arg_47_0._tweenId, true)

		arg_47_0._tweenId = nil
	end
end

return var_0_0
