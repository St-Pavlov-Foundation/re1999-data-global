module("modules.logic.fight.entity.comp.FightUnitSpine_500M", package.seeall)

local var_0_0 = class("FightUnitSpine_500M", LuaCompBase)

function var_0_0._onResLoaded(arg_1_0, arg_1_1)
	return
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.entityId = arg_2_1.id
	arg_2_0.unitSpawn = arg_2_1

	LuaEventSystem.addEventMechanism(arg_2_0)
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0.behindGo = gohelper.create3d(arg_3_1, "behind")
	arg_3_0.centerGo = gohelper.create3d(arg_3_1, "center")
	arg_3_0.frontGo = gohelper.create3d(arg_3_1, "front")

	arg_3_0:setCenterSpinePos()
	FightController.instance:registerCallback(FightEvent.RefreshSpineHeadIcon, arg_3_0.refreshSpineHeadIcon, arg_3_0)
end

function var_0_0.setCenterSpinePos(arg_4_0)
	arg_4_0:initOffset()

	local var_4_0 = arg_4_0.centerGo.transform

	transformhelper.setLocalPos(var_4_0, arg_4_0.offsetX, arg_4_0.offsetY, arg_4_0.offsetZ)
end

function var_0_0.initOffset(arg_5_0)
	if arg_5_0.offsetX then
		return
	end

	local var_5_0 = lua_fight_const.configDict[56]

	if not var_5_0 then
		arg_5_0.offsetX = 0
		arg_5_0.offsetY = 0
		arg_5_0.offsetZ = 0

		return
	end

	local var_5_1 = FightStrUtil.instance:getSplitToNumberCache(var_5_0.value, "#")

	if not var_5_1 then
		arg_5_0.offsetX = 0
		arg_5_0.offsetY = 0
		arg_5_0.offsetZ = 0

		return
	end

	arg_5_0.offsetX = var_5_1[1]
	arg_5_0.offsetY = var_5_1[2]
	arg_5_0.offsetZ = var_5_1[3]
end

function var_0_0.getCenterSpineOffset(arg_6_0)
	arg_6_0:initOffset()

	return arg_6_0.offsetX, arg_6_0.offsetY, arg_6_0.offsetZ
end

