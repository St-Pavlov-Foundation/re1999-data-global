module("modules.logic.rouge.dlc.101.view.RougeLimiterLockedTipsView", package.seeall)

slot0 = class("RougeLimiterLockedTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._scrolltips = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_tips")
	slot0._imagebufficon = gohelper.findChildImage(slot0.viewGO, "#scroll_tips/Viewport/Content/top/#image_bufficon")
	slot0._txtbufflevel = gohelper.findChildText(slot0.viewGO, "#scroll_tips/Viewport/Content/top/#txt_bufflevel")
	slot0._txtbuffname = gohelper.findChildText(slot0.viewGO, "#scroll_tips/Viewport/Content/top/#txt_buffname")
	slot0._godesccontainer = gohelper.findChild(slot0.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer")
	slot0._txtdecitem = gohelper.findChildText(slot0.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer/#txt_decitem")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "#scroll_tips/Viewport/Content/#txt_tips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUnlockedTips()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRougeLimiterLockedTips)
end

function slot0.refreshUnlockedTips(slot0)
	slot0._limiterGroupId = slot0.viewParam and slot0.viewParam.limiterGroupId
	slot1 = RougeDLCConfig101.instance:getLimiterGroupCo(slot0._limiterGroupId)
	slot4 = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(slot0._limiterGroupId, RougeDLCConfig101.instance:getLimiterGroupMaxLevel(slot0._limiterGroupId)) and slot3.id
	slot0._txtbufflevel.text = GameUtil.getRomanNums(slot2)
	slot0._txtbuffname.text = slot1 and slot1.title
	slot0._txttips.text = slot1 and slot1.desc

	UISpriteSetMgr.instance:setRouge4Sprite(slot0._imagebufficon, slot1.icon)
	slot0:_refreshLimiterGroupDesc()
end

function slot0._refreshLimiterGroupDesc(slot0)
	gohelper.CreateObjList(slot0, slot0._refreshGroupDesc, RougeDLCConfig101.instance:getAllLimiterCosInGroup(slot0._limiterGroupId), slot0._godesccontainer, slot0._txtdecitem.gameObject)
end

function slot0._refreshGroupDesc(slot0, slot1, slot2, slot3)
	gohelper.onceAddComponent(slot1, gohelper.Type_TextMesh).text = slot2 and slot2.desc
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
