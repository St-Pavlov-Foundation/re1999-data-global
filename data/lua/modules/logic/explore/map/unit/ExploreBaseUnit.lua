module("modules.logic.explore.map.unit.ExploreBaseUnit", package.seeall)

local var_0_0 = class("ExploreBaseUnit", BaseUnitSpawn)
local var_0_1 = typeof(SLFramework.LuaMonobehavier)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = gohelper.create3d(arg_1_1, arg_1_2)

	arg_1_0.trans = var_1_0.transform

	arg_1_0:init(var_1_0)

	arg_1_0._hasInteract = false
	arg_1_0._isEnter = false

	arg_1_0:onInit()

	arg_1_0._luamonoContainer = var_1_0:GetComponent(var_0_1)

	arg_1_0:_checkContainerNeedUpdate()
end

function var_0_0.isRole(arg_2_0)
	return false
end

function var_0_0.canMove(arg_3_0)
	return false
end

function var_0_0.onEnter(arg_4_0)
	return
end

function var_0_0.onUpdateCount(arg_5_0, arg_5_1, arg_5_2)
	return
end

function var_0_0.setupMO(arg_6_0)
	return
end

function var_0_0.doFix(arg_7_0)
	return
end

function var_0_0.onTriggerDone(arg_8_0)
	return
end

function var_0_0.onTrigger(arg_9_0)
	return
end

function var_0_0.onCancelTrigger(arg_10_0)
	return
end

function var_0_0.onRoleEnter(arg_11_0, arg_11_1, arg_11_2)
	return
end

function var_0_0.onRoleStay(arg_12_0)
	return
end

function var_0_0.onRoleLeave(arg_13_0)
	return
end

function var_0_0.onExit(arg_14_0)
	return
end

function var_0_0.onRelease(arg_15_0)
	return
end

function var_0_0.onDestroy(arg_16_0)
	return
end

function var_0_0.isMoving(arg_17_0)
	return false
end

function var_0_0._checkContainerNeedUpdate(arg_18_0)
	return
end

function var_0_0.onLightDataChange(arg_19_0, arg_19_1)
	if arg_19_0.lightComp then
		arg_19_0.lightComp:onLightDataChange(arg_19_1)
	end
end

function var_0_0.onStatusChange(arg_20_0, arg_20_1)
	if ExploreHelper.getBit(arg_20_1, ExploreEnum.InteractIndex.InteractEnabled) > 0 then
		arg_20_0:onInteractChange(arg_20_0.mo:isInteractEnabled())
	end

	if ExploreHelper.getBit(arg_20_1, ExploreEnum.InteractIndex.ActiveState) > 0 then
		local var_20_0 = arg_20_0.mo:isInteractActiveState()

		arg_20_0:onActiveChange(var_20_0)

		if arg_20_0.mo then
			arg_20_0.mo:activeStateChange(var_20_0)
		end
	end
end

function var_0_0.onStatus2Change(arg_21_0, arg_21_1, arg_21_2)
	return
end

function var_0_0.onInteractChange(arg_22_0, arg_22_1)
	return
end

function var_0_0.onActiveChange(arg_23_0, arg_23_1)
	return
end

function var_0_0.onNodeChange(arg_24_0, arg_24_1, arg_24_2)
	return
end

function var_0_0.onRoleNear(arg_25_0)
	arg_25_0._roleNear = true
end

function var_0_0.onRoleFar(arg_26_0)
	arg_26_0._roleNear = false
end

function var_0_0.onMapInit(arg_27_0)
	return
end

function var_0_0.onHeroInitDone(arg_28_0)
	return
end

function var_0_0.setData(arg_29_0, arg_29_1)
	arg_29_0.mo = arg_29_1
	arg_29_0.id = arg_29_1.id
	arg_29_0.go.name = arg_29_0.__cname .. arg_29_1.id

	arg_29_0:setPosByNode(arg_29_1.nodePos)

	if arg_29_0.mo:isEnter() then
		arg_29_0:setEnter()
	else
		arg_29_0:setExit()
	end

	arg_29_0:_setupMO()
end