function var_0_0.refreshSpineHeadIcon(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = lua_fight_sp_500m_model.configDict[arg_7_1]

	if not var_7_0 then
		logError("爬塔500M模型配置不存在 : " .. tostring(arg_7_1))

		return
	end

	local var_7_1 = var_7_0.headIcon

	if var_7_1 == arg_7_0.headIcon then
		logError("refresh head icon, but icon is equal src")

		return
	end

	arg_7_0.headIcon = var_7_1

	arg_7_0:loadCenterSpineTexture()
end

function var_0_0.reInitDefaultAnimState(arg_8_0)
	arg_8_0:callFunc("reInitDefaultAnimState")
end

function var_0_0.play(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_0:callFunc("play", arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
end

function var_0_0.replaceAnimState(arg_10_0, arg_10_1)
	arg_10_0:callFunc("replaceAnimState", arg_10_1)
end

function var_0_0._onTransitionAnimEvent(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return
end

function var_0_0.tryPlay(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	return arg_12_0:callFunc("tryPlay", arg_12_1, arg_12_2, arg_12_3)
end

function var_0_0._cannotPlay(arg_13_0, arg_13_1)
	return arg_13_0:callFunc("_cannotPlay", arg_13_1)
end

function var_0_0.playAnim(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0:callFunc("playAnim", arg_14_1, arg_14_2, arg_14_3)
end

function var_0_0.setFreeze(arg_15_0, arg_15_1)
	arg_15_0:callFunc("setFreeze", arg_15_1)
end

function var_0_0.setTimeScale(arg_16_0, arg_16_1)
	arg_16_0:callFunc("setTimeScale", arg_16_1)
end

function var_0_0.setLayer(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:callFunc("setLayer", arg_17_1, arg_17_2)
end

local var_0_1 = 10

function var_0_0.setRenderOrder(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.frontSpine then
		arg_18_0.frontSpine:setRenderOrder(arg_18_1 + var_0_1, arg_18_2)
	end

	if arg_18_0.centerSpine then
		arg_18_0.centerSpine:setRenderOrder(arg_18_1, arg_18_2)
	end

	if arg_18_0.behindSpine then
		arg_18_0.behindSpine:setRenderOrder(arg_18_1 - var_0_1, arg_18_2)
	end
end

function var_0_0.changeLookDir(arg_19_0, arg_19_1)
	arg_19_0:callFunc("changeLookDir", arg_19_1)
end

function var_0_0._changeLookDir(arg_20_0)
	arg_20_0:callFunc("_changeLookDir")
end

function var_0_0.setActive(arg_21_0, arg_21_1)
	arg_21_0:callFunc("setActive", arg_21_1)
end

function var_0_0.setAnimation(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0:callFunc("setAnimation", arg_22_1, arg_22_2, arg_22_3)
end

function var_0_0._initSpine(arg_23_0, arg_23_1)
	return
end

function var_0_0._initSpecialSpine(arg_24_0)
	return
end

function var_0_0.detectDisplayInScreen(arg_25_0)
	return arg_25_0:callFunc("detectDisplayInScreen")
end

function var_0_0.detectRefreshAct(arg_26_0, arg_26_1)
	return arg_26_0:callFunc("detectRefreshAct", arg_26_1)
end

function var_0_0._onBuffUpdate(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	return
end

function var_0_0.releaseSpecialSpine(arg_28_0)
	arg_28_0:callFunc("releaseSpecialSpine")
end

function var_0_0._clear(arg_29_0)
	arg_29_0:callFunc("_clear")
end

function var_0_0.beforeDestroy(arg_30_0)
	arg_30_0:clearLoader()
	arg_30_0:removeAnimEventCallback(arg_30_0.onAnimEvent, arg_30_0)
	FightController.instance:unregisterCallback(FightEvent.RefreshSpineHeadIcon, arg_30_0.refreshSpineHeadIcon, arg_30_0)
	arg_30_0:callFunc("beforeDestroy")
end

function var_0_0.onDestroy(arg_31_0)
	return
end

function var_0_0.getSpineGO(arg_32_0)
	if arg_32_0.centerSpine then
		return arg_32_0.centerSpine:getSpineGO()
	end
end

function var_0_0.getSpineTr(arg_33_0)
	if arg_33_0.centerSpine then
		return arg_33_0.centerSpine:getSpineTr()
	end
end

function var_0_0.getSkeletonAnim(arg_34_0)
	if arg_34_0.centerSpine then
		return arg_34_0.centerSpine:getSkeletonAnim()
	end
end

function var_0_0.getAnimState(arg_35_0)
	if arg_35_0.centerSpine then
		return arg_35_0.centerSpine:getSkeletonAnim()
	end
end

function var_0_0.getPPEffectMask(arg_36_0)
	if arg_36_0.centerSpine then
		return arg_36_0.centerSpine:getPPEffectMask()
	end
end

function var_0_0.getLookDir(arg_37_0)
	if arg_37_0.centerSpine then
		return arg_37_0.centerSpine:getLookDir()
	end
end

function var_0_0.hasAnimation(arg_38_0, arg_38_1)
	if arg_38_0.centerSpine then
		return arg_38_0.centerSpine:hasAnimation(arg_38_1)
	end
end

function var_0_0.addAnimEventCallback(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_0.centerSpine then
		return arg_39_0.centerSpine:addAnimEventCallback(arg_39_1, arg_39_2, arg_39_3)
	end
end

function var_0_0.removeAnimEventCallback(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0.centerSpine then
		return arg_40_0.centerSpine:removeAnimEventCallback(arg_40_1, arg_40_2)
	end
end

function var_0_0.removeAllAnimEventCallback(arg_41_0)
	if arg_41_0.centerSpine then
		return arg_41_0.centerSpine:removeAllAnimEventCallback()
	end
end

function var_0_0._onAnimCallback(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	return
end

function var_0_0.setResPath(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = arg_43_0.unitSpawn:getMO().modelId

	if not var_43_0 then
		return
	end

	local var_43_1 = lua_fight_sp_500m_model.configDict[var_43_0]

	if not var_43_1 then
		logError("爬塔500M模型配置不存在 : " .. tostring(var_43_0))

		return
	end

	arg_43_0.loadedCb = arg_43_2
	arg_43_0.loadedCbObj = arg_43_3
	arg_43_0.headIcon = var_43_1.headIcon
	arg_43_0.frontSpineLoaded = false
	arg_43_0.centerSpineLoaded = false
	arg_43_0.behindSpineLoaded = false

	if not arg_43_0.frontSpine then
		arg_43_0.frontSpine = MonoHelper.addLuaComOnceToGo(arg_43_0.frontGo, FightUnitSpine, arg_43_0.unitSpawn)
	end

	if not arg_43_0.centerSpine then
		arg_43_0.centerSpine = MonoHelper.addLuaComOnceToGo(arg_43_0.centerGo, FightUnitSpine, arg_43_0.unitSpawn)
	end

	if not arg_43_0.behindSpine then
		arg_43_0.behindSpine = MonoHelper.addLuaComOnceToGo(arg_43_0.behindGo, FightUnitSpine, arg_43_0.unitSpawn)
	end

	arg_43_0:loadCenterSpineTexture()
	arg_43_0.frontSpine:setResPath(arg_43_0:getSpineRes(var_43_1.front), arg_43_0.onFrontResLoaded, arg_43_0)
	arg_43_0.centerSpine:setResPath(arg_43_0:getSpineRes(var_43_1.center), arg_43_0.onCenterResLoaded, arg_43_0)
	arg_43_0.behindSpine:setResPath(arg_43_0:getSpineRes(var_43_1.behind), arg_43_0.onBehindResLoaded, arg_43_0)
end

function var_0_0.getSpineRes(arg_44_0, arg_44_1)
	return string.format("roles/%s.prefab", arg_44_1)
end

function var_0_0.callFunc(arg_45_0, arg_45_1, ...)
	if arg_45_0.frontSpine then
		local var_45_0 = arg_45_0.frontSpine[arg_45_1]

		if var_45_0 then
			var_45_0(arg_45_0.frontSpine, ...)
		else
			logError("not found func int frontSpine : " .. tostring(arg_45_1))
		end
	end

	if arg_45_0.behindSpine then
		local var_45_1 = arg_45_0.behindSpine[arg_45_1]

		if var_45_1 then
			var_45_1(arg_45_0.behindSpine, ...)
		else
			logError("not found func int behindSpine : " .. tostring(arg_45_1))
		end
	end

	if arg_45_0.centerSpine then
		local var_45_2 = arg_45_0.centerSpine[arg_45_1]

		if var_45_2 then
			return var_45_2(arg_45_0.centerSpine, ...)
		else
			logError("not found func int centerSpine : " .. tostring(arg_45_1))
		end
	end
end

function var_0_0.onFrontResLoaded(arg_46_0)
	gohelper.addChild(arg_46_0.frontGo, arg_46_0.frontSpine:getSpineGO())

	arg_46_0.frontSpineLoaded = true

	arg_46_0.frontSpine:setActive(false)
	arg_46_0:checkLoadResDone()
end

function var_0_0.onCenterResLoaded(arg_47_0)
	gohelper.addChild(arg_47_0.centerGo, arg_47_0.centerSpine:getSpineGO())

	arg_47_0.centerSpineLoaded = true

	arg_47_0.centerSpine:setActive(false)
	arg_47_0:checkLoadResDone()
end

function var_0_0.onBehindResLoaded(arg_48_0)
	gohelper.addChild(arg_48_0.behindGo, arg_48_0.behindSpine:getSpineGO())

	arg_48_0.behindSpineLoaded = true

	arg_48_0.behindSpine:setActive(false)
	arg_48_0:checkLoadResDone()
end

function var_0_0.checkLoadResDone(arg_49_0)
	if not arg_49_0.frontSpineLoaded then
		return
	end

	if not arg_49_0.centerSpineLoaded then
		return
	end

	if not arg_49_0.behindSpineLoaded then
		return
	end

	arg_49_0:setActive(true)

	if arg_49_0:checkCanPlayBornAnim() then
		arg_49_0:addAnimEventCallback(arg_49_0.onAnimEvent, arg_49_0)
		arg_49_0:playAnim("born", false, true)
	end

	if arg_49_0.loadedCb then
		if arg_49_0.loadedCbObj then
			arg_49_0.loadedCb(arg_49_0.loadedCbObj, arg_49_0)
		else
			arg_49_0.loadedCb(arg_49_0)
		end
	end

	arg_49_0.loadedCb = nil
	arg_49_0.loadedCbObj = nil

	arg_49_0:setHeadTexture()
	arg_49_0:dispatchEvent(UnitSpine.Evt_OnLoaded)
end

function var_0_0.checkCanPlayBornAnim(arg_50_0)
	if FightModel.instance.needFightReconnect then
		return false
	end

	return arg_50_0.unitSpawn:getCreateStage() == FightEnum.EntityCreateStage.Init
end

function var_0_0.onAnimEvent(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if arg_51_2 == SpineAnimEvent.ActionComplete then
		arg_51_0:removeAnimEventCallback(arg_51_0.onAnimEvent, arg_51_0)
		arg_51_0.unitSpawn:resetAnimState()
	end
end

function var_0_0.loadCenterSpineTexture(arg_52_0)
	if string.nilorempty(arg_52_0.headIcon) then
		arg_52_0:onLoadTextureFinish()

		return
	end

	arg_52_0:clearLoader()

	arg_52_0.loader = MultiAbLoader.New()

	arg_52_0.loader:addPath(ResUrl.getRoleDynamicTexture(arg_52_0.headIcon))
	arg_52_0.loader:startLoad(arg_52_0.onLoadTextureFinish, arg_52_0)
end

function var_0_0.onLoadTextureFinish(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1 and arg_53_1:getFirstAssetItem()

	arg_53_0.headTexture = var_53_0 and var_53_0:GetResource()
	arg_53_0.loadHeadTextureDone = true

	arg_53_0:setHeadTexture()
end

local var_0_2 = UnityEngine.Shader.PropertyToID("_MainTex")

function var_0_0.setHeadTexture(arg_54_0)
	local var_54_0 = arg_54_0.unitSpawn.spineRenderer:getReplaceMat()

	if var_54_0 and arg_54_0.headTexture then
		var_54_0:SetTexture(var_0_2, arg_54_0.headTexture)
	end
end

function var_0_0.clearLoader(arg_55_0)
	if arg_55_0.loader then
		arg_55_0.loader:dispose()

		arg_55_0.loader = nil
	end

	arg_55_0.headTexture = nil
	arg_55_0.loadHeadTextureDone = false
end

return var_0_0
