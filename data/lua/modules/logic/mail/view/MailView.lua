module("modules.logic.mail.view.MailView", package.seeall)

local var_0_0 = class("MailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simagebgleft = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bgleft")
	arg_1_0._simagewave = gohelper.findChildSingleImage(arg_1_0.viewGO, "mailtipview/#go_right/#simage_wave")
	arg_1_0._btndeleteallmail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_deleteallmail")
	arg_1_0._btngetallbatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_getallbatch")
	arg_1_0._txtmailcount = gohelper.findChildText(arg_1_0.viewGO, "mailtipview/mailcount/mailcount/#txt_mailcount")
	arg_1_0._txtunreadmailcount = gohelper.findChildText(arg_1_0.viewGO, "mailtipview/mailcount/#txt_unreadmailcount")
	arg_1_0._goemptyleft = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_emptyleft")
	arg_1_0._goemptyright = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_emptyright")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right")
	arg_1_0._imgstamp = gohelper.findChildImage(arg_1_0.viewGO, "mailtipview/#go_right/#image_stamp")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "mailtipview/#go_right/#scroll_content")
	arg_1_0._sccontent = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right/#scroll_content/viewport/content")
	arg_1_0._txtmailTitle = gohelper.findChildText(arg_1_0.viewGO, "mailtipview/#go_right/#txt_mailTitle")
	arg_1_0._txtsender = gohelper.findChildText(arg_1_0.viewGO, "mailtipview/#go_right/sender/#txt_sender")
	arg_1_0._txtsendtxt = gohelper.findChildText(arg_1_0.viewGO, "mailtipview/#go_right/senddate/#txt_sendtxt")
	arg_1_0._txtexpireTime = gohelper.findChildText(arg_1_0.viewGO, "mailtipview/#go_right/time/#txt_expireTime")
	arg_1_0._gosignature = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right/#scroll_content/viewport/content/#go_signature")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "mailtipview/#go_right/#go_rewards/#scroll_reward")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mailtipview/#go_right/#btn_get")
	arg_1_0._gohasgotten = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right/#go_rewards/#go_hasgotten")
	arg_1_0._imagehasgottenbg = gohelper.findChildImage(arg_1_0.viewGO, "mailtipview/#go_right/#go_rewards/#go_hasgotten/#image_hasgottenbg")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right/#scroll_enclosure/Viewport/Content/#go_rewardItem")
	arg_1_0._goselectone = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_selectone")
	arg_1_0._imagetopicon = gohelper.findChildImage(arg_1_0.viewGO, "mailtipview/#go_left/#image_topicon")
	arg_1_0._rewardContent = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right/#go_rewards/#scroll_reward/viewport/content")
	arg_1_0._contentTrs = arg_1_0._rewardContent.transform
	arg_1_0._gorewardsBg = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right/#go_rewards/#go_rewardsBg")
	arg_1_0._gojump = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right/#go_jump")
	arg_1_0._txtjump = gohelper.findChildText(arg_1_0.viewGO, "mailtipview/#go_right/#go_jump/#txt_jump")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mailtipview/#go_right/#go_jump/#txt_jump/#btn_jump")
	arg_1_0._scrollmail = gohelper.findChildScrollRect(arg_1_0.viewGO, "mailtipview/#go_left/#scroll_mail")
	arg_1_0._gomonthcard = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right/#go_monthcard")
	arg_1_0._btnrenew = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mailtipview/#go_right/#go_monthcard/#btn_renew")
	arg_1_0._simagecardicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "mailtipview/#go_right/#go_monthcard/#simage_cardicon")
	arg_1_0._gomodifyname = gohelper.findChild(arg_1_0.viewGO, "mailtipview/#go_right/#go_modifyname")
	arg_1_0._btnmodifyname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mailtipview/#go_right/#go_modifyname/#btn_modifyname")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndeleteallmail:AddClickListener(arg_2_0._btndeleteallmailOnClick, arg_2_0)
	arg_2_0._btngetallbatch:AddClickListener(arg_2_0._btngetallbatchOnClick, arg_2_0)
	arg_2_0._btnget:AddClickListener(arg_2_0._btngetOnClick, arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btnrenew:AddClickListener(arg_2_0._btnrenewOnClick, arg_2_0)
	arg_2_0._btnmodifyname:AddClickListener(arg_2_0._btnmodifynameOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndeleteallmail:RemoveClickListener()
	arg_3_0._btngetallbatch:RemoveClickListener()
	arg_3_0._btnget:RemoveClickListener()
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btnrenew:RemoveClickListener()
	arg_3_0._btnmodifyname:RemoveClickListener()
	arg_3_0._scrollcontent:RemoveOnValueChanged()
end

function var_0_0._btndeleteallmailOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.MailSureToDeleteAll, MsgBoxEnum.BoxType.Yes_No, function()
		MailRpc.instance:sendDeleteMailBatchRequest(1)
	end)
end

function var_0_0._btngetallbatchOnClick(arg_6_0)
	MailRpc.instance:sendReadMailBatchRequest(1)
end

function var_0_0._btnrenewOnClick(arg_7_0)
	StoreController.instance:openStoreView(StoreEnum.StoreId.Package, StoreEnum.MonthCardGoodsId)
end

function var_0_0._btnmodifynameOnClick(arg_8_0)
	arg_8_0:closeThis()

	local var_8_0 = PlayerModel.instance:getPlayinfo()

	PlayerController.instance:openPlayerView(var_8_0, true)
	ViewMgr.instance:openView(ViewName.PlayerModifyNameView)
end

function var_0_0._btngetOnClick(arg_9_0)
	if arg_9_0._selectMO and arg_9_0._selectMO.state ~= MailEnum.ReadStatus.Read then
		MailRpc.instance:sendReadMailRequest(arg_9_0._selectMO.id)
	end
end

function var_0_0._btnjumpOnClick(arg_10_0)
	local var_10_0 = arg_10_0._selectMO:getJumpLink()

	if arg_10_0._selectMO and not string.nilorempty(var_10_0) then
		local var_10_1, var_10_2 = string.match(var_10_0, "^SoJump#(.+)#(.+)$")

		if var_10_1 then
			local var_10_3 = {
				url = var_10_1,
				id = var_10_2
			}
			local var_10_4 = cjson.encode(var_10_3)

			SDKMgr.instance:openSoJump(var_10_4)
		else
			GameUtil.openURL(var_10_0)
		end

		MailRpc.instance:sendMarkMailJumpRequest(arg_10_0._selectMO.id)
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0:addEventCb(MailController.instance, MailEvent.OnMailCountChange, arg_11_0._refreshCount, arg_11_0)
	arg_11_0:addEventCb(MailController.instance, MailEvent.UpdateSelectMail, arg_11_0._updateSelectMail, arg_11_0)
	arg_11_0:addEventCb(MailController.instance, MailEvent.OnMailRead, arg_11_0._onMailRead, arg_11_0)
	arg_11_0:addEventCb(MailController.instance, MailEvent.OnMailDel, arg_11_0._onMailDel, arg_11_0)
	gohelper.setActive(arg_11_0._gomodifyname, false)

	arg_11_0.orginalPos = arg_11_0._scrollreward.transform.localPosition
	arg_11_0._txtsignature = arg_11_0._gosignature:GetComponent(typeof(TMPro.TMP_Text))
	arg_11_0._rectmask2DOneWay = arg_11_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2DOneWay))
	arg_11_0._rectmask2DOneWay.enabled = true

	arg_11_0._simagebg:LoadImage(ResUrl.getMailBg("mail_bg2"))
	arg_11_0._simagebgleft:LoadImage(ResUrl.getMailBg("mail_bg1"))
	arg_11_0._simagewave:LoadImage(ResUrl.getMailBg("huawen_003"))
	arg_11_0._simagecardicon:LoadImage(ResUrl.getMailBg("bg_youjiantishi"))
	gohelper.setActive(arg_11_0._goright, false)
	gohelper.setActive(arg_11_0._gorewardItem, false)
	MailModel.instance:setMailList()
	arg_11_0:_refreshCount()
	gohelper.addUIClickAudio(arg_11_0._btndeleteallmail.gameObject, AudioEnum.UI.UI_Mail_delete)

	arg_11_0._hyperLinkClick = arg_11_0._txtsignature:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	arg_11_0._hyperLinkClick:SetClickListener(arg_11_0._onHyperLinkClick, arg_11_0)
