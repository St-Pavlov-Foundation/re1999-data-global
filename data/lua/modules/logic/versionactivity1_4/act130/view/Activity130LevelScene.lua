module("modules.logic.versionactivity1_4.act130.view.Activity130LevelScene", package.seeall)

slot0 = class("Activity130LevelScene", BaseView)

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
	slot0._sceneRoot = UnityEngine.GameObject.New("ActivityRole37Map")

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0._sceneGos = slot0:getUserDataTb_()

	MainCameraMgr.instance:addView(ViewName.Activity130LevelView, slot0._initCamera, nil, slot0)

	slot2 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot0._sceneRoot)

	table.insert(slot0._sceneGos, slot2)
	gohelper.setActive(slot2, false)

	slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[4], slot0._sceneRoot)

	table.insert(slot0._sceneGos, slot4)
	gohelper.setActive(slot4, false)

	slot5 = Activity130Model.instance:getMaxUnlockEpisode()

	if slot0.viewParam and slot0.viewParam.episodeId then
		slot5 = slot0.viewParam.episodeId
	end

	Activity130Model.instance:setCurEpisodeId(slot5)

	slot7 = slot5 < 1 and Activity130Enum.lvSceneType.Light or Activity130Config.instance:getActivity130EpisodeCo(VersionActivity1_4Enum.ActivityId.Role37, slot5).lvscene

	gohelper.setActive(slot0._sceneGos[slot7], true)
	transformhelper.setLocalPos(slot0._sceneGos[slot7].transform, 0, 0, 0)

	slot0._scene1Animator = slot0._sceneGos[1]:GetComponent(typeof(UnityEngine.Animator))

	slot0._scene1Animator:Play("open", 0, 0)

	slot0._scene2Animator = slot0._sceneGos[2]:GetComponent(typeof(UnityEngine.Animator))

	slot0._scene2Animator:Play("open", 0, 0)
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
		gohelper.setActive(slot0._sceneGos[2], Activity130Config.instance:getActivity130EpisodeCo(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId()).lvscene == Activity130Enum.lvSceneType.Moon)
		gohelper.setActive(slot0._sceneRoot, slot1)
	end
end

function slot0._onSetScenePos(slot0, slot1)
	for slot5, slot6 in pairs(slot0._sceneGos) do
		transformhelper.setPosXY(slot6.transform, slot1, 0)
	end
end

function slot0._onBackToLevelView(slot0)
	slot1 = VersionActivity1_4Enum.ActivityId.Role37

	if Activity130Model.instance:getCurEpisodeId() == 0 then
		return
	end

	gohelper.setActive(slot0._sceneGos[2], Activity130Config.instance:getActivity130EpisodeCo(slot1, slot2).lvscene == Activity130Enum.lvSceneType.Moon)

	if slot0._sceneRoot then
		gohelper.setActive(slot0._sceneRoot, true)
		slot0._scene1Animator:Play("open", 0, 0)
		slot0._scene2Animator:Play("open", 0, 0)
	end
end

function slot0.changeLvScene(slot0, slot1)
	gohelper.setActive(slot0._sceneGos[slot1], true)

	if slot1 == Activity130Enum.lvSceneType.Light then
		slot0._sceneGos[2]:GetComponent(typeof(UnityEngine.Animator)):Play("tosun", 0, 0)
	else
		slot2:Play("tohaunghun", 0, 0)
	end
end

function slot0._addEvents(slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.ShowLevelScene, slot0._onSetSceneActive, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.BackToLevelView, slot0._onBackToLevelView, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.SetScenePos, slot0._onSetScenePos, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.ShowLevelScene, slot0._onSetSceneActive, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.BackToLevelView, slot0._onBackToLevelView, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.SetScenePos, slot0._onSetScenePos, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end
end

return slot0
