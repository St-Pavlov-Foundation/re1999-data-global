module("modules.logic.scene.view.LoadingRoomView", package.seeall)

slot0 = class("LoadingRoomView", LoadingBlackView)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_amb_home_mist)
end

return slot0
