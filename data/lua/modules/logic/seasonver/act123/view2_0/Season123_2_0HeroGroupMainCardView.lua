module("modules.logic.seasonver.act123.view2_0.Season123_2_0HeroGroupMainCardView", package.seeall)

slot0 = class("Season123_2_0HeroGroupMainCardView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerole = gohelper.findChildSingleImage(slot0.viewGO, "herogroupcontain/#simage_role")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot4 = ResUrl.getSeasonIcon

	slot0._simagerole:LoadImage(slot4("img_vertin.png"))

	slot0._supercardItems = {}
	slot0._supercardGroups = {}

	for slot4 = 1, Activity123Enum.MainCardNum do
		slot5 = slot0:getUserDataTb_()
		slot5.golight = gohelper.findChild(slot0.viewGO, string.format("herogroupcontain/#go_supercard%s/light", slot4))
		slot5.goempty = gohelper.findChild(slot0.viewGO, string.format("herogroupcontain/#go_supercard%s/#go_supercardempty", slot4))
		slot5.gopos = gohelper.findChild(slot0.viewGO, string.format("herogroupcontain/#go_supercard%s/#go_supercardpos", slot4))
		slot5.btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, string.format("herogroupcontain/#go_supercard%s/#btn_supercardclick", slot4))

		slot5.btnclick:AddClickListener(slot0._btnseasonsupercardOnClick, slot0, slot4)

		slot0._supercardGroups[slot4] = slot5
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagerole:UnLoadImage()

	if slot0._supercardGroups then
		for slot4, slot5 in pairs(slot0._supercardGroups) do
			slot5.btnclick:RemoveClickListener()
		end

		slot0._supercardGroups = nil
	end

	if slot0._supercardItems then
		for slot4, slot5 in pairs(slot0._supercardItems) do
			slot5:destroy()
		end

		slot0._supercardItems = nil
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0.refreshMainCards, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0.refreshMainCards, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.HeroGroupIndexChanged, slot0.refreshMainCards, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.RecordRspMainCardRefresh, slot0.refreshMainCards, slot0)
	slot0:refreshMainCards()
end

function slot0.onClose(slot0)
end

function slot0.refreshMainCards(slot0)
	for slot4 = 1, Activity123Enum.MainCardNum do
		slot0:_refreshMainCard(slot4)
	end
end

function slot0._refreshMainCard(slot0, slot1)
	slot2 = HeroGroupModel.instance:getCurGroupMO()
	slot6 = false

	if Season123HeroGroupModel.instance:getMainPosEquipId(slot1) and slot3 ~= 0 then
		if not slot0._supercardItems[slot1] then
			slot5 = Season123_2_0CelebrityCardItem.New()

			slot5:init(slot0._supercardGroups[slot1].gopos, slot3)

			slot0._supercardItems[slot1] = slot5
		else
			gohelper.setActive(slot5.go, true)
			slot5:reset(slot3)
		end

		slot6 = true
	elseif slot5 then
		gohelper.setActive(slot5.go, false)
	end

	gohelper.setActive(slot4.golight, slot6)

	if not Season123Model.instance:getActInfo(slot0.viewParam.actId) then
		return
	end

	slot8 = slot7.heroGroupSnapshotSubId
	slot9 = Season123HeroGroupModel.instance:isEquipCardPosUnlock(slot1, Season123EquipItemListModel.MainCharPos)

	gohelper.setActive(slot4.goempty, slot9)
	gohelper.setActive(slot4.btnclick, slot9)
end

function slot0._btnseasonsupercardOnClick(slot0, slot1)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not Season123HeroGroupModel.instance:isEquipCardPosUnlock(({
		actId = slot0.viewParam.actId,
		stage = slot0.viewParam.stage,
		slot = slot1
	}).slot, Season123EquipItemListModel.MainCharPos) then
		return
	end

	ViewMgr.instance:openView(Season123Controller.instance:getEquipHeroViewName(), slot2)
end

return slot0
