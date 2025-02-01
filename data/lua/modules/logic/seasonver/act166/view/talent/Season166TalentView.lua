module("modules.logic.seasonver.act166.view.talent.Season166TalentView", package.seeall)

slot0 = class("Season166TalentView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, slot0._refreshTalentSlot, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, slot0._refreshTalentSlot, slot0)
end

function slot0._editableInitView(slot0)
	slot0._actId = Season166Model.instance:getCurSeasonId()

	slot0:_initTalent()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = Season166Model.instance:getCurSeasonId()

	slot0:_refreshUI()
	slot0:refreshReddot()
end

function slot0._initTalent(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(lua_activity166_talent.configList) do
		if slot7.activityId == slot0._actId then
			slot1[#slot1 + 1] = slot7
		end
	end

	slot0.talentItemDic = {}

	for slot6 = 1, #slot1 do
		if not gohelper.isNil(gohelper.findChild(slot0.viewGO, "root/talents/talent" .. slot6)) then
			slot8 = slot0:getUserDataTb_()
			slot8.config = slot1[slot6]
			slot9 = slot8.config.talentId
			gohelper.findChildText(slot7, "up/txt_talentName").text = slot8.config.name
			gohelper.findChildText(slot7, "up/en").text = slot8.config.nameEn
			slot8.goEquip = gohelper.findChild(slot7, "go_Equip")
			slot8.btnEquip = gohelper.findChildButtonWithAudio(slot7, "go_Equip/btn_equip")
			slot8.btnLock = gohelper.findChildButtonWithAudio(slot7, "go_Equip/locked")
			slot8.goequiping = gohelper.findChild(slot7, "go_Equip/go_equiping")
			slot8.reddotGO = gohelper.findChild(slot7, "reddot")
			slot8.goslot1 = gohelper.findChild(slot7, "equipslot/1")
			slot8.goslotLight1 = gohelper.findChild(slot7, "equipslot/1/light")
			slot8.goslot2 = gohelper.findChild(slot7, "equipslot/2")
			slot8.goslotLight2 = gohelper.findChild(slot7, "equipslot/2/light")
			slot8.goslot3 = gohelper.findChild(slot7, "equipslot/3")
			slot8.goslotLight3 = gohelper.findChild(slot7, "equipslot/3/light")
			slot8.anim = slot7:GetComponent(gohelper.Type_Animator)

			slot0:addClickCb(gohelper.findChildButtonWithAudio(slot7, "up"), slot0._clickTalent, slot0, slot9)
			slot0:addClickCb(slot8.btnEquip, slot0._clickEquip, slot0, slot9)
			slot0:addClickCb(slot8.btnLock, slot0._clickLock, slot0)

			slot0.talentItemDic[slot9] = slot8
		end
	end
end

function slot0._clickTalent(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Season166TalentSelectView, {
		talentId = slot1
	})
end

function slot0._clickEquip(slot0, slot1)
	if Season166Model.getPrefsTalent() == slot1 then
		return
	end

	Season166Model.setPrefsTalent(slot1)
	Season166Controller.instance:dispatchEvent(Season166Event.SetTalentId, slot1)
	slot0:_refreshEquipBtn()
end

function slot0._clickLock(slot0)
	GameFacade.showToast(ToastEnum.Season166TalentLock)
end

function slot0._refreshUI(slot0)
	slot0:_refreshTalentSlot()

	if slot0.viewParam and slot0.viewParam.showEquip then
		slot0:_refreshEquipBtn()
	end

	for slot5, slot6 in pairs(slot0.talentItemDic) do
		gohelper.setActive(slot6.goEquip, slot1)
	end
end

function slot0._refreshEquipBtn(slot0)
	slot1 = slot0.viewParam.talentId or Season166Model.getPrefsTalent()

	for slot5, slot6 in pairs(slot0.talentItemDic) do
		if slot0.viewParam.talentId then
			gohelper.setActive(slot6.btnEquip, false)
			gohelper.setActive(slot6.goequiping, slot5 == slot1)
			gohelper.setActive(slot6.btnLock, slot5 ~= slot1)
		else
			gohelper.setActive(slot6.btnEquip, slot5 ~= slot1)
			gohelper.setActive(slot6.goequiping, slot5 == slot1)
			gohelper.setActive(slot6.btnLock, false)
		end

		slot6.anim:Play(slot5 == slot1 and "start" or "idle")
	end
end

function slot0._refreshTalentSlot(slot0)
	for slot4, slot5 in pairs(slot0.talentItemDic) do
		slot6 = Season166Model.instance:getTalentInfo(slot0.actId, slot4)
		slot7 = slot6.config.slot

		for slot12 = 1, 3 do
			gohelper.setActive(slot5["goslot" .. slot12], slot12 <= slot7)

			if slot12 <= slot7 then
				gohelper.setActive(slot5["goslotLight" .. slot12], slot12 <= #slot6.skillIds)
			end
		end
	end
end

function slot0.refreshReddot(slot0)
	for slot5, slot6 in pairs(lua_activity166_talent.configDict[slot0._actId]) do
		gohelper.setActive(slot0.talentItemDic[slot6.talentId].reddotGO, Season166Model.instance:checkHasNewTalent(slot6.talentId))
	end
end

function slot0.checkTalentReddotShow(slot0, slot1)
	slot1:defaultRefreshDot()

	slot1.show = Season166Model.instance:checkHasNewTalent(slot1.infoDict[RedDotEnum.DotNode.Season166Talent])

	if slot1.show then
		slot1:showRedDot(RedDotEnum.Style.Green)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.Season166TalentSelectView then
		slot0:refreshReddot()
	end
end

return slot0
