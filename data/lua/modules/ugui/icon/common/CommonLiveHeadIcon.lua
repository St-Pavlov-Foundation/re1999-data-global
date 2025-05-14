module("modules.ugui.icon.common.CommonLiveHeadIcon", package.seeall)

local var_0_0 = class("CommonLiveHeadIcon", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._simageHeadIcon = arg_1_1
	arg_1_0._imageComp = arg_1_0._simageHeadIcon.gameObject:GetComponent(gohelper.Type_Image)
end

function var_0_0.setLiveHead(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_1 = tonumber(arg_2_1)
	arg_2_2 = arg_2_2 and true or false
	arg_2_3 = arg_2_3 and true or false

	if not arg_2_1 then
		return
	end

	local var_2_0 = lua_item.configDict[arg_2_1]

	if var_2_0 == nil then
		return
	end

	local var_2_1 = tonumber(var_2_0.icon)
	local var_2_2 = var_2_0.isDynamic == IconMgrConfig.HeadIconType.Dynamic

	arg_2_0.isDynamic = var_2_2
	arg_2_0.setNativeSize = arg_2_2
	arg_2_0.isParallel = arg_2_3
	arg_2_0.isGray = false

	if arg_2_0.portraitId and arg_2_0.portraitId == var_2_1 then
		arg_2_0:syncAnimationTime()
		arg_2_0:calculateSize()

		if arg_2_4 and arg_2_5 then
			arg_2_4(arg_2_5, arg_2_0)
		end

		return
	end

	if not arg_2_0._loader then
		arg_2_0._loader = PrefabInstantiate.Create(arg_2_0._simageHeadIcon.gameObject)
	end

	if not gohelper.isNil(arg_2_0._dynamicIconObj) then
		logNormal("destroy liveHead icon" .. tostring(arg_2_0._dynamicIconObj.name))
		arg_2_0:removeHeadLiveIcon()
		arg_2_0._loader:dispose()

		arg_2_0.animation = nil
	elseif arg_2_0._loader:getPath() then
		arg_2_0._loader:dispose()
	end

	arg_2_0.portraitId = var_2_1
	arg_2_0.callBack = arg_2_4
	arg_2_0.callBackObj = arg_2_5

	if not var_2_2 then
		logNormal("set static icon portraitId: " .. tostring(var_2_1))
		arg_2_0._simageHeadIcon:LoadImage(ResUrl.getPlayerHeadIcon(var_2_1), arg_2_0._onStaticLoadCallBack, arg_2_0)
	else
		logNormal("set dynamic icon portraitId: " .. tostring(var_2_1))
		arg_2_0:setDynamicIcon(var_2_1)
	end
end

function var_0_0.setDynamicIcon(arg_3_0, arg_3_1)
	arg_3_0.portraitId = arg_3_1

	local var_3_0 = ResUrl.getLiveHeadIconPrefab(arg_3_1)

	arg_3_0._loader:startLoad(var_3_0, arg_3_0._onLoadCallBack, arg_3_0)
end

function var_0_0._onStaticLoadCallBack(arg_4_0)
	if arg_4_0.setNativeSize then
		arg_4_0._imageComp:SetNativeSize()
	end

	arg_4_0:invokeCallBack()
end

function var_0_0._onLoadCallBack(arg_5_0)
	arg_5_0:reInitComp()
	arg_5_0:syncAnimationTime()
	arg_5_0:setMaterial()
	arg_5_0:calculateSize()
	arg_5_0:invokeCallBack()
end

function var_0_0.reInitComp(arg_6_0)
	arg_6_0._dynamicIconObj = arg_6_0._loader:getInstGO()
	arg_6_0._root = gohelper.findChild(arg_6_0._dynamicIconObj, "root")
	arg_6_0.animation = gohelper.findChildComponent(arg_6_0._dynamicIconObj, "root", gohelper.Type_Animation)

	if arg_6_0.animation ~= nil and arg_6_0.animation.clip ~= nil then
		local var_6_0 = arg_6_0.animation.clip

		arg_6_0.animationState = arg_6_0.animation:get_Item(var_6_0.name)
	end

	IconMgr.instance:addLiveIconAnimationReferenceTime(arg_6_0.portraitId)
end

function var_0_0.invokeCallBack(arg_7_0)
	if not arg_7_0.callBack or not arg_7_0.callBackObj then
		return
	end

	arg_7_0.callBack(arg_7_0.callBackObj, arg_7_0)

	arg_7_0.callBack = nil
	arg_7_0.callBackObj = nil
end

function var_0_0.calculateSize(arg_8_0)
	if gohelper.isNil(arg_8_0._dynamicIconObj) then
		return
	end

	if arg_8_0.isParallel then
		arg_8_0._dynamicIconObj.transform.parent = arg_8_0._simageHeadIcon.transform.parent
	else
		arg_8_0._dynamicIconObj.transform.parent = arg_8_0._simageHeadIcon.transform
	end

	arg_8_0:setDynamicVisible(arg_8_0.isDynamic and not arg_8_0.isGray)
	arg_8_0:setStaticVisible(not arg_8_0.isDynamic or arg_8_0.isGray)

	local var_8_0 = arg_8_0._simageHeadIcon.gameObject.transform
	local var_8_1 = recthelper.getWidth(arg_8_0._root.transform)

	if not arg_8_0.isParallel then
		local var_8_2 = 1

		if not arg_8_0.setNativeSize then
			gohelper.setAsFirstSibling(arg_8_0._dynamicIconObj)

			local var_8_3 = recthelper.getWidth(arg_8_0._simageHeadIcon.transform)
			local var_8_4 = recthelper.getWidth(arg_8_0._root.transform)
			local var_8_5 = math.max(0, var_8_3 / var_8_4)

			transformhelper.setLocalScale(arg_8_0._dynamicIconObj.transform, var_8_5, var_8_5, 1)
		else
			recthelper.setSize(var_8_0, var_8_1, var_8_1)
		end

		return
	end

	gohelper.setSiblingAfter(arg_8_0._dynamicIconObj, arg_8_0._simageHeadIcon.gameObject)

	local var_8_6, var_8_7 = transformhelper.getLocalScale(var_8_0)
	local var_8_8, var_8_9, var_8_10 = transformhelper.getPos(var_8_0)
	local var_8_11 = 1

	if not arg_8_0.setNativeSize then
		local var_8_12 = recthelper.getWidth(var_8_0)

		var_8_11 = math.max(0, var_8_12 / var_8_1)
	else
		recthelper.setSize(var_8_0, var_8_1, var_8_1)
	end

	local var_8_13, var_8_14, var_8_15 = transformhelper.getLocalRotation(var_8_0)

	transformhelper.setLocalRotation(arg_8_0._dynamicIconObj.transform, var_8_13, var_8_14, var_8_15)
	transformhelper.setLocalScale(arg_8_0._dynamicIconObj.transform, var_8_11 * var_8_6, var_8_11 * var_8_7, 1)
	transformhelper.setPos(arg_8_0._dynamicIconObj.transform, var_8_8, var_8_9, var_8_10)
end

function var_0_0.setMaterial(arg_9_0)
	if not arg_9_0.isDynamic then
		return
	end

	local var_9_0 = gohelper.findChildImage(arg_9_0.imageReference, "")

	if var_9_0 == nil or var_9_0.material == nil then
		return
	end

	arg_9_0:traverseReplaceChildrenMaterial(arg_9_0._root, var_9_0.material)
end

function var_0_0.traverseReplaceChildrenMaterial(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetComponentsInChildren(gohelper.Type_Image)
	local var_10_1 = var_10_0.Length

	if var_10_1 <= 0 then
		return
	end

	for iter_10_0 = 0, var_10_1 - 1 do
		local var_10_2 = var_10_0[iter_10_0]

		if var_10_2 and var_10_2.material == var_10_2.defaultMaterial then
			var_10_2.material = arg_10_2
		end
	end
end

function var_0_0.setAlpha(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	if not arg_11_0.isDynamic then
		ZProj.UGUIHelper.SetColorAlpha(arg_11_0._imageComp, arg_11_1)

		return
	end

	if arg_11_0.canvasGroup == nil then
		arg_11_0.canvasGroup = gohelper.onceAddComponent(arg_11_0._dynamicIconObj, gohelper.Type_CanvasGroup)
	end

	if arg_11_0.canvasGroup then
		arg_11_0.canvasGroup.alpha = arg_11_1
	end
end

function var_0_0.setAnimationTime(arg_12_0, arg_12_1)
	if not arg_12_0.isDynamic or gohelper.isNil(arg_12_0._dynamicIconObj) or arg_12_0.animationState == nil then
		return
	end

	local var_12_0 = arg_12_0.animationState
	local var_12_1 = UnityEngine.Time.timeSinceLevelLoad - arg_12_1
	local var_12_2 = var_12_0.length

	if var_12_2 == nil then
		return
	end

	var_12_0.time = var_12_1 % var_12_2
end

function var_0_0.setGray(arg_13_0, arg_13_1)
	ZProj.UGUIHelper.SetGrayscale(arg_13_0._simageHeadIcon.gameObject, arg_13_1)

	arg_13_0.isGray = arg_13_1

	if not arg_13_0.isDynamic then
		return
	end

	arg_13_0:setStaticVisible(arg_13_1)
	arg_13_0:setDynamicVisible(not arg_13_1)
	arg_13_0._simageHeadIcon:LoadImage(ResUrl.getPlayerHeadIcon(arg_13_0.portraitId))
end

function var_0_0.setDynamicVisible(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._dynamicIconObj, arg_14_0.isDynamic and arg_14_1)
end

function var_0_0.setStaticVisible(arg_15_0, arg_15_1)
	if arg_15_0.isParallel then
		gohelper.setActive(arg_15_0._simageHeadIcon, arg_15_1)
	end
end

function var_0_0.onEnable(arg_16_0)
	arg_16_0:syncAnimationTime()
end

function var_0_0.syncAnimationTime(arg_17_0)
	if not arg_17_0.isDynamic or gohelper.isNil(arg_17_0._dynamicIconObj) or arg_17_0.animationState == nil then
		return
	end

	local var_17_0 = IconMgr.instance:getLiveIconReferenceTime(arg_17_0.portraitId)

	if var_17_0 then
		arg_17_0:setAnimationTime(var_17_0)
	end
end

function var_0_0.removeHeadLiveIcon(arg_18_0)
	if not arg_18_0.isDynamic or gohelper.isNil(arg_18_0._dynamicIconObj) then
		return
	end

	IconMgr.instance:removeHeadLiveIcon(arg_18_0.portraitId)

	arg_18_0._dynamicIconObj = nil
end

function var_0_0.onDestroy(arg_19_0)
	arg_19_0:removeHeadLiveIcon()

	if arg_19_0._loader then
		arg_19_0._loader:dispose()

		arg_19_0._loader = nil
	end
end

return var_0_0
