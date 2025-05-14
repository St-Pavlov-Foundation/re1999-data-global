module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapScene", package.seeall)

local var_0_0 = class("Activity1_3ChessMapScene", BaseView)
local var_0_1 = {
	[Activity1_3ChessEnum.Chapter.One] = {
		1,
		2,
		3,
		4
	},
	[Activity1_3ChessEnum.Chapter.Two] = {
		5,
		6,
		7,
		8
	}
}
local var_0_2 = {
	{
		"Obj-Plant/all/diffuse/zjm01_jy"
	},
	{
		"Obj-Plant/all/diffuse/zjm01_shu"
	},
	{
		"Obj-Plant/all/diffuse/zjm01_lang",
		"Obj-Plant/all/diffuse/zjm01_yang"
	},
	{
		"Obj-Plant/all/diffuse/zjm01_lsm"
	},
	{
		"Obj-Plant/all/diffuse/zjm02_jjc"
	},
	{
		"Obj-Plant/all/diffuse/zjm02_mj",
		"Obj-Plant/all/diffuse/zjm02_ml_die"
	},
	{
		"Obj-Plant/all/diffuse/zjm02_sp01",
		"Obj-Plant/all/diffuse/zjm02_sp02",
		"Obj-Plant/all/diffuse/zjm02_sp03"
	},
	{
		"Obj-Plant/all/diffuse/zjm02_bb",
		"Obj-Plant/all/diffuse/zjm02_jj",
		"Obj-Plant/all/diffuse/zjm02_mm"
	}
}

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.MapSceneActvie, arg_2_0.setSceneActive, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onUpdateParam(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_5_0.onScreenResize, arg_5_0)
end

function var_0_0.setSceneActive(arg_6_0, arg_6_1)
	if arg_6_0._sceneRoot then
		gohelper.setActive(arg_6_0._sceneRoot, arg_6_1)
	end
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._pageIds = {
		Activity1_3ChessEnum.Chapter.One,
		Activity1_3ChessEnum.Chapter.Two
	}
	arg_8_0._chapterSceneUdtbDict = {}
	arg_8_0._chapterInactList = {}

	arg_8_0:onScreenResize()

	local var_8_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_8_1 = CameraMgr.instance:getSceneRoot()

	arg_8_0._sceneRoot = UnityEngine.GameObject.New("Activity1_3ChessMap")

	local var_8_2, var_8_3, var_8_4 = transformhelper.getLocalPos(var_8_0)

	transformhelper.setLocalPos(arg_8_0._sceneRoot.transform, 0, var_8_3, 0)
	gohelper.addChild(var_8_1, arg_8_0._sceneRoot)
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

function var_0_0.switchStage(arg_11_0, arg_11_1)
	if not Activity1_3ChessEnum.MapSceneResPath[arg_11_1] then
		return
	end

	if arg_11_0._chapterSceneUdtbDict then
		arg_11_0:_createChapterScene(arg_11_1)

		for iter_11_0, iter_11_1 in pairs(arg_11_0._chapterSceneUdtbDict) do
			gohelper.setActive(iter_11_1.go, iter_11_1.chaperId == arg_11_1)
		end
	end
end

function var_0_0._createChapterScene(arg_12_0, arg_12_1)
	if arg_12_0._chapterSceneUdtbDict and not arg_12_0._chapterSceneUdtbDict[arg_12_1] then
		local var_12_0 = arg_12_0:getResInst(Activity1_3ChessEnum.MapSceneResPath[arg_12_1], arg_12_0._sceneRoot)

		transformhelper.setLocalPos(var_12_0.transform, 0, 0, 0)

		local var_12_1 = arg_12_0:getUserDataTb_()

		var_12_1.go = var_12_0
		var_12_1.chaperId = arg_12_1
		var_12_1.nodeElementDic = {}
		var_12_1.animator = gohelper.onceAddComponent(var_12_0, typeof(UnityEngine.Animator))
		arg_12_0._chapterSceneUdtbDict[arg_12_1] = var_12_1

		arg_12_0:_initChapterSceneElement(arg_12_1)
	end
end

function var_0_0._initChapterSceneElement(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._chapterSceneUdtbDict[arg_13_1]
	local var_13_1 = var_0_1[arg_13_1]

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = var_0_2[iter_13_1]

		for iter_13_2, iter_13_3 in ipairs(var_13_2) do
			local var_13_3 = gohelper.findChild(var_13_0.go, iter_13_3)

			if var_13_3 then
				if not var_13_0.nodeElementDic[iter_13_1] then
					var_13_0.nodeElementDic[iter_13_1] = {}
				end

				local var_13_4 = var_13_0.nodeElementDic[iter_13_1]

				var_13_4[#var_13_4 + 1] = var_13_3

				gohelper.setActive(var_13_3, false)
			end
		end
	end

	arg_13_0:_refreshChaperSceneElement(arg_13_1)
end

function var_0_0._refreshChaperSceneElement(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._chapterSceneUdtbDict[arg_14_1]
	local var_14_1 = var_14_0 and var_14_0.nodeElementDic

	if not var_14_1 then
		return
	end

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		local var_14_2 = Activity122Model.instance:getEpisodeData(iter_14_0)
		local var_14_3 = var_14_2 and var_14_2.star > 0

		if arg_14_2 ~= nil then
			var_14_3 = arg_14_2
		end

		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			gohelper.setActive(iter_14_3, var_14_3)
		end
	end
end

function var_0_0.onSetVisible(arg_15_0, arg_15_1)
	if arg_15_1 then
		arg_15_0:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.One)
		arg_15_0:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.Two)
	else
		arg_15_0:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.One, false)
		arg_15_0:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.Two, false)
	end
end

function var_0_0.playSceneEnterAni(arg_16_0, arg_16_1)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)

	local var_16_0 = arg_16_0._chapterSceneUdtbDict[arg_16_1]

	if var_16_0 and var_16_0.animator then
		var_16_0.animator:Play("open")
	end

	TaskDispatcher.runDelay(arg_16_0.playSceneEnterAniEnd, arg_16_0, 0.6)
end

function var_0_0.playSceneEnterAniEnd(arg_17_0)
	UIBlockMgr.instance:endBlock(Activity1_3ChessEnum.UIBlockKey)
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