function var_0_0.getExploreUnitMO(arg_30_0)
	return arg_30_0.mo
end

function var_0_0.setTmpData(arg_31_0, arg_31_1)
	arg_31_0.mo = arg_31_1
	arg_31_0.id = arg_31_1.id
	arg_31_0.go.name = arg_31_0.__cname .. arg_31_1.id

	arg_31_0:setPosByNode(arg_31_1.nodePos, true)
	arg_31_0:_setupMO()
end

function var_0_0._setupMO(arg_32_0)
	arg_32_0:setupMO()
end

function var_0_0.tryTrigger(arg_33_0, arg_33_1)
	if arg_33_0.mo:isInteractEnabled() and arg_33_0._isEnter then
		arg_33_0:onTrigger()
		ExploreMapTriggerController.instance:triggerUnit(arg_33_0, arg_33_1)

		return arg_33_0:needInteractAnim()
	end
end

function var_0_0.needInteractAnim(arg_34_0)
	return false
end

function var_0_0.cancelTrigger(arg_35_0)
	arg_35_0:onCancelTrigger()
	ExploreMapTriggerController.instance:cancelTrigger(arg_35_0)
end

function var_0_0.getHasInteract(arg_36_0)
	return arg_36_0.mo:isInteractDone()
end

function var_0_0.setName(arg_37_0, arg_37_1)
	arg_37_0.go.name = arg_37_1
end

function var_0_0.setParent(arg_38_0, arg_38_1)
	arg_38_0.trans:SetParent(arg_38_1)
end

function var_0_0.getPos(arg_39_0)
	return arg_39_0.position
end

function var_0_0.getUnitType(arg_40_0)
	if arg_40_0.mo then
		return arg_40_0.mo.type
	end
end

function var_0_0.needUpdateHeroPos(arg_41_0)
	return false
end

function var_0_0.getFixItemId(arg_42_0)
	return nil
end

function var_0_0.canTrigger(arg_43_0)
	return arg_43_0.mo and arg_43_0.mo:isInteractEnabled() and not arg_43_0.mo:isInteractFinishState() and arg_43_0:isEnter()
end

function var_0_0.isInteractActiveState(arg_44_0)
	if arg_44_0.mo then
		return arg_44_0.mo:isInteractActiveState()
	end

	return false
end

function var_0_0.setPos(arg_45_0, arg_45_1, arg_45_2)
	if gohelper.isNil(arg_45_0.go) == false then
		transformhelper.setPos(arg_45_0.trans, -999999, 0, -99999)

		arg_45_1.y = 10

		local var_45_0, var_45_1 = UnityEngine.Physics.Raycast(arg_45_1, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

		if var_45_0 then
			arg_45_1.y = var_45_1.point.y
		else
			arg_45_1.y = arg_45_0.trans.position.y
		end

		arg_45_0.position = arg_45_1

		transformhelper.setPos(arg_45_0.trans, arg_45_0.position.x, arg_45_0.position.y, arg_45_0.position.z)

		local var_45_2 = ExploreHelper.posToTile(arg_45_1)

		if var_45_2 ~= arg_45_0.nodePos then
			local var_45_3 = arg_45_0.nodePos

			arg_45_0.nodePos = var_45_2

			if arg_45_0.mo then
				arg_45_0.mo:updatePos(var_45_2)
			end

			arg_45_0.nodeMO = ExploreMapModel.instance:getNode(ExploreHelper.getKey(arg_45_0.nodePos))

			if arg_45_2 ~= true then
				ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitNodeChange, arg_45_0, arg_45_0.nodePos, var_45_3)
			end

			arg_45_0:onNodeChange(var_45_3, arg_45_0.nodePos)
		end
	end
end

function var_0_0.removeFromNode(arg_46_0)
	local var_46_0 = arg_46_0.nodePos

	arg_46_0.nodePos = nil

	if arg_46_0.mo then
		arg_46_0.mo:removeFromNode()
	end

	arg_46_0.nodeMO = nil

	ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitNodeChange, arg_46_0, false, var_46_0)
	arg_46_0:onNodeChange(var_46_0, arg_46_0.nodePos)
