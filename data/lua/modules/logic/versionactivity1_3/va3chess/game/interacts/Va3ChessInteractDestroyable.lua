module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractDestroyable", package.seeall)

slot0 = class("Va3ChessInteractDestroyable", Va3ChessInteractBase)

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)

	if not slot0._target.avatar.loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot0._animSelf = slot2:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0._target.interoperableFlag = gohelper.findChild(slot2, "icon")
end

slot1 = "switch"

function slot0.playDeleteObjView(slot0)
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.BreakBoughs)

	if slot0._animSelf then
		slot0._animSelf:Play(uv0)
	end
end

function slot0.showStateView(slot0, slot1, slot2)
	if slot1 == Va3ChessEnum.ObjState.Idle then
		slot0:showIdleStateView()
	elseif slot1 == Va3ChessEnum.ObjState.Interoperable then
		slot0:showInteroperableStateView(slot2)
	end
end

function slot0.showIdleStateView(slot0)
	gohelper.setActive(slot0._target.interoperableFlag, false)
end

function slot0.showInteroperableStateView(slot0, slot1)
	gohelper.setActive(slot0._target.interoperableFlag, true)
end

return slot0
