module("modules.logic.seasonver.act123.view1_9.Season123_1_9EntryScene", package.seeall)

local var_0_0 = class("Season123_1_9EntryScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._cameraHelper = Season123_1_9EntryCamera.New()

	arg_4_0._cameraHelper:init()

	arg_4_0._loadHelper = Season123_1_9EntryLoadScene.New()

	arg_4_0._loadHelper:init()

	arg_4_0._sceneRoot = arg_4_0._loadHelper:createSceneRoot()
	arg_4_0._sceneRootTrs = arg_4_0._sceneRoot.transform

	arg_4_0._loadHelper:loadRes(arg_4_0.onSceneResLoaded, arg_4_0)
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._loadHelper then
		arg_5_0._loadHelper:disposeSceneRoot()
		arg_5_0._loadHelper:dispose()

		arg_5_0._sceneRoot = nil
		arg_5_0._loadHelper = nil
	end

	if arg_5_0._cameraHelper then
		arg_5_0._cameraHelper:dispose()

		arg_5_0._cameraHelper = nil
	end

	if arg_5_0._dragHelper then
		arg_5_0._dragHelper:dispose()

		arg_5_0._dragHelper = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.LocateToStage, arg_6_0.handleLocateToStage, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.SetRetailScene, arg_6_0.handleSetRetailScene, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.SwitchRetailPrefab, arg_6_0.handleSwitchRetailScene, arg_6_0)
	arg_6_0:addEventCb(Season123EntryController.instance, Season123Event.EntrySceneFocusPos, arg_6_0.handleFocusPos, arg_6_0)
	arg_6_0:addEventCb(Season123EntryController.instance, Season123Event.ReleaseFocusPos, arg_6_0.handleReleaseFocusPos, arg_6_0)
	arg_6_0:addEventCb(Season123EntryController.instance, Season123Event.RetailObjLoaded, arg_6_0.handleRetailObjLoaded, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.EnterEpiosdeList, arg_6_0.enterEpiosdeList, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.EnterRetailView, arg_6_0.playCloseAnim, arg_6_0)
	arg_6_0:refreshStage(true)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onSceneResLoaded(arg_8_0, arg_8_1)
	arg_8_0._sceneBgGo = arg_8_1
	arg_8_0._sceneAnim = arg_8_0._sceneBgGo:GetComponent(typeof(UnityEngine.Animator))

	transformhelper.setLocalPos(arg_8_0._sceneBgGo.transform, SeasonEntryEnum.DefaultScenePosX, SeasonEntryEnum.DefaultScenePosY, SeasonEntryEnum.DefaultScenePosZ)
	Season123EntryController.instance:dispatchEvent(Season123Event.EntrySceneLoaded)

	arg_8_0._dragHelper = Season123_1_9EntryDrag.New()

	arg_8_0._dragHelper:init(arg_8_0._gofullscreen, arg_8_0._sceneBgGo.transform)
	arg_8_0._dragHelper:initBound()
	arg_8_0._dragHelper:setDragEnabled(false)
	arg_8_0:refreshRetailStatus()
end

function var_0_0.handleLocateToStage(arg_9_0, arg_9_1)
	if not arg_9_0._sceneBgGo then
		return
	end

	local var_9_0 = arg_9_1.actId
	local var_9_1 = arg_9_1.stageId

	if Season123Config.instance:getStageCo(var_9_0, var_9_1) then
		Season123EntryController.instance:goToStage(var_9_1)
		arg_9_0:refreshStage()
	end
end

function var_0_0.refreshStage(arg_10_0, arg_10_1)
	if not arg_10_0._loadHelper then
		return
	end

	local var_10_0 = Season123EntryModel.instance:getCurrentStage()

	if not var_10_0 then
		return
	end

	arg_10_0._loadHelper:showStageRes(var_10_0, arg_10_1)
end

function var_0_0.refreshRetail(arg_11_0, arg_11_1)
	if not arg_11_0._loadHelper or not arg_11_0._sceneBgGo or not arg_11_0._retailId then
		return
	end

	arg_11_0._loadHelper:showRetailRes(arg_11_0._retailSceneId)
end

function var_0_0.refreshRetailStatus(arg_12_0)
	if not arg_12_0._loadHelper or not arg_12_0._sceneBgGo then
		return
	end

	gohelper.setActive(arg_12_0._sceneBgGo, arg_12_0._isRetailVisible)

	if arg_12_0._isRetailVisible then
		arg_12_0._loadHelper:hideAllStage()
		arg_12_0:refreshRetail()
	else
		arg_12_0._loadHelper:hideAllRetail()
		arg_12_0:refreshStage()
	end
end

function var_0_0.handleFocusPos(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0._sceneBgGo then
		return
	end

	logNormal("focus to pos " .. tostring(arg_13_1) .. "," .. tostring(arg_13_2))

	local var_13_0 = arg_13_0._dragHelper:getTempPos()

	var_13_0.x, var_13_0.y = arg_13_1, arg_13_2

	arg_13_0._dragHelper:setDragEnabled(false)
	arg_13_0._dragHelper:setScenePosTween(var_13_0, SeasonEntryEnum.FocusTweenTime)
end

function var_0_0.handleReleaseFocusPos(arg_14_0)
	arg_14_0._cameraHelper:tweenToScale(1, SeasonEntryEnum.FocusTweenTime)
end

function var_0_0.handleSetRetailScene(arg_15_0, arg_15_1)
	arg_15_0._isRetailVisible = arg_15_1

	arg_15_0:refreshRetailStatus()
end

function var_0_0.handleSwitchRetailScene(arg_16_0, arg_16_1)
	arg_16_0._retailId = arg_16_1
	arg_16_0._retailSceneId = Season123Model.instance.retailSceneId
	arg_16_0._retailFocusId = nil

	arg_16_0:refreshRetail()
	arg_16_0:tryFocusOnRetailObj()
end

function var_0_0.handleRetailObjLoaded(arg_17_0, arg_17_1)
	if arg_17_0._retailId and arg_17_0._retailFocusId == nil then
		local var_17_0, var_17_1 = Season123EntryModel.getRandomRetailRes(arg_17_0._retailSceneId)

		if var_17_0 == arg_17_1 then
			arg_17_0:tryFocusOnRetailObj()
		end
	end
end

function var_0_0.tryFocusOnRetailObj(arg_18_0)
	if arg_18_0._retailId and arg_18_0._retailFocusId == nil then
		local var_18_0, var_18_1 = Season123EntryModel.getRandomRetailRes(arg_18_0._retailSceneId)
		local var_18_2, var_18_3 = arg_18_0._loadHelper:getRetailPosByIndex(var_18_0)

		if var_18_2 and var_18_3 then
			arg_18_0._retailFocusId = arg_18_0._retailId

			arg_18_0:handleFocusPos(var_18_2, var_18_3)
		end
	end
end

function var_0_0.enterEpiosdeList(arg_19_0, arg_19_1)
	local var_19_0 = Season123EntryModel.instance:getCurrentStage()

	if not var_19_0 then
		return
	end

	arg_19_0._loadHelper:tweenStage(var_19_0, arg_19_1)

	if not arg_19_1 then
		arg_19_0._loadHelper:playAnim(var_19_0, Activity123Enum.StageSceneAnim.Idle)
	end
end

function var_0_0.playCloseAnim(arg_20_0)
	local var_20_0 = Season123EntryModel.instance:getCurrentStage()

	arg_20_0._loadHelper:playAnim(var_20_0, Activity123Enum.StageSceneAnim.Close)
end

return var_0_0
