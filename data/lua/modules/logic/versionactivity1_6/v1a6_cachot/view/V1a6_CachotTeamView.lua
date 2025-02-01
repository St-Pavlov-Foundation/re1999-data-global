module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamView", package.seeall)

slot0 = class("V1a6_CachotTeamView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotipswindow = gohelper.findChild(slot0.viewGO, "#go_tipswindow")
	slot0._simageselect = gohelper.findChildSingleImage(slot0.viewGO, "#go_tipswindow/left/#simage_select")
	slot0._gopresetcontent = gohelper.findChild(slot0.viewGO, "#go_tipswindow/left/scroll_view/Viewport/#go_presetcontent")
	slot0._gopreparecontent = gohelper.findChild(slot0.viewGO, "#go_tipswindow/right/scroll_view/Viewport/#go_preparecontent")
	slot0._gostart = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_start")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tipswindow/#go_start/#btn_start")
	slot0._gostartlight = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_start/#btn_start/#go_startlight")
	slot0._imagepoint1 = gohelper.findChildImage(slot0.viewGO, "#go_tipswindow/#go_start/#image_point1")
	slot0._gopoin1light = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_start/#image_point1/#go_poin1_light")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnaddheartOnClick(slot0)
end

function slot0._btnaddroleOnClick(slot0)
end

function slot0._btnstartOnClick(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = slot0:_getGroup(1, "", slot1, slot2, 1, V1a6_CachotEnum.HeroCountInGroup)
	slot4 = slot0:_getGroup(1, "", slot1, slot2, V1a6_CachotEnum.HeroCountInGroup + 1, V1a6_CachotEnum.InitTeamMaxHeroCountInGroup)

	if #slot1 == 0 then
		GameFacade.showToast(ToastEnum.V1a6CachotToast02)

		return
	end

	RogueRpc.instance:sendEnterRogueRequest(V1a6_CachotEnum.ActivityId, V1a6_CachotTeamModel.instance:getSelectLevel(), slot3, slot4, slot2)
	V1a6_CachotStatController.instance:statStart()
end

function slot0._getGroup(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = {
		id = slot1,
		groupName = slot2
	}
	slot9 = {}
	slot10 = {}

	for slot14 = slot5, slot6 do
		slot15 = V1a6_CachotHeroSingleGroupModel.instance:getById(slot14)

		if tonumber(V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO():getPosEquips(slot14 - 1).equipUid[1]) and slot17 > 0 then
			if EquipModel.instance:getEquip(slot16.equipUid[1]) then
				table.insert(slot4, slot17)
			else
				slot16.equipUid[1] = "0"
				slot17 = 0
			end
		end

		slot19 = HeroModel.instance:getById(slot15.heroUid) and slot18.heroId or 0

		table.insert(slot9, slot19)
		table.insert(slot10, slot16)

		if slot19 > 0 then
			table.insert(slot3, slot19)
		end
	end

	slot7.heroList = slot9
	slot7.equips = slot10

	return slot7
end

function slot0._hasSelectedHero(slot0)
	for slot4 = 1, V1a6_CachotEnum.InitTeamMaxHeroCountInGroup do
		if (HeroModel.instance:getById(V1a6_CachotHeroSingleGroupModel.instance:getById(slot4).heroUid) and slot6.heroId or 0) > 0 then
			return true
		end
	end
end

function slot0._updateStatus(slot0)
	slot1 = slot0:_hasSelectedHero()

	gohelper.setActive(slot0._gostartlight, slot1)
	gohelper.setActive(slot0._gopoin1light, slot1)

	slot0._imagepoint1.enabled = not slot1
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gostart, slot0.viewParam and slot0.viewParam.isInitSelect)
	slot0:_updateStatus()
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnReceiveEnterRogueReply, slot0._onReceiveEnterRogueReply, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._modifyHeroGroup, slot0)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotTeamView, slot0._btncloseOnClick, slot0)
end

function slot0._modifyHeroGroup(slot0)
	slot0:_updateStatus()
end

function slot0._onReceiveEnterRogueReply(slot0)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotMainView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotDifficultyView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotTeamView)
	V1a6_CachotController.instance:openRoom()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
