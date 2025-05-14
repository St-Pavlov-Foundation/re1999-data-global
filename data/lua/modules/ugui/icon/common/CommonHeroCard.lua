module("modules.ugui.icon.common.CommonHeroCard", package.seeall)

local var_0_0 = class("CommonHeroCard", ListScrollCell)
local var_0_1 = typeof(UnityEngine.UI.Mask)
local var_0_2 = 0.001

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)

	var_1_0:setUseCase(arg_1_1)

	return var_1_0
end

local var_0_3 = {}

function var_0_0.put(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0 or not arg_2_1 or not arg_2_2 then
		if isDebugBuild then
			logError(string.format("put 参数为空 case{%s} skin{%s} spine{%s}", tostring(arg_2_0), tostring(arg_2_1), tostring(arg_2_2)))
		end

		return
	end

	var_0_3[arg_2_0] = var_0_3[arg_2_0] or {}
	var_0_3[arg_2_0][arg_2_1] = var_0_3[arg_2_0][arg_2_1] or {}

	table.insert(var_0_3[arg_2_0][arg_2_1], arg_2_2)
end

function var_0_0.get(arg_3_0, arg_3_1)
	if not arg_3_0 or not arg_3_1 then
		if isDebugBuild then
			logError(string.format("get 参数为空 case{%s} skin{%s}", tostring(arg_3_0), tostring(arg_3_1)))
		end

		return
	end

	local var_3_0 = var_0_3[arg_3_0]

	if var_3_0 then
		local var_3_1 = var_3_0[arg_3_1]

		if var_3_1 and #var_3_1 > 0 then
			for iter_3_0 = #var_3_1, 1, -1 do
				local var_3_2 = table.remove(var_3_1, #var_3_1)

				if not gohelper.isNil(var_3_2:getSpineGo()) then
					return var_3_2
				end
			end
		end
	end
end

function var_0_0.release(arg_4_0, arg_4_1)
	if not arg_4_0 or not arg_4_1 then
		if isDebugBuild then
			logError(string.format("release 参数为空 case{%s} spine{%s}", tostring(arg_4_0), tostring(arg_4_1)))
		end

		return
	end

	local var_4_0 = var_0_3[arg_4_0]

	if var_4_0 then
		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			for iter_4_2 = #iter_4_1, 1, -1 do
				if arg_4_1 == iter_4_1[iter_4_2] then
					table.remove(iter_4_1, iter_4_2)
				end
			end
		end
	end
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0._go = arg_5_1
	arg_5_0._tr = arg_5_1.transform
	arg_5_0._imgIcon = gohelper.onceAddComponent(arg_5_0._go, gohelper.Type_Image)
	arg_5_0._spineGO = nil
	arg_5_0._guiSpine = nil
end

function var_0_0.setUseCase(arg_6_0, arg_6_1)
	arg_6_0._reuseCase = arg_6_1
end

function var_0_0.setSpineRaycastTarget(arg_7_0, arg_7_1)
	arg_7_0._raycastTarget = arg_7_1 == true and true or false

	if arg_7_0._uiLimitSpine then
		local var_7_0 = arg_7_0._uiLimitSpine:getSkeletonGraphic()

		if var_7_0 then
			var_7_0.raycastTarget = arg_7_0._raycastTarget
		end
	end
end

function var_0_0.setGrayScale(arg_8_0, arg_8_1)
	ZProj.UGUIHelper.SetGrayscale(arg_8_0._go, arg_8_1)
end

function var_0_0.setGrayFactor(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._grayFactor

	arg_9_0._grayFactor = arg_9_1

	local var_9_1 = var_9_0 and var_9_0 > var_0_2
	local var_9_2 = arg_9_0._grayFactor and arg_9_0._grayFactor > var_0_2

	if (var_9_1 and not var_9_2 or not var_9_1 and var_9_2) and arg_9_0._skinConfig then
		arg_9_0:onUpdateMO(arg_9_0._skinConfig, true)
	end

	ZProj.UGUIHelper.SetGrayFactor(arg_9_0._go, arg_9_1)
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 and arg_10_1 == arg_10_0._skinConfig and not arg_10_2 then
		return
	end

	arg_10_0:_checkPutSpineToPool(arg_10_0._skinConfig)

	arg_10_0._skinConfig = arg_10_1
	arg_10_0._limitedCO = arg_10_0._skinConfig and lua_character_limited.configDict[arg_10_0._skinConfig.id]

	local var_10_0 = arg_10_0._grayFactor and arg_10_0._grayFactor > var_0_2
	local var_10_1 = arg_10_0._limitedCO and not string.nilorempty(arg_10_0._limitedCO.spine) and not var_10_0

	if var_10_1 then
		local var_10_2 = ResUrl.getRolesBustPrefab(arg_10_0._limitedCO.spine)

		if arg_10_0._uiLimitSpine then
			arg_10_0._uiLimitSpine:setResPath(var_10_2, arg_10_0._onSpineLoaded, arg_10_0, true)
		else
			if arg_10_0._reuseCase then
				arg_10_0._uiLimitSpine = var_0_0.get(arg_10_0._reuseCase, arg_10_0._skinConfig.id)

				if arg_10_0._uiLimitSpine then
					arg_10_0._limitSpineGO = arg_10_0._uiLimitSpine._gameObj

					local var_10_3, var_10_4 = recthelper.getAnchor(arg_10_0._limitSpineGO.transform)

					gohelper.addChild(arg_10_0._go, arg_10_0._limitSpineGO)
					recthelper.setAnchor(arg_10_0._limitSpineGO.transform, var_10_3, var_10_4)
				end
			end

			if not arg_10_0._uiLimitSpine then
				arg_10_0._limitSpineGO = gohelper.create2d(arg_10_0._go, "LimitedSpine")
				arg_10_0._uiLimitSpine = GuiSpine.Create(arg_10_0._limitSpineGO, false)

				arg_10_0._uiLimitSpine:setResPath(var_10_2, arg_10_0._onSpineLoaded, arg_10_0, true)
			end
		end

		gohelper.setActive(arg_10_0._limitSpineGO, true)
		gohelper.setAsFirstSibling(arg_10_0._limitSpineGO)

		if arg_10_0._simageIcon then
			arg_10_0._simageIcon:UnLoadImage()
		end

		arg_10_0._imgIcon.enabled = true

		TaskDispatcher.runRepeat(arg_10_0._checkAlphaClip, arg_10_0, 0.05, 20)
	else
		TaskDispatcher.cancelTask(arg_10_0._checkAlphaClip, arg_10_0)

		if not arg_10_0._simageIcon then
			arg_10_0._simageIcon = gohelper.getSingleImage(arg_10_0._go)
		end

		local var_10_5 = ResUrl.getHeadIconMiddle(arg_10_0._skinConfig.retangleIcon)

		if arg_10_0._simageIcon.curImageUrl ~= var_10_5 then
			arg_10_0._simageIcon:UnLoadImage()
		end

		arg_10_0._simageIcon:LoadImage(var_10_5)
	end

	if var_10_1 then
		if not arg_10_0._mask then
			arg_10_0._mask = gohelper.onceAddComponent(arg_10_0._go, var_0_1)
			arg_10_0._mask.showMaskGraphic = false
		end

		arg_10_0._mask.enabled = true
	elseif arg_10_0._mask then
		arg_10_0._mask.enabled = false
	end
end

function var_0_0.onEnable(arg_11_0)
	if arg_11_0._uiLimitSpine then
		TaskDispatcher.runRepeat(arg_11_0._checkAlphaClip, arg_11_0, 0.05, 20)
	end
end

function var_0_0._checkAlphaClip(arg_12_0)
	if not arg_12_0._uiLimitSpine then
		TaskDispatcher.cancelTask(arg_12_0._checkAlphaClip, arg_12_0)

		return
	end

	local var_12_0 = arg_12_0._uiLimitSpine:getSkeletonGraphic()

	if gohelper.isNil(var_12_0) then
		return
	end

	if var_12_0.color.a < 1 then
		ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 0.5)

		return
	end

	local var_12_1 = var_12_0.transform.parent

	for iter_12_0 = 1, 5 do
		if var_12_1 == nil then
			return
		end

		local var_12_2 = var_12_1:GetComponent(gohelper.Type_CanvasGroup)

		if var_12_2 and var_12_2.alpha < 1 then
			ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 0.5)

			return
		end

		var_12_1 = var_12_1.parent
	end
end

function var_0_0._checkPutSpineToPool(arg_13_0, arg_13_1)
	if arg_13_0._uiLimitSpine then
		if not gohelper.isNil(arg_13_0._uiLimitSpine:getSpineGo()) then
			gohelper.setActive(arg_13_0._limitSpineGO, false)

			if arg_13_0._reuseCase and arg_13_1 then
				var_0_0.put(arg_13_0._reuseCase, arg_13_1.id, arg_13_0._uiLimitSpine)

				arg_13_0._uiLimitSpine = nil
				arg_13_0._limitSpineGO = nil
			end
		else
			arg_13_0._uiLimitSpine:doClear()

			if not gohelper.isNil(arg_13_0._limitSpineGO) then
				gohelper.destroy(arg_13_0._limitSpineGO)
			end

			arg_13_0._uiLimitSpine = nil
			arg_13_0._limitSpineGO = nil
		end
	end
end

function var_0_0._onSpineLoaded(arg_14_0)
	local var_14_0 = arg_14_0._limitedCO.spineParam[1] or 0
	local var_14_1 = arg_14_0._limitedCO.spineParam[2] or 0
	local var_14_2 = arg_14_0._limitedCO.spineParam[3] or 1
	local var_14_3 = arg_14_0._uiLimitSpine:getSpineTr()

	recthelper.setAnchor(var_14_3, recthelper.getAnchor(arg_14_0._tr))
	recthelper.setWidth(var_14_3, recthelper.getWidth(arg_14_0._tr))
	recthelper.setHeight(var_14_3, recthelper.getHeight(arg_14_0._tr))
	recthelper.setAnchor(var_14_3, var_14_0, var_14_1)
	transformhelper.setLocalScale(var_14_3, var_14_2, var_14_2, 1)
	arg_14_0:setSpineRaycastTarget(arg_14_0._raycastTarget)
end

function var_0_0.onDestroy(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._checkAlphaClip, arg_15_0)

	if arg_15_0._reuseCase then
		if not arg_15_0._uiLimitSpine then
			local var_15_0 = gohelper.findChild(arg_15_0._go, "LimitedSpine")

			if var_15_0 then
				arg_15_0._uiLimitSpine = MonoHelper.getLuaComFromGo(var_15_0, GuiSpine)
			end
		end

		if arg_15_0._uiLimitSpine then
			var_0_0.release(arg_15_0._reuseCase, arg_15_0._uiLimitSpine)
		end
	end

	if arg_15_0._uiLimitSpine then
		arg_15_0._uiLimitSpine:doClear()

		arg_15_0._uiLimitSpine = nil
	end

	if arg_15_0._simageIcon then
		arg_15_0._simageIcon:UnLoadImage()

		arg_15_0._simageIcon = nil
	end
end

return var_0_0
