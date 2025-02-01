module("modules.logic.rouge.dlc.101.view.RougeLimiterDebuffTipsView", package.seeall)

slot0 = class("RougeLimiterDebuffTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobuffdec = gohelper.findChild(slot0.viewGO, "#go_buffdec")
	slot0._btncheck = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buffdec/#btn_check")
	slot0._imagebufficon = gohelper.findChildImage(slot0.viewGO, "#go_buffdec/#image_bufficon")
	slot0._txtbufflevel = gohelper.findChildText(slot0.viewGO, "#go_buffdec/#txt_bufflevel")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#go_buffdec/#txt_dec")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_buffdec/#txt_name")
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "#go_buffdec/#image_point")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "#go_buffdec/#txt_cost")
	slot0._txtbuffdec = gohelper.findChildText(slot0.viewGO, "#go_buffdec/#txt_buffdec")
	slot0._btnequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buffdec/btnContain/#btn_equip")
	slot0._btnunequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buffdec/btnContain/#btn_unequip")
	slot0._btncostunlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buffdec/btnContain/#btn_costunlock")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_buffdec/btnContain/#btn_costunlock/#txt_num")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_buffdec/btnContain/#btn_costunlock/#txt_num/#image_icon")
	slot0._btnspeedup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buffdec/btnContain/#btn_speedup")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncheck:AddClickListener(slot0._btncheckOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncheck:RemoveClickListener()
end

function slot0._btncheckOnClick(slot0)
	RougeDLCController101.instance:openRougeLimiterOverView({
		limiterIds = RougeDLCModel101.instance:getLimiterClientMo() and slot1:getLimitIds(),
		buffIds = RougeDLCModel101.instance:getAllLimiterBuffIds(),
		totalRiskValue = RougeDLCModel101.instance:getTotalRiskValue()
	})
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.RefreshLimiterDebuffTips, slot0._onRefreshLimiterDebuffTips, slot0)

	slot0._animator = gohelper.onceAddComponent(slot0._gobuffdec, gohelper.Type_Animator)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshDebuffTips()
end

function slot0.onOpen(slot0)
	slot0:refreshDebuffTips()
end

function slot0.refreshDebuffTips(slot0, slot1)
	slot0._preLimiterGroupId = slot0._curLimiterGroupId
	slot0._preLimiterGroupLv = slot0._curLimiterGroupLv

	if RougeDLCModel101.instance:getCurLimiterGroupLv(slot1) <= 0 then
		slot1 = slot0:getNeedShowLimiterGroupId()
	end

	slot0._curLimiterGroupId = slot1 or slot0:getNeedShowLimiterGroupId()
	slot3 = slot0._curLimiterGroupId and slot0._curLimiterGroupId > 0

	gohelper.setActive(slot0._gobuffdec, slot3)

	if not slot3 then
		slot0._preLimiterGroupId = nil
		slot0._curLimiterGroupId = nil

		return
	end

	slot0._curLimiterGroupLv = RougeDLCModel101.instance:getCurLimiterGroupLv(slot0._curLimiterGroupId)
	slot0._txtname.text = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(slot0._curLimiterGroupId, slot0._curLimiterGroupLv) and slot4.title
	slot0._txtdec.text = slot4 and slot4.desc
	slot0._txtcost.text = slot4 and slot4.riskValue
	slot0._txtbufflevel.text = GameUtil.getRomanNums(slot0._curLimiterGroupLv)

	UISpriteSetMgr.instance:setRouge4Sprite(slot0._imagebufficon, RougeDLCConfig101.instance:getLimiterGroupCo(slot0._curLimiterGroupId).icon)
end

function slot0.getNeedShowLimiterGroupId(slot0)
	return slot1 and slot1[RougeDLCModel101.instance:getSelectLimiterGroupIds() and #slot1 or 0]
end

function slot0._onRefreshLimiterDebuffTips(slot0, slot1)
	slot0:refreshDebuffTips(slot1)
	slot0:try2PlayRefreshAnim(slot1)
end

function slot0.try2PlayRefreshAnim(slot0, slot1)
	if not slot0:isNeedPlayRefreshAnim(slot1) then
		return
	end

	slot0._animator:Play("refresh", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.RefreshLimiterTips)
end

function slot0.isNeedPlayRefreshAnim(slot0)
	if not slot0._curLimiterGroupId and not slot0._preLimiterGroupId then
		return false
	end

	if slot0._curLimiterGroupId == slot0._preLimiterGroupId and slot0._preLimiterGroupLv == slot0._curLimiterGroupLv then
		return false
	end

	return true
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
