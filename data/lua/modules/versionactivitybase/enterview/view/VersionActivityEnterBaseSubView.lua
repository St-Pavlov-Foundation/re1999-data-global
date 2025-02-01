module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseSubView", package.seeall)

slot0 = class("VersionActivityEnterBaseSubView", BaseView)

function slot0.onInitView(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)) then
		slot1:Play(UIAnimationName.Open, 0, 0)
	end

	slot0:everySecondCall()
	slot0:beginPerSecondRefresh()
end

function slot0.onOpenFinish(slot0)
end

function slot0.onEnterVideoFinished(slot0)
	slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:everySecondCall()
end

function slot0.onDestroyView(slot0)
end

function slot0.beginPerSecondRefresh(slot0)
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
end

function slot0.everySecondCall(slot0)
end

return slot0
