module("modules.logic.versionactivity1_4.act130.view.Activity130DungeonChange", package.seeall)

slot0 = class("Activity130DungeonChange", BaseView)

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
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0._changeRoot = gohelper.findChild(slot0.viewGO, "#go_dungeonchange")
	slot0._changeGo = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._changeRoot)
	slot0._changeAnimator = slot0._changeGo:GetComponent(typeof(UnityEngine.Animator))
	slot0._changeAnimatorPlayer = SLFramework.AnimatorPlayer.Get(slot0._changeGo)

	gohelper.setActive(slot0._changeRoot, false)
end

function slot0.onClose(slot0)
end

function slot0._onNewUnlockChangeLevelScene(slot0)
	if Activity130Model.instance:getNewUnlockEpisode() > -1 then
		slot0:_onChangeLevelScene(slot1)
	end
end

function slot0._onChangeLevelScene(slot0, slot1)
	if Activity130Model.instance:getCurEpisodeId() > 4 and slot1 > 4 then
		return
	end

	if slot2 < 5 and slot1 < 5 then
		return
	end

	slot3 = VersionActivity1_4Enum.ActivityId.Role37
	slot0._toSceneType = slot1 < 1 and Activity130Enum.lvSceneType.Light or Activity130Config.instance:getActivity130EpisodeCo(slot3, slot1).lvscene

	gohelper.setActive(slot0._changeRoot, true)

	if slot0._toSceneType == Activity130Enum.lvSceneType.Light then
		slot0._changeAnimator:Play("to_sun", 0, 0)

		if slot0._toSceneType ~= (slot2 < 1 and Activity130Enum.lvSceneType.Light or Activity130Config.instance:getActivity130EpisodeCo(slot3, slot2).lvscene) then
			TaskDispatcher.runDelay(slot0._startChangeScene, slot0, 0.17)
		end
	elseif slot0._toSceneType == Activity130Enum.lvSceneType.Moon then
		slot0._changeAnimator:Play("to_moon", 0, 0)

		if slot0._toSceneType ~= slot4 then
			TaskDispatcher.runDelay(slot0._startChangeScene, slot0, 0.17)
		end
	end
end

function slot0._startChangeScene(slot0)
	slot0.viewContainer:changeLvScene(slot0._toSceneType)
	TaskDispatcher.runDelay(slot0._aniFinished, slot0, 0.83)
end

function slot0._aniFinished(slot0)
	gohelper.setActive(slot0._changeRoot, false)
end

function slot0._addEvents(slot0)
end

function slot0._removeEvents(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
end

return slot0