end

function var_0_0.isPassLight(arg_47_0)
	return arg_47_0:getLightRecvType() == ExploreEnum.LightRecvType.Photic
end

function var_0_0.getLightRecvType(arg_48_0)
	return arg_48_0.mo.isPhotic and ExploreEnum.LightRecvType.Photic or ExploreEnum.LightRecvType.Barricade
end

function var_0_0.getLightRecvDirs(arg_49_0)
	return nil
end

function var_0_0.onLightChange(arg_50_0, arg_50_1, arg_50_2)
	return
end

function var_0_0.onLightEnter(arg_51_0, arg_51_1)
	return
end

function var_0_0.onLightExit(arg_52_0)
	return
end

function var_0_0.onRotation(arg_53_0)
	return
end

function var_0_0.setInFOV(arg_54_0, arg_54_1)
	if arg_54_0:isEnter() and arg_54_0._isInFOV ~= arg_54_1 then
		arg_54_0._isInFOV = arg_54_1

		arg_54_0:onInFOVChange(arg_54_1)
	end
end

function var_0_0.isInFOV(arg_55_0)
	return arg_55_0._isInFOV or false
end

function var_0_0.onInFOVChange(arg_56_0, arg_56_1)
	return
end

function var_0_0.updateSceneY(arg_57_0, arg_57_1)
	if arg_57_1 then
		arg_57_0.position.y = arg_57_1
	else
		local var_57_0 = arg_57_0.position.y

		arg_57_0.position.y = 10

		local var_57_1, var_57_2 = UnityEngine.Physics.Raycast(arg_57_0.position, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

		if var_57_1 then
			arg_57_0.position.y = var_57_2.point.y
		else
			arg_57_0.position.y = arg_57_0.trans.position.y
		end
	end

	transformhelper.setPos(arg_57_0.trans, arg_57_0.position.x, arg_57_0.position.y, arg_57_0.position.z)
end

function var_0_0.setScale(arg_58_0, arg_58_1)
	transformhelper.setLocalScale(arg_58_0.trans, arg_58_1, arg_58_1, arg_58_1)
end

function var_0_0.setRotate(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	transformhelper.setLocalRotation(arg_59_0.trans, arg_59_1, arg_59_2, arg_59_3)
end

function var_0_0.setPosByNode(arg_60_0, arg_60_1, arg_60_2)
	arg_60_0:setPos(ExploreHelper.tileToPos(arg_60_1), arg_60_2)
end

function var_0_0.isEnter(arg_61_0)
	return arg_61_0._isEnter
end

function var_0_0.isActive(arg_62_0)
	return arg_62_0.go.activeSelf
end

function var_0_0.isEnable(arg_63_0)
	return arg_63_0:isActive()
end

function var_0_0.setActive(arg_64_0, arg_64_1)
	gohelper.setActive(arg_64_0.go, arg_64_1)
end

function var_0_0.setEnter(arg_65_0)
	if not arg_65_0:isEnter() then
		arg_65_0._isEnter = true

		arg_65_0.mo:setEnter(true)

		if isDebugBuild then
			logWarn(string.format("[+]%s:%s进入地图", arg_65_0.__cname, arg_65_0.id))
		end

		arg_65_0:setActive(true)
		arg_65_0:onEnter()
	end
end

function var_0_0.setExit(arg_66_0)
	if arg_66_0:isEnter() then
		arg_66_0._isEnter = false

		arg_66_0.mo:setEnter(false)

		if isDebugBuild then
			logWarn(string.format("[-]%s:%s退出地图", arg_66_0.__cname, arg_66_0.id))
		end

		arg_66_0:setActive(false)
		arg_66_0:onExit()
	else
		logWarn("重复退出" .. arg_66_0.id .. arg_66_0.__cname)
	end
end

function var_0_0.destroy(arg_67_0)
	arg_67_0:onDestroy()
	gohelper.destroy(arg_67_0.go)

	arg_67_0.trans = nil
	arg_67_0.mo = nil
	arg_67_0.go = nil
end

return var_0_0