end

function var_0_0._onHyperLinkClick(arg_12_0, arg_12_1)
	if not string.nilorempty(arg_12_1) then
		local var_12_0, var_12_1 = string.match(arg_12_1, "^SoJump#(.+)#(.+)$")

		if var_12_0 then
			local var_12_2 = {
				url = var_12_0,
				id = var_12_1
			}
			local var_12_3 = cjson.encode(var_12_2)

			SDKMgr.instance:openSoJump(var_12_3)
		else
			GameUtil.openURL(arg_12_1)
		end
	end
end

function var_0_0._refreshCount(arg_13_0)
	arg_13_0:_trySelectFirstMail()

	local var_13_0 = MailModel.instance:getCount()
	local var_13_1 = MailModel.instance:getUnreadCount()

	arg_13_0._txtmailcount.text = var_13_0 .. "/" .. CommonConfig.instance:getConstStr(ConstEnum.MailMaxCount)
	arg_13_0._txtunreadmailcount.text = var_13_1

	gohelper.setActive(arg_13_0._goemptyright, var_13_0 <= 0)
	gohelper.setActive(arg_13_0._goemptyleft, var_13_0 <= 0)
	gohelper.setActive(arg_13_0._imagetopicon.gameObject, var_13_0 > 0)
	gohelper.setActive(arg_13_0._goselectone, not arg_13_0._selectMO and var_13_0 > 0)
