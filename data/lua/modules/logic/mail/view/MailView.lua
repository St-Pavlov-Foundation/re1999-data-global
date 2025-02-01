module("modules.logic.mail.view.MailView", package.seeall)

slot0 = class("MailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._simagebgleft = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bgleft")
	slot0._simagewave = gohelper.findChildSingleImage(slot0.viewGO, "mailtipview/#go_right/#simage_wave")
	slot0._btndeleteallmail = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_deleteallmail")
	slot0._btngetallbatch = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_getallbatch")
	slot0._txtmailcount = gohelper.findChildText(slot0.viewGO, "mailtipview/mailcount/mailcount/#txt_mailcount")
	slot0._txtunreadmailcount = gohelper.findChildText(slot0.viewGO, "mailtipview/mailcount/#txt_unreadmailcount")
	slot0._goemptyleft = gohelper.findChild(slot0.viewGO, "mailtipview/#go_emptyleft")
	slot0._goemptyright = gohelper.findChild(slot0.viewGO, "mailtipview/#go_emptyright")
	slot0._goright = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right")
	slot0._imgstamp = gohelper.findChildImage(slot0.viewGO, "mailtipview/#go_right/#image_stamp")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "mailtipview/#go_right/#scroll_content")
	slot0._sccontent = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right/#scroll_content/viewport/content")
	slot0._txtmailTitle = gohelper.findChildText(slot0.viewGO, "mailtipview/#go_right/#txt_mailTitle")
	slot0._txtsender = gohelper.findChildText(slot0.viewGO, "mailtipview/#go_right/sender/#txt_sender")
	slot0._txtsendtxt = gohelper.findChildText(slot0.viewGO, "mailtipview/#go_right/senddate/#txt_sendtxt")
	slot0._txtexpireTime = gohelper.findChildText(slot0.viewGO, "mailtipview/#go_right/time/#txt_expireTime")
	slot0._gosignature = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right/#scroll_content/viewport/content/#go_signature")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "mailtipview/#go_right/#go_rewards/#scroll_reward")
	slot0._btnget = gohelper.findChildButtonWithAudio(slot0.viewGO, "mailtipview/#go_right/#btn_get")
	slot0._gohasgotten = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right/#go_rewards/#go_hasgotten")
	slot0._imagehasgottenbg = gohelper.findChildImage(slot0.viewGO, "mailtipview/#go_right/#go_rewards/#go_hasgotten/#image_hasgottenbg")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right/#scroll_enclosure/Viewport/Content/#go_rewardItem")
	slot0._goselectone = gohelper.findChild(slot0.viewGO, "mailtipview/#go_selectone")
	slot0._imagetopicon = gohelper.findChildImage(slot0.viewGO, "mailtipview/#go_left/#image_topicon")
	slot0._rewardContent = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right/#go_rewards/#scroll_reward/viewport/content")
	slot0._contentTrs = slot0._rewardContent.transform
	slot0._gorewardsBg = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right/#go_rewards/#go_rewardsBg")
	slot0._gojump = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right/#go_jump")
	slot0._txtjump = gohelper.findChildText(slot0.viewGO, "mailtipview/#go_right/#go_jump/#txt_jump")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "mailtipview/#go_right/#go_jump/#txt_jump/#btn_jump")
	slot0._scrollmail = gohelper.findChildScrollRect(slot0.viewGO, "mailtipview/#go_left/#scroll_mail")
	slot0._gomonthcard = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right/#go_monthcard")
	slot0._btnrenew = gohelper.findChildButtonWithAudio(slot0.viewGO, "mailtipview/#go_right/#go_monthcard/#btn_renew")
	slot0._simagecardicon = gohelper.findChildSingleImage(slot0.viewGO, "mailtipview/#go_right/#go_monthcard/#simage_cardicon")
	slot0._gomodifyname = gohelper.findChild(slot0.viewGO, "mailtipview/#go_right/#go_modifyname")
	slot0._btnmodifyname = gohelper.findChildButtonWithAudio(slot0.viewGO, "mailtipview/#go_right/#go_modifyname/#btn_modifyname")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndeleteallmail:AddClickListener(slot0._btndeleteallmailOnClick, slot0)
	slot0._btngetallbatch:AddClickListener(slot0._btngetallbatchOnClick, slot0)
	slot0._btnget:AddClickListener(slot0._btngetOnClick, slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0._btnrenew:AddClickListener(slot0._btnrenewOnClick, slot0)
	slot0._btnmodifyname:AddClickListener(slot0._btnmodifynameOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndeleteallmail:RemoveClickListener()
	slot0._btngetallbatch:RemoveClickListener()
	slot0._btnget:RemoveClickListener()
	slot0._btnjump:RemoveClickListener()
	slot0._btnrenew:RemoveClickListener()
	slot0._btnmodifyname:RemoveClickListener()
	slot0._scrollcontent:RemoveOnValueChanged()
end

function slot0._btndeleteallmailOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.MailSureToDeleteAll, MsgBoxEnum.BoxType.Yes_No, function ()
		MailRpc.instance:sendDeleteMailBatchRequest(1)
	end)
end

function slot0._btngetallbatchOnClick(slot0)
	MailRpc.instance:sendReadMailBatchRequest(1)
end

function slot0._btnrenewOnClick(slot0)
	StoreController.instance:openStoreView(StoreEnum.StoreId.Package, StoreEnum.MonthCardGoodsId)
end

function slot0._btnmodifynameOnClick(slot0)
	slot0:closeThis()
	PlayerController.instance:openPlayerView(PlayerModel.instance:getPlayinfo(), true)
	ViewMgr.instance:openView(ViewName.PlayerModifyNameView)
end

function slot0._btngetOnClick(slot0)
	if slot0._selectMO and slot0._selectMO.state ~= MailEnum.ReadStatus.Read then
		MailRpc.instance:sendReadMailRequest(slot0._selectMO.id)
	end
end

function slot0._btnjumpOnClick(slot0)
	slot1 = slot0._selectMO:getJumpLink()

	if slot0._selectMO and not string.nilorempty(slot1) then
		slot2, slot3 = string.match(slot1, "^SoJump#(.+)#(.+)$")

		if slot2 then
			SDKMgr.instance:openSoJump(cjson.encode({
				url = slot2,
				id = slot3
			}))
		else
			UnityEngine.Application.OpenURL(slot1)
		end

		MailRpc.instance:sendMarkMailJumpRequest(slot0._selectMO.id)
	end
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(MailController.instance, MailEvent.OnMailCountChange, slot0._refreshCount, slot0)
	slot0:addEventCb(MailController.instance, MailEvent.UpdateSelectMail, slot0._updateSelectMail, slot0)
	slot0:addEventCb(MailController.instance, MailEvent.OnMailRead, slot0._onMailRead, slot0)
	slot0:addEventCb(MailController.instance, MailEvent.OnMailDel, slot0._onMailDel, slot0)
	gohelper.setActive(slot0._gomodifyname, false)

	slot0.orginalPos = slot0._scrollreward.transform.localPosition
	slot0._txtsignature = slot0._gosignature:GetComponent(typeof(TMPro.TMP_Text))
	slot0._rectmask2DOneWay = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2DOneWay))
	slot0._rectmask2DOneWay.enabled = true

	slot0._simagebg:LoadImage(ResUrl.getMailBg("mail_bg2"))
	slot0._simagebgleft:LoadImage(ResUrl.getMailBg("mail_bg1"))
	slot0._simagewave:LoadImage(ResUrl.getMailBg("huawen_003"))
	slot0._simagecardicon:LoadImage(ResUrl.getMailBg("bg_youjiantishi"))
	gohelper.setActive(slot0._goright, false)
	gohelper.setActive(slot0._gorewardItem, false)
	MailModel.instance:setMailList()
	slot0:_refreshCount()
	gohelper.addUIClickAudio(slot0._btndeleteallmail.gameObject, AudioEnum.UI.UI_Mail_delete)

	slot0._hyperLinkClick = slot0._txtsignature:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick:SetClickListener(slot0._onHyperLinkClick, slot0)
