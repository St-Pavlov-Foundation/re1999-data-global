module("modules.logic.room.view.critter.summon.RoomCritterSummonPoolIcon", package.seeall)

slot0 = class("RoomCritterSummonPoolIcon", CommonCritterIcon)

function slot0.onInitView(slot0)
	slot0._imagequality = gohelper.findChildImage(slot0.viewGO, "#simage_quality")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._gomood = gohelper.findChild(slot0.viewGO, "#go_mood")
	slot0._gohasMood = gohelper.findChild(slot0.viewGO, "#go_mood/#go_hasMood")
	slot0._simagemood = gohelper.findChildSingleImage(slot0.viewGO, "#go_mood/#go_hasMood/#simage_mood")
	slot0._simageprogress = gohelper.findChildSingleImage(slot0.viewGO, "#go_mood/#go_hasMood/#simage_progress")
	slot0._txtmood = gohelper.findChildText(slot0.viewGO, "#go_mood/#go_hasMood/#txt_mood")
	slot0._gonoMood = gohelper.findChild(slot0.viewGO, "#go_mood/#go_noMood")
	slot0._gobuildingIcon = gohelper.findChild(slot0.viewGO, "#go_buildingIcon")
	slot0._simagebuildingIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_buildingIcon/#simage_buildingIcon")
	slot0._goindex = gohelper.findChild(slot0.viewGO, "#go_index")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#go_index/#txt_index")
	slot0._gonum = gohelper.findChild(slot0.viewGO, "#go_num")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_num/#txt_num")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._btnclick = gohelper.findChildClickWithAudio(slot0.viewGO, "#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1

	slot0:setMOValue()
	slot0:activeGo()
end

function slot0.setMOValue(slot0, slot1, slot2, slot3, slot4)
	slot0.critterId = slot0.mo.critterId

	slot0:setSelectUIVisible(slot3)
	slot0:refresh()
end

function slot0.refresh(slot0)
	uv0.super.refresh(slot0)
	slot0:refrshNum()
	slot0:refrshNull()
end

function slot0.refreshIcon(slot0)
	if not string.nilorempty(CritterConfig.instance:getCritterHeadIcon(slot0.mo:getCritterMo():getSkinId())) then
		slot0:_loadIcon(ResUrl.getCritterHedaIcon(slot2))
	end
end

function slot0.activeGo(slot0)
	gohelper.setActive(slot0._gomood, false)
	gohelper.setActive(slot0._goindex, false)
	gohelper.setActive(slot0._gonum, true)
end

function slot0.refrshNum(slot0)
	slot0._txtnum.text = slot0.mo:getPoolCount()
end

function slot0.refrshNull(slot0)
	slot1 = slot0.mo:getPoolCount() <= 0

	gohelper.setActive(slot0._gofinish, slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._imagequality.gameObject, slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._simageicon.gameObject, slot1)
end

return slot0
