module("modules.logic.room.view.critter.detail.RoomCriiterDetailSimpleViewContainer", package.seeall)

slot0 = class("RoomCriiterDetailSimpleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCriiterDetailSimpleView.New())

	return slot1
end

function slot0.playCloseTransition(slot0)
	ZProj.ProjAnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0.onCloseAnimDone, slot0)
end

function slot0.onCloseAnimDone(slot0)
	slot0:onPlayCloseTransitionFinish()
	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onCloseRoomCriiterDetailSimpleView)
end

return slot0