end

function slot0._onHyperLinkClick(slot0, slot1)
	if not string.nilorempty(slot1) then
		slot2, slot3 = string.match(slot1, "^SoJump#(.+)#(.+)$")

		if slot2 then
			SDKMgr.instance:openSoJump(cjson.encode({
				url = slot2,
				id = slot3
			}))
		else
			UnityEngine.Application.OpenURL(slot1)
		end
	end
end

function slot0._refreshCount(slot0)
	slot0:_trySelectFirstMail()

	slot1 = MailModel.instance:getCount()
	slot0._txtmailcount.text = slot1 .. "/" .. CommonConfig.instance:getConstStr(ConstEnum.MailMaxCount)
	slot0._txtunreadmailcount.text = MailModel.instance:getUnreadCount()

	gohelper.setActive(slot0._goemptyright, slot1 <= 0)
	gohelper.setActive(slot0._goemptyleft, slot1 <= 0)
	gohelper.setActive(slot0._imagetopicon.gameObject, slot1 > 0)
	gohelper.setActive(slot0._goselectone, not slot0._selectMO and slot1 > 0)
end

function slot0._trySelectFirstMail(slot0)
	if not slot0._selectMO and #MailCategroyModel.instance:getList() > 0 then
		slot0._scrollmail.verticalNormalizedPosition = 1

		MailCategroyModel.instance:selectCell(1, true)
	end
