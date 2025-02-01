module("modules.logic.versionactivity1_4.act131.view.Activity131LevelScene", package.seeall)

slot0 = class("Activity131LevelScene", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0._editableInitView(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("ActivityRole6Map")

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.onOpen(slot0)
	slot0:_addEvents()
	MainCameraMgr.instance:addView(ViewName.Activity131LevelView, slot0._initCamera, nil, slot0)

	slot0._sceneGo = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._sceneRoot)
	slot2 = Activity131Model.instance:getMaxUnlockEpisode()

	if slot0.viewParam and slot0.viewParam.episodeId then
		slot2 = slot0.viewParam.episodeId
	end

	Activity131Model.instance:setCurEpisodeId(slot2)
	gohelper.setActive(slot0._sceneGo, true)
	transformhelper.setLocalPos(slot0._sceneGo.transform, 0, 0, 0)

	slot0._sceneAnimator = slot0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	slot0._sceneAnimator:Play("open", 0, 0)

	if slot0.viewParam and slot0.viewParam.exitFromBattle then
		slot0:_onSetSceneActive(false)
	end
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7.4 * GameUtil.getAdapterScale(true)
end

function slot0.onClose(slot0)
	slot0:_removeEvents()
end

function slot0._onSetSceneActive(slot0, slot1)
	if slot0._sceneRoot then
		gohelper.setActive(slot0._sceneRoot, slot1)
	end
end

function slot0._onSetScenePos(slot0, slot1)
	transformhelper.setPosXY(slot0._sceneRoot.transform, slot1, 0)
end

function slot0._onBackToLevelView(slot0)
	if slot0._sceneRoot then
		gohelper.setActive(slot0._sceneRoot, true)
		slot0._sceneAnimator:Play("open", 0, 0)
	end
end

function slot0._addEvents(slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.ShowLevelScene, slot0._onSetSceneActive, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.BackToLevelView, slot0._onBackToLevelView, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.SetScenePos, slot0._onSetScenePos, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.ShowLevelScene, slot0._onSetSceneActive, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.BackToLevelView, slot0._onBackToLevelView, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.SetScenePos, slot0._onSetScenePos, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end
end

return slot0
