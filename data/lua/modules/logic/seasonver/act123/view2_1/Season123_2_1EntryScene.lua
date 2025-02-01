module("modules.logic.seasonver.act123.view2_1.Season123_2_1EntryScene", package.seeall)

slot0 = class("Season123_2_1EntryScene", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._cameraHelper = Season123_2_1EntryCamera.New()

	slot0._cameraHelper:init()

	slot0._loadHelper = Season123_2_1EntryLoadScene.New()

	slot0._loadHelper:init()

	slot0._sceneRoot = slot0._loadHelper:createSceneRoot()
	slot0._sceneRootTrs = slot0._sceneRoot.transform

	slot0._loadHelper:loadRes(slot0.onSceneResLoaded, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._loadHelper then
		slot0._loadHelper:disposeSceneRoot()
		slot0._loadHelper:dispose()

		slot0._sceneRoot = nil
		slot0._loadHelper = nil
	end

	if slot0._cameraHelper then
		slot0._cameraHelper:dispose()

		slot0._cameraHelper = nil
	end

	if slot0._dragHelper then
		slot0._dragHelper:dispose()

		slot0._dragHelper = nil
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.LocateToStage, slot0.handleLocateToStage, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.SetRetailScene, slot0.handleSetRetailScene, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.SwitchRetailPrefab, slot0.handleSwitchRetailScene, slot0)
	slot0:addEventCb(Season123EntryController.instance, Season123Event.EntrySceneFocusPos, slot0.handleFocusPos, slot0)
	slot0:addEventCb(Season123EntryController.instance, Season123Event.ReleaseFocusPos, slot0.handleReleaseFocusPos, slot0)
	slot0:addEventCb(Season123EntryController.instance, Season123Event.RetailObjLoaded, slot0.handleRetailObjLoaded, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.EnterEpiosdeList, slot0.enterEpiosdeList, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.EnterRetailView, slot0.playCloseAnim, slot0)
	slot0:refreshStage(true)
end

function slot0.onClose(slot0)
end

function slot0.onSceneResLoaded(slot0, slot1)
	slot0._sceneBgGo = slot1
	slot0._sceneAnim = slot0._sceneBgGo:GetComponent(typeof(UnityEngine.Animator))

	transformhelper.setLocalPos(slot0._sceneBgGo.transform, SeasonEntryEnum.DefaultScenePosX, SeasonEntryEnum.DefaultScenePosY, SeasonEntryEnum.DefaultScenePosZ)
	Season123EntryController.instance:dispatchEvent(Season123Event.EntrySceneLoaded)

	slot0._dragHelper = Season123_2_1EntryDrag.New()

	slot0._dragHelper:init(slot0._gofullscreen, slot0._sceneBgGo.transform)
	slot0._dragHelper:initBound()
	slot0._dragHelper:setDragEnabled(false)
	slot0:refreshRetailStatus()
end

function slot0.handleLocateToStage(slot0, slot1)
	if not slot0._sceneBgGo then
		return
	end

	if Season123Config.instance:getStageCo(slot1.actId, slot1.stageId) then
		Season123EntryController.instance:goToStage(slot3)
		slot0:refreshStage()
	end
end

function slot0.refreshStage(slot0, slot1)
	if not slot0._loadHelper then
		return
	end

	if not Season123EntryModel.instance:getCurrentStage() then
		return
	end

	slot0._loadHelper:showStageRes(slot2, slot1)
end

function slot0.refreshRetail(slot0, slot1)
	if not slot0._loadHelper or not slot0._sceneBgGo or not slot0._retailId then
		return
	end

	slot0._loadHelper:showRetailRes(slot0._retailSceneId)
end

function slot0.refreshRetailStatus(slot0)
	if not slot0._loadHelper or not slot0._sceneBgGo then
		return
	end

	gohelper.setActive(slot0._sceneBgGo, slot0._isRetailVisible)

	if slot0._isRetailVisible then
		slot0._loadHelper:hideAllStage()
		slot0:refreshRetail()
	else
		slot0._loadHelper:hideAllRetail()
		slot0:refreshStage()
	end
end

function slot0.handleFocusPos(slot0, slot1, slot2)
	if not slot0._sceneBgGo then
		return
	end

	logNormal("focus to pos " .. tostring(slot1) .. "," .. tostring(slot2))

	slot3 = slot0._dragHelper:getTempPos()
	slot3.y = slot2
	slot3.x = slot1

	slot0._dragHelper:setDragEnabled(false)
	slot0._dragHelper:setScenePosTween(slot3, SeasonEntryEnum.FocusTweenTime)
end

function slot0.handleReleaseFocusPos(slot0)
	slot0._cameraHelper:tweenToScale(1, SeasonEntryEnum.FocusTweenTime)
end

function slot0.handleSetRetailScene(slot0, slot1)
	slot0._isRetailVisible = slot1

	slot0:refreshRetailStatus()
end

function slot0.handleSwitchRetailScene(slot0, slot1)
	slot0._retailId = slot1
	slot0._retailSceneId = Season123Model.instance.retailSceneId
	slot0._retailFocusId = nil

	slot0:refreshRetail()
	slot0:tryFocusOnRetailObj()
end

function slot0.handleRetailObjLoaded(slot0, slot1)
	if slot0._retailId and slot0._retailFocusId == nil then
		slot2, slot3 = Season123EntryModel.getRandomRetailRes(slot0._retailSceneId)

		if slot2 == slot1 then
			slot0:tryFocusOnRetailObj()
		end
	end
end

function slot0.tryFocusOnRetailObj(slot0)
	if slot0._retailId and slot0._retailFocusId == nil then
		slot1, slot2 = Season123EntryModel.getRandomRetailRes(slot0._retailSceneId)
		slot3, slot4 = slot0._loadHelper:getRetailPosByIndex(slot1)

		if slot3 and slot4 then
			slot0._retailFocusId = slot0._retailId

			slot0:handleFocusPos(slot3, slot4)
		end
	end
end

function slot0.enterEpiosdeList(slot0, slot1)
	if not Season123EntryModel.instance:getCurrentStage() then
		return
	end

	slot0._loadHelper:tweenStage(slot2, slot1)

	if not slot1 then
		slot0._loadHelper:playAnim(slot2, Activity123Enum.StageSceneAnim.Idle)
	end
end

function slot0.playCloseAnim(slot0)
	slot0._loadHelper:playAnim(Season123EntryModel.instance:getCurrentStage(), Activity123Enum.StageSceneAnim.Close)
end

return slot0
