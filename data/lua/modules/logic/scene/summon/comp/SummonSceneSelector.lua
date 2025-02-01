module("modules.logic.scene.summon.comp.SummonSceneSelector", package.seeall)

slot0 = class("SummonSceneSelector", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._curSelectType = nil
	slot0._curSelectGo = nil

	logNormal("SummonSceneSelector:onSceneStart")
	SummonController.instance:registerCallback(SummonEvent.onSummonTabSet, slot0._handleSelectScene, slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onSceneResize, slot0)
	slot0:_handleSelectScene()
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0:_handleSelectScene()
	slot0:_refreshSelectScene()
end

function slot0._onSceneResize(slot0)
	if slot0._curSelectType == SummonEnum.ResultType.Equip then
		slot0._sceneObj.cameraAnim:switchToEquip()
	else
		slot0._sceneObj.cameraAnim:switchToChar()
	end
end

function slot0._handleSelectScene(slot0)
	if not SummonController.instance:getLastPoolId() then
		logNormal("LastPoolId is empty, Maybe call from guide.")
	end

	if SummonMainModel.getResultTypeById(slot1) ~= slot0._curSelectType then
		slot0._curSelectType = slot2

		slot0:_refreshSelectScene()
	end
end

function slot0._refreshSelectScene(slot0)
	slot1, slot2 = nil

	if slot0._curSelectType == SummonEnum.ResultType.Equip then
		slot1 = slot0._goSceneEquip
		slot2 = slot0._goSceneChar

		slot0._sceneObj.cameraAnim:switchToEquip()
	else
		slot1 = slot0._goSceneChar
		slot2 = slot0._goSceneEquip

		slot0._sceneObj.cameraAnim:switchToChar()
	end

	slot0._sceneObj.bgm:Play(slot0._curSelectType)

	slot0._curSelectGo = slot1

	SummonController.instance:resetAnimScale()

	slot4 = slot0._sceneObj:getSceneContainerGO().transform

	if not gohelper.isNil(slot2) then
		slot2.transform:SetParent(slot0:getNoSelectedRootGo().transform, false)
	end

	if not gohelper.isNil(slot1) then
		slot1.transform:SetParent(slot4, false)
	end
end

function slot0.initEquipSceneGo(slot0, slot1)
	slot0._assetItemEquip = slot1

	slot0._assetItemEquip:Retain()
end

function slot0.initCharSceneGo(slot0, slot1)
	slot0._assetItemChar = slot1

	slot0._assetItemChar:Retain()
end

function slot0.isSceneGOInited(slot0, slot1)
	if slot1 then
		return not gohelper.isNil(slot0._goSceneChar)
	else
		return not gohelper.isNil(slot0._goSceneEquip)
	end
end

function slot0.initSceneGO(slot0, slot1)
	slot2 = false

	if slot1 then
		if gohelper.isNil(slot0._goSceneChar) and slot0._assetItemChar then
			slot0._goSceneChar = gohelper.clone(slot0._assetItemChar:GetResource(), slot0:getNoSelectedRootGo(), "char_scene_go")
			slot2 = true
		end
	elseif gohelper.isNil(slot0._goSceneEquip) and slot0._assetItemEquip then
		slot0._goSceneEquip = gohelper.clone(slot0._assetItemEquip:GetResource(), slot0:getNoSelectedRootGo(), "equip_scene_go")
		slot2 = true
	end

	if slot2 then
		slot0:_refreshSelectScene()
		slot0:dispatchEvent(SummonSceneEvent.OnSceneGOInited, slot1)

		if not gohelper.isNil(slot0._goSceneChar) and not gohelper.isNil(slot0._goSceneEquip) then
			slot0:dispatchEvent(SummonSceneEvent.OnSceneAllGOInited)
		end
	end
end

function slot0.getNoSelectedRootGo(slot0)
	if not slot0._goSelectorRoot then
		slot0._goSelectorRoot = gohelper.create3d(slot0._sceneObj:getSceneContainerGO(), "SceneSelector")

		gohelper.setActive(slot0._goSelectorRoot, false)
	end

	return slot0._goSelectorRoot
end

function slot0.getEquipSceneGo(slot0)
	return slot0._goSceneEquip
end

function slot0.getCharSceneGo(slot0)
	return slot0._goSceneChar
end

function slot0.getCurSceneGo(slot0)
	return slot0._curSelectGo
end

function slot0.onSceneClose(slot0)
	slot0:onSceneHide()
	gohelper.setActive(slot0._goSelectorRoot, true)
	gohelper.destroy(slot0._goSceneEquip)
	gohelper.destroy(slot0._goSceneChar)
	gohelper.destroy(slot0._goSelectorRoot)

	slot0._goSceneEquip = nil
	slot0._goSelectorRoot = nil
	slot0._goSceneChar = nil
	slot0._curSelectGo = nil

	if slot0._assetItemEquip then
		slot0._assetItemEquip:Release()

		slot0._assetItemEquip = nil
	end

	if slot0._assetItemChar then
		slot0._assetItemChar:Release()

		slot0._assetItemChar = nil
	end
end

function slot0.onSceneHide(slot0)
	logNormal("onSceneHide")
	SummonController.instance:unregisterCallback(SummonEvent.onSummonTabSet, slot0._handleSelectScene, slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._onSceneResize, slot0)
end

return slot0
