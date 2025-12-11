module("modules.logic.scene.summon.comp.SummonSceneSelector", package.seeall)

local var_0_0 = class("SummonSceneSelector", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._curSelectType = nil
	arg_1_0._curSelectGo = nil

	logNormal("SummonSceneSelector:onSceneStart")
	SummonController.instance:registerCallback(SummonEvent.onSummonTabSet, arg_1_0._handleSelectScene, arg_1_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_1_0._onSceneResize, arg_1_0)
	arg_1_0:_handleSelectScene()
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:_handleSelectScene()
	arg_2_0:_refreshSelectScene()
end

function var_0_0._onSceneResize(arg_3_0)
	if arg_3_0._curSelectType == SummonEnum.ResultType.Equip then
		arg_3_0._sceneObj.cameraAnim:switchToEquip()
	else
		arg_3_0._sceneObj.cameraAnim:switchToChar()
	end
end

function var_0_0._handleSelectScene(arg_4_0)
	local var_4_0 = SummonController.instance:getLastPoolId()

	if not var_4_0 then
		logNormal("LastPoolId is empty, Maybe call from guide.")
	end

	local var_4_1 = SummonMainModel.getResultTypeById(var_4_0)

	if var_4_1 ~= arg_4_0._curSelectType then
		arg_4_0._curSelectType = var_4_1

		arg_4_0:_refreshSelectScene()
	end
end

function var_0_0._refreshSelectScene(arg_5_0)
	local var_5_0
	local var_5_1

	if arg_5_0._curSelectType == SummonEnum.ResultType.Equip then
		var_5_0 = arg_5_0._goSceneEquip
		var_5_1 = arg_5_0._goSceneChar

		arg_5_0._sceneObj.cameraAnim:switchToEquip()
	else
		var_5_0 = arg_5_0._goSceneChar
		var_5_1 = arg_5_0._goSceneEquip

		arg_5_0._sceneObj.cameraAnim:switchToChar()
	end

	arg_5_0._sceneObj.bgm:Play(arg_5_0._curSelectType)

	arg_5_0._curSelectGo = var_5_0

	SummonController.instance:resetAnimScale()

	local var_5_2 = arg_5_0:getNoSelectedRootGo().transform
	local var_5_3 = arg_5_0._sceneObj:getSceneContainerGO().transform

	if not gohelper.isNil(var_5_1) then
		var_5_1.transform:SetParent(var_5_2, false)
	end

	if not gohelper.isNil(var_5_0) then
		var_5_0.transform:SetParent(var_5_3, false)
	end
end

function var_0_0.initEquipSceneGo(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._assetItemEquip

	arg_6_0._assetItemEquip = arg_6_1

	arg_6_0._assetItemEquip:Retain()

	if var_6_0 then
		var_6_0:Release()
	end
end

function var_0_0.initCharSceneGo(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._assetItemChar

	arg_7_0._assetItemChar = arg_7_1

	arg_7_0._assetItemChar:Retain()

	if var_7_0 then
		var_7_0:Release()
	end
end

function var_0_0.isSceneGOInited(arg_8_0, arg_8_1)
	if arg_8_1 then
		return not gohelper.isNil(arg_8_0._goSceneChar)
	else
		return not gohelper.isNil(arg_8_0._goSceneEquip)
	end
end

function var_0_0.initSceneGO(arg_9_0, arg_9_1)
	local var_9_0 = false

	if arg_9_1 then
		if gohelper.isNil(arg_9_0._goSceneChar) and arg_9_0._assetItemChar then
			arg_9_0._goSceneChar = gohelper.clone(arg_9_0._assetItemChar:GetResource(), arg_9_0:getNoSelectedRootGo(), "char_scene_go")
			var_9_0 = true
		end
	elseif gohelper.isNil(arg_9_0._goSceneEquip) and arg_9_0._assetItemEquip then
		arg_9_0._goSceneEquip = gohelper.clone(arg_9_0._assetItemEquip:GetResource(), arg_9_0:getNoSelectedRootGo(), "equip_scene_go")
		var_9_0 = true
	end

	if var_9_0 then
		arg_9_0:_refreshSelectScene()
		arg_9_0:dispatchEvent(SummonSceneEvent.OnSceneGOInited, arg_9_1)

		if not gohelper.isNil(arg_9_0._goSceneChar) and not gohelper.isNil(arg_9_0._goSceneEquip) then
			arg_9_0:dispatchEvent(SummonSceneEvent.OnSceneAllGOInited)
		end
	end
end

function var_0_0.getNoSelectedRootGo(arg_10_0)
	if not arg_10_0._goSelectorRoot then
		local var_10_0 = arg_10_0._sceneObj:getSceneContainerGO()

		arg_10_0._goSelectorRoot = gohelper.create3d(var_10_0, "SceneSelector")

		gohelper.setActive(arg_10_0._goSelectorRoot, false)
	end

	return arg_10_0._goSelectorRoot
end

function var_0_0.getEquipSceneGo(arg_11_0)
	return arg_11_0._goSceneEquip
end

function var_0_0.getCharSceneGo(arg_12_0)
	return arg_12_0._goSceneChar
end

function var_0_0.getCurSceneGo(arg_13_0)
	return arg_13_0._curSelectGo
end

function var_0_0.onSceneClose(arg_14_0)
	arg_14_0:onSceneHide()
	gohelper.setActive(arg_14_0._goSelectorRoot, true)
	gohelper.destroy(arg_14_0._goSceneEquip)
	gohelper.destroy(arg_14_0._goSceneChar)
	gohelper.destroy(arg_14_0._goSelectorRoot)

	arg_14_0._goSceneEquip = nil
	arg_14_0._goSelectorRoot = nil
	arg_14_0._goSceneChar = nil
	arg_14_0._curSelectGo = nil

	if arg_14_0._assetItemEquip then
		arg_14_0._assetItemEquip:Release()

		arg_14_0._assetItemEquip = nil
	end

	if arg_14_0._assetItemChar then
		arg_14_0._assetItemChar:Release()

		arg_14_0._assetItemChar = nil
	end
end

function var_0_0.onSceneHide(arg_15_0)
	logNormal("onSceneHide")
	SummonController.instance:unregisterCallback(SummonEvent.onSummonTabSet, arg_15_0._handleSelectScene, arg_15_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_15_0._onSceneResize, arg_15_0)
end

return var_0_0
