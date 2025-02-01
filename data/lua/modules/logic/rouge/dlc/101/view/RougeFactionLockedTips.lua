module("modules.logic.rouge.dlc.101.view.RougeFactionLockedTips", package.seeall)

slot0 = class("RougeFactionLockedTips", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._scrolltips = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_tips")
	slot0._imageskillicon = gohelper.findChildImage(slot0.viewGO, "#scroll_tips/Viewport/Content/top/#image_skillicon")
	slot0._godesccontainer = gohelper.findChild(slot0.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer")
	slot0._txtdecitem = gohelper.findChildText(slot0.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer/#txt_decitem")
	slot0._btncostunlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#scroll_tips/Viewport/Content/#btn_costunlock")
	slot0._txtunlocknum = gohelper.findChildText(slot0.viewGO, "#scroll_tips/Viewport/Content/#btn_costunlock/#txt_unlocknum")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#scroll_tips/Viewport/Content/#btn_costunlock/#txt_unlocknum/#image_icon")
	slot0._goRightTop = gohelper.findChild(slot0.viewGO, "#go_RightTop")
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "#go_RightTop/point/#image_point")
	slot0._txtpoint = gohelper.findChildText(slot0.viewGO, "#go_RightTop/point/#txt_point")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_RightTop/point/#btn_click")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_RightTop/tips")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "#go_RightTop/tips/#txt_tips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btncostunlock:AddClickListener(slot0._btncostunlockOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btncostunlock:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncostunlockOnClick(slot0)
	if slot0._unlockEmblem <= RougeDLCModel101.instance:getTotalEmblemCount() then
		AudioMgr.instance:trigger(AudioEnum.UI.UnlockRougeSkill)
		RougeRpc.instance:sendRougeUnlockSkillRequest(RougeOutsideModel.instance:season(), slot0._unlockSkillId, function (slot0, slot1)
			if slot1 ~= 0 then
				return
			end

			RougeOutsideModel.instance:getRougeGameRecord():updateSkillUnlockInfo(uv0._skillType, uv0._unlockSkillId)
			RougeDLCModel101.instance:getLimiterMo():updateTotalEmblemCount(-uv0._unlockEmblem)
			RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateEmblem)
			RougeController.instance:dispatchEvent(RougeEvent.UpdateUnlockSkill, uv0._skillType, uv0._unlockSkillId)
			uv0:closeThis()
		end)
	else
		GameFacade.showToast(ToastEnum.LackEmblem)
	end
end

function slot0._btnclickOnClick(slot0)
	slot0._isTipVisible = not slot0._isTipVisible

	gohelper.setActive(slot0._gotips, slot0._isTipVisible)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateEmblem, slot0._onUpdateEmblem, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshSkillInfo()
	slot0:_onUpdateEmblem()
end

slot1 = "#D5D1C8"
slot2 = "#BF2E11"

function slot0._refreshSkillInfo(slot0)
	slot0._unlockSkillId = slot0.viewParam and slot0.viewParam.skillId
	slot1 = RougeDLCConfig101.instance:getUnlockSkills(slot0._unlockSkillId)
	slot0._skillType = slot1.type
	slot0._unlockEmblem = slot1 and slot1.unlockEmblem or 0
	slot0._txtunlocknum.text = string.format("<%s>-%s</color>", slot0._unlockEmblem <= RougeDLCModel101.instance:getTotalEmblemCount() and uv0 or uv1, slot0._unlockEmblem)
	slot7 = {}

	if not string.nilorempty(RougeOutsideModel.instance:config():getSkillCo(slot1.type, slot1.skillId).desc) then
		slot7 = string.split(slot6.desc, "#")
	end

	gohelper.CreateObjList(slot0, slot0.refreshDesc, slot7, slot0._godesccontainer, slot0._txtdecitem.gameObject)
	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageskillicon, slot6.icon)
end

function slot0.refreshDesc(slot0, slot1, slot2, slot3)
	gohelper.onceAddComponent(slot1, gohelper.Type_TextMesh).text = slot2
end

function slot0._onUpdateEmblem(slot0)
	slot0._txtpoint.text = RougeDLCModel101.instance:getTotalEmblemCount()
	slot0._txttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_dlc_101_emblemTips"), {
		RougeDLCModel101.instance:getTotalEmblemCount(),
		lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.MaxEmblemCount] and slot1.value or 0
	})
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
