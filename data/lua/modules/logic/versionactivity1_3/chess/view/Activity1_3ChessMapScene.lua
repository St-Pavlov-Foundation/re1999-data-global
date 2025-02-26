module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapScene", package.seeall)

slot0 = class("Activity1_3ChessMapScene", BaseView)
slot1 = {
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
slot2 = {
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

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.MapSceneActvie, slot0.setSceneActive, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.onScreenResize, slot0)
end

function slot0.setSceneActive(slot0, slot1)
	if slot0._sceneRoot then
		gohelper.setActive(slot0._sceneRoot, slot1)
	end
end

function slot0.onClose(slot0)
end

function slot0._editableInitView(slot0)
	slot0._pageIds = {
		Activity1_3ChessEnum.Chapter.One,
		Activity1_3ChessEnum.Chapter.Two
	}
	slot0._chapterSceneUdtbDict = {}
	slot0._chapterInactList = {}

	slot0:onScreenResize()

	slot0._sceneRoot = UnityEngine.GameObject.New("Activity1_3ChessMap")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.onScreenResize(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function slot0.resetCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = 5
	slot1.orthographic = false
end

function slot0.switchStage(slot0, slot1)
	if not Activity1_3ChessEnum.MapSceneResPath[slot1] then
		return
	end

	if slot0._chapterSceneUdtbDict then
		slot0:_createChapterScene(slot1)

		for slot5, slot6 in pairs(slot0._chapterSceneUdtbDict) do
			gohelper.setActive(slot6.go, slot6.chaperId == slot1)
		end
	end
end

function slot0._createChapterScene(slot0, slot1)
	if slot0._chapterSceneUdtbDict and not slot0._chapterSceneUdtbDict[slot1] then
		slot2 = slot0:getResInst(Activity1_3ChessEnum.MapSceneResPath[slot1], slot0._sceneRoot)

		transformhelper.setLocalPos(slot2.transform, 0, 0, 0)

		slot3 = slot0:getUserDataTb_()
		slot3.go = slot2
		slot3.chaperId = slot1
		slot3.nodeElementDic = {}
		slot3.animator = gohelper.onceAddComponent(slot2, typeof(UnityEngine.Animator))
		slot0._chapterSceneUdtbDict[slot1] = slot3

		slot0:_initChapterSceneElement(slot1)
	end
end

function slot0._initChapterSceneElement(slot0, slot1)
	slot2 = slot0._chapterSceneUdtbDict[slot1]

	for slot7, slot8 in ipairs(uv0[slot1]) do
		for slot13, slot14 in ipairs(uv1[slot8]) do
			if gohelper.findChild(slot2.go, slot14) then
				if not slot2.nodeElementDic[slot8] then
					slot2.nodeElementDic[slot8] = {}
				end

				slot16 = slot2.nodeElementDic[slot8]
				slot16[#slot16 + 1] = slot15

				gohelper.setActive(slot15, false)
			end
		end
	end

	slot0:_refreshChaperSceneElement(slot1)
end

function slot0._refreshChaperSceneElement(slot0, slot1, slot2)
	if not (slot0._chapterSceneUdtbDict[slot1] and slot3.nodeElementDic) then
		return
	end

	for slot8, slot9 in pairs(slot4) do
		slot11 = Activity122Model.instance:getEpisodeData(slot8) and slot10.star > 0

		if slot2 ~= nil then
			slot11 = slot2
		end

		for slot15, slot16 in ipairs(slot9) do
			gohelper.setActive(slot16, slot11)
		end
	end
end

function slot0.onSetVisible(slot0, slot1)
	if slot1 then
		slot0:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.One)
		slot0:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.Two)
	else
		slot0:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.One, false)
		slot0:_refreshChaperSceneElement(Activity1_3ChessEnum.Chapter.Two, false)
	end
end

function slot0.playSceneEnterAni(slot0, slot1)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)

	if slot0._chapterSceneUdtbDict[slot1] and slot2.animator then
		slot2.animator:Play("open")
	end

	TaskDispatcher.runDelay(slot0.playSceneEnterAniEnd, slot0, 0.6)
end

function slot0.playSceneEnterAniEnd(slot0)
	UIBlockMgr.instance:endBlock(Activity1_3ChessEnum.UIBlockKey)
end

function slot0.onDestroyView(slot0)
	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end

	if slot0._chapterSceneUdtbDict then
		slot0._chapterSceneUdtbDict = nil
	end
end

return slot0
