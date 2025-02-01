module("modules.logic.room.view.common.RoomMaterialTipViewContainer", package.seeall)

slot0 = class("RoomMaterialTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomMaterialTipView.New())
	table.insert(slot1, RoomMaterialTipViewBanner.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onContainerOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_open)
end

return slot0
