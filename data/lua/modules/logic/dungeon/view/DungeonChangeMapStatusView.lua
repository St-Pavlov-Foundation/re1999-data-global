module("modules.logic.dungeon.view.DungeonChangeMapStatusView", package.seeall)

slot0 = class("DungeonChangeMapStatusView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagesun = gohelper.findChildSingleImage(slot0.viewGO, "#simage_sun")
	slot0._simagemoon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_moon")
	slot0._simagesun1 = gohelper.findChildSingleImage(slot0.viewGO, "Sun/ani/#simage_sun1")
	slot0._simagesun2 = gohelper.findChildSingleImage(slot0.viewGO, "Sun/ani/#simage_sun2")
	slot0._simagemoon1 = gohelper.findChildSingleImage(slot0.viewGO, "Moon/ani/#simage_moon1")
	slot0._simagemoon2 = gohelper.findChildSingleImage(slot0.viewGO, "Moon/ani/#simage_moon2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._changeAnimatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0._simagesun:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_sun_3"))
	slot0._simagemoon:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_moon_3"))
	slot0._simagesun1:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_sun_1"))
	slot0._simagesun2:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_sun_2"))
	slot0._simagemoon1:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_moon_1"))
	slot0._simagemoon2:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeon_change_moon_2"))
end

function slot0._changeTime(slot0, slot1)
	AudioMgr.instance:trigger(slot1 == "moon" and AudioEnum.VersionActivity1_3.play_ui_molu_night_switch or AudioEnum.VersionActivity1_3.play_ui_molu_daytime_switch)
	slot0._changeAnimatorPlayer:Play("to_" .. slot1, slot0._changeDone, slot0)
end

function slot0._changeDone(slot0)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
	slot0:_changeTime(slot0.viewParam)
end

function slot0.onOpen(slot0)
	slot0:_changeTime(slot0.viewParam)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagesun:UnLoadImage()
	slot0._simagemoon:UnLoadImage()
	slot0._simagesun1:UnLoadImage()
	slot0._simagesun2:UnLoadImage()
	slot0._simagemoon1:UnLoadImage()
	slot0._simagemoon2:UnLoadImage()
end

return slot0