end

function slot0._updateSelectMail(slot0, slot1)
	slot0._selectMO = slot1

	gohelper.setActive(slot0._goright, slot0._selectMO)
	gohelper.setActive(slot0._goselectone, not slot0._selectMO and MailModel.instance:getCount() > 0)

	if not (slot0._selectMO and slot0._selectMO.id == slot1.id) then
		slot0._txtmailTitle.text = GameUtil.getBriefNameByWidth(slot1:getLangTitle(), slot0._txtmailTitle)
		slot0._txtsender.text = slot1:getLangSender()
		slot0._txtsendtxt.text = TimeUtil.langTimestampToString3(slot1.createTime / 1000)
		slot0._txtexpireTime.text = slot0:_getExpireTimeString(slot1.expireTime)
		slot0._txtsignature.text = slot1:getLangContent()
		slot0.senderType = "img_yp_" .. slot1:getSenderType()

		UISpriteSetMgr.instance:setMailSprite(slot0._imgstamp, slot0.senderType, true)

		if string.nilorempty(slot1:getJumpLink()) then
			gohelper.setActive(slot0._gojump.gameObject, false)
		else
			gohelper.setActive(slot0._gojump.gameObject, true)

			if type(slot1.jumpTitle) ~= "table" and string.nilorempty(slot1.jumpTitle) then
				slot0._txtjump.text = luaLang("mail_jump_title")
			else
				slot0._txtjump.text = slot1:getTemplateJumpTitle()
			end
		end

		slot0._scrollcontent.verticalNormalizedPosition = 1
		slot0._scrollreward.horizontalNormalizedPosition = 0

		if slot1:haveBonus() then
			gohelper.setActive(slot0._scrollreward.gameObject, true)
		else
			if slot1.state ~= MailEnum.ReadStatus.Read then
				MailRpc.instance:sendReadMailRequest(slot1.id)
			end

			gohelper.setActive(slot0._scrollreward.gameObject, false)
		end

		slot0:handleSpecialTag(slot1)
	end

	if slot1:haveBonus() then
		gohelper.setActive(slot0._btnget.gameObject, slot1.state ~= MailEnum.ReadStatus.Read)
		gohelper.setActive(slot0._gohasgotten.gameObject, slot1.state == MailEnum.ReadStatus.Read)
		gohelper.setActive(slot0._gorewardsBg, true)

		for slot8, slot9 in ipairs(ItemConfig.instance:getStackItemList(slot1.itemGroup)) do
			slot9.state = slot1.state
		end

		recthelper.setWidth(slot0._imagehasgottenbg.transform, 318 + 60 * math.min(5, #slot4 - 1))

		slot5 = slot0.viewContainer._viewSetting.otherRes[2]

		if not slot0._rewards then
			slot0._rewards = {}
		end

		for slot9 = 1, #slot4 do
			if not slot0._rewards[slot9] then
				slot0._rewards[slot9] = MailRewardItem.New()

				slot0._rewards[slot9]:init(slot0:getResInst(slot5, slot0._rewardContent))
			end

			gohelper.setActive(slot0._rewards[slot9].go, true)
			slot0._rewards[slot9]:onUpdateMO(slot4[slot9])
		end

		for slot9 = #slot4 + 1, #slot0._rewards do
			gohelper.setActive(slot0._rewards[slot9].go, false)
		end

		transformhelper.setLocalPosXY(slot0._scrollreward.transform, 999999, 999999)
		TaskDispatcher.runDelay(slot0.setRewardsPos, slot0, 0)
	else
		gohelper.setActive(slot0._btnget.gameObject, false)
		gohelper.setActive(slot0._gohasgotten.gameObject, false)
		gohelper.setActive(slot0._gorewardsBg.gameObject, false)
	end

	slot4 = 335

	if string.nilorempty(slot1:getJumpLink()) then
		slot4 = not slot1:haveBonus() and slot1.specialTag ~= MailEnum.SpecialTag.MonthExpired and 570 or 375
	end

	slot0:_setMailScrollHeight(slot4)
	slot0:_setContentHeight()

	if recthelper.getHeight(slot0._scrollcontent.transform) < recthelper.getHeight(slot0._sccontent.transform) then
		slot0._rectmask2DOneWay.enabled = true
	else
		slot0._rectmask2DOneWay.enabled = false
	end
end

function slot0._setContentHeight(slot0)
	recthelper.setHeight(slot0._sccontent.transform, recthelper.getHeight(slot0._txtsignature.transform) + 10)
end

function slot0.handleSpecialTag(slot0, slot1)
	if slot1 ~= nil and slot1.specialTag ~= 0 then
		gohelper.setActive(slot0._gomonthcard, slot1.specialTag == MailEnum.SpecialTag.MonthExpired)
		gohelper.setActive(slot0._gomodifyname, slot1.specialTag == MailEnum.SpecialTag.ModifyName)
	else
		gohelper.setActive(slot0._gomonthcard, false)
		gohelper.setActive(slot0._gomodifyname, false)
	end
end

function slot0.setRewardsPos(slot0)
	if not slot0._contentTrs then
		return
	end

	slot1 = 0

	transformhelper.setLocalPosXY(slot0._scrollreward.transform, (recthelper.getWidth(slot0._scrollreward.transform) > recthelper.getWidth(slot0._contentTrs) or slot0.orginalPos.x) and slot0.orginalPos.x + (slot3 - slot2) / 2, slot0.orginalPos.y)
end

function slot0._onMailRead(slot0, slot1)
	if slot0._selectMO then
		for slot5, slot6 in ipairs(slot1) do
			if slot0._selectMO.id == slot6 then
				slot0:_updateSelectMail(slot0._selectMO)
			end
		end
	end
end

function slot0._onMailDel(slot0, slot1)
	if slot0._selectMO then
		for slot5, slot6 in ipairs(slot1) do
			if slot0._selectMO and slot0._selectMO.id == slot6 then
				gohelper.setActive(slot0._goright, false)

				slot0._selectMO = nil
			end
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._rewards then
		for slot4 = 1, #slot0._rewards do
			slot0._rewards[slot4]:onDestroy()
		end
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagebgleft:UnLoadImage()
	slot0._simagewave:UnLoadImage()
	slot0._simagecardicon:UnLoadImage()
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0._getExpireTimeString(slot0, slot1)
	if slot1 == 0 then
		return ""
	end

	if slot1 / 1000 - ServerTime.now() <= 0 then
		return ""
	end

	if slot3 / 86400 > 1 then
		return string.format("%d", slot4) .. luaLang("mail_dayslate")
	elseif slot4 * 24 > 1 then
		return string.format("%d", slot5) .. luaLang("mail_hourlate")
	elseif slot5 * 60 > 1 then
		return string.format("%d", slot6) .. luaLang("mail_minutelate")
	else
		return 1 .. luaLang("mail_minutelate")
	end
end

function slot0._setMailScrollHeight(slot0, slot1)
	slot2 = gohelper.findChild(slot0._scrollcontent.gameObject, "viewport/content")

	ZProj.UGUIHelper.RebuildLayout(slot2.transform)
	recthelper.setHeight(slot0._scrollcontent.transform, slot1)

	slot0.couldScroll = slot1 < recthelper.getHeight(slot2.transform) and true or false
end

return slot0
