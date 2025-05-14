module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapScene", package.seeall)

local var_0_0 = class("JiaLaBoNaMapScene", BaseView)

function var_0_0.onInitView(arg_1_0)
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

function var_0_0.onUpdateParam(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_5_0.onScreenResize, arg_5_0)
	arg_5_0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.MapSceneActvie, arg_5_0._onMapSceneActivie, arg_5_0)
end

function var_0_0.setSceneActive(arg_6_0, arg_6_1)
	if arg_6_0._sceneRoot then
		gohelper.setActive(arg_6_0._sceneRoot, arg_6_1)
	end
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:resetCamera()
end

function var_0_0._onMapSceneActivie(arg_8_0, arg_8_1)
	arg_8_0:setSceneActive(arg_8_1)
end

function var_0_0.onScreenResize(arg_9_0)
	local var_9_0 = CameraMgr.instance:getMainCamera()
	local var_9_1 = GameUtil.getAdapterScale(true)

	var_9_0.orthographic = true
	var_9_0.orthographicSize = 7.5 * var_9_1
end

function var_0_0.resetCamera(arg_10_0)
	local var_10_0 = CameraMgr.instance:getMainCamera()

	var_10_0.orthographicSize = 5
	var_10_0.orthographic = false
end

function var_0_0.switchPage(arg_11_0, arg_11_1)
	if not JiaLaBoNaEnum.MapSceneRes[arg_11_1] then
		return
	end

	if arg_11_0._chapterSceneUdtbDict then
		arg_11_0._curChaperId = arg_11_1

		arg_11_0:_createChapterScene(arg_11_1)

		for iter_11_0, iter_11_1 in pairs(arg_11_0._chapterSceneUdtbDict) do
			gohelper.setActive(iter_11_1.go, iter_11_1.chapterId == arg_11_1)
		end

		arg_11_0:refreshInteract()
	end
end

function var_0_0.playSceneAnim(arg_12_0, arg_12_1)
	if not string.nilorempty(arg_12_1) then
		local var_12_0 = arg_12_0._chapterSceneUdtbDict[arg_12_0._curChaperId]

		if var_12_0 and var_12_0.animator then
			var_12_0.animator:Play(arg_12_1)
		end
	end
end

function var_0_0._createChapterScene(arg_13_0, arg_13_1)
	if arg_13_0._chapterSceneUdtbDict and not arg_13_0._chapterSceneUdtbDict[arg_13_1] then
		local var_13_0 = arg_13_0:getResInst(JiaLaBoNaEnum.MapSceneRes[arg_13_1], arg_13_0._sceneRoot)

		transformhelper.setLocalPos(var_13_0.transform, 0, 0, 0)

		local var_13_1 = arg_13_0:getUserDataTb_()

		var_13_1.go = var_13_0
		var_13_1.chapterId = arg_13_1
		var_13_1.animator = var_13_0:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
		arg_13_0._chapterSceneUdtbDict[arg_13_1] = var_13_1

		arg_13_0:_findInactGo(var_13_0, arg_13_1)
	end
end

function var_0_0._findInactGo(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = VersionActivity1_3Enum.ActivityId.Act306
	local var_14_1 = Activity120Config.instance:getEpisodeList(var_14_0)

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if iter_14_1.chapterId == arg_14_2 and not string.nilorempty(iter_14_1.inactPaths) then
			local var_14_2 = string.split(iter_14_1.inactPaths, "|") or {}
			local var_14_3 = arg_14_0:getUserDataTb_()

			arg_14_0._chapterInactsTbDict[iter_14_1.id] = var_14_3

			for iter_14_2, iter_14_3 in ipairs(var_14_2) do
				local var_14_4 = string.nilorempty(iter_14_3)
				local var_14_5 = not var_14_4 and gohelper.findChild(arg_14_1, iter_14_3)

				if not gohelper.isNil(var_14_5) then
					local var_14_6 = arg_14_0:getUserDataTb_()

					var_14_6.go = var_14_5
					var_14_6.animator = var_14_5:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

					table.insert(var_14_3, var_14_6)
				elseif not var_14_4 then
					logError(string.format("export_尘埃与星的边界活动关卡 activityId：%s id:% inactPaths:%s下标错误", var_14_0, iter_14_1.id, iter_14_2))
				end
			end
		end
	end
end

function var_0_0.refreshInteract(arg_15_0, arg_15_1)
	local var_15_0 = VersionActivity1_3Enum.ActivityId.Act306
	local var_15_1 = Activity120Config.instance:getEpisodeList(var_15_0)

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		arg_15_0:_refreshInteractById(iter_15_1.id, iter_15_1.id == arg_15_1)
	end
end

function var_0_0._refreshInteractById(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._chapterInactsTbDict[arg_16_1]

	if var_16_0 and #var_16_0 > 0 then
		local var_16_1 = Activity120Model.instance:isEpisodeClear(arg_16_1)

		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			gohelper.setActive(iter_16_1.go, var_16_1)

			if arg_16_2 and iter_16_1.animator then
				iter_16_1.animator:Play("open", 0, 0)
			end
		end
	end
end

function var_0_0._editableInitView(arg_17_0)
	arg_17_0._pageIds = {
		JiaLaBoNaEnum.Chapter.One,
		JiaLaBoNaEnum.Chapter.Two
	}
	arg_17_0._chapterSceneUdtbDict = {}
	arg_17_0._chapterInactsTbDict = {}

	arg_17_0:onScreenResize()

	local var_17_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_17_1 = CameraMgr.instance:getSceneRoot()

	arg_17_0._sceneRoot = UnityEngine.GameObject.New("JiaLaBoNaMap")

	local var_17_2, var_17_3, var_17_4 = transformhelper.getLocalPos(var_17_0)

	transformhelper.setLocalPos(arg_17_0._sceneRoot.transform, 0, var_17_3, 0)
	gohelper.addChild(var_17_1, arg_17_0._sceneRoot)
end

function var_0_0.onDestroyView(arg_18_0)
	if arg_18_0._sceneRoot then
		gohelper.destroy(arg_18_0._sceneRoot)

		arg_18_0._sceneRoot = nil
	end

	if arg_18_0._chapterSceneUdtbDict then
		arg_18_0._chapterSceneUdtbDict = nil
	end
end

return var_0_0
