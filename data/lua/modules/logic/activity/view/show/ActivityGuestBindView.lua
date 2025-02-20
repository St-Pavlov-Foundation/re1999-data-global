module("modules.logic.activity.view.show.ActivityGuestBindView", package.seeall)

slot0 = class("ActivityGuestBindView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "leftbottom/#scroll_reward")
	slot0._btngo = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbottom/#btn_go")
	slot0._txtbtngo = gohelper.findChildText(slot0.viewGO, "rightbottom/#btn_go/#txt_btngo")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngo:AddClickListener(slot0._btngoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngo:RemoveClickListener()
end

function slot0._btngoOnClick(slot0)
	slot2 = SDKModel.instance:getAccountBindBonus()

	logNormal("ActivityGuestBindView:_btngoOnClick click: e=" .. tostring(slot2))

	if slot2 == SDKEnum.RewardType.None then
		SDKMgr.instance:openAccountBind()

		return
	end

	if slot2 == slot1.Claim then
		logNormal("ActivityGuestBindView:_btngoOnClick sendAct1000AccountBindBonusRequest")
		Activity1000Rpc.instance:sendAct1000AccountBindBonusRequest(slot0.viewParam.actId)

		return
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_blind_bg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam

	gohelper.addChild(slot1.parent, slot0.viewGO)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
	Activity1000Rpc.instance:sendAct1000GetInfoRequest(slot1.actId, slot0._refresh, slot0)

	slot9 = "#"
	slot5 = {}

	for slot9 = 1, #GameUtil.splitString2(SDKConfig.instance:getGuestBindRewards(), true, "|", slot9) do
		slot5[#slot5 + 1] = {
			itemCO = slot4[slot9]
		}
	end

	ActivityGuestBindViewListModel.instance:setList(slot5)
	slot0:_refresh()
	slot0:addEventCb(SDKController.instance, SDKEvent.UpdateAccountBindBonus, slot0._refresh, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SDKController.instance, SDKEvent.UpdateAccountBindBonus, slot0._refresh, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

function slot0._onUpdateAccountBindBonus(slot0)
	logNormal("ActivityGuestBindView:_onGuestBindSucc")
	slot0:_refresh()
end

function slot0._refresh(slot0)
	slot2 = SDKModel.instance:getAccountBindBonus()

	logNormal("ActivityGuestBindView:_refresh e=" .. tostring(slot2))

	if slot2 == SDKEnum.RewardType.None then
		slot0._txtbtngo.text = luaLang("activityguestbindview_go")
	elseif slot2 == slot1.Claim then
		slot0._txtbtngo.text = luaLang("activityguestbindview_reward")
	elseif slot2 == slot1.Got then
		slot0._txtbtngo.text = luaLang("activityguestbindview_rewarded")
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._btngo.gameObject:GetComponent(gohelper.Type_Image), slot2 == slot1.Got and "#666666" or "#ffffff")
end

return slot0
