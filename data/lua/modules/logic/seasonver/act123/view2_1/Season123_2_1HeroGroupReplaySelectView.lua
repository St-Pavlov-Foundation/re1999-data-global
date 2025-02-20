module("modules.logic.seasonver.act123.view2_1.Season123_2_1HeroGroupReplaySelectView", package.seeall)

slot0 = class("Season123_2_1HeroGroupReplaySelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnmultispeed = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed")
	slot0._txtmultispeed = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/Label")
	slot0._btnclosemult = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closemult")
	slot0._gomultPos = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/#go_multpos")
	slot0._gomultispeed = gohelper.findChild(slot0.viewGO, "#go_multispeed")
	slot0._gomultContent = gohelper.findChild(slot0.viewGO, "#go_multispeed/Viewport/Content")
	slot0._gomultitem = gohelper.findChild(slot0.viewGO, "#go_multispeed/Viewport/Content/#go_multitem")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_startseasonreplay/#go_cost/#image_icon")
	slot0._txtcostNum = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_startseasonreplay/#go_cost/#txt_num")
	slot0._godropbg = gohelper.findChild(slot0.viewGO, "#go_multispeed/Viewport/bg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmultispeed:AddClickListener(slot0._btnmultispeedOnClick, slot0)
	slot0._btnclosemult:AddClickListener(slot0._btnclosemultOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmultispeed:RemoveClickListener()
	slot0._btnclosemult:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._isMultiOpen = false
	slot0.rectdropbg = slot0._godropbg.transform

	slot0:refreshMulti()
end

function slot0.onDestroyView(slot0)
end

function slot0.onOpen(slot0)
	slot0:initCostIcon()
	slot0:initMultiGroup()
	slot0:refreshSelection()
end

function slot0.onClose(slot0)
end

slot0.ItemHeight = 92

function slot0.initMultiGroup(slot0)
	slot0._multSpeedItems = {}
	slot0.maxMultiplicationTimes = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication)
	slot2 = nil
	slot2 = (not Season123HeroGroupModel.instance:isEpisodeSeason123Retail() or math.min(slot0.maxMultiplicationTimes, Season123HeroGroupModel.instance:getMultiplicationTicket())) and 1

	for slot6 = 1, slot0.maxMultiplicationTimes do
		if slot2 < slot0.maxMultiplicationTimes - slot6 + 1 then
			gohelper.setActive(slot0._gomultContent.transform:GetChild(slot6 - 1), false)
		else
			gohelper.setActive(slot7, true)
			slot0:initMultSpeedItem(slot7.gameObject, slot8, slot2)
		end
	end

	recthelper.setHeight(slot0.rectdropbg, uv0.ItemHeight * slot2)
end

function slot0.initMultSpeedItem(slot0, slot1, slot2, slot3)
	if not slot0._multSpeedItems[slot2] then
		slot0:addClickCb(gohelper.getClick(slot1), slot0.onClickSetSpeed, slot0, slot2)

		gohelper.findChildTextMesh(slot1, "num").text = luaLang("multiple") .. slot2

		gohelper.setActive(gohelper.findChild(slot1, "line"), slot2 ~= slot3)

		slot0._multSpeedItems[slot2] = slot0:getUserDataTb_()
		slot0._multSpeedItems[slot2].txtnum = slot5
		slot0._multSpeedItems[slot2].goselecticon = gohelper.findChild(slot1, "selecticon")
	end
end

function slot0.initCostIcon(slot0)
	if Season123Config.instance:getEquipItemCoin(Season123HeroGroupModel.instance.activityId, Activity123Enum.Const.UttuTicketsCoin) then
		if not CurrencyConfig.instance:getCurrencyCo(slot2) then
			return
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageicon, tostring(slot3.icon) .. "_1")
	else
		logNormal("Season123 ticketId is nil : " .. tostring(slot1))
	end
end

function slot0.refreshMulti(slot0)
	gohelper.setActive(slot0._gomultispeed, slot0._isMultiOpen)
	gohelper.setActive(slot0._btnclosemult, slot0._isMultiOpen)

	slot0._gomultispeed.transform.position = slot0._gomultPos.transform.position
end

function slot0.onClickSetSpeed(slot0, slot1)
	slot0:setMultSpeed(slot1)
end

slot1 = GameUtil.parseColor("#efb785")
slot2 = GameUtil.parseColor("#C3BEB6")

function slot0.setMultSpeed(slot0, slot1)
	Season123HeroGroupController.instance:setMultiplication(slot1)

	slot2 = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(Season123HeroGroupModel.instance.multiplication))
	slot0._isMultiOpen = false

	slot0:refreshMulti()
	slot0:refreshSelection()
end

function slot0.refreshSelection(slot0)
	slot1 = Season123HeroGroupModel.instance.multiplication
	slot5 = "multiple"
	slot0._txtmultispeed.text = luaLang(slot5) .. slot1
	slot0._txtcostNum.text = "-" .. tostring(slot1)

	for slot5 = 1, slot0.maxMultiplicationTimes do
		if slot0._multSpeedItems[slot5] then
			slot6.txtnum.color = slot1 == slot5 and uv0 or uv1

			gohelper.setActive(slot6.goselecticon, slot1 == slot5)
		end
	end
end

function slot0._btnmultispeedOnClick(slot0)
	slot0._isMultiOpen = not slot0._isMultiOpen

	slot0:refreshMulti()
end

function slot0._btnclosemultOnClick(slot0)
	slot0._isMultiOpen = false

	slot0:refreshMulti()
end

return slot0
