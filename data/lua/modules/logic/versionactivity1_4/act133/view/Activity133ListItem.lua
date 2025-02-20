module("modules.logic.versionactivity1_4.act133.view.Activity133ListItem", package.seeall)

slot0 = class("Activity133ListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageitem = gohelper.findChildImage(slot0.viewGO, "#image_item")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#image_item/lockbg")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/Content")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/Content/#go_item")
	slot0._btnfix = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_fix")
	slot0._goFixIcon = gohelper.findChild(slot0.viewGO, "bottom/#btn_fix/icon")
	slot0._goCanFix = gohelper.findChild(slot0.viewGO, "bottom/#btn_fix/icon1")
	slot0._btncheck = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_check")
	slot0._btnchecking = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg_checking/#btn_checking")
	slot0._imgcost = gohelper.findChildImage(slot0.viewGO, "bottom/cost/txt/#simage_icon")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "bottom/cost/txt")
	slot0._gochecking = gohelper.findChild(slot0.viewGO, "bottom/#go_checking")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "bottom/cost")
	slot0._gobuyed = gohelper.findChild(slot0.viewGO, "bottom/buyed")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "bottom/buyed/#txt_title")
	slot0._gocheckbg = gohelper.findChild(slot0.viewGO, "bg_checking")
	slot0._golockbg = gohelper.findChild(slot0.viewGO, "bg_lockedmask")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "bottom/#btn_fix/icon/#go_reddot")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._unlockAniTime = 1

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfix:AddClickListener(slot0._btnfixOnClick, slot0)
	slot0._btncheck:AddClickListener(slot0._btncheckOnClick, slot0)
	slot0._btnchecking:AddClickListener(slot0._btncheckingOnClick, slot0)
	slot0:addEventCb(Activity133Controller.instance, Activity133Event.OnUpdateInfo, slot0._refreshStatus, slot0)
	slot0:addEventCb(Activity133Controller.instance, Activity133Event.OnGetBonus, slot0._refreshStatus, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfix:RemoveClickListener()
	slot0._btncheck:RemoveClickListener()
	slot0._btnchecking:RemoveClickListener()
	slot0:removeEventCb(Activity133Controller.instance, Activity133Event.OnUpdateInfo, slot0._refreshStatus, slot0)
	slot0:removeEventCb(Activity133Controller.instance, Activity133Event.OnGetBonus, slot0._refreshStatus, slot0)
end

function slot0._btnfixOnClick(slot0)
	if tonumber(slot0.targetNum) <= CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act133).quantity then
		slot0._animator.speed = 1

		UIBlockMgr.instance:startBlock("Activity133ListItem")
		slot0._animator:Play(UIAnimationName.Unlock, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_list_maintain)
		slot0._animator:Update(0)
		TaskDispatcher.runDelay(slot0._onItemFixAniFinish, slot0, slot0._unlockAniTime)
	else
		GameFacade.showToast(ToastEnum.DiamondBuy, slot0.costName)
	end
end

function slot0._onItemFixAniFinish(slot0)
	UIBlockMgr.instance:endBlock("Activity133ListItem")
	Activity133Rpc.instance:sendAct133BonusRequest(slot0.actId, slot0.id)
end

function slot0._btncheckOnClick(slot0)
	slot0._view:selectCell(slot0._index, true)
end

function slot0._btncheckingOnClick(slot0)
	slot0._view:selectCell(slot0._index, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	Activity133Controller.instance:dispatchEvent(Activity133Event.OnSelectCheckNote)
end

function slot0._editableInitView(slot0)
	slot0._itemList = {}
	slot0._isfix = false
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1

	slot0:_refreshUI()
	slot0:_checkRedDot()
end

function slot0._checkRedDot(slot0)
	if tonumber(slot0.targetNum) <= CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act133).quantity then
		slot0._canGet = true
	else
		slot0._canGet = false
	end

	gohelper.setActive(slot0._goFixIcon, not slot0._canGet)
	gohelper.setActive(slot0._goCanFix, slot0._canGet)
end

function slot0._refreshUI(slot0)
	slot1 = slot0.mo.config
	slot0.actId = slot1.activityId
	slot0.id = slot1.id
	slot0.iconid = slot1.icon

	UISpriteSetMgr.instance:setV1a4ShiprepairSprite(slot0._imageitem, tostring(slot1.icon))

	slot2 = string.splitToNumber(slot1.needTokens, "#")
	slot0.targetNum = slot2[3]
	slot0.costName = ItemModel.instance:getItemConfig(slot2[1], slot2[2]) and slot6.name or ""
	slot7, slot8 = ItemModel.instance:getItemConfigAndIcon(slot3, slot4)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imgcost, string.format("%s_1", slot7.icon))

	slot0._txtcost.text = slot0.targetNum
	slot0._txttitle.text = slot1.title

	for slot15, slot16 in ipairs(GameUtil.splitString2(slot1.bonus, true)) do
		if not slot0._itemList[slot15] then
			slot17 = slot0:getUserDataTb_()
			slot17.go = gohelper.cloneInPlace(slot0._goitem)

			gohelper.setActive(slot17.go, true)

			slot17.icon = IconMgr.instance:getCommonPropItemIcon(slot17.go)
			slot17.goget = gohelper.findChild(slot17.go, "get")

			gohelper.setAsLastSibling(slot17.goget)
			gohelper.setActive(slot17.goget, false)
			table.insert(slot0._itemList, slot17)
		end

		slot17.icon:setMOValue(slot16[1], slot16[2], slot16[3], nil, true)
		slot17.icon:SetCountLocalY(45)
		slot17.icon:SetCountBgHeight(30)
		slot17.icon:setCountFontSize(36)
	end

	slot0:_refreshStatus()
end

function slot0._refreshStatus(slot0)
	slot1 = Activity133Model.instance:checkBonusReceived(slot0.mo.id)

	gohelper.setActive(slot0._btnfix.gameObject, not slot1)
	gohelper.setActive(slot0._btncheck.gameObject, slot1)
	gohelper.setActive(slot0._golock, not slot1)
	gohelper.setActive(slot0._golockbg, not slot1)
	gohelper.setActive(slot0._gocost, not slot1)

	slot5 = slot1

	gohelper.setActive(slot0._gobuyed, slot5)

	for slot5, slot6 in pairs(slot0._itemList) do
		gohelper.setActive(slot6.goget, slot1)

		if slot1 then
			slot6.icon:setAlpha(0.45, 0.8)
		else
			slot6.icon:setAlpha(1, 1)
		end
	end
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._btncheck.gameObject, not slot1)
	gohelper.setActive(slot0._gochecking, slot1)
	gohelper.setActive(slot0._gocheckbg, slot1)

	if slot1 then
		Activity133Controller.instance:dispatchEvent(Activity133Event.OnSelectCheckNote, slot0.mo)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