end

function var_0_0._trySelectFirstMail(arg_14_0)
	local var_14_0 = MailCategroyModel.instance:getList()

	if not arg_14_0._selectMO and #var_14_0 > 0 then
		arg_14_0._scrollmail.verticalNormalizedPosition = 1

		MailCategroyModel.instance:selectCell(1, true)
	end
end

function var_0_0._updateSelectMail(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._selectMO and arg_15_0._selectMO.id == arg_15_1.id

	arg_15_0._selectMO = arg_15_1

	gohelper.setActive(arg_15_0._goright, arg_15_0._selectMO)

	local var_15_1 = MailModel.instance:getCount()

	gohelper.setActive(arg_15_0._goselectone, not arg_15_0._selectMO and var_15_1 > 0)

	if not var_15_0 then
		arg_15_0._txtmailTitle.text = GameUtil.getBriefNameByWidth(arg_15_1:getLangTitle(), arg_15_0._txtmailTitle)
		arg_15_0._txtsender.text = arg_15_1:getLangSender()
		arg_15_0._txtsendtxt.text = TimeUtil.langTimestampToString3(arg_15_1.createTime / 1000)
		arg_15_0._txtexpireTime.text = arg_15_0:_getExpireTimeString(arg_15_1.expireTime)
		arg_15_0._txtsignature.text = arg_15_1:getLangContent()
		arg_15_0.senderType = "img_yp_" .. arg_15_1:getSenderType()

		UISpriteSetMgr.instance:setMailSprite(arg_15_0._imgstamp, arg_15_0.senderType, true)

		if string.nilorempty(arg_15_1:getJumpLink()) then
			gohelper.setActive(arg_15_0._gojump.gameObject, false)
		else
			gohelper.setActive(arg_15_0._gojump.gameObject, true)

			if type(arg_15_1.jumpTitle) ~= "table" and string.nilorempty(arg_15_1.jumpTitle) then
				arg_15_0._txtjump.text = luaLang("mail_jump_title")
			else
				arg_15_0._txtjump.text = arg_15_1:getTemplateJumpTitle()
			end
		end

		arg_15_0._scrollcontent.verticalNormalizedPosition = 1
		arg_15_0._scrollreward.horizontalNormalizedPosition = 0

		if arg_15_1:haveBonus() then
			gohelper.setActive(arg_15_0._scrollreward.gameObject, true)
		else
			if arg_15_1.state ~= MailEnum.ReadStatus.Read then
				MailRpc.instance:sendReadMailRequest(arg_15_1.id)
			end

			gohelper.setActive(arg_15_0._scrollreward.gameObject, false)
		end

		arg_15_0:handleSpecialTag(arg_15_1)
	end

	if arg_15_1:haveBonus() then
		gohelper.setActive(arg_15_0._btnget.gameObject, arg_15_1.state ~= MailEnum.ReadStatus.Read)
		gohelper.setActive(arg_15_0._gohasgotten.gameObject, arg_15_1.state == MailEnum.ReadStatus.Read)
		gohelper.setActive(arg_15_0._gorewardsBg, true)

		local var_15_2 = ItemConfig.instance:getStackItemList(arg_15_1.itemGroup)

		for iter_15_0, iter_15_1 in ipairs(var_15_2) do
			iter_15_1.state = arg_15_1.state
		end

		recthelper.setWidth(arg_15_0._imagehasgottenbg.transform, 318 + 60 * math.min(5, #var_15_2 - 1))

		local var_15_3 = arg_15_0.viewContainer._viewSetting.otherRes[2]

		if not arg_15_0._rewards then
			arg_15_0._rewards = {}
		end

		for iter_15_2 = 1, #var_15_2 do
			if not arg_15_0._rewards[iter_15_2] then
				local var_15_4 = arg_15_0:getResInst(var_15_3, arg_15_0._rewardContent)

				arg_15_0._rewards[iter_15_2] = MailRewardItem.New()

				arg_15_0._rewards[iter_15_2]:init(var_15_4)
			end

			gohelper.setActive(arg_15_0._rewards[iter_15_2].go, true)
			arg_15_0._rewards[iter_15_2]:onUpdateMO(var_15_2[iter_15_2])
		end

		for iter_15_3 = #var_15_2 + 1, #arg_15_0._rewards do
			gohelper.setActive(arg_15_0._rewards[iter_15_3].go, false)
		end

		transformhelper.setLocalPosXY(arg_15_0._scrollreward.transform, 999999, 999999)
		TaskDispatcher.runDelay(arg_15_0.setRewardsPos, arg_15_0, 0)
	else
		gohelper.setActive(arg_15_0._btnget.gameObject, false)
		gohelper.setActive(arg_15_0._gohasgotten.gameObject, false)
		gohelper.setActive(arg_15_0._gorewardsBg.gameObject, false)
	end

	local var_15_5 = 335

	if string.nilorempty(arg_15_1:getJumpLink()) then
		var_15_5 = not arg_15_1:haveBonus() and arg_15_1.specialTag ~= MailEnum.SpecialTag.MonthExpired and 570 or 375
	end

	arg_15_0:_setMailScrollHeight(var_15_5)
	arg_15_0:_setContentHeight()

	if recthelper.getHeight(arg_15_0._scrollcontent.transform) < recthelper.getHeight(arg_15_0._sccontent.transform) then
		arg_15_0._rectmask2DOneWay.enabled = true
	else
		arg_15_0._rectmask2DOneWay.enabled = false
	end
end

function var_0_0._setContentHeight(arg_16_0)
	local var_16_0 = 10
	local var_16_1 = recthelper.getHeight(arg_16_0._txtsignature.transform) + var_16_0

	recthelper.setHeight(arg_16_0._sccontent.transform, var_16_1)
end

function var_0_0.handleSpecialTag(arg_17_0, arg_17_1)
	if arg_17_1 ~= nil and arg_17_1.specialTag ~= 0 then
		gohelper.setActive(arg_17_0._gomonthcard, arg_17_1.specialTag == MailEnum.SpecialTag.MonthExpired)
		gohelper.setActive(arg_17_0._gomodifyname, arg_17_1.specialTag == MailEnum.SpecialTag.ModifyName)
	else
		gohelper.setActive(arg_17_0._gomonthcard, false)
		gohelper.setActive(arg_17_0._gomodifyname, false)
	end
end

function var_0_0.setRewardsPos(arg_18_0)
	if not arg_18_0._contentTrs then
		return
	end

	local var_18_0 = 0
	local var_18_1 = recthelper.getWidth(arg_18_0._contentTrs)
	local var_18_2 = recthelper.getWidth(arg_18_0._scrollreward.transform)

	if var_18_2 <= var_18_1 then
		var_18_0 = arg_18_0.orginalPos.x
	else
		var_18_0 = arg_18_0.orginalPos.x + (var_18_2 - var_18_1) / 2
	end

	transformhelper.setLocalPosXY(arg_18_0._scrollreward.transform, var_18_0, arg_18_0.orginalPos.y)
end

function var_0_0._onMailRead(arg_19_0, arg_19_1)
	if arg_19_0._selectMO then
		for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
			if arg_19_0._selectMO.id == iter_19_1 then
				arg_19_0:_updateSelectMail(arg_19_0._selectMO)
			end
		end
	end
end

function var_0_0._onMailDel(arg_20_0, arg_20_1)
	if arg_20_0._selectMO then
		for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
			if arg_20_0._selectMO and arg_20_0._selectMO.id == iter_20_1 then
				gohelper.setActive(arg_20_0._goright, false)

				arg_20_0._selectMO = nil
			end
		end
	end
end

function var_0_0.onUpdateParam(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	if arg_22_0._rewards then
		for iter_22_0 = 1, #arg_22_0._rewards do
			arg_22_0._rewards[iter_22_0]:onDestroy()
		end
	end

	arg_22_0._simagebg:UnLoadImage()
	arg_22_0._simagebgleft:UnLoadImage()
	arg_22_0._simagewave:UnLoadImage()
	arg_22_0._simagecardicon:UnLoadImage()
end

function var_0_0.onOpen(arg_23_0)
	return
end

function var_0_0.onClose(arg_24_0)
	return
end

function var_0_0._getExpireTimeString(arg_25_0, arg_25_1)
	if arg_25_1 == 0 then
		return ""
	end

	local var_25_0 = arg_25_1 / 1000 - ServerTime.now()

	if var_25_0 <= 0 then
		return ""
	end

	local var_25_1 = var_25_0 / 86400

	if var_25_1 > 1 then
		return string.format("%d", var_25_1) .. luaLang("mail_dayslate")
	else
		local var_25_2 = var_25_1 * 24

		if var_25_2 > 1 then
			return string.format("%d", var_25_2) .. luaLang("mail_hourlate")
		else
			local var_25_3 = var_25_2 * 60

			if var_25_3 > 1 then
				return string.format("%d", var_25_3) .. luaLang("mail_minutelate")
			else
				return 1 .. luaLang("mail_minutelate")
			end
		end
	end
end

function var_0_0._setMailScrollHeight(arg_26_0, arg_26_1)
	local var_26_0 = gohelper.findChild(arg_26_0._scrollcontent.gameObject, "viewport/content")

	ZProj.UGUIHelper.RebuildLayout(var_26_0.transform)

	local var_26_1 = recthelper.getHeight(var_26_0.transform)

	recthelper.setHeight(arg_26_0._scrollcontent.transform, arg_26_1)

	arg_26_0.couldScroll = arg_26_1 < var_26_1 and true or false
end

return var_0_0
